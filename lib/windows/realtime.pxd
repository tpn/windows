# realtimeapiset.h
from . cimport types

cdef extern from "<windows.h>":

    BOOL QueryInterruptTime(PULONGLONG lpInterruptTime)
    BOOL QueryInterruptTimePrecise(PULONGLONG lpInterruptTimePrecise)
    BOOL QueryUnbiasedInterruptTime(PULONGLONG lpUnbiasedInterruptTime)
    BOOL QueryUnbiasedInterruptTimePrecise(PULONGLONG lpUnbiasedInterruptTimePrecise)
