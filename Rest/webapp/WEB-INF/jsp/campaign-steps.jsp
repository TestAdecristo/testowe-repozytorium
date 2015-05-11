<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>GetSocial</title>
		
		<link rel="stylesheet" href="/rest/static/css/reset.css">		
		<link rel="stylesheet" href="/rest/static/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="/rest/static/css/style.css">

		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600' rel='stylesheet' type='text/css'>

	</head>
	
	<body>
	
	<div id="wrapper">
		<%@ include file="/WEB-INF/jsp/header.jsp" %>
		
		<section id="content-wrapper">
			<%@ include file="/WEB-INF/jsp/navigation.jsp" %>
			
			<div id="content" class="grid">
				
				<div class="grid-item grid-item-10 last">
					<h2 class="section-title">Campaign steps for campaign: Campaign name</h2>
					
					<div class="grid-item-content">
						<table id="table_privileges">
							<thead>
								<tr>
									<td class="table_cell_username">Nazwa Kroku</td>
									<td>Opis</td>
									<td>Data rozpoczęcia</td>	
									<td>Data ukończenia</td>
									<td>Kolejność</td>	
									<td>Pokaż zawartość</td>	
									<td>Edytuj krok</td>			
									<td>Usuń krok</td>	
								</tr>	
							</thead>
							<tbody>
								<c:forEach var="step" items="${stepList}">
								<tr>
									<td>${step.name}</td>
									<td>${step.description}</td>
									<td>${step.startDate}</td>
									<td>${step.endDate}</td>
									<td>${step.stepOrder}</td>
									<td><a href="#" class="button">Pokaż zawartość</a></td>
									<td>
										
										<form action="#" method="POST">
											<input type="hidden" value="${step.stepId}" name="id_step"> <!-- Tutaj przechowujemy ID step -->
											<input type="submit" class="button" value="Edytuj">
									
										</form>
										
									</td>
									<td>
										<form action="" method="POST">
											<input type="hidden" value="${step.stepId}" name="id_kampanii"> <!-- Tutaj przechowujemy ID step -->
											<input type="submit" class="button button-red" value="Usuń">
										</form>
									</td>
								</tr>
								</c:forEach>	
							</tbody>
						</table>
						
						<a class="button" href="<spring:url value='/campaign-step-add' htmlEscape='true' />">Dodaj nowy krok</a>
						<a class="button" href="<spring:url value='/campaigns' htmlEscape='true' />">Powrót do widoku kampanii</a>
					</div>			
				</div>
			</div>
		</section>
	</div>	
	
	<!-- Load Javascripts -->
	<script>
	
	</script>
	
	</body>
</html>