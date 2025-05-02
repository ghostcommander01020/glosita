<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
</head>
<body>
<h2>Hola {{ $data['name'] }}, gracias por registrarte en <strong>Glosita</strong> !</h2>
<p>Por favor confirma tu correo electrónico.</p>
<p>Para ello simplemente debes hacer click en el siguiente enlace:</p>

<a href="{{ route('email_verify', $data['confirmation_code']) }}">
    Click para confirmar tu email
</a>
</body>
</html>
