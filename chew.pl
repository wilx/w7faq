use strict;

local $/;

my $text = <>;

my $sol = qr/(?:\A|^)/m;
my $eol = qr/[\n]/;
my $max3w = qr/\w+(?:\s+\w+(?:\s+\w+)?)?/x;

# Heading 1

$text =~ s/$sol[_]+$eol
$sol\s*$eol
$sol\|\s*-+((?:[^-]|-[^-])+)-+\s*\|$eol
$sol[_]+$eol
/\n# $1\n\n/gmx;

# Heading 3

$text =~ s/((?:$sol-+$eol)?)
$sol\s*--((?:[^-]|-[^-])+)--\s*$eol
\1
/## $2\n\n/xmg;

# Heading 2

$text =~ s/((?:$sol-+$eol)?)
$sol\s*-([^-]+)-\s*$eol
\1
/### $2\n\n/xmg;

$text =~ s/$sol-+$eol
(\#+.+$eol)
/\n$1/xmg;

# Horizontal ruleres

$text =~ s/$sol\s*-+$eol/\n----\n\n/gmx;

# List headings

$text =~ s/(\w+)\s*(:?)\s*$eol
$sol(\s*\*)
/$1$2\n\n$3/gmx;

#$text =~ s/$sol(\s*$max3w)\s*$eol//gmx;

# Q and A

$text =~ s/(?<!$eol)$eol[A]:/\n\nA:/gmx;

# Tables

$text =~ s/\|$eol
$sol(\w)/|\n\n$1/gmx;

$text =~ s,$sol\|[\s\|]+$eol,,gmx;
$text =~ s,(_+)\|(_*),('-'x(length($1))).'+'.('-'x(length($2))),gmxe;
$text =~ s,$sol\s(_+)\s*$eol,"\n+".('-'x(length($1)))."+\n",gmxe;
$text =~ s,\|-,+-,gmx;
$text =~ s,-\|,-+,gmx;
#$text =~ s/\s__/+--/gmx;

pos($text) = 0;
while ($text =~ /\G-/)
{
    my $savepos = pos($text);
    s
}

$text =~ s,\.\s\s$eol,\n,gmx;

print $text;
