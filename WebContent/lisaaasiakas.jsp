<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakkaan lisääminen</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td>
				<td><input type="submit" id="tallenna" value="Lisää"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
<script>
$(document).ready(function() {
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	// Lomakkeen tietojen validointi / tarkistus. Lomakkeen tietojen ollessa ok, kutsutaan listaaTiedot()-funktiota
	$("#tiedot").validate({
		rules: {
			etunimi:	{
				required: true,
				minlength: 2
			},
			sukunimi:	{
				required: true,
				minlength: 2
			},
			puhelin:	{
				required: true,
				minlength: 10
			},
			sposti:		{
				required: true,
				minlength: 10
			}
		},
		messages: {
			etunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt etunimi"
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt sukunimi",
			},
			puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt puhelinnumeroksi"
			},
			sposti: {
				required: "Sähköpostiosoite puuttuu",
				minlength: "Liian lyhyt sähköpostisoite"
			}
		},
		submitHanlder: function(form) {
			lisaaTiedot();
		}
	});
	//Kursorin vienti etunimi-kenttään sivun latauksessa
	$("#etunimi").focus();
});

function lisaaTiedot(){
		var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
		console.log(formJsonStr);
		$.ajax({url:"myynti", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
			if(result.response==0){
	        	$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
	        }else if(result.response==1){			
	        	$("#ilmo").html("Asiakkaan lisääminen onnistui.");
	        	$("#etunimi, #sukunimi, #puhelin, #sposti").val("");
			}
	    }});	
	}
</script>
</body>
</html>