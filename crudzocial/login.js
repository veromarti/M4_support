const form = document.querySelector('form');

form.addEventListener('submit', async (error) => 
{
    error.preventDefault()
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    const response = await fetch(`http://localhost:1115/user?email=${email}`)
    const data = await response.json();

    console.log(data)

    if(data.length > 0){
        if (password == data[0].password) {
            alert('nice')
            
        } else {
            alert('bad auth')
        }
    } else{
        alert('user not found')
    }
})