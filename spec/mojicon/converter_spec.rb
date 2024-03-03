RSpec.describe Mojicon::Converter do
  include Mojicon::Converter
  describe ".trim_space(word)" do
    it "半角全角スペースを削除した文字列を返却する" do
      word = "Hello World こんにちは　"
      expect(word.trim_space).to eq("HelloWorldこんにちは")
    end
  end

  # 全角を半角に変換する
  # Mojicon::Converterモジュールのメソッドとしてzen_to_han(word)を実装する
  # wordが全角文字であることを確認して、全角を半角に変換した文字列を返却する
  # wordはひらがな、カタカナ、アルファベット全て対応する
  # 空白スペースや記号についても対応する
  # wordに全角文字が含まれていない場合は、wordをそのまま返却する

  describe "zen_to_han" do
    let(:zenkaku_alhabet_up) { "ＡＢＣＤＥ" }
    let(:zenkaku_alhabet_down) { "ａｂｃｄｅ" }
    let(:zenkaku_kana1) { "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノ" }
    let(:zenkaku_kana2) { "ハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶ" }
    let(:zenkaku_num) { "１２３４" }
    let(:zenkaku_space) { "　" }
    let(:zenkaku_symbol1) { "！＃＄％＆（）＊＋，－．／：；＜＝＞？＠［］＾＿｀｛｜｝＼" }
    let(:zenkaku_symbol2) { "（）｟｠｛｝［］＜＞" }
    let(:not_zenkaku) { "ｱAa1" }
    let(:single) { "’" }
    let(:double) { "”" }
    let(:nil_word) { nil }

    it "半角に変換" do
      expect(zenkaku_kana1.zen_to_han).to eq("ｧｱｨｲｩｳｪｴｫｵｶｶﾞｷｷﾞｸｸﾞｹｹﾞｺｺﾞｻｻﾞｼｼﾞｽｽﾞｾｾﾞｿｿﾞﾀﾀﾞﾁﾁﾞｯﾂﾂﾞﾃﾃﾞﾄﾄﾞﾅﾆﾇﾈﾉ")
      expect(zenkaku_kana2.zen_to_han).to eq("ﾊﾊﾞﾊﾟﾋﾋﾞﾋﾟﾌﾌﾞﾌﾟﾍﾍﾞﾍﾟﾎﾎﾞﾎﾟﾏﾐﾑﾒﾓｬﾔｭﾕｮﾖﾗﾘﾙﾚﾛヮﾜヰヱｦﾝｳﾞヵヶ")
      expect(zenkaku_alhabet_up.zen_to_han).to eq("ABCDE")
      expect(zenkaku_alhabet_down.zen_to_han).to eq("abcde")
      expect(zenkaku_num.zen_to_han).to eq("1234")
      expect(zenkaku_space.zen_to_han).to eq(" ")
      expect(zenkaku_symbol1.zen_to_han).to eq("!#$%&()*+,-./:;<=>?@[]^_`{|}\\")
      expect(zenkaku_symbol2.zen_to_han).to eq("()⦅⦆{}[]<>")
      expect(not_zenkaku.zen_to_han).to eq("ｱAa1")
      expect(single.zen_to_han).to eq("'")
      expect(double.zen_to_han).to eq("\"")
    end
  end

  describe "han_to_zen" do
    let(:hankaku_kana1) do
      "ｧｱｨｲｩｳｪｴｫｵｶｶﾞｷｷﾞｸｸﾞｹｹﾞｺｺﾞｻｻﾞｼｼﾞｽｽﾞｾｾﾞｿｿﾞﾀﾀﾞﾁﾁﾞｯﾂﾂﾞﾃﾃﾞﾄﾄﾞﾅﾆﾇﾈﾉ"
    end
    let(:hankaku_kana2) do
      "ﾊﾊﾞﾊﾟﾋﾋﾞﾋﾟﾌﾌﾞﾌﾟﾍﾍﾞﾍﾟﾎﾎﾞﾎﾟﾏﾐﾑﾒﾓｬﾔｭﾕｮﾖﾗﾘﾙﾚﾛヮﾜｦﾝｳﾞ"
    end
    let(:hankaku_alhabet_up) { "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    let(:hankaku_alhabet_down) { "abcdefghijklmnopqrstuvwxyz" }
    let(:hankaku_number) { "0123456789" }
    let(:hankaku_spece) { " " }
    let(:hankaku_symbol1) { "!#$%&\'\"()*+,-./:;<=>?@[]^_`{|}~\\" }
    let(:hankaku_symbol2) { "()⦅⦆⟨⟩{}[]<>" }

    it "全角に変換" do
      expect(hankaku_kana1.han_to_zen).to eq("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノ")
      expect(hankaku_kana2.han_to_zen).to eq("ハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヲンヴ")
      expect(hankaku_alhabet_up.han_to_zen).to eq("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ")
      expect(hankaku_alhabet_down.han_to_zen).to eq("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ")
      expect(hankaku_number.han_to_zen).to eq("０１２３４５６７８９")
      expect(hankaku_spece.han_to_zen).to eq("　")
      expect(hankaku_symbol1.han_to_zen).to eq("！＃＄％＆＇＂（）＊＋，－．／：；＜＝＞？＠［］＾＿｀｛｜｝～＼")
      expect(hankaku_symbol2.han_to_zen).to eq("（）｟｠〈〉｛｝［］＜＞")
    end
  end

  describe "kana_to_hira" do
    let(:kana) { "ア" }

    it "カタカナをひらがなに変換する" do
      expect(kana.kana_to_hira).to eq("あ")
    end
  end

  describe "hira_to_kana" do
    let(:kana) { "あ" }

    it "ひらがなをカタカナに変換する" do
      expect(kana.hira_to_kana).to eq("ア")
    end
  end

  describe "upper_to_down" do
    let(:upper_alphabet) { "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    let(:upper_hirakana) { "あいうえおつやゆよ" }
    let(:upper_katakana) { "アイウエオツヤユヨ" }

    it "ひらがなをカタカナに変換する" do
      expect(upper_alphabet.upper_to_down).to eq("abcdefghijklmnopqrstuvwxyz")
      expect(upper_hirakana.upper_to_down).to eq("ぁぃぅぇぉっゃゅょ")
      expect(upper_katakana.upper_to_down).to eq("ァィゥェォッャュョ")
    end
  end

  describe "down_to_upper" do
    let(:down_alphabet) { "abcdefghijklmnopqrstuvwxyz" }
    let(:down_hirakana) { "ぁぃぅぇぉっゃゅょ" }
    let(:down_katakana) { "ァィゥェォッャュョ" }

    it "小文字を大文字に変換する" do
      expect(down_alphabet.down_to_upper).to eq("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
      expect(down_hirakana.down_to_upper).to eq("あいうえおつやゆよ")
      expect(down_katakana.down_to_upper).to eq("アイウエオツヤユヨ")
    end
  end

  describe "kanji_to_arabic" do
    let(:kanji) { "一〇二四" }
    let(:address) { "東京都港区東麻布三丁目二六番一〇－三〇一号" }
    let(:date) { "平成二十四年八月三十一日" }
    let(:capital) { "三三三億三三三三万三三三三" }

    context "半角数字" do
      it "漢数字をアラビア数字に変換する" do
        expect(kanji.kanji_to_arabic).to eq("1024")
        expect(address.kanji_to_arabic).to eq("東京都港区東麻布3丁目26番10－301号")
        expect(capital.kanji_to_arabic).to eq("33333333333")
      end
    end

    context "全角数字" do
      it "漢数字をアラビア数字に変換する" do
        expect(date.kanji_to_arabic(conversion_zenkaku: true)).to eq("平成２４年８月３１日")
      end
    end
  end

  describe "arabic_to_kanji" do
    let(:arabic_str) { "1024" }
    let(:arabic_address) { "東京都港区東麻布3丁目26番10－301号" }
    let(:date) { "平成２４年８月３１日" }
    let(:capital) { "33333333333" }

    context "〇あり" do
      it "アラビア数字を漢数字に変換する" do
        expect(arabic_str.arabic_to_kanji).to eq("一〇二四")
        expect(arabic_address.arabic_to_kanji).to eq("東京都港区東麻布三丁目二六番一〇－三〇一号")
        expect(date.arabic_to_kanji).to eq("平成二四年八月三一日")
        expect(capital.arabic_to_kanji).to eq("三三三億三三三三万三三三三")
      end
    end

    context "〇なし" do
      it "アラビア数字を漢数字に変換する" do
        expect(arabic_str.arabic_to_kanji(zero: false)).to eq("千二十四")
        expect(arabic_address.arabic_to_kanji(zero: false)).to eq("東京都港区東麻布三丁目二十六番十－三百一号")
        expect(date.arabic_to_kanji(zero: false)).to eq("平成二十四年八月三十一日")
        expect(capital.arabic_to_kanji(zero: false)).to eq("三百三十三億三千三百三十三万三千三百三十三")
      end
    end
  end

  describe "to_new_moji" do
    let(:takahashi) { "髙橋" }

    it "新字体に変換する" do
      expect(takahashi.to_new_moji).to eq("高橋")
    end
  end

  describe "equal?" do
    let(:word) { "ｱｲｳｴｵ" }
    let(:word2) { "アイウエオ" }
    let(:word3) { "あいうえお" }
    let(:saitou_old) { "齊藤" }
    let(:saitou_new) { "斉藤" }
    let(:kanji_address) { "東京都港区東麻布三丁目二六番一〇－三〇一号" }
    let(:arabic_address) { "東京都港区東麻布3丁目26番10－301号" }

    it "同じ内容と判定した場合はtrueを返却する" do
      expect(word.equal?(word2)).to be_truthy
      expect(word2.equal?(word3)).to be_truthy
      expect(word3.equal?(word)).to be_truthy
      expect(saitou_old.equal?(saitou_new)).to be_truthy
      expect(kanji_address.equal?(arabic_address)).to be_truthy
      expect(arabic_address.equal?(kanji_address)).to be_truthy
    end

    it "異なる内容と判定した場合はfalseを返却する" do
      expect(saitou_new.equal?(saitou_old)).to be_falsey
    end
  end
end
