require "nkf"
require "itaiji"
require "ya_kansuji"

module Mojicon
  module Converter
    using YaKansuji::CoreRefine

    def trim_space
      self&.delete(" ")&.delete("　")
    end

    def zen_to_han
      return self if self&.nil?
      return self unless match(/[^ -~｡-ﾟ]/)

      space_trimmed_word = tr("　", " ")
      nkf_converted = NKF.nkf("-Z4 -w", space_trimmed_word)
      nkf_converted.tr("｟｠", "⦅⦆")
    end

    def han_to_zen
      return self if self&.nil?

      converted = tr("A-Za-z0-9", "Ａ-Ｚａ-ｚ０-９")
      space_converted = converted.tr(" ", "　")
      nkf_converted = NKF.nkf("-w -X", space_converted)
      nkf_converted.tr("\s!#$%&\'\"()⦅⦆⟨⟩*+,-./:;<=>?@[]^_`{|}~\\", "　！＃＄％＆＇＂（）｟｠〈〉＊＋，－．／：；＜＝＞？＠［］＾＿｀｛｜｝～＼")
    end

    def kana_to_hira
      return self if self.nil?

      self.tr("ァ-ヶ", "ぁ-ん")
    end

    def hira_to_kana
      return self if self.nil?

      self.tr("ぁ-ん", "ァ-ヶ")
    end

    def upper_to_down
      return self if self.nil?

      downcased = downcase
      downcased.tr("あいうえおつやゆよアイウエオツヤユヨ", "ぁぃぅぇぉっゃゅょァィゥェォッャュョ")
    end

    def down_to_upper
      return self if self.nil?

      upcased = upcase
      upcased.tr("ぁぃぅぇぉっゃゅょァィゥェォッャュョ", "あいうえおつやゆよアイウエオツヤユヨ")
    end

    def kanji_to_arabic(conversion_zenkaku: false)
      kanji_pattern = /[一二三四五六七八九〇十百千万億兆]+/
      kanji_numbers = scan(kanji_pattern).map(&:to_i)
      replaced_str = gsub(kanji_pattern).with_index do |_match, index|
        kanji_numbers[index].to_s
      end

      if conversion_zenkaku
        replaced_str.han_to_zen
      else
        replaced_str
      end
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
    end

    def to_new_moji
      Itaiji::Converter.new.seijitai(self)
    end

    def equal?(other)
      return false if nil?

      candidate.include?(other)
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
        trim_space.zen_to_han.hira_to_kana,
        trim_space.han_to_zen.kana_to_hira,
        trim_space.han_to_zen.hira_to_kana,
        trim_space.kana_to_hira.zen_to_han,
        trim_space.kana_to_hira.han_to_zen,
        trim_space.hira_to_kana.zen_to_han,
        trim_space.hira_to_kana.han_to_zen,
        trim_space.upper_to_down.zen_to_han,
        trim_space.upper_to_down.han_to_zen,
        trim_space.upper_to_down.kana_to_hira,
        trim_space.upper_to_down.hira_to_kana,
        trim_space.down_to_upper.zen_to_han,
        trim_space.down_to_upper.han_to_zen,
        trim_space.down_to_upper.kana_to_hira,
        trim_space.down_to_upper.hira_to_kana,
        trim_space.to_new_moji,
        trim_space.arabic_to_kanji,
        trim_space.arabic_to_kanji(zero: true),
        trim_space.kanji_to_arabic,
        trim_space.kanji_to_arabic(conversion_zenkaku: true)
      ].uniq
    end
  end
end
