<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<p>
<br/>
</p>
<h4>Chat Room <small>(${user.DNAME })</small></h4>
<div style="height: 520px; overflow-y: scroll; " id="chatView">
	
</div>
<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="chatView">CHAT</span>
  </div>
  <input type="text" class="form-control" aria-describedby="basic-addon1"
  	id="input" >
</div>
<script>
	var chatws = new WebSocket("ws://"+ location.host + "${pageContext.servletContext.contextPath}/timchat.do");
	chatws.onmessage = function(evt){
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		switch(obj.mode){
		case "timChat":
			timChatHandle(obj);
			break;
		}
	};
	
	var timChatHandle = function(obj){
		var txt = obj.text;
		var name = obj.sendUser.NAME;
		var pname = obj.sendUser.PNAME;
		var dname = obj.sendUser.DNAME;
		
		var html = "<div class=\"alert alert-secondary\" role=\"alert\" style=\"padding:3px; margin-bottom:3px;\" >";
		html += name + pname + "( "+dname+" ) : <br/>"+ obj.text;
		html +="</div>";
		document.getElementById("chatView").innerHTML += html;
		document.getElementById("chatView").scrollTop = document.getElementById("chatView").scrollHeight;
	};
	
	document.getElementById("input").onchange = function(){
		console.log(this.value);
		var msg = {
			"mode" : "timChat",
			"text" : this.value
		};
		chatws.send(JSON.stringify(msg));
		this.value="";
	}
</script>