<%-- 
    Document   : home
    Created on : 18-mar-2020, 9:39:35
    Author     : Alberto
--%>

<%@page import="entities.Rating"%>
<%@page import="entities.Movie"%>
<%@page import="entities.Person"%>
<%@page import="java.util.List"%>
<%@page import="entities.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/mycss.css">
</head>

<body>
        <%
     String msg = (String)session.getAttribute("msg");
     Usuario user = (Usuario) session.getAttribute("usuario");
     if (msg!=null) {%>
        <div class="alert alert-warning alert-dismissible fade show text-center" role="alert">
            <%= msg%>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%session.removeAttribute("msg");
     }
    List<Person> personas = (List<Person>)session.getAttribute("personas");
    List<Movie> peliculas = (List<Movie>)session.getAttribute("peliculas");
    List<Rating> puntos = (List<Rating>)session.getAttribute("puntos");
    String ficha = (String)session.getAttribute("ficha");
  %>
    <div class="container shadow px-0">
        <nav class="navbar navbar-expand-sm navbar-dark bg-dark mb-3">
            <img class="navbar-brand logo" src="img/logotmdb.png" />
            <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse"
                data-target="#collapsibleNavId" aria-controls="collapsibleNavId" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="collapsibleNavId">
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item active">
                        <a class="nav-link <%=(ficha.equals("person")?"active":"")%>" href="Controller?op=personomovie&ficha=person">Person <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%=(ficha.equals("movie")?"active":"")%>" href="Controller?op=personomovie&ficha=movie">Movie</a>
                    </li>
                </ul>
                <%if (user!=null) {%>
                    <form class="row ml-auto" action="Controller?op=logout" method="POST">
                        <div class="col">
                            <h4 class="text-white m-2">Welcome, <%= user.getNombre()%>!</h4> 
                        </div>
                        <div class="col">
                            <button type="submit" class="btn bg-dark borderverde text-white">Log Out</button>
                        </div>
                    </form>
                <%}else {%>
                    <form class="row ml-auto" action="Controller?op=login" method="POST">
                        <div class="col">
                            <input type="text" class="form-control" name="dni" placeholder="DNI">
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="nombre" placeholder="Nombre">
                        </div>
                        <div class="col">
                            <button type="submit" class="btn bg-dark borderverde text-white">Login/Register</button>
                        </div>
                    </form>
                <%}%>
            </div>
        </nav>
        
        
        <div class="row justify-content-center">
            <%if (ficha.equals("person")) { 
                // pinto persons
                for (Person person:personas){
            %>
            <div class="col-10 col-md-5 col-lg-4">
                <div class="card m-2">
                    <img src=" https://image.tmdb.org/t/p/w500<%=person.getFoto() %>" class="card-img-top" alt="...">
                    <div class="card-body">
                        <span class="rating2 d-flex justify-content-center">
                            
                            <% 
                            int n = 0;
                            int cuenta = 0;
                            
                            for(Rating rating: puntos){
                                if(rating.getIdperson().getId() ==(person.getId())){
                                    cuenta += (rating.getPuntos());
                                    n += 1;
                                }
                                
                            }
                            if(n!=0){
                                int estrellas = (int)cuenta/n;
                                for(int i = 0; i <= estrellas; i = i + 1)
                                {%>
                                    <a class="disabled">&#9733;</a>
                                
                                <%}}
                             %>
                            
                           
                        </span>
                         
                        <h5 class="card-title d-flex justify-content-center"><%=person.getNombre()%></h5>
                        <%if (user!=null){%>
                        <span class="rating d-flex justify-content-center">
                            <a href="Controller?op=rating&rating=1&id=<%=person.getId()%>">&#9733;</a>
                            <a href="Controller?op=rating&rating=2&id=<%=person.getId()%>">&#9733;</a>
                            <a href="Controller?op=rating&rating=3&id=<%=person.getId()%>">&#9733;</a>
                            <a href="Controller?op=rating&rating=4&id=<%=person.getId()%>">&#9733;</a>
                            <a href="Controller?op=rating&rating=5&id=<%=person.getId()%>">&#9733;</a>
                        </span>
                        <%}%>
                    </div>
                     <%if (user!=null){%>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-center">
                            <button class="btn bgverde text-white"  data-id="<%=person.getId()%>" data-toggle="modal" data-target="#modalpeliculas">Filmografia</button>
                        </li>
                    </ul>
                    <%}%>
                </div>
            </div>
            <% 
       }}   %>
        </div>
        
        <div class="row justify-content-center">
            <%if (ficha.equals("movie")) { 
                // pinto persons
                for (Movie movie:peliculas){
            %>
            <div class="col-10 col-md-5">
                <div class="card mb-3" style="max-width: 540px;">
                    <div class="row no-gutters">
                        <div class="col-md-4">
                            <img src=" https://image.tmdb.org/t/p/w500<%=movie.getPoster() %>" class="card-img" alt="...">
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <h3 class="card-title"><%=movie.getTitulo()%></h3>
                                <h5 class="card-text"><%=movie.getFecha()%></h5>
                                <p class="card-text"><%=movie.getTrama()%></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% 
       }}   %>
        </div>
        <footer>
            <h1 class="d-flex justify-content-center align-middle bg-dark textverde h100">The MovieDB - Azarquiel 2020
            </h1>
        </footer>
        
         <!-- Modal -->
        <div class="modal fade" id="modalpeliculas" tabindex="-1" role="dialog" aria-labelledby="modelTitleId" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modal title</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                    </div>
                    <div class="modal-body">
                        Body
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <script src="js/myjs.js"></script>

</body>
</html>
