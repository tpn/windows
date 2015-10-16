cdef extern from "<windows.h>":

    ctypedef bint BOOL
    ctypedef char CHAR
    ctypedef CHAR BOOLEAN
    ctypedef unsigned char UCHAR
    ctypedef UCHAR BYTE
    ctypedef short SHORT
    ctypedef unsigned short USHORT
    ctypedef USHORT WCHAR
    ctypedef WCHAR* PWSTR
    ctypedef int INT32
    ctypedef long long INT64
    ctypedef Py_ssize_t INT_PTR
    ctypedef unsigned int UINT32
    ctypedef unsigned long long UINT64
    ctypedef Py_ssize_t UINT_PTR
    ctypedef long LONG
    ctypedef long LONG32
    ctypedef long long LONGLONG
    ctypedef long long LONG64
    ctypedef LONGLONG USN
    ctypedef unsigned long ULONG
    ctypedef ULONG ACCESS_MASK
    ctypedef Py_ssize_t ULONG_PTR
    ctypedef ULONG_PTR KAFFINITY
    ctypedef ULONG* PULONG
    ctypedef unsigned long long ULONGLONG
    ctypedef unsigned long long ULONG64
    ctypedef ULONG64* PULONG64
    ctypedef ULONGLONG* PULONGLONG
    ctypedef Py_ssize_t HANDLE
    ctypedef unsigned short WORD
    ctypedef unsigned long DWORD
    ctypedef DWORD* PDWORD
    ctypedef unsigned int DWORD32
    ctypedef unsigned long long DWORD64
    ctypedef long long __int64

    ctypedef struct PROCESSOR_NUMBER:
        WORD Group
        BYTE Number
        BYTE Reserved
    ctypedef PROCESSOR_NUMBER* PPROCESSOR_NUMBER

    ctypedef struct PROCESS_INFORMATION:
        HANDLE hProcess
        HANDLE hThread
        DWORD dwProcessId
        DWORD dwThreadId
    ctypedef PROCESS_INFORMATION* PPROCESS_INFORMATION

    ctypedef struct LIST_ENTRY:
        LIST_ENTRY *Flink
        LIST_ENTRY *Blink
    ctypedef LIST_ENTRY* PLIST_ENTRY

    # See http://www.hitmaroc.net/600697-3913-cython-nesting-union-within-struct.html
    # regarding the quirky nesting.
    ctypedef struct _ULARGE_INTEGER:
        DWORD LowPart
        DWORD HighPart

    ctypedef union ULARGE_INTEGER:
        DWORD LowPart
        DWORD HighPart
        _ULARGE_INTEGER u
        ULONGLONG QuadPart

    ctypedef struct _LARGE_INTEGER:
        DWORD LowPart
        LONG  HighPart

    ctypedef union LARGE_INTEGER:
        DWORD LowPart
        LONG  HighPart
        _LARGE_INTEGER u
        LONGLONG QuadPart

    ctypedef struct UNICODE_STRING:
        USHORT Length
        USHORT MaximumLength
        PWSTR  Buffer
    ctypedef UNICODE_STRING* PUNICODE_STRING

    ctypedef struct IO_COUNTERS:
        ULONGLONG ReadOperationCount
        ULONGLONG WriteOperationCount
        ULONGLONG OtherOperationCount
        ULONGLONG ReadTransferCount
        ULONGLONG WriteTransferCount
        ULONGLONG OtherTransferCount
    ctypedef IO_COUNTERS* PIO_COUNTERS

    ctypedef struct FILETIME:
        DWORD dwLowDateTime
        DWORD dwHighDateTime
    ctypedef FILETIME* PFILETIME
    ctypedef PFILETIME LPFILETIME

    ctypedef struct SYSTEMTIME:
        WORD wYear
        WORD wMonth
        WORD wDayOfWeek
        WORD wDay
        WORD wHour
        WORD wMinute
        WORD wSecond
        WORD wMilliseconds
    ctypedef SYSTEMTIME* PSYSTEMTIME
    ctypedef PSYSTEMTIME LPSYSTEMTIME

    ctypedef struct CRITICAL_SECTION:
        pass
    ctypedef CRITICAL_SECTION* PCRITICAL_SECTION
    ctypedef CRITICAL_SECTION* LPCRITICAL_SECTION

    ctypedef enum LOGICAL_PROCESSOR_RELATIONSHIP:
        RelationProcessorCore
        RelationNumaNode
        RelationCache
        RelationProcessorPackage
        RelationGroup
        RelationAll = 0xffff

    ctypedef struct GROUP_AFFINITY:
        KAFFINITY Mask
        WORD Group
        WORD Reserved[3]
    ctypedef GROUP_AFFINITY* PGROUP_AFFINITY

    ctypedef struct PROCESSOR_RELATIONSHIP:
        BYTE Flags
        BYTE EfficiencyClass
        BYTE Reserved[21]
        WORD GroupCount

    ctypedef enum CACHE_LEVEL:
        L1 = 1
        L2 = 2
        L3 = 3

    ctypedef enum PROCESSOR_CACHE_TYPE:
        CacheUnified
        CacheInstruction
        CacheData
        CacheTrace

    ctypedef struct CACHE_DESCRIPTOR:
        BYTE Level
        BYTE Associativity
        WORD LineSize
        DWORD Size
        PROCESSOR_CACHE_TYPE Type
    ctypedef CACHE_DESCRIPTOR* PCACHE_DESCRIPTOR

    ctypedef struct CACHE_RELATIONSHIP:
        BYTE Level
        BYTE Associativity
        WORD LineSize
        DWORD CacheSize
        PROCESSOR_CACHE_TYPE Type
        BYTE Reserved[20]
        GROUP_AFFINITY GroupMask
    ctypedef CACHE_RELATIONSHIP* PCACHE_RELATIONSHIP

    ctypedef struct NUMA_NODE_RELATIONSHIP:
        DWORD NodeNumber
        BYTE Reserved[20]
        GROUP_AFFINITY GroupMask
    ctypedef NUMA_NODE_RELATIONSHIP* PNUMA_NODE_RELATIONSHIP

    ctypedef struct PROCESSOR_GROUP_INFO:
        BYTE MaximumProcessorCount
        BYTE ActiveProcessorCount
        BYTE Reserved[38]
        KAFFINITY ActiveProcessorMask
    ctypedef PROCESSOR_GROUP_INFO* PPROCESSOR_GROUP_INFO

    ctypedef struct GROUP_RELATIONSHIP:
        WORD MaximumGroupCount
        WORD ActiveGroupCount
        BYTE Reserved[20]
        # 1 = ANYSIZE_ARRAY
        PROCESSOR_GROUP_INFO GroupInfo[1]

    ctypedef struct PROCESSOR_NUMBER:
        WORD Group
        BYTE Number
        BYTE Reserved
    ctypedef PROCESSOR_NUMBER* PPROCESSOR_NUMBER

    ctypedef struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX:
        LOGICAL_PROCESSOR_RELATIONSHIP Relationship
        DWORD Size
        # union:
        PROCESSOR_RELATIONSHIP Processor
        NUMA_NODE_RELATIONSHIP NumaNode
        CACHE_RELATIONSHIP Cache
        GROUP_RELATIONSHIP Group

    ctypedef enum CPU_SET_INFORMATION_TYPE:
        CpuSetInformation

    ctypedef struct CPU_SET:
        DWORD Id
        WORD Group
        BYTE LogicalProcessorIndex
        BYTE CoreIndex
        BYTE LastLevelCacheIndex
        BYTE NumaNodeIndex
        BYTE EfficiencyClass

        # Inner anonymous struct:
        BOOLEAN Parked
        BOOLEAN Allocated
        BOOLEAN AllocatedToTargetProcess
        BOOLEAN RealTime
        BYTE ReservedFlags

        DWORD Reserved
        DWORD64 AllocationTag

    ctypedef struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION:
        DWORD Size
        CPU_SET_INFORMATION_TYPE Type
        CPU_SET CpuSet

        # Union/struct CpuSet info repeated:
        DWORD Id
        WORD Group
        BYTE LogicalProcessorIndex
        BYTE CoreIndex
        BYTE LastLevelCacheIndex
        BYTE NumaNodeIndex
        BYTE EfficiencyClass

        # Inner anonymous struct:
        BOOLEAN Parked
        BOOLEAN Allocated
        BOOLEAN AllocatedToTargetProcess
        BOOLEAN RealTime
        BYTE ReservedFlags

        DWORD Reserved
        DWORD64 AllocationTag
    ctypedef SYSTEM_LOGICAL_PROCESSOR_INFORMATION SYSTEM_CPU_SET_INFORMATION
    ctypedef SYSTEM_CPU_SET_INFORMATION* PSYSTEM_CPU_SET_INFORMATION

    ctypedef struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX:
        LOGICAL_PROCESSOR_RELATIONSHIP Relationship
        DWORD Size
        # Union:
        PROCESSOR_RELATIONSHIP Processor
        NUMA_NODE_RELATIONSHIP NumaNode
        CACHE_RELATIONSHIP Cache
        GROUP_RELATIONSHIP Group
    ctypedef SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX* PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX

cdef inline ULONGLONG FileTimeToUnsignedLongLong(PFILETIME filetime):
    cdef ULARGE_INTEGER ul
    ul.LowPart = filetime.dwLowDateTime
    ul.HighPart = filetime.dwHighDateTime
    return ul.QuadPart

