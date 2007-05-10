package make::opensslcert;

use Exporter 'import';
use make::configure;
@EXPORT = qw(make_openssl_cert);


sub make_openssl_cert()
{
	open (FH, ">openssl.template");
	my $org = promptstring_s("Please enter the organization name", "My IRC Network");
	my $unit = promptstring_s("Please enter the unit Name", "Server Admins");
	my $state = promptstring_s("Please enter your state or locality name", "Alaska");
	my $country = promptstring_s("Please enter your country (two letter code)", "US");
	my $city = promptstring_s("Please enter your city", "Factory Town");
	my $email = promptstring_s("Please enter a contact email address", "oompa\@loompa.com");
	print FH <<__END__;
$country
$state
$city
$org
$unit
$email
firstname.lastname@yourcompany.com
__END__
close(FH);
system("cat openssl.template | openssl req -x509 -nodes -newkey rsa:1024 -keyout key.pem -out cert.pem 2>/dev/null");
system("openssl dhparam -out dhparams.pem 1024");
unlink("openssl.template");
}

1;
