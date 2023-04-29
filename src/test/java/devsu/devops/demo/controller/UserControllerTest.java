package devsu.devops.demo.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

@AutoConfigureMockMvc
@SpringBootTest
@DisplayName("User controller")
public class UserControllerTest {

	@Autowired
	private MockMvc mockMvc;

	private final String relativePath = "/users";

	@Test
	@DisplayName("GET: " + relativePath + ": ✔ Status code 200")
	void getUsers_statusOk() throws Exception {
		mockMvc.perform(
				get(relativePath)
				.characterEncoding("utf-8")
				)
		.andExpect(status().isOk());
	}

	@Test
	@DisplayName("GET: " + relativePath + "/health: ✔ Status code 200")
	void getHealth_statusOk() throws Exception {
		MvcResult resultado = mockMvc.perform(
				get(relativePath+ "/health")
				.characterEncoding("utf-8")
				).andReturn();
				assertEquals(200, resultado.getResponse().getStatus(), "Resultado no esperado");
				assertEquals("OK", resultado.getResponse().getContentAsString(), "Resultado no esperado");
	}	
}
