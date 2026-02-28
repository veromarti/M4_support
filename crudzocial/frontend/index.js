const tbody = document.querySelector('tbody');


fetch('http://localhost:1115/users').then(response => response.json()).then(users => {
    users.forEach(user => {
        tbody.innerHTML += `<tr>
          <th scope="row">${user.id}</th>
          <td>${user.full_name}</td>
          <td>${user.email}</td>
        </tr>`
    });
});

const users = await fetch('http://localhost:1115/users').then(response => response.json()).then(users => users)

console.log(users)


