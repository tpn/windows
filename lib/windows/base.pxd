# WinBase.h
cdef extern from "<windows.h>":

    BOOL __stdcall GetProcessIoCounters(HANDLE hProcess, PIO_COUNTERS lpIoCounters)
    DWORD GetActiveProcessorCount(WORD GroupNumber)

