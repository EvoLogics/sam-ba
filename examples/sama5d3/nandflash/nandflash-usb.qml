import SAMBA 3.1
import SAMBA.Connection.Serial 3.1
import SAMBA.Device.SAMA5D3 3.1

AppletLoader {
	connection: SerialConnection {
		//port: "ttyACM0"
		//port: "COM85"
		//baudRate: 57600
	}

	device: SAMA5D3Xplained {
		// to use a custom config, replace SAMA5D2Xplained by SAMA5D2 and
		// uncomment the following lines, or see documentation for
		// custom board creation.
		//config {
		//	nandflash {
		//		ioset: 1
		//		busWidth: 8
		//		header: 0xc0902405
		//	}
		//}
	}

	onConnectionOpened: {
		// initialize Low-Level applet
		appletInitialize("lowlevel")

		// initialize NAND flash applet
		appletInitialize("nandflash")

		// erase all memory
		appletErase(0, connection.applet.memorySize)

		// write files
		appletWrite(0x000000, "at91bootstrap-sama5d3_xplained.bin", true)
		appletWrite(0x040000, "u-boot-sama5d3-xplained.bin")
		appletWrite(0x0c0000, "u-boot-env-sama5d3-xplained.bin")
		appletWrite(0x180000, "at91-sama5d3_xplained.dtb")
		appletWrite(0x200000, "zImage-sama5d3-xplained.bin")
		appletWrite(0x800000, "atmel-xplained-demo-image-sama5d3-xplained.ubi")
	}
}
