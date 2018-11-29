require 'minitest/autorun'

def parse(txt)
  # ...
end

class RubyQuizTest < MiniTest::Test
  def test_parse_level1
    records = [["A", "B", "C", "D"],
               ["a", "b", "c", "d"],
               ["e", "f", "g", "h"],
               [" i ", " j ", " k ", " l "],
               ["", "", "", ""],
               ["", "", "", ""]]
    txt =
      <<~TXT
        A,B,C,"D"
        # plain values
        a,b,c,d
        # spaces before and after
         e ,f , g,h
        # quoted: with spaces before and after
        " i ", " j " , " k "," l "
        # empty values
        ,,,
        # empty quoted values
        "","","",""
        # 3 empty lines



        # EOF on next line
      TXT

    assert_equal records, parse(txt)
  end

  def test_parse_level2
    records = [["1", "Hamlet says, \"Seems,\" madam! Nay it is; I know not \"seems.\""]]
    txt =
      <<~TXT
        1, "Hamlet says, ""Seems,"" madam! Nay it is; I know not ""seems."""
      TXT
    assert_equal records, parse(txt)
  end

  def test_parse_level3
    records = [["1", "Hamlet says, \"Seems,\" madam! Nay it is; I know not \"seems.\""]]
    txt =
      <<~TXT
        1, "Hamlet says, \\"Seems,\\" madam! Nay it is; I know not \\"seems.\\""
      TXT
    assert_equal records, parse(txt)
  end

  def test_parse_level4
    records = [["1", "Hamlet says, 'Seems,' madam! Nay it is; I know not 'seems.'"],
               ["2", 'Hamlet says, "Seems," madam! Nay it is; I know not "seems."']]
    txt =
      <<~TXT
        1, "Hamlet says, 'Seems,' madam! Nay it is; I know not 'seems.'"
        2, 'Hamlet says, "Seems," madam! Nay it is; I know not "seems."'
      TXT
    assert_equal records, parse(txt)
  end
end
