package app.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import app.service.AlertService;

@Controller
public class AlertSocketController extends TextWebSocketHandler{
	
	@Autowired
	Gson gson;
	
	@Autowired
	AlertService service;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		service.addSocket(session);
		Map<String, Object> attrs = session.getAttributes();	
	
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		service.removeSocket(session);
	}
	
/*	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String payload = message.getPayload();
		System.out.println("handleTextMessage : " + payload);
		
		service.sendAll(payload);
	}*/
	
}
