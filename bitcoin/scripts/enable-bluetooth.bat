

::echo "script starting"

:: Bluetooth Device (RFCOMM Protocol TDI)
pnputil /enable-device "BTH\MS_RFCOMM\7&13fffb10&0&0"


:: Microsoft Bluetooth Enumerator
pnputil /enable-device "BTH\MS_BTHBRB\7&13fffb10&0&1"


:: Microsoft Bluetooth LE Enumerator
pnputil /enable-device "BTH\MS_BTHLE\7&13fffb10&0&3"


::pause


