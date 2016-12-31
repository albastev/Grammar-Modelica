#!perl6

use v6;
use Test;
use lib '..\lib';
use Grammar::Modelica;

plan 59;

grammar TestString is Grammar::Modelica {
  rule TOP {^<STRING>$}
}
ok TestString.parse('"Pizza&Stuff"');
ok TestString.parse('"This should be a good string...\\r\\n"');

ok TestString.parse('"Pizza९Stuff"');
nok TestString.parse('"Pizza"&"Stuff"');
ok TestString.parse('"Pizza\\"&\\"Stuff"');
nok TestString.parse('"Pizza\\Stuff"');
ok TestString.parse('"Pizza\\\\Stuff"');

grammar TestQChar is Grammar::Modelica {
  rule TOP {^<Q-CHAR>$}
}
ok TestQChar.parse('P');
ok TestQChar.parse('9');
ok TestQChar.parse('&');
ok TestQChar.parse('#');
nok TestQChar.parse('९');

grammar TestSChar is Grammar::Modelica {
  rule TOP {^<S-CHAR>$}
}
ok TestSChar.parse('P');
ok TestSChar.parse('9');
ok TestSChar.parse('&');
ok TestSChar.parse('#');
ok TestSChar.parse('९');

grammar TestQIdent is Grammar::Modelica {
  rule TOP {^<Q-IDENT>$}
}
ok TestQIdent.parse("'Pizza_Stuff123'");

grammar TestName is Grammar::Modelica {
  rule TOP {^<name>$}
}
ok TestName.parse('Pizza_Stuff123');
ok TestName.parse("'Pizza_Stuff123'");
nok TestName.parse("9wrong");
nok TestName.parse('$wrong');
nok TestName.parse('wr९ng');
ok TestName.parse("_fine");

grammar TestComment is Grammar::Modelica {
  rule TOP {^<comment>$}
}

ok TestComment.parse('//this is a comment');
ok TestComment.parse('//this is a comment ');
ok TestComment.parse('/*this is a comment*/');

grammar TestWS is Grammar::Modelica {
  rule TOP {^<ws>$}
}

ok TestWS.parse(' //this is a comment');
ok TestWS.parse(' //this is a comment ९');
ok TestWS.parse('//this is a comment ');
ok TestWS.parse('/*this is a comment*/ ');
ok TestWS.parse('/*this is a comment९*/ ');
ok TestWS.parse(' /*this is a comment*/');
ok TestWS.parse(" /*this is a comment*/\n");
ok TestWS.parse(" /*this is\n a comment*/\n");
nok TestWS.parse(" //*this is\n a comment*/\n");
nok TestWS.parse('cow /*this is a comment*/');
nok TestWS.parse('/*this is a comment*/ cow');
nok TestWS.parse("//this is a comment\nnot this though...");

grammar TestWS2 is Grammar::Modelica {
  rule TOP {^<IDENT><ws><IDENT>$}
}

ok TestWS2.parse('cow/*this is a comment*/ cow');
ok TestWS2.parse('cow/*this is a comment*/cow');
ok TestWS2.parse('cow /*this is a comment*/cow');
ok TestWS2.parse("cow /*this is a comment*/\ncow");
ok TestWS2.parse("cow//this is a comment\ncow");

grammar TestUnsignedInteger is Grammar::Modelica {
  rule TOP {^<UNSIGNED_INTEGER>$}
}

ok TestUnsignedInteger.parse('12');
nok TestUnsignedInteger.parse('1 2');

grammar TestUnsignedNumber is Grammar::Modelica {
  rule TOP {^<UNSIGNED_NUMBER>$}
}

ok TestUnsignedNumber.parse('12');
nok TestUnsignedNumber.parse('1 2');
ok TestUnsignedNumber.parse('12.34');
nok TestUnsignedNumber.parse('12 .34');
nok TestUnsignedNumber.parse('12. 34');
ok TestUnsignedNumber.parse('12.34e-56');
ok TestUnsignedNumber.parse('12.34E-56');
ok TestUnsignedNumber.parse('12.34e+56');
nok TestUnsignedNumber.parse('12.34 e+56');
nok TestUnsignedNumber.parse('12.34e +56');
nok TestUnsignedNumber.parse('12.34e+ 56');
nok TestUnsignedNumber.parse('12.34e+56 ');
nok TestUnsignedNumber.parse(' 12.34e+56');
