package WocliApiServer::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

sub login {
	
	print "[WocliApiServer::Controller::Login::login] called\n";
	my $self = shift;
	my $args = shift;
	my $cb = shift;
	my $user = $self->param('user') || '';
	my $pass = $self->param('pass') || '';
	return $self->render(status => 401, json => {"X-Wocli-Key-ID" => "null"}) unless $self->users->check($user, $pass);

	$self->session(user => $user);
	
	$self->res->headers->add("X-Wocli-Key-ID" => "asdfghjkl");
	$self->render(status => 200, json => {"X-Wocli-Key-ID" => "asdfghjkl"});
}

sub logged_in {
	my $self = shift;
	return 1 if $self->session('user');
	$self->redirect_to('index');
	return undef;
}

sub logout {
	my $self = shift;
	$self->session(expires => 1);
	$self->redirect_to('index');
}

1;
