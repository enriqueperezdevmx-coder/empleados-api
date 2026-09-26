#!/usr/bin/env bash
API=http://localhost:8080/api/empleados

paso() {
    echo
    echo "### $1"
    echo "$2 $3"
    if [ -n "$4" ]; then
        curl -s -X "$2" "$API$3" -H "Content-Type: application/json" -d "$4" -w '\nHTTP %{http_code}\n'
    else
        curl -s -X "$2" "$API$3" -w '\nHTTP %{http_code}\n'
    fi
}

echo "Evidencia CRUD  $(date +'%Y-%m-%d %H:%M') $(git config user.name)"

paso "1. Crear empleado válido 201" POST "" '{"nombre":"Laura","apellidos":"Gómez","email":"laura.gomez@empresa.com","puesto":"Desarrolladora","departamento":"Tecnología","salario":35000,"fechaIngreso":"2024-01-15","activo":true}'
paso "2. Email repetido 409" POST "" '{"nombre":"Laura 2","apellidos":"Gómez","email":"laura.gomez@empresa.com","puesto":"Desarrolladora","departamento":"Tecnología","salario":35000,"fechaIngreso":"2024-01-15","activo":true}'
paso "3. Validación fallida 400" POST "" '{"nombre":"","apellidos":"","email":"invalido","puesto":"","departamento":"","salario":-10,"fechaIngreso":"2030-01-01"}'
paso "4. JSON mal formado 400" POST "" '{nombre: roto}'
paso "5. Listar todos 200" GET ""
paso "6. Buscar por ID existente 200" GET "/1"
paso "7. Buscar por ID inexistente 404" GET "/999"
paso "8. Modificar empleado 200" PUT "/1" '{"nombre":"Mariana","apellidos":"Sánchez Actualizada","email":"mariana.actualizada@academia.mx","puesto":"Líder Técnica","departamento":"Tecnología","salario":55000,"fechaIngreso":"2021-02-15","activo":true}'
paso "9. Modificar con email de otro 409" PUT "/1" '{"nombre":"Mariana","apellidos":"Sánchez","email":"jorge.ramirez@academia.mx","puesto":"Líder","departamento":"Tecnología","salario":55000,"fechaIngreso":"2021-02-15","activo":true}'
paso "10. Modificar ID inexistente 404" PUT "/999" '{"nombre":"Nadie","apellidos":"Nadie","email":"nadie@empresa.com","puesto":"Dev","departamento":"Tecnología","salario":30000,"fechaIngreso":"2024-01-01","activo":true}'
paso "11. Eliminar empleado 204" DELETE "/1"
paso "12. Eliminar ID inexistente 404" DELETE "/999"
