sub main()
  m.port = createObject("roMessagePort")
	screen = createObject("roSgScreen")
	screen.setMessagePort(m.port)
	scene = screen.createScene("demo")
	screen.show()

	while(true)
		msg = wait(0, m.port)
		msgType = type(msg)
		if msgType = "roSgScreenEvent"
			if msg.isScreenClosed() then return
		end if
  end while
end sub
