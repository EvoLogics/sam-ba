import SAMBA 3.1
import SAMBA.Connection.JLink 3.1
import SAMBA.Device.SAMA5D2 3.1

AppletLoader {
	connection: JLinkConnection {
		//port: "99999999"
	}

	device: SAMA5D2Xplained {
		/* override part of default config */
		config {
			/* use SDCard socket */
			sdmmc {
				instance: 1
			}
		}
	}

	onConnectionOpened: {
		// initialize SD/MMC applet
		appletInitialize("sdmmc")

		// write file
		appletWrite(0, "filesystem_image.raw", false)

		// initialize boot config applet
		appletInitialize("bootconfig")

		// Use BUREG0 as boot configuration word
		appletWriteBootCfg(BootCfg.BSCR, BSCR.fromText("VALID,BUREG0"))

		// Enable external boot only on SDMMC0
		appletWriteBootCfg(BootCfg.BUREG0,
			BCW.fromText("EXT_MEM_BOOT,UART1_IOSET1,JTAG_IOSET1," +
			             "SDMMC0_DISABLED,SDMMC1,NFC_DISABLED," +
			             "SPI1_DISABLED,SPI0_DISABLED," +
			             "QSPI1_DISABLED,QSPI0_DISABLED"))
	}
}
