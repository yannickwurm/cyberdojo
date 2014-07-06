  test 'chunk with a space in its filename' do
    lines =
    [
      'diff --git a/sandbox/file with_space b/sandbox/file with_space',
      'new file mode 100644',
      'index 0000000..21984c7',
      '--- /dev/null',
      '+++ b/sandbox/file with_space',
      '@@ -0,0 +1 @@',
      '+Please rename me!',
      '\\ No newline at end of file'
    ].join("\n")
            'diff --git a/sandbox/file with_space b/sandbox/file with_space',
            'new file mode 100644',
            'index 0000000..21984c7',
                  :added_lines   => [ 'Please rename me!' ],
    source_lines =
    [
      'Please rename me!'
    ].join("\n")
      section(0),
      added_line('Please rename me!', 1),
  test 'chunk with defaulted now line info' do
    lines =
    [
      'diff --git a/sandbox/untitled_5G3 b/sandbox/untitled_5G3',
      'index e69de29..2e65efe 100644',
      '--- a/sandbox/untitled_5G3',
      '+++ b/sandbox/untitled_5G3',
      '@@ -0,0 +1 @@',
      '+aaa',
      '\\ No newline at end of file'
    ].join("\n")

    # http://www.artima.com/weblogs/viewpost.jsp?thread=164293
    # Is a blog entry by Guido van Rossum.
    # He says that in L,S the ,S can be omitted if the chunk size
    # S is 1. So -3 is the same as -3,1
            'diff --git a/sandbox/untitled_5G3 b/sandbox/untitled_5G3',
            'index e69de29..2e65efe 100644'
                  :added_lines   => [ 'aaa' ],
    source_lines =
    [
      'aaa'
    ].join("\n")
      section(0),
      added_line('aaa', 1),
  test 'two chunks with leading and trailing same lines ' +
       'and no newline at eof' do

    diff_lines =
    [
      'diff --git a/sandbox/lines b/sandbox/lines',
      'index b1a30d9..7fa9727 100644',
      '--- a/sandbox/lines',
      '+++ b/sandbox/lines',
      '@@ -1,5 +1,5 @@',
      ' aaa',
      '-bbb',
      '+ccc',
      ' ddd',
      ' eee',
      ' fff',
      '@@ -8,6 +8,6 @@',
      ' nnn',
      ' ooo',
      ' ppp',
      '-qqq',
      '+rrr',
      ' sss',
      ' ttt',
      '\\ No newline at end of file'
    ].join("\n")
            'diff --git a/sandbox/lines b/sandbox/lines',
            'index b1a30d9..7fa9727 100644'
              :before_lines => [ 'aaa' ],
                  :deleted_lines => [ 'bbb' ],
                  :added_lines   => [ 'ccc' ],
                  :after_lines => [ 'ddd', 'eee', 'fff' ]
              :before_lines => [ 'nnn', 'ooo', 'ppp' ],
                  :deleted_lines => [ 'qqq' ],
                  :added_lines   => [ 'rrr' ],
                  :after_lines => [ 'sss', 'ttt' ]
    source_lines =
    [
      'aaa',
      'ccc',
      'ddd',
      'eee',
      'fff',
      'ggg',
      'hhh',
      'nnn',
      'ooo',
      'ppp',
      'rrr',
      'sss',
      'ttt'
    ].join("\n")
      same_line('aaa', 1),
      section(0),
      deleted_line('bbb', 2),
      added_line('ccc', 2),
      same_line('ddd',  3),
      same_line('eee',  4),
      same_line('fff',  5),
      same_line('ggg',  6),
      same_line('hhh',  7),
      same_line('nnn',  8),
      same_line('ooo',  9),
      same_line('ppp', 10),
      section(1),
      deleted_line('qqq', 11),
      added_line('rrr', 11),
      same_line('sss', 12),
      same_line('ttt', 13)
  test 'two chunks first and last lines change ' +
       'and are 7 lines apart' do
    # diffs need to be 7 lines apart not to be merged
    # into contiguous sections in one chunk

    diff_lines =
    [
      'diff --git a/sandbox/lines b/sandbox/lines',
      'index 0719398..2943489 100644',
      '--- a/sandbox/lines',
      '+++ b/sandbox/lines',
      '@@ -1,4 +1,4 @@',
      '-aaa',
      '+bbb',
      ' ccc',
      ' ddd',
      ' eee',
      '@@ -6,4 +6,4 @@',
      ' ppp',
      ' qqq',
      ' rrr',
      '-sss',
      '+ttt'
    ].join("\n")
            'diff --git a/sandbox/lines b/sandbox/lines',
            'index 0719398..2943489 100644'
                  :deleted_lines => [ 'aaa' ],
                  :added_lines   => [ 'bbb' ],
                  :after_lines => [ 'ccc', 'ddd', 'eee' ]
              :before_lines => [ 'ppp', 'qqq', 'rrr' ],
                  :deleted_lines => [ 'sss' ],
                  :added_lines   => [ 'ttt' ],
    source_lines =
    [
      'bbb',
      'ccc',
      'ddd',
      'eee',
      'fff',
      'ppp',
      'qqq',
      'rrr',
      'ttt'
    ].join("\n")
      section(0),
      deleted_line('aaa', 1),
      added_line('bbb', 1),
      same_line('ccc', 2),
      same_line('ddd', 3),
      same_line('eee', 4),
      same_line('fff', 5),
      same_line('ppp', 6),
      same_line('qqq', 7),
      same_line('rrr', 8),
      section(1),
      deleted_line('sss', 9),
      added_line('ttt', 9)
  test 'one chunk with two sections ' +
       'each with one line added and one line deleted' do

    diff_lines =
    [
      'diff --git a/sandbox/lines b/sandbox/lines',
      'index 535d2b0..a173ef1 100644',
      '--- a/sandbox/lines',
      '+++ b/sandbox/lines',
      '@@ -1,8 +1,8 @@',
      ' aaa',
      ' bbb',
      '-ccc',
      '+ddd',
      ' eee',
      '-fff',
      '+ggg',
      ' hhh',
      ' iii',
      ' jjj'
    ].join("\n")
            'diff --git a/sandbox/lines b/sandbox/lines',
            'index 535d2b0..a173ef1 100644'
              :before_lines => [ 'aaa', 'bbb' ],
                  :deleted_lines => [ 'ccc' ],
                  :added_lines   => [ 'ddd' ],
                  :after_lines => [ 'eee' ]
                  :deleted_lines => [ 'fff' ],
                  :added_lines   => [ 'ggg' ],
                  :after_lines => [ 'hhh', 'iii', 'jjj' ]
    source_lines =
    [
      'aaa',
      'bbb',
      'ddd',
      'eee',
      'ggg',
      'hhh',
      'iii',
      'jjj'
    ].join("\n")
      same_line('aaa', 1),
      same_line('bbb', 2),
      section(0),
      deleted_line('ccc', 3),
      added_line('ddd', 3),
      same_line('eee', 4),
      section(1),
      deleted_line('fff', 5),
      added_line('ggg', 5),
      same_line('hhh', 6),
      same_line('iii', 7),
      same_line('jjj', 8)
  test 'one chunk with one section with only lines added' do

    diff_lines =
    [
      'diff --git a/sandbox/lines b/sandbox/lines',
      'index 06e567b..59e88aa 100644',
      '--- a/sandbox/lines',
      '+++ b/sandbox/lines',
      '@@ -1,6 +1,9 @@',
      ' aaa',
      ' bbb',
      ' ccc',
      '+ddd',
      '+eee',
      '+fff',
      ' ggg',
      ' hhh',
      ' iii'
    ].join("\n")
              :before_lines => [ 'aaa', 'bbb', 'ccc' ],
                  :added_lines   => [ 'ddd', 'eee', 'fff' ],
                  :after_lines => [ 'ggg', 'hhh', 'iii' ]
    source_lines =
    [
      'aaa',
      'bbb',
      'ccc',
      'ddd',
      'eee',
      'fff',
      'ggg',
      'hhh',
      'iii',
      'jjj'
    ].join("\n")
      same_line('aaa', 1),
      same_line('bbb', 2),
      same_line('ccc', 3),
      section(0),
      added_line('ddd', 4),
      added_line('eee', 5),
      added_line('fff', 6),
      same_line('ggg', 7),
      same_line('hhh', 8),
      same_line('iii', 9),
      same_line('jjj', 10)
  test 'one chunk with one section with only lines deleted' do

    diff_lines =
    [
      'diff --git a/sandbox/lines b/sandbox/lines',
      'index 0b669b6..a972632 100644',
      '--- a/sandbox/lines',
      '+++ b/sandbox/lines',
      '@@ -2,8 +2,6 @@',
      ' bbb',
      ' ccc',
      ' ddd',
      '-EEE',
      '-FFF',
      ' ggg',
      ' hhh',
      ' iii'
    ].join("\n")
            'diff --git a/sandbox/lines b/sandbox/lines',
            'index 0b669b6..a972632 100644'
              :before_lines => [ 'bbb', 'ccc', 'ddd' ],
                  :deleted_lines => [ 'EEE', 'FFF' ],
                  :after_lines => [ 'ggg', 'hhh', 'iii' ]
    source_lines =
    [
      'aaa',
      'bbb',
      'ccc',
      'ddd',
      'ggg',
      'hhh',
      'iii',
      'jjj'
    ].join("\n")
      same_line('aaa', 1),
      same_line('bbb', 2),
      same_line('ccc', 3),
      same_line('ddd', 4),
      section(0),
      deleted_line('EEE', 5),
      deleted_line('FFF', 6),
      same_line('ggg', 5),
      same_line('hhh', 6),
      same_line('iii', 7),
      same_line('jjj', 8)
  test 'one chunk with one section ' +
       'with more lines deleted than added' do

    diff_lines =
    [
      'diff --git a/sandbox/lines b/sandbox/lines',
      'index 08fe19c..1f8695e 100644',
      '--- a/sandbox/lines',
      '+++ b/sandbox/lines',
      '@@ -3,9 +3,7 @@',
      ' ddd',
      ' eee',
      ' fff',
      '-ggg',
      '-hhh',
      '-iii',
      '+jjj',
      ' kkk',
      ' lll',
      ' mmm'
    ].join("\n")
            'diff --git a/sandbox/lines b/sandbox/lines',
            'index 08fe19c..1f8695e 100644'
              :before_lines => [ 'ddd', 'eee', 'fff' ],
                  :deleted_lines => [ 'ggg', 'hhh', 'iii' ],
                  :added_lines   => [ 'jjj' ],
                  :after_lines => [ 'kkk', 'lll', 'mmm' ]
    source_lines =
    [
      'bbb',
      'ccc',
      'ddd',
      'eee',
      'fff',
      'jjj',
      'kkk',
      'lll',
      'mmm',
      'nnn'
    ].join("\n")
      same_line('bbb', 1),
      same_line('ccc', 2),
      same_line('ddd', 3),
      same_line('eee', 4),
      same_line('fff', 5),
      section(0),
      deleted_line('ggg', 6),
      deleted_line('hhh', 7),
      deleted_line('iii', 8),
      added_line('jjj', 6),
      same_line('kkk', 7),
      same_line('lll', 8),
      same_line('mmm', 9),
      same_line('nnn', 10)
  test 'one chunk with one section ' +
       'with more lines added than deleted' do

    diff_lines =
    [
      'diff --git a/sandbox/lines b/sandbox/lines',
      'index 8e435da..a787223 100644',
      '--- a/sandbox/lines',
      '+++ b/sandbox/lines',
      '@@ -3,7 +3,8 @@',
      ' ccc',
      ' ddd',
      ' eee',
      '-fff',
      '+XXX',
      '+YYY',
      ' ggg',
      ' hhh',
      ' iii'
    ].join("\n")
            'diff --git a/sandbox/lines b/sandbox/lines',
            'index 8e435da..a787223 100644'
              :before_lines => [ 'ccc', 'ddd', 'eee' ],
                  :deleted_lines => [ 'fff' ],
                  :added_lines   => [ 'XXX', 'YYY' ],
                  :after_lines => [ 'ggg', 'hhh', 'iii' ]
    source_lines =
    [
      'aaa',
      'bbb',
      'ccc',
      'ddd',
      'eee',
      'XXX',
      'YYY',
      'ggg',
      'hhh',
      'iii',
      'jjj',
      'kkk',
      'lll',
      'mmm'
    ].join("\n")
      same_line('aaa', 1),
      same_line('bbb', 2),
      same_line('ccc', 3),
      same_line('ddd', 4),
      same_line('eee', 5),
      section(0),
      deleted_line('fff', 6),
      added_line('XXX',6),
      added_line('YYY',7),
      same_line('ggg',   8),
      same_line('hhh',   9),
      same_line('iii',  10),
      same_line('jjj', 11),
      same_line('kkk', 12),
      same_line('lll', 13),
      same_line('mmm',14),
  test 'one chunk with one section ' +
       'with one line deleted and one line added' do

    diff_lines =
    [
      'diff --git a/sandbox/lines b/sandbox/lines',
      'index 5ed4618..aad3f67 100644',
      '--- a/sandbox/lines',
      '+++ b/sandbox/lines',
      '@@ -5,7 +5,7 @@',
      ' aaa',
      ' bbb',
      ' ccc',
      '-QQQ',
      '+RRR',
      ' ddd',
      ' eee',
      ' fff'
    ].join("\n")
            'diff --git a/sandbox/lines b/sandbox/lines',
            'index 5ed4618..aad3f67 100644'
              :before_lines => [ 'aaa', 'bbb', 'ccc' ],
                  :deleted_lines => [ 'QQQ' ],
                  :added_lines   => [ 'RRR' ],
                  :after_lines => [ 'ddd', 'eee', 'fff' ]
    source_lines =
    [
      'zz',
      'yy',
      'xx',
      'ww',
      'aaa',
      'bbb',
      'ccc',
      'RRR',
      'ddd',
      'eee',
      'fff',
      'ggg',
      'hhh'
    ].join("\n")
      'zz', 'yy', 'xx', 'ww', 'aaa', 'bbb', 'ccc',
      'RRR',
      'ddd', 'eee', 'fff', 'ggg', 'hhh'
      same_line('zz', 1),
      same_line('yy', 2),
      same_line('xx', 3),
      same_line('ww', 4),
      same_line('aaa', 5),
      same_line('bbb', 6),
      same_line('ccc', 7),
      section(0),
      deleted_line('QQQ', 8),
      added_line('RRR', 8),
      same_line('ddd',   9),
      same_line('eee', 10),
      same_line('fff', 11),
      same_line('ggg', 12),
      same_line('hhh', 13)
  def same_line(line,number)
    { :line => line, :type => :same, :number => number }
  end

  def deleted_line(line,number)
    { :line => line, :type => :deleted, :number => number }
  end

  def added_line(line,number)
    { :line => line, :type => :added, :number => number }
  end

  def section(index)
    { :type => :section, :index => index }