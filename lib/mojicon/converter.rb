require "nkf"
require "itaiji"
require "ya_kansuji"

module Mojicon
  module Converter
    using YaKansuji::CoreRefine

    def trim_space
      self.delete(" ")&.delete("　")
    end

    def zen_to_han
      return self unless match(/[^ -~｡-ﾟ]/)

      space_trimmed_word = tr("　", " ")
      nkf_converted = NKF.nkf("-Z4 -w", space_trimmed_word)
      nkf_converted.tr("｟｠", "⦅⦆")
    end

    def han_to_zen
      converted = tr("A-Za-z0-9", "Ａ-Ｚａ-ｚ０-９")
      space_converted = converted.tr(" ", "　")
      nkf_converted = NKF.nkf("-w -X", space_converted)
      nkf_converted.tr("\s!#$%&\'\"()⦅⦆⟨⟩*+,-./:;<=>?@[]^_`−{|}~\\", "　！＃＄％＆＇＂（）｟｠〈〉＊＋，－．／：；＜＝＞？＠［］＾＿｀－｛｜｝～＼")
    end

    def kana_to_hira
      vu = self.tr("ヴ","ゔ")
      vu.tr("ァ-ヶ", "ぁ-ん")
    end

    def hira_to_kana
      vu = self.tr("ゔ","ヴ")
      vu.tr("ぁ-ん", "ァ-ヶ")
    end

    def upper_to_down
      downcased = self.downcase
      downcased.tr("あいうえおつやゆよアイウエオツヤユヨｱｲｳｴｵﾂﾔﾕﾖ", "ぁぃぅぇぉっゃゅょァィゥェォッャュョｧｨｩｪｫｯｬｭｮ")
    end

    def down_to_upper
      upcased = self.upcase
      upcased.tr("ぁぃぅぇぉっゃゅょァィゥェォッャュョｧｨｩｪｫｯｬｭｮ", "あいうえおつやゆよアイウエオツヤユヨｱｲｳｴｵﾂﾔﾕﾖ")
    end

    def kanji_to_arabic
      kanji_pattern = /[一二三四五六七八九〇十百千万億兆]+/
      kanji_numbers = scan(kanji_pattern).map(&:to_i)
      replaced_str = gsub(kanji_pattern).with_index do |_match, index|
        kanji_numbers[index].to_s
      end
      replaced_str.zen_to_han
    end

    def arabic_to_kanji(zero: true)
      arabic_pattern = /[\d０-９]+/
      arabic_numbers = zen_to_han.scan(arabic_pattern).map(&:to_i)
      arabic_numbers = gsub(arabic_pattern).with_index do |_match, index|
        if zero
          YaKansuji.to_kan(arabic_numbers[index], :judic_v)
        else
          YaKansuji.to_kan(arabic_numbers[index], :simple)
        end
      end
      arabic_numbers.han_to_zen
    end

    def to_new_moji
      Itaiji::Converter.new.seijitai(self)
    end

    def equal?(other)
      return false if other.nil?
      return false unless other.is_a?(String)
      return true if self == other

      candidate.include?(other.trim_space)
    end

    def candidate
      [
        trim_space,
        trim_space.zen_to_han,
        trim_space.han_to_zen,
        trim_space.kana_to_hira,
        trim_space.hira_to_kana,
        trim_space.upper_to_down,
        trim_space.down_to_upper,
        trim_space.kanji_to_arabic,
        trim_space.arabic_to_kanji,
        trim_space.arabic_to_kanji(zero: false),
        trim_space.to_new_moji, 
        trim_space.hira_to_kana.zen_to_han,
        trim_space.kanji_to_arabic.han_to_zen,
        trim_space.arabic_to_kanji.zen_to_han,
        trim_space.arabic_to_kanji(zero: false).zen_to_han,
        trim_space.han_to_zen.kana_to_hira,
      ].uniq
    end
  end
end
