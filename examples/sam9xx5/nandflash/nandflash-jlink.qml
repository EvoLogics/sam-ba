import SAMBA 3.1
import SAMBA.Connection.JLink 3.1
import SAMBA.Device.SAM9xx5 3.1

AppletLoader {
	connection: JLinkConnection {
		//port: "99999999"
	}

	device: SAM9xx5EK {
		// to use a custom config, replace SAM9xx5EK by SAM9xx5 and
		// uncomment the following lines, or see documentation for
		// custom board creation.
		//config {
		//	extram {
		//		preset: 1
		//	}
		//	nandflash {
		//		ioset: 1
		//		busWidth: 8
		//		header: 0xc0082405
		//	}
		//}
	}

	onConnectionOpened: {
		// initialize Low-Level applet
		appletInitialize("lowlevel")

		// initialize External RAM applet
		appletInitialize("extram")

		// initialize NAND flash applet
		appletInitialize("nandflash")

		// erase all memory
		appletErase(0, connection.applet.memorySize)

		// write files
		appletWrite(0x000000, "at91bootstrap-sam9-ek.bin", true)
		appletWrite(0x040000, "u-boot-sam9-ek.bin")
		appletWrite(0x0c0000, "u-boot-env-sam9-ek.bin")
		appletWrite(0x180000, "at91-sam9-ek.dtb")
		appletWrite(0x200000, "zImage-sam9-ek.bin")
		appletWrite(0x800000, "atmel-xplained-demo-image-sam9-ek.ubi")
	}
}
