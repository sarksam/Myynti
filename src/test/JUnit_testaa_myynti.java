package test;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.Assert.assertEquals;
import java.util.ArrayList;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;

import model.Asiakas;
import model.dao.Dao;

@TestMethodOrder(OrderAnnotation.class)
class JUnit_testaa_myynti {

	@Test
	@Order(1)
	public void testPoistaKaikkiAsiakkaat() {
		//Poistetaan kaikki asiakkaat
		Dao dao = new Dao();
		dao.poistaKaikkiAsiakkaat("terminator");
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki();
		assertEquals(0, asiakkaat.size());
	}
	
	@Test
	@Order(2)
	public void testLisaaAsiakas() {
		//Tehd‰‰n testiasiakkaita
		Dao dao = new Dao();
		Asiakas asiakas_1 = new Asiakas ("Sami", "S‰rkilahti", "+3584012345678", "sami.sarkilahti@myy.haaga-helia.fi");
		Asiakas asiakas_2 = new Asiakas ("Teppo", "Tepponen", "+35840234567890", "teppo.tepinen@myy.haaga-helia.fi");
		Asiakas asiakas_3 = new Asiakas ("Seppo", "Sepinen", "+35840234567891", "seppo.sepinen@myy.haaga-helia.fi");
		Asiakas asiakas_4 = new Asiakas ("Reijo", "Repinen", "+35840234567892", "reijo.repinen@myy.haaga-helia.fi");
		Asiakas asiakas_5 = new Asiakas ("Pirjo", "Pirjonen", "+35840234567893", "pirjo.pirjonen@myy.haaga-helia.fi");
		assertEquals(true, dao.lisaaAsiakas(asiakas_1));
		assertEquals(true, dao.lisaaAsiakas(asiakas_2));
		assertEquals(true, dao.lisaaAsiakas(asiakas_3));
		assertEquals(true, dao.lisaaAsiakas(asiakas_4));
		assertEquals(true, dao.lisaaAsiakas(asiakas_5));
	}
	
	@Test
	@Order(3) 
	public void testMuutaAsiakas() {
		//Muutetaan yht‰ asiakasta
		Dao dao = new Dao();
		Asiakas muutettava = dao.etsiAsiakas("Sami");
		muutettava.setEtunimi("Sami");
		muutettava.setSukunimi("S‰rkilahti");
		muutettava.setPuhelin("+358408482292");
		muutettava.setSposti("sami.sarkilahti@myy.haaga.helia.fi");
		dao.muutaAsiakas(muutettava, "Sami");	
		assertEquals("Sami", dao.etsiAsiakas("Sami").getEtunimi());
		assertEquals("S‰rkilahti", dao.etsiAsiakas("S‰rkilahti").getSukunimi());
		assertEquals("+358408482292", dao.etsiAsiakas("+358408482292").getPuhelin());
		assertEquals("sami.sarkilahti@myy.haaga-helia.fi", dao.etsiAsiakas("sami.sarkilahti@myy.haaga-helia.fi").getSposti());
	}
	
	@Test
	@Order(4) 
	public void testPoistaAsiakas() {
		Dao dao = new Dao();
		dao.poistaAsiakas(11);
		assertEquals(null, dao.etsiAsiakas("Sami"));
	}
}
