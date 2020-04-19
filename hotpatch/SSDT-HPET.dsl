// Generic HPET Fix
// HPET System Timer
// System Board
// Allow to fix HPET or dimply disable it

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "HPET", 0)
{
#endif
    External (_SB_.PCI0.LPCB.HPET, DeviceObj)
    
    External (_SB_.PCI0.LPCB.HPET._HID, IntObj)
    External (_SB_.PCI0.LPCB.HPET._CID, IntObj)

    External (_SB_.PCI0.LPCB.HPET._STA, UnknownObj) // name or method
    External (_SB_.PCI0.LPCB.HPET._CRS, UnknownObj) // name or method

    Scope (\_SB.PCI0.LPCB.HPET)
    {
        If (!CondRefOf (\_SB.PCI0.LPCB.HPET._HID))
        {
            Name (_HID, EisaId ("PNP0103"))
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.HPET._CID))
        {
            Name (_CID, EisaId ("PNP0C01"))
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.HPET._STA))
        {
            Method (_STA, 0, NotSerialized)
            {
                // DSTZ = Disable by name rename
                // DSTX = Disable by method rename
                If ((CondRefOf (\_SB.PCI0.LPCB.HPET.DSTX) || CondRefOf (\_SB.PCI0.LPCB.HPET.DSTZ)))
                {
                    Return (Zero)
                }

                Return (0x0F)
            }
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.HPET._CRS))
        {
            Method (_CRS, 0, Serialized)
            {
                Return (ResourceTemplate ()
                {
                    IRQNoFlags ()
                        {0}
                    IRQNoFlags ()
                        {8}
                    Memory32Fixed (ReadWrite,
                        0xFED00000,         // Address Base
                        0x00004000,         // Address Length
                        )
                })
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
