// From the-darkvoid repo
//
// SSDT-YTBT.dsl
//
// Dell XPS 15 9560
//
// This SSDT fixes Type-C hot plug, and attempts to implement Thunderbolt device tree structure.
//
// Credit to dpassmor for the original ExpressCard idea:
// https://www.tonymacx86.com/threads/usb-c-hotplug-questions.211313/
//

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "TYPC", 0)
{
#endif
	External (_SB.PCI0.RP01.PXSX, DeviceObj)    // (from opcode)

	// USB-C
	Scope (\_SB.PCI0.RP01.PXSX) // UPSB
	{
		// This is the key fix for machines that turn off the Type-C port, right here.
		Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
		{
			Return (One) // Returning 0 means not a removable device. But we want to act like an ExpressCard! (credit dpassmor)
		}

		Method (_STA, 0, NotSerialized)  // _STA: Status
		{
			Return (0x0F)
		}
	}
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
