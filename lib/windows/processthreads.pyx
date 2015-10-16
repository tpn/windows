
from processthreads cimport *
#include "processthreads.pxi"

cdef class ThreadTime:
    cdef:
        HANDLE handle
        ULONGLONG creation
        ULONGLONG exit
        ULONGLONG kernel
        ULONGLONG user

    def __cinit__(self, HANDLE handle):
        if not handle:
            handle = GetCurrentThread()
        self.handle = handle
        self.refresh()

    def refresh(self):
        cdef:
            BOOL success
            FILETIME creation
            FILETIME exit
            FILETIME kernel
            FILETIME user
        success = GetThreadTimes(self.handle, &creation, &exit, &kernel, &user)
        if not success:
            raise OSError()
        self.creation = FileTimeToUnsignedLongLong(&creation)
        self.exit = FileTimeToUnsignedLongLong(&exit)
        self.kernel = FileTimeToUnsignedLongLong(&kernel)
        self.user = FileTimeToUnsignedLongLong(&user)
