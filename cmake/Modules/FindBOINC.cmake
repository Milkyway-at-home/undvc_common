# - Find BOINC 
# Find the native BOINC includes and libraries
#
#  BOINC_INCLUDE_DIR - where to find mysql.h, etc.
#  BOINC_LIBRARIES   - List of libraries when using MySQL.
#  BOINC_FOUND       - True if MySQL found.

IF (BOINC_INCLUDE_DIR)
    # Already in cache, be silent
    SET(BOINC_FIND_QUIETLY TRUE)
ENDIF (BOINC_INCLUDE_DIR)

FIND_PATH(BOINC_INCLUDE_DIR config.h
    /boinc/src/boinc/
)

FIND_LIBRARY(BOINC_LIBRARY
    NAMES boinc
    PATHS /boinc/src/boinc
    PATH_SUFFIXES lib
)
FIND_LIBRARY(BOINC_CRYPT_LIBRARY
    NAMES boinc_crypt
    PATHS /boinc/src/boinc
    PATH_SUFFIXES lib
)
FIND_LIBRARY(BOINC_API_LIBRARY
    NAMES boinc_api
    PATHS /boinc/src/boinc
    PATH_SUFFIXES api
)

FIND_LIBRARY(BOINC_SCHED_LIBRARY
    NAMES sched
    PATHS /boinc/src/boinc
    PATH_SUFFIXES sched
)

#MESSAGE(STATUS "boinc names ${BOINC_LIBRARY} ${BOINC_CRYPT_LIBRARY} ${BOINC_API_LIBRARY}.")

IF (BOINC_INCLUDE_DIR AND BOINC_LIBRARY)
    add_definitions( -D_BOINC_ )
    SET(BOINC_FOUND TRUE)
    SET( BOINC_LIBRARIES ${BOINC_SCHED_LIBRARY} ${BOINC_LIBRARY} ${BOINC_API_LIBRARY} ${BOINC_CRYPT_LIBRARY})
ELSE (BOINC_INCLUDE_DIR AND BOINC_LIBRARY)
    SET(BOINC_FOUND FALSE)
    SET( BOINC_LIBRARIES )
ENDIF (BOINC_INCLUDE_DIR AND BOINC_LIBRARY)

IF (BOINC_FOUND)
    IF (NOT BOINC_FIND_QUIETLY)
        MESSAGE(STATUS "Found BOINC: ${BOINC_LIBRARY}")
        MESSAGE(STATUS " -- BOINC include directory: ${BOINC_INCLUDE_DIR}")
    ENDIF (NOT BOINC_FIND_QUIETLY)
ELSE (BOINC_FOUND)
    IF (BOINC_FIND_REQUIRED)
        MESSAGE(STATUS "Looked for BOINC libraries named ${BOINC_NAMES}.")
        MESSAGE(FATAL_ERROR "Could NOT find BOINC library")
    ENDIF (BOINC_FIND_REQUIRED)
ENDIF (BOINC_FOUND)

MARK_AS_ADVANCED(
    BOINC_LIBRARY
    BOINC_INCLUDE_DIR
    )
