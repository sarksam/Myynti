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
<title>Asiakkaan tietojen muuttaminen</title>
</head>
<body>
<form id="tiedot">
	<table class="table">
		<thead>
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>
				<th>Hallinta</th>
			</tr>
		</thead>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td>
				<td><input type="submit" id="Tallenna" value="tallenna"></td>
		<tbody>
		</tbody>
	</table>
	<input type="hidden" name="asiakas_id" id="asiakas_id">
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	$("#etunimi").focus();//viedään kursori etunimi-kenttään sivun latauksen yhteydessä
	
	//Haetaan muutettavan asiakkaan tiedot. Kutsutaan backin GET-metodia ja välitetään kutsun mukana muutettavan tiedon id
	//GET /myynti/haeyksi/asiakas_id
	var asiakas_id = requestURLParam("asiakas_id"); //Funktio löytyy scripts/main.js 	
	$.ajax({url:"myynti/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){	
		$("#asiakas_id").val(result.asiakas_id);
		$("#etunimi").val(result.etunimi);	
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);	
		$("#asiakas_id").val(result.asiakas_id);
    }});	
	
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
			paivitaTiedot();
		}
	});
});

// funktio tietojen päivittämistä varten. Kutsutaan backin PUT-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä. 
//PUT /myynti/
function paivitaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	console.log(formJsonStr);
	$.ajax({url:"myynti", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
		if(result.response==0) {
		$.("#ilmo").html("Asiakkaan päivittäminen epäonnistui.");
	}else if(result.response==1){
			$("#ilmo").html("Asiakkaan päivittäminen onnistui.");
			}
	}});
}
</script>
</html>