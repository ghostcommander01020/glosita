<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
</head>
<body>
<h2>Hola {{ $data['user']->name }}, para recuperar tu cuenta de Glosita solo debes acceder al siguiente enlace  </h2>

<p>Para ello simplemente debes hacer click en el siguiente enlace:</p>

<a href="{{url('/')}}/reset/password/{{$data['user']->confirmation_code}}">
    Click para confirmar tu email
</a>
</body>
</html>