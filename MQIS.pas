unit MQIS ;

{ *** MQ Server API access thru Delphi  *** }

{ adapted by Pere Albert, Barcelona. perealbert@es.ibm.com }
{ requires 'MQM.DLL' and 'AMQZSAIC.DLL' (MQ Server) ; }

{ 2006-Jul : includes MQAI from CMQBC.H - Sebastia Altemir }
{ 2006-Sep : change MQIC32.DLL into MQM.DLL and duplicate MQI.PAS and MQIC.PAS }
{ 2006-Oct : inclure cmqcfc.h }
{ 2012-Oct : update OD, PMO, GMO, SCO, AIR and CNO for MQ version 7 }
{ 2013-Mar : include MQSUB(); lots of PMQVOID in old verbs; MQSD }
{ 20150520 : use AnsiChar instead of Char and AnsiString instead of String, so we dont get double-bytes from a Unicode string }

interface

const
  MQOD_STRUC_ID                  = 'OD  ' ;
  MQOD_VERSION_1                 = 1 ;
  MQOD_VERSION_2                 = 2 ;
  MQOD_VERSION_3                 = 3 ;
  MQOD_VERSION_4                 = 4 ;
  MQOD_CURRENT_VERSION           = 4 ;

  MQPMO_STRUC_ID                 = 'PMO ' ;
  MQPMO_VERSION_1                = 1 ;
  MQPMO_VERSION_2                = 2 ;
  MQPMO_VERSION_3                = 3 ;
  MQPMO_CURRENT_VERSION          = 3 ;

  MQGMO_STRUC_ID                 = 'GMO ' ;
  MQGMO_VERSION_1                = 1 ;
  MQGMO_VERSION_2                = 2 ;
  MQGMO_VERSION_3                = 3 ;
  MQGMO_VERSION_4                = 4 ;
  MQGMO_CURRENT_VERSION          = 4 ;

  MQMD_STRUC_ID                  = 'MD  ' ;
  MQMD_VERSION_1                 = 1 ;
  MQMD_VERSION_2                 = 2 ;
  MQMD_CURRENT_VERSION           = 2 ;

  MQMDE_STRUC_ID                 = 'MDE ' ;
  MQMDE_VERSION_2                = 2 ;
  MQMDE_CURRENT_VERSION          = 2 ;

  MQBO_STRUC_ID                  = 'BO  ' ;
  MQBO_VERSION_1                 = 1 ;
  MQBO_CURRENT_VERSION           = 1 ;

  MQSCO_STRUC_ID                 = 'SCO ' ;
  MQSCO_VERSION_1                = 1 ;
  MQSCO_VERSION_2                = 2 ;
  MQSCO_CURRENT_VERSION          = 2 ;

{ Key Reset Count }
  MQSCO_RESET_COUNT_DEFAULT = 0 ;

{ SSL FIPS Requirements }
  MQSSL_FIPS_NO  = 0 ;
  MQSSL_FIPS_YES = 1 ;


  MQAIR_STRUC_ID                 = 'AIR ' ;
  MQAIR_VERSION_1                = 1 ;
  MQAIR_VERSION_2                = 2 ;
  MQAIR_CURRENT_VERSION          = 2 ;

  MQCNO_STRUC_ID                 = 'CNO ' ;
  MQCNO_VERSION_1                = 1 ;
  MQCNO_VERSION_2                = 2 ;
  MQCNO_VERSION_3                = 3 ;
  MQCNO_VERSION_4                = 4 ;
  MQCNO_VERSION_5                = 5 ;
  MQCNO_CURRENT_VERSION          = 5 ;

  MQRFH_STRUC_ID                 = 'RFH ' ;
  MQRFH_VERSION_1                = 1 ;
  MQRFH_VERSION_2                = 2 ;

  MQDH_STRUC_ID                  = 'DH  ' ;
  MQDH_VERSION_1                 = 1 ;
  MQDH_CURRENT_VERSION           = 1 ;

  MQDLH_STRUC_ID                 = 'DLH ' ;
  MQDLH_VERSION_1                = 1 ;
  MQDLH_CURRENT_VERSION          = 1 ;

  MQCIH_STRUC_ID                 = 'CIH ' ;
  MQCIH_VERSION_1                = 1 ;
  MQCIH_VERSION_2                = 2 ;
  MQCIH_CURRENT_VERSION          = 2 ;

  MQIIH_STRUC_ID                 = 'IIH ' ;
  MQIIH_VERSION_1                = 1 ;
  MQIIH_CURRENT_VERSION          = 1 ;

  MQRMH_STRUC_ID                 = 'RMH ' ;
  MQRMH_VERSION_1                = 1 ;
  MQRMH_CURRENT_VERSION          = 1 ;

  MQSD_STRUC_ID_ARRAY            = 'SD  ' ;
  MQSD_VERSION_1                 = 1 ;

  MQTM_STRUC_ID                  = 'TM  ' ;
  MQTM_VERSION_1                 = 1 ;
  MQTM_CURRENT_VERSION           = 1 ;

  MQTMC_STRUC_ID                 = 'TMC ';
  MQTMC_VERSION_1                = '   1';
  MQTMC_VERSION_2                = '   2';
  MQTMC_CURRENT_VERSION          = '   2';

  MQWIH_STRUC_ID                 = 'WIH ' ;
  MQWIH_VERSION_1                = 1 ;
  MQWIH_CURRENT_VERSION          = 1 ;

  MQXQH_STRUC_ID                 = 'XQH ' ;
  MQXQH_VERSION_1                = 1 ;
  MQXQH_CURRENT_VERSION          = 1 ;

{ Values Related to MQCLOSE Function }

{ Object Handle }
 MQHO_UNUSABLE_HOBJ      = -1 ;
 MQHO_NONE               = 0 ;

{Object types}
  MQOT_NONE                      = 0 ;
  MQOT_Q                         = 1 ;
  MQOT_NAMELIST                  = 2 ;
  MQOT_PROCESS                   = 3 ;
  MQOT_STORAGE_CLASS             = 4 ;
  MQOT_Q_MGR                     = 5 ;
  MQOT_CHANNEL                   = 6 ;
  MQOT_AUTH_INFO                 = 7 ;
  MQOT_TOPIC                     = 8 ;
  MQOT_CF_STRUC                  = 10 ;
  MQOT_LISTENER                  = 11 ;
  MQOT_SERVICE                   = 12 ;
  MQOT_RESERVED_1                = 999 ;

{ Extended Object Types }
  MQOT_ALL               = 1001 ;
  MQOT_ALIAS_Q           = 1002 ;
  MQOT_MODEL_Q           = 1003 ;
  MQOT_LOCAL_Q           = 1004 ;
  MQOT_REMOTE_Q          = 1005 ;
  MQOT_SENDER_CHANNEL    = 1007 ;
  MQOT_SERVER_CHANNEL    = 1008 ;
  MQOT_REQUESTER_CHANNEL = 1009 ;
  MQOT_RECEIVER_CHANNEL  = 1010 ;
  MQOT_CURRENT_CHANNEL   = 1011 ;
  MQOT_SAVED_CHANNEL     = 1012 ;
  MQOT_SVRCONN_CHANNEL   = 1013 ;
  MQOT_CLNTCONN_CHANNEL  = 1014 ;
  MQOT_SHORT_CHANNEL     = 1015 ;

{Connect Options}
  MQCNO_STANDARD_BINDING         = $00000000 ;
  MQCNO_FASTPATH_BINDING         = $00000001 ;
  MQCNO_SERIALIZE_CONN_TAG_Q_MGR = $00000002 ;
  MQCNO_SERIALIZE_CONN_TAG_QSG   = $00000004 ;
  MQCNO_RESTRICT_CONN_TAG_Q_MGR  = $00000008 ;
  MQCNO_RESTRICT_CONN_TAG_QSG    = $00000010 ;
  MQCNO_HANDLE_SHARE_NONE        = $00000020 ;
  MQCNO_HANDLE_SHARE_BLOCK       = $00000040 ;
  MQCNO_HANDLE_SHARE_NO_BLOCK    = $00000080 ;
  MQCNO_SHARED_BINDING           = $00000100 ;
  MQCNO_ISOLATED_BINDING         = $00000200 ;
  MQCNO_ACCOUNTING_MQI_ENABLED   = $00001000 ;
  MQCNO_ACCOUNTING_MQI_DISABLED  = $00002000 ;
  MQCNO_ACCOUNTING_Q_ENABLED     = $00004000 ;
  MQCNO_ACCOUNTING_Q_DISABLED    = $00008000 ;
  MQCNO_NO_CONV_SHARING          = $00010000 ;
  MQCNO_ALL_CONVS_SHARE          = $00040000 ;
  MQCNO_CD_FOR_OUTPUT_ONLY       = $00080000 ;
  MQCNO_USE_CD_SELECTION         = $00100000 ;
  MQCNO_RECONNECT_AS_DEF         = $00000000 ;
  MQCNO_RECONNECT                = $01000000 ;
  MQCNO_RECONNECT_DISABLED       = $02000000 ;
  MQCNO_RECONNECT_Q_MGR          = $04000000 ;
  MQCNO_NONE                     = $00000000 ;

{Open Options}
  MQOO_BIND_AS_Q_DEF             = $00000000 ;
  MQOO_READ_AHEAD_AS_Q_DEF       = $00000000 ;
  MQOO_INPUT_AS_Q_DEF            = $00000001 ;
  MQOO_INPUT_SHARED              = $00000002 ;
  MQOO_INPUT_EXCLUSIVE           = $00000004 ;
  MQOO_BROWSE                    = $00000008 ;
  MQOO_OUTPUT                    = $00000010 ;
  MQOO_INQUIRE                   = $00000020 ;
  MQOO_SET                       = $00000040 ;
  MQOO_SAVE_ALL_CONTEXT          = $00000080 ;
  MQOO_PASS_IDENTITY_CONTEXT     = $00000100 ;
  MQOO_PASS_ALL_CONTEXT          = $00000200 ;
  MQOO_SET_IDENTITY_CONTEXT      = $00000400 ;
  MQOO_SET_ALL_CONTEXT           = $00000800 ;
  MQOO_ALTERNATE_USER_AUTHORITY  = $00001000 ;
  MQOO_FAIL_IF_QUIESCING         = $00002000 ;
  MQOO_BIND_ON_OPEN              = $00004000 ;
  MQOO_BIND_NOT_FIXED            = $00008000 ;
  MQOO_RESOLVE_NAMES             = $00010000 ;
  MQOO_CO_OP                     = $00020000 ;
  MQOO_RESOLVE_LOCAL_Q           = $00040000 ;
  MQOO_NO_READ_AHEAD             = $00080000 ;
  MQOO_READ_AHEAD                = $00100000 ;

 // ****************************************************************/
 // *  Values Related to MQSUB Function                            */
 // ****************************************************************/

{ Subscribe Options }
  MQSO_NONE                      = $00000000 ;
  MQSO_NON_DURABLE               = $00000000 ;
  MQSO_READ_AHEAD_AS_Q_DEF       = $00000000 ;
  MQSO_ALTER                     = $00000001 ;
  MQSO_CREATE                    = $00000002 ;
  MQSO_RESUME                    = $00000004 ;
  MQSO_DURABLE                   = $00000008 ;
  MQSO_GROUP_SUB                 = $00000010 ;
  MQSO_MANAGED                   = $00000020 ;
  MQSO_SET_IDENTITY_CONTEXT      = $00000040 ;
  MQSO_FIXED_USERID              = $00000100 ;
  MQSO_ANY_USERID                = $00000200 ;
  MQSO_PUBLICATIONS_ON_REQUEST   = $00000800 ;
  MQSO_NEW_PUBLICATIONS_ONLY     = $00001000 ;
  MQSO_FAIL_IF_QUIESCING         = $00002000 ;
  MQSO_ALTERNATE_USER_AUTHORITY  = $00040000 ;
  MQSO_WILDCARD_CHAR             = $00100000 ;
  MQSO_WILDCARD_TOPIC            = $00200000 ;
  MQSO_SET_CORREL_ID             = $00400000 ;
  MQSO_SCOPE_QMGR                = $04000000 ;
  MQSO_NO_READ_AHEAD             = $08000000 ;
  MQSO_READ_AHEAD                = $10000000 ;

{Report options}
  MQRO_EXCEPTION                 = $01000000 ;
  MQRO_EXCEPTION_WITH_DATA       = $03000000 ;
  MQRO_EXCEPTION_WITH_FULL_DATA  = $07000000 ;
  MQRO_EXPIRATION                = $00200000 ;
  MQRO_EXPIRATION_WITH_DATA      = $00600000 ;
  MQRO_EXPIRATION_WITH_FULL_DATA = $00E00000 ;
  MQRO_COA                       = $00000100 ;
  MQRO_COA_WITH_DATA             = $00000300 ;
  MQRO_COA_WITH_FULL_DATA        = $00000700 ;
  MQRO_COD                       = $00000800 ;
  MQRO_COD_WITH_DATA             = $00001800 ;
  MQRO_COD_WITH_FULL_DATA        = $00003800 ;
  MQRO_PAN                       = $00000001 ;
  MQRO_NAN                       = $00000002 ;
  MQRO_ACTIVITY                  = $00000004 ;
  MQRO_NEW_MSG_ID                = $00000000 ;
  MQRO_PASS_MSG_ID               = $00000080 ;
  MQRO_COPY_MSG_ID_TO_CORREL_ID  = $00000000 ;
  MQRO_PASS_CORREL_ID            = $00000040 ;
  MQRO_DEAD_LETTER_Q             = $00000000 ;
  MQRO_DISCARD_MSG               = $08000000 ;
  MQRO_PASS_DISCARD_AND_EXPIRY   = $00004000 ;
  MQRO_NONE                      = $00000000 ;

{Close options}
  MQCO_IMMEDIATE                 = $00000000 ;
  MQCO_NONE                      = $00000000 ;
  MQCO_DELETE                    = $00000001 ;
  MQCO_DELETE_PURGE              = $00000002 ;
  MQCO_KEEP_SUB                  = $00000004 ;
  MQCO_REMOVE_SUB                = $00000008 ;
  MQCO_QUIESCE                   = $00000020 ;

{Message types}
  MQMT_SYSTEM_FIRST              = 1 ;
  MQMT_REQUEST                   = 1 ;
  MQMT_REPLY                     = 2 ;
  MQMT_DATAGRAM                  = 8 ;
  MQMT_REPORT                    = 4 ;
  MQMT_MQE_FIELDS_FROM_MQE       = 112 ;
  MQMT_MQE_FIELDS                = 113 ;
  MQMT_SYSTEM_LAST               = 65535 ;
  MQMT_APPL_FIRST                = 65536 ;
  MQMT_APPL_LAST                 = 999999999 ;

{Expiry}
  MQEI_UNLIMITED                 = -1 ;

{Begin Options}
  MQBO_NONE                      = $00000000 ;

{Feedback values}
  MQFB_NONE                      = 0 ;
  MQFB_SYSTEM_FIRST              = 1 ;
  MQFB_QUIT                      = 256 ;
  MQFB_EXPIRATION                = 258 ;
  MQFB_COA                       = 259 ;
  MQFB_COD                       = 260 ;
  MQFB_CHANNEL_COMPLETED         = 262 ;
  MQFB_CHANNEL_FAIL_RETRY        = 263 ;
  MQFB_CHANNEL_FAIL              = 264 ;
  MQFB_APPL_CANNOT_BE_STARTED    = 265 ;
  MQFB_TM_ERROR                  = 266 ;
  MQFB_APPL_TYPE_ERROR           = 267 ;
  MQFB_STOPPED_BY_MSG_EXIT       = 268 ;
  MQFB_ACTIVITY                  = 269 ;
  MQFB_XMIT_Q_MSG_ERROR          = 271 ;
  MQFB_PAN                       = 275 ;
  MQFB_NAN                       = 276 ;
  MQFB_STOPPED_BY_CHAD_EXIT      = 277 ;
  MQFB_STOPPED_BY_PUBSUB_EXIT    = 279 ;
  MQFB_NOT_A_REPOSITORY_MSG      = 280 ;
  MQFB_BIND_OPEN_CLUSRCVR_DEL    = 281 ;
  MQFB_MAX_ACTIVITIES            = 282 ;
  MQFB_NOT_FORWARDED             = 283 ;
  MQFB_NOT_DELIVERED             = 284 ;
  MQFB_UNSUPPORTED_FORWARDING    = 285 ;
  MQFB_UNSUPPORTED_DELIVERY      = 286 ;
  MQFB_DATA_LENGTH_ZERO          = 291 ;
  MQFB_DATA_LENGTH_NEGATIVE      = 292 ;
  MQFB_DATA_LENGTH_TOO_BIG       = 293 ;
  MQFB_BUFFER_OVERFLOW           = 294 ;
  MQFB_LENGTH_OFF_BY_ONE         = 295 ;
  MQFB_IIH_ERROR                 = 296 ;
  MQFB_NOT_AUTHORIZED_FOR_IMS    = 298 ;
  MQFB_IMS_ERROR                 = 300 ;
  MQFB_IMS_FIRST                 = 301 ;
  MQFB_IMS_LAST                  = 399 ;
  MQFB_CICS_INTERNAL_ERROR       = 401 ;
  MQFB_CICS_NOT_AUTHORIZED       = 402 ;
  MQFB_CICS_BRIDGE_FAILURE       = 403 ;
  MQFB_CICS_CORREL_ID_ERROR      = 404 ;
  MQFB_CICS_CCSID_ERROR          = 405 ;
  MQFB_CICS_ENCODING_ERROR       = 406 ;
  MQFB_CICS_CIH_ERROR            = 407 ;
  MQFB_CICS_UOW_ERROR            = 408 ;
  MQFB_CICS_COMMAREA_ERROR       = 409 ;
  MQFB_CICS_APPL_NOT_STARTED     = 410 ;
  MQFB_CICS_APPL_ABENDED         = 411 ;
  MQFB_CICS_DLQ_ERROR            = 412 ;
  MQFB_CICS_UOW_BACKED_OUT       = 413 ;
  MQFB_PUBLICATIONS_ON_REQUEST   = 501 ;
  MQFB_SUBSCRIBER_IS_PUBLISHER   = 502 ;
  MQFB_MSG_SCOPE_MISMATCH        = 503 ;
  MQFB_SELECTOR_MISMATCH         = 504 ;
  MQFB_NOT_A_GROUPUR_MSG         = 505 ;
  MQFB_SYSTEM_LAST               = 65535 ;
  MQFB_APPL_FIRST                = 65536 ;
  MQFB_APPL_LAST                 = 999999999 ;

{Encoding}
  MQENC_NATIVE                   = $00000222 ;

  MQENC_INTEGER_MASK             = $0000000F ;
  MQENC_DECIMAL_MASK             = $000000F0 ;
  MQENC_FLOAT_MASK               = $00000F00 ;
  MQENC_RESERVED_MASK            = $FFFFF000 ;

  MQENC_INTEGER_UNDEFINED        = $00000000 ;
  MQENC_INTEGER_NORMAL           = $00000001 ;
  MQENC_INTEGER_REVERSED         = $00000002 ;

  MQENC_DECIMAL_UNDEFINED        = $00000000 ;
  MQENC_DECIMAL_NORMAL           = $00000010 ;
  MQENC_DECIMAL_REVERSED         = $00000020 ;

  MQENC_FLOAT_UNDEFINED          = $00000000 ;
  MQENC_FLOAT_IEEE_NORMAL        = $00000100 ;
  MQENC_FLOAT_IEEE_REVERSED      = $00000200 ;
  MQENC_FLOAT_S390               = $00000300 ;
  MQENC_FLOAT_TNS                = $00000400 ;

{Coded Character-Set Identifiers}
  MQCCSI_UNDEFINED               = 0 ;
  MQCCSI_DEFAULT                 = 0 ;
  MQCCSI_Q_MGR                   = 0 ;
  MQCCSI_INHERIT                 = -2 ;
  MQCCSI_EMBEDDED                = -1 ;
  MQCCSI_APPL                    = -3 ;

{Formats}
  MQFMT_NONE                     = '        ' ;
  MQFMT_ADMIN                    = 'MQADMIN ' ;
  MQFMT_CHANNEL_COMPLETED        = 'MQCHCOM ' ;
  MQFMT_CICS                     = 'MQCICS  ' ;
  MQFMT_COMMAND_1                = 'MQCMD1  ' ;
  MQFMT_COMMAND_2                = 'MQCMD2  ' ;
  MQFMT_DEAD_LETTER_HEADER       = 'MQDEAD  ' ;
  MQFMT_DIST_HEADER              = 'MQHDIST ' ;
  MQFMT_EMBEDDED_PCF             = 'MQHEPCF ' ;
  MQFMT_EVENT                    = 'MQEVENT ' ;
  MQFMT_IMS                      = 'MQIMS   ' ;
  MQFMT_IMS_VAR_STRING           = 'MQIMSVS ' ;
  MQFMT_MD_EXTENSION             = 'MQHMDE  ' ;
  MQFMT_PCF                      = 'MQPCF   ' ;
  MQFMT_REF_MSG_HEADER           = 'MQHREF  ' ;
  MQFMT_RF_HEADER                = 'MQHRF   ' ;
  MQFMT_RF_HEADER_1              = 'MQHRF   ' ;
  MQFMT_RF_HEADER_2              = 'MQHRF2  ' ;
  MQFMT_STRING                   = 'MQSTR   ' ;
  MQFMT_TRIGGER                  = 'MQTRIG  ' ;
  MQFMT_WORK_INFO_HEADER         = 'MQHWIH  ' ;
  MQFMT_XMIT_Q_HEADER            = 'MQXMIT  ' ;

{Message Flags}
  MQMF_SEGMENTATION_INHIBITED     = $00000000;
  MQMF_SEGMENTATION_ALLOWED       = $00000001;
  MQMF_MSG_IN_GROUP               = $00000008;
  MQMF_LAST_MSG_IN_GROUP          = $00000010;
  MQMF_SEGMENT                    = $00000002;
  MQMF_LAST_SEGMENT               = $00000004;
  MQMF_NONE                       = $00000000;
  MQMF_REJECT_UNSUP_MASK          = $00000FFF;
  MQMF_ACCEPT_UNSUP_MASK          = $FFF00000;
  MQMF_ACCEPT_UNSUP_IF_XMIT_MASK  = $000FF000;

{Application types}
  MQAT_UNKNOWN                    = -1;
  MQAT_NO_CONTEXT                 = 0;
  MQAT_CICS                       = 1;
  MQAT_MVS                        = 2;
  MQAT_OS390                      = 2;
  MQAT_ZOS                        = 2;
  MQAT_IMS                        = 3;
  MQAT_OS2                        = 4;
  MQAT_DOS                        = 5;
  MQAT_AIX                        = 6;
  MQAT_UNIX                       = 6;
  MQAT_QMGR                       = 7;
  MQAT_OS400                      = 8;
  MQAT_WINDOWS                    = 9;
  MQAT_CICS_VSE                   = 10;
  MQAT_WINDOWS_NT                 = 11;
  MQAT_VMS                        = 12;
  MQAT_GUARDIAN                   = 13;
  MQAT_NSK                        = 13;
  MQAT_VOS                        = 14;
  MQAT_IMS_BRIDGE                 = 19;
  MQAT_XCF                        = 20;
  MQAT_CICS_BRIDGE                = 21;
  MQAT_NOTES_AGENT                = 22;
  MQAT_USER                       = 25;
  MQAT_BROKER                     = 26;
  MQAT_JAVA                       = 28;
  MQAT_DQM                        = 29;
  MQAT_CHANNEL_INITIATOR          = 30;
  MQAT_DEFAULT                    = 6;
  MQAT_USER_FIRST                 = 65536;
  MQAT_USER_LAST                  = 999999999;

{Put-message options}
  MQPMO_SYNCPOINT                 = $00000002;
  MQPMO_NO_SYNCPOINT              = $00000004;
  MQPMO_NEW_MSG_ID                = $00000040;
  MQPMO_NEW_CORREL_ID             = $00000080;
  MQPMO_LOGICAL_ORDER             = $00008000;
  MQPMO_NO_CONTEXT                = $00004000;
  MQPMO_DEFAULT_CONTEXT           = $00000020;
  MQPMO_PASS_IDENTITY_CONTEXT     = $00000100;
  MQPMO_PASS_ALL_CONTEXT          = $00000200;
  MQPMO_SET_IDENTITY_CONTEXT      = $00000400;
  MQPMO_SET_ALL_CONTEXT           = $00000800;
  MQPMO_ALTERNATE_USER_AUTHORITY  = $00001000;
  MQPMO_FAIL_IF_QUIESCING         = $00002000;
  MQPMO_NONE                      = $00000000;

{Put Message Record Fields}
  MQPMRF_MSG_ID                   = $00000001;
  MQPMRF_CORREL_ID                = $00000002;
  MQPMRF_GROUP_ID                 = $00000004;
  MQPMRF_FEEDBACK                 = $00000008;
  MQPMRF_ACCOUNTING_TOKEN         = $00000010;
  MQPMRF_NONE                     = $00000000;

{ Action }
  MQACTP_NEW      = 0 ;
  MQACTP_FORWARD  = 1 ;
  MQACTP_REPLY    = 2 ;
  MQACTP_REPORT   = 3 ;

{Get-message options}
  MQGMO_WAIT                      = $00000001;
  MQGMO_NO_WAIT                   = $00000000;
  MQGMO_SET_SIGNAL                = $00000008;
  MQGMO_FAIL_IF_QUIESCING         = $00002000;
  MQGMO_SYNCPOINT                 = $00000002;
  MQGMO_SYNCPOINT_IF_PERSISTENT   = $00001000;
  MQGMO_NO_SYNCPOINT              = $00000004;
  MQGMO_MARK_SKIP_BACKOUT         = $00000080;
  MQGMO_BROWSE_FIRST              = $00000010;
  MQGMO_BROWSE_NEXT               = $00000020;
  MQGMO_BROWSE_MSG_UNDER_CURSOR   = $00000800;
  MQGMO_MSG_UNDER_CURSOR          = $00000100;
  MQGMO_LOCK                      = $00000200;
  MQGMO_UNLOCK                    = $00000400;
  MQGMO_ACCEPT_TRUNCATED_MSG      = $00000040;
  MQGMO_CONVERT                   = $00004000;
  MQGMO_LOGICAL_ORDER             = $00008000;
  MQGMO_COMPLETE_MSG              = $00010000;
  MQGMO_ALL_MSGS_AVAILABLE        = $00020000;
  MQGMO_ALL_SEGMENTS_AVAILABLE    = $00040000;
  MQGMO_NONE                      = $00000000;

{String Lengths}
  MQ_ABEND_CODE_LENGTH            = 4;
  MQ_ACCOUNTING_TOKEN_LENGTH      = 32;
  MQ_APPL_IDENTITY_DATA_LENGTH    = 32;
  MQ_APPL_NAME_LENGTH             = 28;
  MQ_APPL_ORIGIN_DATA_LENGTH      = 4;
  MQ_APPL_TAG_LENGTH              = 28;
  MQ_ATTENTION_ID_LENGTH          = 4;
  MQ_AUTH_INFO_CONN_NAME_LENGTH   = 264;
  MQ_AUTH_INFO_DESC_LENGTH        = 64;
  MQ_AUTH_INFO_NAME_LENGTH        = 48;
  MQ_AUTHENTICATOR_LENGTH         = 8;
  MQ_BRIDGE_NAME_LENGTH           = 24;
  MQ_CANCEL_CODE_LENGTH           = 4;
  MQ_CF_STRUC_DESC_LENGTH         = 64;
  MQ_CF_STRUC_NAME_LENGTH         = 12;
  MQ_CHANNEL_DATE_LENGTH          = 12;
  MQ_CHANNEL_DESC_LENGTH          = 64;
  MQ_CHANNEL_NAME_LENGTH          = 20;
  MQ_CHANNEL_TIME_LENGTH          = 8;
  MQ_CLUSTER_NAME_LENGTH          = 48;
  MQ_CONN_NAME_LENGTH             = 264;
  MQ_CONN_TAG_LENGTH              = 128;
  MQ_CORREL_ID_LENGTH             = 24;
  MQ_CREATION_DATE_LENGTH         = 12;
  MQ_CREATION_TIME_LENGTH         = 8;
  MQ_DATE_LENGTH                  = 12;
  MQ_DISTINGUISHED_NAME_LENGTH    = 1024;
  MQ_EXIT_DATA_LENGTH             = 32;
  MQ_EXIT_NAME_LENGTH             = 128;
  MQ_EXIT_PD_AREA_LENGTH          = 48;
  MQ_EXIT_USER_AREA_LENGTH        = 16;
  MQ_FACILITY_LENGTH              = 8;
  MQ_FACILITY_LIKE_LENGTH         = 4;
  MQ_FORMAT_LENGTH                = 8;
  MQ_FUNCTION_LENGTH              = 4;
  MQ_GROUP_ID_LENGTH              = 24;
  MQ_LDAP_PASSWORD_LENGTH         = 32;
  MQ_LOCAL_ADDRESS_LENGTH         = 48;
  MQ_LTERM_OVERRIDE_LENGTH        = 8;
  MQ_LUWID_LENGTH                 = 16;
  MQ_MAX_EXIT_NAME_LENGTH         = 128;
  MQ_MAX_MCA_USER_ID_LENGTH       = 64;
  MQ_MAX_USER_ID_LENGTH           = 64;
  MQ_MCA_JOB_NAME_LENGTH          = 28;
  MQ_MCA_NAME_LENGTH              = 20;
  MQ_MCA_USER_ID_LENGTH           = 12;
  MQ_MFS_MAP_NAME_LENGTH          = 8;
  MQ_MODE_NAME_LENGTH             = 8;
  MQ_MSG_HEADER_LENGTH            = 4000;
  MQ_MSG_ID_LENGTH                = 24;
  MQ_MSG_TOKEN_LENGTH             = 16;
  MQ_NAMELIST_DESC_LENGTH         = 64;
  MQ_NAMELIST_NAME_LENGTH         = 48;
  MQ_OBJECT_INSTANCE_ID_LENGTH    = 24;
  MQ_OBJECT_NAME_LENGTH           = 48;
  MQ_PASSWORD_LENGTH              = 12;
  MQ_PROCESS_APPL_ID_LENGTH       = 256;
  MQ_PROCESS_DESC_LENGTH          = 64;
  MQ_PROCESS_ENV_DATA_LENGTH      = 128;
  MQ_PROCESS_NAME_LENGTH          = 48;
  MQ_PROCESS_USER_DATA_LENGTH     = 128;
  MQ_PUT_APPL_NAME_LENGTH         = 28;
  MQ_PUT_DATE_LENGTH              = 8;
  MQ_PUT_TIME_LENGTH              = 8;
  MQ_Q_DESC_LENGTH                = 64;
  MQ_Q_MGR_DESC_LENGTH            = 64;
  MQ_Q_MGR_IDENTIFIER_LENGTH      = 48;
  MQ_Q_MGR_NAME_LENGTH            = 48;
  MQ_Q_NAME_LENGTH                = 48;
  MQ_QSG_NAME_LENGTH              = 4;
  MQ_REMOTE_SYS_ID_LENGTH         = 4;
  MQ_SECURITY_ID_LENGTH           = 40;
  MQ_SERVICE_NAME_LENGTH          = 32;
  MQ_SERVICE_STEP_LENGTH          = 8;
  MQ_SHORT_CONN_NAME_LENGTH       = 20;
  MQ_SSL_CIPHER_SPEC_LENGTH       = 32;
  MQ_SSL_CRYPTO_HARDWARE_LENGTH   = 256;
  MQ_SSL_HANDSHAKE_STAGE_LENGTH   = 32;
  MQ_SSL_KEY_REPOSITORY_LENGTH    = 256;
  MQ_SSL_PEER_NAME_LENGTH         = 1024;
  MQ_SSL_SHORT_PEER_NAME_LENGTH   = 256;
  MQ_START_CODE_LENGTH            = 4;
  MQ_STORAGE_CLASS_DESC_LENGTH    = 64;
  MQ_STORAGE_CLASS_LENGTH         = 8;
  MQ_SUB_IDENTITY_LENGTH          = 128;
  MQ_TIME_LENGTH                  = 8;
  MQ_TOTAL_EXIT_DATA_LENGTH       = 999;
  MQ_TOTAL_EXIT_NAME_LENGTH       = 999;
  MQ_TP_NAME_LENGTH               = 64;
  MQ_TRAN_INSTANCE_ID_LENGTH      = 16;
  MQ_TRANSACTION_ID_LENGTH        = 4;
  MQ_TRIGGER_DATA_LENGTH          = 64;
  MQ_USER_ID_LENGTH               = 12;
  MQ_XCF_GROUP_NAME_LENGTH        =  8;
  MQ_XCF_MEMBER_NAME_LENGTH       =  16;

{Unit of Work Control}
  MQCUOWC_ONLY                    = $00000111;
  MQCUOWC_CONTINUE                = $00010000;
  MQCUOWC_FIRST                   = $00000011;
  MQCUOWC_MIDDLE                  = $00000010;
  MQCUOWC_LAST                    = $00000110;
  MQCUOWC_COMMIT                  = $00000100;
  MQCUOWC_BACKOUT                 = $00001100;

{ Values Related to MQDLTMH Function }
{ Message handle }
  MQHM_UNUSABLE_HMSG = -1 ;
  MQHM_NONE          = 0 ;
 
{ Values Related to MQINQ Function }
{Character-Attribute Selectors}
  MQCA_ADMIN_TOPIC_NAME           = 2105 ;
  MQCA_ALTERATION_DATE            = 2027;
  MQCA_ALTERATION_TIME            = 2028;
  MQCA_APPL_ID                    = 2001;
  MQCA_AUTH_INFO_CONN_NAME        = 2053;
  MQCA_AUTH_INFO_DESC             = 2046;
  MQCA_AUTH_INFO_NAME             = 2045;
  MQCA_BACKOUT_REQ_Q_NAME         = 2019;
  MQCA_BASE_Q_NAME                = 2002;
  MQCA_CF_STRUC_DESC              = 2052;
  MQCA_CF_STRUC_NAME              = 2039;
  MQCA_CHANNEL_AUTO_DEF_EXIT      = 2026;
  MQCA_CLUSTER_DATE               = 2037;
  MQCA_CLUSTER_NAME               = 2029;
  MQCA_CLUSTER_NAMELIST           = 2030;
  MQCA_CLUSTER_Q_MGR_NAME         = 2031;
  MQCA_CLUSTER_TIME               = 2038;
  MQCA_CLUSTER_WORKLOAD_DATA      = 2034;
  MQCA_CLUSTER_WORKLOAD_EXIT      = 2033;
  MQCA_COMMAND_INPUT_Q_NAME       = 2003;
  MQCA_CREATION_DATE              = 2004;
  MQCA_CREATION_TIME              = 2005;
  MQCA_DEAD_LETTER_Q_NAME         = 2006;
  MQCA_DEF_XMIT_Q_NAME            = 2025;
  MQCA_ENV_DATA                   = 2007;
  MQCA_FIRST                      = 2001;
  MQCA_IGQ_USER_ID                = 2041;
  MQCA_INITIATION_Q_NAME          = 2008;
  MQCA_LAST                       = 4000;
  MQCA_LAST_USED                  = 2053;
  MQCA_LDAP_PASSWORD              = 2048;
  MQCA_LDAP_USER_NAME             = 2047;
  MQCA_NAMELIST_DESC              = 2009;
  MQCA_NAMELIST_NAME              = 2010;
  MQCA_NAMES                      = 2020;
  MQCA_PROCESS_DESC               = 2011;
  MQCA_PROCESS_NAME               = 2012;
  MQCA_Q_DESC                     = 2013;
  MQCA_Q_MGR_DESC                 = 2014;
  MQCA_Q_MGR_IDENTIFIER           = 2032;
  MQCA_Q_MGR_NAME                 = 2015;
  MQCA_Q_NAME                     = 2016;
  MQCA_QSG_NAME                   = 2040;
  MQCA_REMOTE_Q_MGR_NAME          = 2017;
  MQCA_REMOTE_Q_NAME              = 2018;
  MQCA_REPOSITORY_NAME            = 2035;
  MQCA_REPOSITORY_NAMELIST        = 2036;
  MQCA_SSL_CRL_NAMELIST           = 2050;
  MQCA_SSL_CRYPTO_HARDWARE        = 2051;
  MQCA_SSL_KEY_REPOSITORY         = 2049;
  MQCA_STORAGE_CLASS              = 2022;
  MQCA_STORAGE_CLASS_DESC         = 2042;
  MQCA_TRIGGER_DATA               = 2023;
  MQCA_USER_DATA                  = 2021;
  MQCA_USER_LIST                  = 4000;
  MQCA_XCF_GROUP_NAME             = 2043;
  MQCA_XCF_MEMBER_NAME            = 2044;
  MQCA_XMIT_Q_NAME                = 2024;

{Integer-Attribute Selectors}
  MQIA_APPL_TYPE                  = 1;
  MQIA_ARCHIVE                    = 60;
  MQIA_AUTH_INFO_TYPE             = 66;
  MQIA_AUTHORITY_EVENT            = 47;
  MQIA_BACKOUT_THRESHOLD          = 22;
  MQIA_CF_LEVEL                   = 70;
  MQIA_CF_RECOVER                 = 71;
  MQIA_CHANNEL_AUTO_DEF           = 55;
  MQIA_CHANNEL_AUTO_DEF_EVENT     = 56;
  MQIA_CLUSTER_Q_TYPE             = 59;
  MQIA_CLUSTER_WORKLOAD_LENGTH    = 58;
  MQIA_CODED_CHAR_SET_ID          = 2;
  MQIA_COMMAND_LEVEL              = 31;
  MQIA_CONFIGURATION_EVENT        = 51;
  MQIA_CURRENT_Q_DEPTH            = 3;
  MQIA_DEF_BIND                   = 61;
  MQIA_DEF_INPUT_OPEN_OPTION      = 4;
  MQIA_DEF_PERSISTENCE            = 5;
  MQIA_DEF_PRIORITY               = 6;
  MQIA_DEFINITION_TYPE            = 7;
  MQIA_DIST_LISTS                 = 34;
  MQIA_EXPIRY_INTERVAL            = 39;
  MQIA_FIRST                      = 1;
  MQIA_HARDEN_GET_BACKOUT         = 8;
  MQIA_HIGH_Q_DEPTH               = 36;
  MQIA_IGQ_PUT_AUTHORITY          = 65;
  MQIA_INDEX_TYPE                 = 57;
  MQIA_INHIBIT_EVENT              = 48;
  MQIA_INHIBIT_GET                = 9;
  MQIA_INHIBIT_PUT                = 10;
  MQIA_INTRA_GROUP_QUEUING        = 64;
  MQIA_LAST                       = 2000;
  MQIA_LAST_USED                  = 66;
  MQIA_LOCAL_EVENT                = 49;
  MQIA_MAX_HANDLES                = 11;
  MQIA_MAX_MSG_LENGTH             = 13;
  MQIA_MAX_PRIORITY               = 14;
  MQIA_MAX_Q_DEPTH                = 15;
  MQIA_MAX_UNCOMMITTED_MSGS       = 33;
  MQIA_MSG_DELIVERY_SEQUENCE      = 16;
  MQIA_MSG_DEQ_COUNT              = 38;
  MQIA_MSG_ENQ_COUNT              = 37;
  MQIA_NAME_COUNT                 = 19;
  MQIA_NAMELIST_TYPE              = 72;
  MQIA_OPEN_INPUT_COUNT           = 17;
  MQIA_OPEN_OUTPUT_COUNT          = 18;
  MQIA_PAGESET_ID                 = 62;
  MQIA_PERFORMANCE_EVENT          = 53;
  MQIA_PLATFORM                   = 32;
  MQIA_Q_DEPTH_HIGH_EVENT         = 43;
  MQIA_Q_DEPTH_HIGH_LIMIT         = 40;
  MQIA_Q_DEPTH_LOW_EVENT          = 44;
  MQIA_Q_DEPTH_LOW_LIMIT          = 41;
  MQIA_Q_DEPTH_MAX_EVENT          = 42;
  MQIA_Q_SERVICE_INTERVAL         = 54;
  MQIA_Q_SERVICE_INTERVAL_EVENT   = 46;
  MQIA_Q_TYPE                     = 20;
  MQIA_QSG_DISP                   = 63;
  MQIA_REMOTE_EVENT               = 50;
  MQIA_RETENTION_INTERVAL         = 21;
  MQIA_SCOPE                      = 45;
  MQIA_SHAREABILITY               = 23;
  MQIA_SSL_TASKS                  = 69;
  MQIA_START_STOP_EVENT           = 52;
  MQIA_SYNCPOINT                  = 30;
  MQIA_TIME_SINCE_RESET           = 35;
  MQIA_TRIGGER_CONTROL            = 24;
  MQIA_TRIGGER_DEPTH              = 29;
  MQIA_TRIGGER_INTERVAL           = 25;
  MQIA_TRIGGER_MSG_PRIORITY       = 26;
  MQIA_TRIGGER_TYPE               = 28;
  MQIA_USAGE                      = 12;
  MQIA_USER_LIST                  = 2000;

{Return Code}
  MQCRC_OK                        = 0;
  MQCRC_CICS_EXEC_ERROR           = 1;
  MQCRC_MQ_API_ERROR              = 2;
  MQCRC_BRIDGE_ERROR              = 3;
  MQCRC_BRIDGE_ABEND              = 4;
  MQCRC_APPLICATION_ABEND         = 5;
  MQCRC_SECURITY_ERROR            = 6;
  MQCRC_PROGRAM_NOT_AVAILABLE     = 7;
  MQCRC_BRIDGE_TIMEOUT            = 8;
  MQCRC_TRANSID_NOT_AVAILABLE     = 9;

{Completion Codes}
  MQCC_OK                         = 0;
  MQCC_WARNING                    = 1;
  MQCC_FAILED                     = 2;
  MQCC_UNKNOWN                    = -1;

{Reason Codes}
  MQRC_NONE                        = 0;
  MQRC_APPL_FIRST                  = 900;
  MQRC_APPL_LAST                   = 999;
  MQRC_ALIAS_BASE_Q_TYPE_ERROR     = 2001;
  MQRC_ALREADY_CONNECTED           = 2002;
  MQRC_BACKED_OUT                  = 2003;
  MQRC_BUFFER_ERROR                = 2004;
  MQRC_BUFFER_LENGTH_ERROR         = 2005;
  MQRC_CHAR_ATTR_LENGTH_ERROR      = 2006;
  MQRC_CHAR_ATTRS_ERROR            = 2007;
  MQRC_CHAR_ATTRS_TOO_SHORT        = 2008;
  MQRC_CONNECTION_BROKEN           = 2009;
  MQRC_DATA_LENGTH_ERROR           = 2010;
  MQRC_DYNAMIC_Q_NAME_ERROR        = 2011;
  MQRC_ENVIRONMENT_ERROR           = 2012;
  MQRC_EXPIRY_ERROR                = 2013;
  MQRC_FEEDBACK_ERROR              = 2014;
  MQRC_GET_INHIBITED               = 2016;
  MQRC_HANDLE_NOT_AVAILABLE        = 2017;
  MQRC_HCONN_ERROR                 = 2018;
  MQRC_HOBJ_ERROR                  = 2019;
  MQRC_INHIBIT_VALUE_ERROR         = 2020;
  MQRC_INT_ATTR_COUNT_ERROR        = 2021;
  MQRC_INT_ATTR_COUNT_TOO_SMALL    = 2022;
  MQRC_INT_ATTRS_ARRAY_ERROR       = 2023;
  MQRC_SYNCPOINT_LIMIT_REACHED     = 2024;
  MQRC_MAX_CONNS_LIMIT_REACHED     = 2025;
  MQRC_MD_ERROR                    = 2026;
  MQRC_MISSING_REPLY_TO_Q          = 2027;
  MQRC_MSG_TYPE_ERROR              = 2029;
  MQRC_MSG_TOO_BIG_FOR_Q           = 2030;
  MQRC_MSG_TOO_BIG_FOR_Q_MGR       = 2031;
  MQRC_NO_MSG_AVAILABLE            = 2033;
  MQRC_NO_MSG_UNDER_CURSOR         = 2034;
  MQRC_NOT_AUTHORIZED              = 2035;
  MQRC_NOT_OPEN_FOR_BROWSE         = 2036;
  MQRC_NOT_OPEN_FOR_INPUT          = 2037;
  MQRC_NOT_OPEN_FOR_INQUIRE        = 2038;
  MQRC_NOT_OPEN_FOR_OUTPUT         = 2039;
  MQRC_NOT_OPEN_FOR_SET            = 2040;
  MQRC_OBJECT_CHANGED              = 2041;
  MQRC_OBJECT_IN_USE               = 2042;
  MQRC_OBJECT_TYPE_ERROR           = 2043;
  MQRC_OD_ERROR                    = 2044;
  MQRC_OPTION_NOT_VALID_FOR_TYPE   = 2045;
  MQRC_OPTIONS_ERROR               = 2046;
  MQRC_PERSISTENCE_ERROR           = 2047;
  MQRC_PERSISTENT_NOT_ALLOWED      = 2048;
  MQRC_PRIORITY_EXCEEDS_MAXIMUM    = 2049;
  MQRC_PRIORITY_ERROR              = 2050;
  MQRC_PUT_INHIBITED               = 2051;
  MQRC_Q_DELETED                   = 2052;
  MQRC_Q_FULL                      = 2053;
  MQRC_Q_NOT_EMPTY                 = 2055;
  MQRC_Q_SPACE_NOT_AVAILABLE       = 2056;
  MQRC_Q_TYPE_ERROR                = 2057;
  MQRC_Q_MGR_NAME_ERROR            = 2058;
  MQRC_Q_MGR_NOT_AVAILABLE         = 2059;
  MQRC_REPORT_OPTIONS_ERROR        = 2061;
  MQRC_SECOND_MARK_NOT_ALLOWED     = 2062;
  MQRC_SECURITY_ERROR              = 2063;
  MQRC_SELECTOR_COUNT_ERROR        = 2065;
  MQRC_SELECTOR_LIMIT_EXCEEDED     = 2066;
  MQRC_SELECTOR_ERROR              = 2067;
  MQRC_SELECTOR_NOT_FOR_TYPE       = 2068;
  MQRC_SIGNAL_OUTSTANDING          = 2069;
  MQRC_SIGNAL_REQUEST_ACCEPTED     = 2070;
  MQRC_STORAGE_NOT_AVAILABLE       = 2071;
  MQRC_SYNCPOINT_NOT_AVAILABLE     = 2072;
  MQRC_TRIGGER_CONTROL_ERROR       = 2075;
  MQRC_TRIGGER_DEPTH_ERROR         = 2076;
  MQRC_TRIGGER_MSG_PRIORITY_ERR    = 2077;
  MQRC_TRIGGER_TYPE_ERROR          = 2078;
  MQRC_TRUNCATED_MSG_ACCEPTED      = 2079;
  MQRC_TRUNCATED_MSG_FAILED        = 2080;
  MQRC_UNKNOWN_ALIAS_BASE_Q        = 2082;
  MQRC_UNKNOWN_OBJECT_NAME         = 2085;
  MQRC_UNKNOWN_OBJECT_Q_MGR        = 2086;
  MQRC_UNKNOWN_REMOTE_Q_MGR        = 2087;
  MQRC_WAIT_INTERVAL_ERROR         = 2090;
  MQRC_XMIT_Q_TYPE_ERROR           = 2091;
  MQRC_XMIT_Q_USAGE_ERROR          = 2092;
  MQRC_NOT_OPEN_FOR_PASS_ALL       = 2093;
  MQRC_NOT_OPEN_FOR_PASS_IDENT     = 2094;
  MQRC_NOT_OPEN_FOR_SET_ALL        = 2095;
  MQRC_NOT_OPEN_FOR_SET_IDENT      = 2096;
  MQRC_CONTEXT_HANDLE_ERROR        = 2097;
  MQRC_CONTEXT_NOT_AVAILABLE       = 2098;
  MQRC_SIGNAL1_ERROR               = 2099;
  MQRC_OBJECT_ALREADY_EXISTS       = 2100;
  MQRC_OBJECT_DAMAGED              = 2101;
  MQRC_RESOURCE_PROBLEM            = 2102;
  MQRC_ANOTHER_Q_MGR_CONNECTED     = 2103;
  MQRC_UNKNOWN_REPORT_OPTION       = 2104;
  MQRC_STORAGE_CLASS_ERROR         = 2105;
  MQRC_COD_NOT_VALID_FOR_XCF_Q     = 2106;
  MQRC_XWAIT_CANCELED              = 2107;
  MQRC_XWAIT_ERROR                 = 2108;
  MQRC_SUPPRESSED_BY_EXIT          = 2109;
  MQRC_FORMAT_ERROR                = 2110;
  MQRC_SOURCE_CCSID_ERROR          = 2111;
  MQRC_SOURCE_INTEGER_ENC_ERROR    = 2112;
  MQRC_SOURCE_DECIMAL_ENC_ERROR    = 2113;
  MQRC_SOURCE_FLOAT_ENC_ERROR      = 2114;
  MQRC_TARGET_CCSID_ERROR          = 2115;
  MQRC_TARGET_INTEGER_ENC_ERROR    = 2116;
  MQRC_TARGET_DECIMAL_ENC_ERROR    = 2117;
  MQRC_TARGET_FLOAT_ENC_ERROR      = 2118;
  MQRC_NOT_CONVERTED               = 2119;
  MQRC_CONVERTED_MSG_TOO_BIG       = 2120;
  MQRC_TRUNCATED                   = 2120;
  MQRC_NO_EXTERNAL_PARTICIPANTS    = 2121;
  MQRC_PARTICIPANT_NOT_AVAILABLE   = 2122;
  MQRC_OUTCOME_MIXED               = 2123;
  MQRC_OUTCOME_PENDING             = 2124;
  MQRC_BRIDGE_STARTED              = 2125;
  MQRC_BRIDGE_STOPPED              = 2126;
  MQRC_ADAPTER_STORAGE_SHORTAGE    = 2127;
  MQRC_UOW_IN_PROGRESS             = 2128;
  MQRC_ADAPTER_CONN_LOAD_ERROR     = 2129;
  MQRC_ADAPTER_SERV_LOAD_ERROR     = 2130;
  MQRC_ADAPTER_DEFS_ERROR          = 2131;
  MQRC_ADAPTER_DEFS_LOAD_ERROR     = 2132;
  MQRC_ADAPTER_CONV_LOAD_ERROR     = 2133;
  MQRC_BO_ERROR                    = 2134;
  MQRC_DH_ERROR                    = 2135;
  MQRC_MULTIPLE_REASONS            = 2136;
  MQRC_OPEN_FAILED                 = 2137;
  MQRC_ADAPTER_DISC_LOAD_ERROR     = 2138;
  MQRC_CNO_ERROR                   = 2139;
  MQRC_CICS_WAIT_FAILED            = 2140;
  MQRC_DLH_ERROR                   = 2141;
  MQRC_HEADER_ERROR                = 2142;
  MQRC_SOURCE_LENGTH_ERROR         = 2143;
  MQRC_TARGET_LENGTH_ERROR         = 2144;
  MQRC_SOURCE_BUFFER_ERROR         = 2145;
  MQRC_TARGET_BUFFER_ERROR         = 2146;
  MQRC_IIH_ERROR                   = 2148;
  MQRC_PCF_ERROR                   = 2149;
  MQRC_DBCS_ERROR                  = 2150;
  MQRC_OBJECT_NAME_ERROR           = 2152;
  MQRC_OBJECT_Q_MGR_NAME_ERROR     = 2153;
  MQRC_RECS_PRESENT_ERROR          = 2154;
  MQRC_OBJECT_RECORDS_ERROR        = 2155;
  MQRC_RESPONSE_RECORDS_ERROR      = 2156;
  MQRC_ASID_MISMATCH               = 2157;
  MQRC_PMO_RECORD_FLAGS_ERROR      = 2158;
  MQRC_PUT_MSG_RECORDS_ERROR       = 2159;
  MQRC_CONN_ID_IN_USE              = 2160;
  MQRC_Q_MGR_QUIESCING             = 2161;
  MQRC_Q_MGR_STOPPING              = 2162;
  MQRC_DUPLICATE_RECOV_COORD       = 2163;
  MQRC_PMO_ERROR                   = 2173;
  MQRC_API_EXIT_NOT_FOUND          = 2182;
  MQRC_API_EXIT_LOAD_ERROR         = 2183;
  MQRC_REMOTE_Q_NAME_ERROR         = 2184;
  MQRC_INCONSISTENT_PERSISTENCE    = 2185;
  MQRC_GMO_ERROR                   = 2186;
  MQRC_CICS_BRIDGE_RESTRICTION     = 2187;
  MQRC_STOPPED_BY_CLUSTER_EXIT     = 2188;
  MQRC_CLUSTER_RESOLUTION_ERROR    = 2189;
  MQRC_CONVERTED_STRING_TOO_BIG    = 2190;
  MQRC_TMC_ERROR                   = 2191;
  MQRC_PAGESET_FULL                = 2192;
  MQRC_STORAGE_MEDIUM_FULL         = 2192;
  MQRC_PAGESET_ERROR               = 2193;
  MQRC_NAME_NOT_VALID_FOR_TYPE     = 2194;
  MQRC_UNEXPECTED_ERROR            = 2195;
  MQRC_UNKNOWN_XMIT_Q              = 2196;
  MQRC_UNKNOWN_DEF_XMIT_Q          = 2197;
  MQRC_DEF_XMIT_Q_TYPE_ERROR       = 2198;
  MQRC_DEF_XMIT_Q_USAGE_ERROR      = 2199;
  MQRC_NAME_IN_USE                 = 2201;
  MQRC_CONNECTION_QUIESCING        = 2202;
  MQRC_CONNECTION_STOPPING         = 2203;
  MQRC_ADAPTER_NOT_AVAILABLE       = 2204;
  MQRC_MSG_ID_ERROR                = 2206;
  MQRC_CORREL_ID_ERROR             = 2207;
  MQRC_FILE_SYSTEM_ERROR           = 2208;
  MQRC_NO_MSG_LOCKED               = 2209;
  MQRC_FILE_NOT_AUDITED            = 2216;
  MQRC_CONNECTION_NOT_AUTHORIZED   = 2217;
  MQRC_MSG_TOO_BIG_FOR_CHANNEL     = 2218;
  MQRC_CALL_IN_PROGRESS            = 2219;
  MQRC_RMH_ERROR                   = 2220;
  MQRC_Q_MGR_ACTIVE                = 2222;
  MQRC_Q_MGR_NOT_ACTIVE            = 2223;
  MQRC_Q_DEPTH_HIGH                = 2224;
  MQRC_Q_DEPTH_LOW                 = 2225;
  MQRC_Q_SERVICE_INTERVAL_HIGH     = 2226;
  MQRC_Q_SERVICE_INTERVAL_OK       = 2227;
  MQRC_UNIT_OF_WORK_NOT_STARTED    = 2232;
  MQRC_CHANNEL_AUTO_DEF_OK         = 2233;
  MQRC_CHANNEL_AUTO_DEF_ERROR      = 2234;
  MQRC_CFH_ERROR                   = 2235;
  MQRC_CFIL_ERROR                  = 2236;
  MQRC_CFIN_ERROR                  = 2237;
  MQRC_CFSL_ERROR                  = 2238;
  MQRC_CFST_ERROR                  = 2239;
  MQRC_INCOMPLETE_GROUP            = 2241;
  MQRC_INCOMPLETE_MSG              = 2242;
  MQRC_INCONSISTENT_CCSIDS         = 2243;
  MQRC_INCONSISTENT_ENCODINGS      = 2244;
  MQRC_INCONSISTENT_UOW            = 2245;
  MQRC_INVALID_MSG_UNDER_CURSOR    = 2246;
  MQRC_MATCH_OPTIONS_ERROR         = 2247;
  MQRC_MDE_ERROR                   = 2248;
  MQRC_MSG_FLAGS_ERROR             = 2249;
  MQRC_MSG_SEQ_NUMBER_ERROR        = 2250;
  MQRC_OFFSET_ERROR                = 2251;
  MQRC_ORIGINAL_LENGTH_ERROR       = 2252;
  MQRC_SEGMENT_LENGTH_ZERO         = 2253;
  MQRC_UOW_NOT_AVAILABLE           = 2255;
  MQRC_WRONG_GMO_VERSION           = 2256;
  MQRC_WRONG_MD_VERSION            = 2257;
  MQRC_GROUP_ID_ERROR              = 2258;
  MQRC_INCONSISTENT_BROWSE         = 2259;
  MQRC_XQH_ERROR                   = 2260;
  MQRC_SRC_ENV_ERROR               = 2261;
  MQRC_SRC_NAME_ERROR              = 2262;
  MQRC_DEST_ENV_ERROR              = 2263;
  MQRC_DEST_NAME_ERROR             = 2264;
  MQRC_TM_ERROR                    = 2265;
  MQRC_CLUSTER_EXIT_ERROR          = 2266;
  MQRC_CLUSTER_EXIT_LOAD_ERROR     = 2267;
  MQRC_CLUSTER_PUT_INHIBITED       = 2268;
  MQRC_CLUSTER_RESOURCE_ERROR      = 2269;
  MQRC_NO_DESTINATIONS_AVAILABLE   = 2270;
  MQRC_CONN_TAG_IN_USE             = 2271;
  MQRC_PARTIALLY_CONVERTED         = 2272;
  MQRC_CONNECTION_ERROR            = 2273;
  MQRC_OPTION_ENVIRONMENT_ERROR    = 2274;
  MQRC_CD_ERROR                    = 2277;
  MQRC_CLIENT_CONN_ERROR           = 2278;
  MQRC_CHANNEL_STOPPED_BY_USER     = 2279;
  MQRC_HCONFIG_ERROR               = 2280;
  MQRC_FUNCTION_ERROR              = 2281;
  MQRC_CHANNEL_STARTED             = 2282;
  MQRC_CHANNEL_STOPPED             = 2283;
  MQRC_CHANNEL_CONV_ERROR          = 2284;
  MQRC_SERVICE_NOT_AVAILABLE       = 2285;
  MQRC_INITIALIZATION_FAILED       = 2286;
  MQRC_TERMINATION_FAILED          = 2287;
  MQRC_UNKNOWN_Q_NAME              = 2288;
  MQRC_SERVICE_ERROR               = 2289;
  MQRC_Q_ALREADY_EXISTS            = 2290;
  MQRC_USER_ID_NOT_AVAILABLE       = 2291;
  MQRC_UNKNOWN_ENTITY              = 2292;
  MQRC_UNKNOWN_AUTH_ENTITY         = 2293;
  MQRC_UNKNOWN_REF_OBJECT          = 2294;
  MQRC_CHANNEL_ACTIVATED           = 2295;
  MQRC_CHANNEL_NOT_ACTIVATED       = 2296;
  MQRC_UOW_CANCELED                = 2297;
  MQRC_FUNCTION_NOT_SUPPORTED      = 2298;
  MQRC_SELECTOR_TYPE_ERROR         = 2299;
  MQRC_COMMAND_TYPE_ERROR          = 2300;
  MQRC_MULTIPLE_INSTANCE_ERROR     = 2301;
  MQRC_SYSTEM_ITEM_NOT_ALTERABLE   = 2302;
  MQRC_BAG_CONVERSION_ERROR        = 2303;
  MQRC_SELECTOR_OUT_OF_RANGE       = 2304;
  MQRC_SELECTOR_NOT_UNIQUE         = 2305;
  MQRC_INDEX_NOT_PRESENT           = 2306;
  MQRC_STRING_ERROR                = 2307;
  MQRC_ENCODING_NOT_SUPPORTED      = 2308;
  MQRC_SELECTOR_NOT_PRESENT        = 2309;
  MQRC_OUT_SELECTOR_ERROR          = 2310;
  MQRC_STRING_TRUNCATED            = 2311;
  MQRC_SELECTOR_WRONG_TYPE         = 2312;
  MQRC_INCONSISTENT_ITEM_TYPE      = 2313;
  MQRC_INDEX_ERROR                 = 2314;
  MQRC_SYSTEM_BAG_NOT_ALTERABLE    = 2315;
  MQRC_ITEM_COUNT_ERROR            = 2316;
  MQRC_FORMAT_NOT_SUPPORTED        = 2317;
  MQRC_SELECTOR_NOT_SUPPORTED      = 2318;
  MQRC_ITEM_VALUE_ERROR            = 2319;
  MQRC_HBAG_ERROR                  = 2320;
  MQRC_PARAMETER_MISSING           = 2321;
  MQRC_CMD_SERVER_NOT_AVAILABLE    = 2322;
  MQRC_STRING_LENGTH_ERROR         = 2323;
  MQRC_INQUIRY_COMMAND_ERROR       = 2324;
  MQRC_NESTED_BAG_NOT_SUPPORTED    = 2325;
  MQRC_BAG_WRONG_TYPE              = 2326;
  MQRC_ITEM_TYPE_ERROR             = 2327;
  MQRC_SYSTEM_BAG_NOT_DELETABLE    = 2328;
  MQRC_SYSTEM_ITEM_NOT_DELETABLE   = 2329;
  MQRC_CODED_CHAR_SET_ID_ERROR     = 2330;
  MQRC_MSG_TOKEN_ERROR             = 2331;
  MQRC_MISSING_WIH                 = 2332;
  MQRC_WIH_ERROR                   = 2333;
  MQRC_RFH_ERROR                   = 2334;
  MQRC_RFH_STRING_ERROR            = 2335;
  MQRC_RFH_COMMAND_ERROR           = 2336;
  MQRC_RFH_PARM_ERROR              = 2337;
  MQRC_RFH_DUPLICATE_PARM          = 2338;
  MQRC_RFH_PARM_MISSING            = 2339;
  MQRC_CHAR_CONVERSION_ERROR       = 2340;
  MQRC_UCS2_CONVERSION_ERROR       = 2341;
  MQRC_DB2_NOT_AVAILABLE           = 2342;
  MQRC_OBJECT_NOT_UNIQUE           = 2343;
  MQRC_CONN_TAG_NOT_RELEASED       = 2344;
  MQRC_CF_NOT_AVAILABLE            = 2345;
  MQRC_CF_STRUC_IN_USE             = 2346;
  MQRC_CF_STRUC_LIST_HDR_IN_USE    = 2347;
  MQRC_CF_STRUC_AUTH_FAILED        = 2348;
  MQRC_CF_STRUC_ERROR              = 2349;
  MQRC_CONN_TAG_NOT_USABLE         = 2350;
  MQRC_GLOBAL_UOW_CONFLICT         = 2351;
  MQRC_LOCAL_UOW_CONFLICT          = 2352;
  MQRC_HANDLE_IN_USE_FOR_UOW       = 2353;
  MQRC_UOW_ENLISTMENT_ERROR        = 2354;
  MQRC_UOW_MIX_NOT_SUPPORTED       = 2355;
  MQRC_WXP_ERROR                   = 2356;
  MQRC_CURRENT_RECORD_ERROR        = 2357;
  MQRC_NEXT_OFFSET_ERROR           = 2358;
  MQRC_NO_RECORD_AVAILABLE         = 2359;
  MQRC_OBJECT_LEVEL_INCOMPATIBLE   = 2360;
  MQRC_NEXT_RECORD_ERROR           = 2361;
  MQRC_BACKOUT_THRESHOLD_REACHED   = 2362;
  MQRC_MSG_NOT_MATCHED             = 2363;
  MQRC_JMS_FORMAT_ERROR            = 2364;
  MQRC_SEGMENTS_NOT_SUPPORTED      = 2365;
  MQRC_WRONG_CF_LEVEL              = 2366;
  MQRC_CONFIG_CREATE_OBJECT        = 2367;
  MQRC_CONFIG_CHANGE_OBJECT        = 2368;
  MQRC_CONFIG_DELETE_OBJECT        = 2369;
  MQRC_CONFIG_REFRESH_OBJECT       = 2370;
  MQRC_CHANNEL_SSL_ERROR           = 2371;
  MQRC_CF_STRUC_FAILED             = 2373;
  MQRC_API_EXIT_ERROR              = 2374;
  MQRC_API_EXIT_INIT_ERROR         = 2375;
  MQRC_API_EXIT_TERM_ERROR         = 2376;
  MQRC_EXIT_REASON_ERROR           = 2377;
  MQRC_RESERVED_VALUE_ERROR        = 2378;
  MQRC_NO_DATA_AVAILABLE           = 2379;
  MQRC_SCO_ERROR                   = 2380;
  MQRC_KEY_REPOSITORY_ERROR        = 2381;
  MQRC_CRYPTO_HARDWARE_ERROR       = 2382;
  MQRC_AUTH_INFO_REC_COUNT_ERROR   = 2383;
  MQRC_AUTH_INFO_REC_ERROR         = 2384;
  MQRC_AIR_ERROR                   = 2385;
  MQRC_AUTH_INFO_TYPE_ERROR        = 2386;
  MQRC_AUTH_INFO_CONN_NAME_ERROR   = 2387;
  MQRC_LDAP_USER_NAME_ERROR        = 2388;
  MQRC_LDAP_USER_NAME_LENGTH_ERR   = 2389;
  MQRC_LDAP_PASSWORD_ERROR         = 2390;
  MQRC_SSL_ALREADY_INITIALIZED     = 2391;
  MQRC_SSL_CONFIG_ERROR            = 2392;
  MQRC_SSL_INITIALIZATION_ERROR    = 2393;
  MQRC_Q_INDEX_TYPE_ERROR          = 2394;
  MQRC_SSL_NOT_ALLOWED             = 2396;
  MQRC_JSSE_ERROR                  = 2397;
  MQRC_SSL_PEER_NAME_MISMATCH      = 2398;
  MQRC_SSL_PEER_NAME_ERROR         = 2399;
  MQRC_UNSUPPORTED_CIPHER_SUITE    = 2400;
  MQRC_SSL_CERTIFICATE_REVOKED     = 2401;
  MQRC_SSL_CERT_STORE_ERROR        = 2402;
  MQRC_REOPEN_EXCL_INPUT_ERROR     = 6100;
  MQRC_REOPEN_INQUIRE_ERROR        = 6101;
  MQRC_REOPEN_SAVED_CONTEXT_ERR    = 6102;
  MQRC_REOPEN_TEMPORARY_Q_ERROR    = 6103;
  MQRC_ATTRIBUTE_LOCKED            = 6104;
  MQRC_CURSOR_NOT_VALID            = 6105;
  MQRC_ENCODING_ERROR              = 6106;
  MQRC_STRUC_ID_ERROR              = 6107;
  MQRC_NULL_POINTER                = 6108;
  MQRC_NO_CONNECTION_REFERENCE     = 6109;
  MQRC_NO_BUFFER                   = 6110;
  MQRC_BINARY_DATA_LENGTH_ERROR    = 6111;
  MQRC_BUFFER_NOT_AUTOMATIC        = 6112;
  MQRC_INSUFFICIENT_BUFFER         = 6113;
  MQRC_INSUFFICIENT_DATA           = 6114;
  MQRC_DATA_TRUNCATED              = 6115;
  MQRC_ZERO_LENGTH                 = 6116;
  MQRC_NEGATIVE_LENGTH             = 6117;
  MQRC_NEGATIVE_OFFSET             = 6118;
  MQRC_INCONSISTENT_FORMAT         = 6119;
  MQRC_INCONSISTENT_OBJECT_STATE   = 6120;
  MQRC_CONTEXT_OBJECT_NOT_VALID    = 6121;
  MQRC_CONTEXT_OPEN_ERROR          = 6122;
  MQRC_STRUC_LENGTH_ERROR          = 6123;
  MQRC_NOT_CONNECTED               = 6124;
  MQRC_NOT_OPEN                    = 6125;
  MQRC_DISTRIBUTION_LIST_EMPTY     = 6126;
  MQRC_INCONSISTENT_OPEN_OPTIONS   = 6127;
  MQRC_WRONG_VERSION               = 6128;
  MQRC_REFERENCE_ERROR             = 6129;

{ Values Related to Queue Attributes }

  MQQT_LOCAL        = 1 ;
  MQQT_MODEL        = 2 ;
  MQQT_ALIAS        = 3 ;
  MQQT_REMOTE       = 6 ;
  MQQT_CLUSTER      = 7 ;

{Priority}
  MQPRI_PRIORITY_AS_Q_DEF        = -1 ;
  MQPRI_PRIORITY_AS_PARENT       = -2 ;
  MQPRI_PRIORITY_AS_PUBLISHED    = -3 ;
  MQPRI_PRIORITY_AS_TOPIC_DEF    = -1 ;

{Original length}
  MQOL_UNDEFINED                 = -1;

{Wait interval}
  MQWI_UNLIMITED                 = -1;
  MQCGWI_DEFAULT                 = -2;

{Returned length}
  MQRL_UNDEFINED                 = -1;

{Authentication Information Type}
  MQAIT_CRL_LDAP                 = 1;

{Output Data Length}
  MQCODL_AS_INPUT                = -1;

{Integer Attribute Value Denoting "Not Applicable"}
  MQIAV_NOT_APPLICABLE           = -1;
  MQIAV_UNDEFINED                = -2;

{Persistence values}
  MQPER_NOT_PERSISTENT           = 0;
  MQPER_PERSISTENT               = 1;
  MQPER_PERSISTENCE_AS_Q_DEF     = 2;

{Signal Values}
  MQEC_MSG_ARRIVED               = 2;
  MQEC_WAIT_INTERVAL_EXPIRED     = 3;
  MQEC_WAIT_CANCELED             = 4;
  MQEC_Q_MGR_QUIESCING           = 5;
  MQEC_CONNECTION_QUIESCING      = 6;

{Match Options}
  MQMO_MATCH_MSG_ID              = $00000001;
  MQMO_MATCH_CORREL_ID           = $00000002;
  MQMO_MATCH_GROUP_ID            = $00000004;
  MQMO_MATCH_MSG_SEQ_NUMBER      = $00000008;
  MQMO_MATCH_OFFSET              = $00000010;
  MQMO_MATCH_MSG_TOKEN           = $00000020;
  MQMO_NONE                      = $00000000;

{Group status}
  MQGS_NOT_IN_GROUP              = ' ';
  MQGS_MSG_IN_GROUP              = 'G';
  MQGS_LAST_MSG_IN_GROUP         = 'L';

{Segment status}
  MQSS_NOT_A_SEGMENT             = ' ';
  MQSS_SEGMENT                   = 'S';
  MQSS_LAST_SEGMENT              = 'L';

{Segmentation}
  MQSEG_INHIBITED                = ' ';
  MQSEG_ALLOWED                  = 'A';

{Link Type}
  MQCLT_PROGRAM                  = 1;
  MQCLT_TRANSACTION              = 2;

{ADS Descriptor}
  MQCADSD_NONE                   = $00000000;
  MQCADSD_SEND                   = $00000001;
  MQCADSD_RECV                   = $00000010;
  MQCADSD_MSGFORMAT              = $00000100;

{Conversational Task}
  MQCCT_YES                      = $00000001;
  MQCCT_NO                       = $00000000;

{Task End Status}
  MQCTES_NOSYNC                  = $00000000;
  MQCTES_COMMIT                  = $00000100;
  MQCTES_BACKOUT                 = $00001100;
  MQCTES_ENDTASK                 = $00010000;

{MQRH}
  MQRFH_STRUC_LENGTH_FIXED       = 32;
  MQRFH_STRUC_LENGTH_FIXED_2     = 36;
  MQRFH_NONE                     = $00000000;

{Names for Name/Value String}
  MQNVS_APPL_TYPE                = 'OPT_APP_GRP ';
  MQNVS_MSG_TYPE                 = 'OPT_MSG_TYPE ';

{General Flags}
  MQDHF_NEW_MSG_IDS              = $00000001;
  MQDHF_NONE                     = $00000000;

{Function}
  MQCFUNC_MQCONN                 = 'CONN';
  MQCFUNC_MQGET                  = 'GET ';
  MQCFUNC_MQINQ                  = 'INQ ';
  MQCFUNC_MQOPEN                 = 'OPEN';
  MQCFUNC_MQPUT                  = 'PUT ';
  MQCFUNC_MQPUT1                 = 'PUT1';
  MQCFUNC_NONE                   = '    ';

{Start Code}
  MQCSC_START                    = 'S   ';
  MQCSC_STARTDATA                = 'SD  ';
  MQCSC_TERMINPUT                = 'TD  ';
  MQCSC_NONE                     = '    ';

{CIH}
  MQCIH_LENGTH_1                 = 164;
  MQCIH_LENGTH_2                 = 180;
  MQCIH_CURRENT_LENGTH           = 180;
  MQCIH_NONE                     = $00000000;

{IIH}
  MQIIH_LENGTH_1                  = 84;
  MQIIH_NONE                      = $00000000;

{WIH}
  MQWIH_LENGTH_1                  = 120;
  MQWIH_CURRENT_LENGTH            = 120;
  MQWIH_NONE                      = $00000000;

{MQRMH Flags}
  MQRMHF_LAST                     = $00000001;
  MQRMHF_NOT_LAST                 = $00000000;

{MQMDE}
  MQMDE_LENGTH_2                  = 72;
  MQMDEF_NONE                     = $00000000;

{Transaction State}
  MQITS_IN_CONVERSATION           = 'C';
  MQITS_NOT_IN_CONVERSATION       = ' ';
  MQITS_ARCHITECTED               = 'A';

{Commit Mode}
  MQICM_COMMIT_THEN_SEND          = '0';
  MQICM_SEND_THEN_COMMIT          = '1';

{Security Scope}
  MQISS_CHECK                     = 'C';
  MQISS_FULL                      = 'F';

{ +++ SAG, Oct-2006 }
{ ++ CMQBC.H : }

{ Create-Bag Options for mqCreateBag }

  MQCBO_NONE                      = $00000000 ;
  MQCBO_USER_BAG                  = $00000000 ;
  MQCBO_ADMIN_BAG                 = $00000001 ;
  MQCBO_COMMAND_BAG               = $00000010 ;
  MQCBO_SYSTEM_BAG                = $00000020 ;
  MQCBO_GROUP_BAG                 = $00000040 ;
  MQCBO_LIST_FORM_ALLOWED         = $00000002 ;
  MQCBO_LIST_FORM_INHIBITED       = $00000000 ;
  MQCBO_REORDER_AS_REQUIRED       = $00000004 ;
  MQCBO_DO_NOT_REORDER            = $00000000 ;
  MQCBO_CHECK_SELECTORS           = $00000008 ;
  MQCBO_DO_NOT_CHECK_SELECTORS    = $00000000 ;

{ Buffer Length for mqAddString and mqSetString }

  MQBL_NULL_TERMINATED            = -1 ;

{ Item Type for mqInquireItemInfo }

  MQITEM_INTEGER                  = 1 ;
  MQITEM_STRING                   = 2 ;
  MQITEM_BAG                      = 3 ;
  MQITEM_BYTE_STRING              = 4 ;
  MQITEM_INTEGER_FILTER           = 5 ;
  MQITEM_STRING_FILTER            = 6 ;
  MQITEM_INTEGER64                = 7 ;
  MQITEM_BYTE_STRING_FILTER       = 8 ;

  MQIT_INTEGER                    = 1 ;
  MQIT_STRING                     = 2 ;
  MQIT_BAG                        = 3 ;

{ Handle Selectors }

  MQHA_FIRST                      = 4001 ;
  MQHA_BAG_HANDLE                 = 4001 ;
  MQHA_LAST_USED                  = 4001 ;
  MQHA_LAST                       = 6000 ;

{ Limits for Selectors for Object Attributes }

  MQOA_FIRST                      = 1 ;
  MQOA_LAST                       = 9000 ;

{ Integer System Selectors }

  MQIASY_FIRST                    = -1 ;
  MQIASY_CODED_CHAR_SET_ID        = -1 ;
  MQIASY_TYPE                     = -2 ;
  MQIASY_COMMAND                  = -3 ;
  MQIASY_MSG_SEQ_NUMBER           = -4 ;
  MQIASY_CONTROL                  = -5 ;
  MQIASY_COMP_CODE                = -6 ;
  MQIASY_REASON                   = -7 ;
  MQIASY_BAG_OPTIONS              = -8 ;
  MQIASY_VERSION                  = -9 ;
  MQIASY_LAST_USED                = -9 ;
  MQIASY_LAST                     = -2000 ;

{ Special Selector Values }

  MQSEL_ANY_SELECTOR              = -30001 ;
  MQSEL_ANY_USER_SELECTOR         = -30002 ;
  MQSEL_ANY_SYSTEM_SELECTOR       = -30003 ;
  MQSEL_ALL_SELECTORS             = -30001 ;
  MQSEL_ALL_USER_SELECTORS        = -30002 ;
  MQSEL_ALL_SYSTEM_SELECTORS      = -30003 ;

{ Special Index Values }

  MQIND_NONE                      = -1 ;
  MQIND_ALL                       = -2 ;

{ Bag Handles }

  MQHB_UNUSABLE_HBAG              = -1 ;
  MQHB_NONE                       = -2 ;

{ ++ CMQCFC.H : }

{ Command Codes }

 MQCMD_CHANGE_Q_MGR             =   1 ;
 MQCMD_INQUIRE_Q_MGR            =   2 ;
 MQCMD_CHANGE_PROCESS           =   3 ;
 MQCMD_COPY_PROCESS             =   4 ;
 MQCMD_CREATE_PROCESS           =   5 ;
 MQCMD_DELETE_PROCESS           =   6 ;
 MQCMD_INQUIRE_PROCESS          =   7 ;
 MQCMD_CHANGE_Q                 =   8 ;
 MQCMD_CLEAR_Q                  =   9 ;
 MQCMD_COPY_Q                   =  10 ;
 MQCMD_CREATE_Q                 =  11 ;
 MQCMD_DELETE_Q                 =  12 ;
 MQCMD_INQUIRE_Q                =  13 ;
 MQCMD_REFRESH_Q_MGR            =  16 ;
 MQCMD_RESET_Q_STATS            =  17 ;
 MQCMD_INQUIRE_Q_NAMES          =  18 ;
 MQCMD_INQUIRE_PROCESS_NAMES    =  19 ;
 MQCMD_INQUIRE_CHANNEL_NAMES    =  20 ;
 MQCMD_CHANGE_CHANNEL           =  21 ;
 MQCMD_COPY_CHANNEL             =  22 ;
 MQCMD_CREATE_CHANNEL           =  23 ;
 MQCMD_DELETE_CHANNEL           =  24 ;
 MQCMD_INQUIRE_CHANNEL          =  25 ;
 MQCMD_PING_CHANNEL             =  26 ;
 MQCMD_RESET_CHANNEL            =  27 ;
 MQCMD_START_CHANNEL            =  28 ;
 MQCMD_STOP_CHANNEL             =  29 ;
 MQCMD_START_CHANNEL_INIT       =  30 ;
 MQCMD_START_CHANNEL_LISTENER   =  31 ;
 MQCMD_CHANGE_NAMELIST          =  32 ;
 MQCMD_COPY_NAMELIST            =  33 ;
 MQCMD_CREATE_NAMELIST          =  34 ;
 MQCMD_DELETE_NAMELIST          =  35 ;
 MQCMD_INQUIRE_NAMELIST         =  36 ;
 MQCMD_INQUIRE_NAMELIST_NAMES   =  37 ;
 MQCMD_ESCAPE                   =  38 ;
 MQCMD_RESOLVE_CHANNEL          =  39 ;
 MQCMD_PING_Q_MGR               =  40 ;
 MQCMD_INQUIRE_Q_STATUS         =  41 ;
 MQCMD_INQUIRE_CHANNEL_STATUS   =  42 ;
 MQCMD_CONFIG_EVENT             =  43 ;
 MQCMD_Q_MGR_EVENT              =  44 ;
 MQCMD_PERFM_EVENT              =  45 ;
 MQCMD_CHANNEL_EVENT            =  46 ;
 MQCMD_DELETE_PUBLICATION       =  60 ;
 MQCMD_DEREGISTER_PUBLISHER     =  61 ;
 MQCMD_DEREGISTER_SUBSCRIBER    =  62 ;
 MQCMD_PUBLISH                  =  63 ;
 MQCMD_REGISTER_PUBLISHER       =  64 ;
 MQCMD_REGISTER_SUBSCRIBER      =  65 ;
 MQCMD_REQUEST_UPDATE           =  66 ;
 MQCMD_BROKER_INTERNAL          =  67 ;
 MQCMD_ACTIVITY_MSG             =  69 ;
 MQCMD_INQUIRE_CLUSTER_Q_MGR    =  70 ;
 MQCMD_RESUME_Q_MGR_CLUSTER     =  71 ;
 MQCMD_SUSPEND_Q_MGR_CLUSTER    =  72 ;
 MQCMD_REFRESH_CLUSTER          =  73 ;
 MQCMD_RESET_CLUSTER            =  74 ;
 MQCMD_TRACE_ROUTE              =  75 ;
 MQCMD_REFRESH_SECURITY         =  78 ;
 MQCMD_CHANGE_AUTH_INFO         =  79 ;
 MQCMD_COPY_AUTH_INFO           =  80 ;
 MQCMD_CREATE_AUTH_INFO         =  81 ;
 MQCMD_DELETE_AUTH_INFO         =  82 ;
 MQCMD_INQUIRE_AUTH_INFO        =  83 ;
 MQCMD_INQUIRE_AUTH_INFO_NAMES  =  84 ;
 MQCMD_INQUIRE_CONNECTION       =  85 ;
 MQCMD_STOP_CONNECTION          =  86 ;
 MQCMD_INQUIRE_AUTH_RECS        =  87 ;
 MQCMD_INQUIRE_ENTITY_AUTH      =  88 ;
 MQCMD_DELETE_AUTH_REC          =  89 ;
 MQCMD_SET_AUTH_REC             =  90 ;
 MQCMD_LOGGER_EVENT             =  91 ;
 MQCMD_RESET_Q_MGR              =  92 ;
 MQCMD_CHANGE_LISTENER          =  93 ;
 MQCMD_COPY_LISTENER            =  94 ;
 MQCMD_CREATE_LISTENER          =  95 ;
 MQCMD_DELETE_LISTENER          =  96 ;
 MQCMD_INQUIRE_LISTENER         =  97 ;
 MQCMD_INQUIRE_LISTENER_STATUS  =  98 ;
 MQCMD_COMMAND_EVENT            =  99 ;
 MQCMD_CHANGE_SECURITY          = 100 ;
 MQCMD_CHANGE_CF_STRUC          = 101 ;
 MQCMD_CHANGE_STG_CLASS         = 102 ;
 MQCMD_CHANGE_TRACE             = 103 ;
 MQCMD_ARCHIVE_LOG              = 104 ;
 MQCMD_BACKUP_CF_STRUC          = 105 ;
 MQCMD_CREATE_BUFFER_POOL       = 106 ;
 MQCMD_CREATE_PAGE_SET          = 107 ;
 MQCMD_CREATE_CF_STRUC          = 108 ;
 MQCMD_CREATE_STG_CLASS         = 109 ;
 MQCMD_COPY_CF_STRUC            = 110 ;
 MQCMD_COPY_STG_CLASS           = 111 ;
 MQCMD_DELETE_CF_STRUC          = 112 ;
 MQCMD_DELETE_STG_CLASS         = 113 ;
 MQCMD_INQUIRE_ARCHIVE          = 114 ;
 MQCMD_INQUIRE_CF_STRUC         = 115 ;
 MQCMD_INQUIRE_CF_STRUC_STATUS  = 116 ;
 MQCMD_INQUIRE_CMD_SERVER       = 117 ;
 MQCMD_INQUIRE_CHANNEL_INIT     = 118 ;
 MQCMD_INQUIRE_QSG              = 119 ;
 MQCMD_INQUIRE_LOG              = 120 ;
 MQCMD_INQUIRE_SECURITY         = 121 ;
 MQCMD_INQUIRE_STG_CLASS        = 122 ;
 MQCMD_INQUIRE_SYSTEM           = 123 ;
 MQCMD_INQUIRE_THREAD           = 124 ;
 MQCMD_INQUIRE_TRACE            = 125 ;
 MQCMD_INQUIRE_USAGE            = 126 ;
 MQCMD_MOVE_Q                   = 127 ;
 MQCMD_RECOVER_BSDS             = 128 ;
 MQCMD_RECOVER_CF_STRUC         = 129 ;
 MQCMD_RESET_TPIPE              = 130 ;
 MQCMD_RESOLVE_INDOUBT          = 131 ;
 MQCMD_RESUME_Q_MGR             = 132 ;
 MQCMD_REVERIFY_SECURITY        = 133 ;
 MQCMD_SET_ARCHIVE              = 134 ;
 MQCMD_SET_LOG                  = 136 ;
 MQCMD_SET_SYSTEM               = 137 ;
 MQCMD_START_CMD_SERVER         = 138 ;
 MQCMD_START_Q_MGR              = 139 ;
 MQCMD_START_TRACE              = 140 ;
 MQCMD_STOP_CHANNEL_INIT        = 141 ;
 MQCMD_STOP_CHANNEL_LISTENER    = 142 ;
 MQCMD_STOP_CMD_SERVER          = 143 ;
 MQCMD_STOP_Q_MGR               = 144 ;
 MQCMD_STOP_TRACE               = 145 ;
 MQCMD_SUSPEND_Q_MGR            = 146 ;
 MQCMD_INQUIRE_CF_STRUC_NAMES   = 147 ;
 MQCMD_INQUIRE_STG_CLASS_NAMES  = 148 ;
 MQCMD_CHANGE_SERVICE           = 149 ;
 MQCMD_COPY_SERVICE             = 150 ;
 MQCMD_CREATE_SERVICE           = 151 ;
 MQCMD_DELETE_SERVICE           = 152 ;
 MQCMD_INQUIRE_SERVICE          = 153 ;
 MQCMD_INQUIRE_SERVICE_STATUS   = 154 ;
 MQCMD_START_SERVICE            = 155 ;
 MQCMD_STOP_SERVICE             = 156 ;
 MQCMD_DELETE_BUFFER_POOL       = 157 ;
 MQCMD_DELETE_PAGE_SET          = 158 ;
 MQCMD_CHANGE_BUFFER_POOL       = 159 ;
 MQCMD_CHANGE_PAGE_SET          = 160 ;
 MQCMD_INQUIRE_Q_MGR_STATUS     = 161 ;
 MQCMD_CREATE_LOG               = 162 ;
 MQCMD_STATISTICS_MQI           = 164 ;
 MQCMD_STATISTICS_Q             = 165 ;
 MQCMD_STATISTICS_CHANNEL       = 166 ;
 MQCMD_ACCOUNTING_MQI           = 167 ;
 MQCMD_ACCOUNTING_Q             = 168 ;
 MQCMD_INQUIRE_AUTH_SERVICE     = 169 ;
 MQCMD_NONE                     =   0 ;

{ Control Options }
 MQCFC_LAST         = 1 ;
 MQCFC_NOT_LAST     = 0 ;

{ Reason Codes }

  MQRCCF_CFH_TYPE_ERROR             = 3001 ;
  MQRCCF_CFH_LENGTH_ERROR           = 3002 ;
  MQRCCF_CFH_VERSION_ERROR          = 3003 ;
  MQRCCF_CFH_MSG_SEQ_NUMBER_ERR     = 3004 ;
  MQRCCF_CFH_CONTROL_ERROR          = 3005 ;
  MQRCCF_CFH_PARM_COUNT_ERROR       = 3006 ;
  MQRCCF_CFH_COMMAND_ERROR          = 3007 ;
  MQRCCF_COMMAND_FAILED             = 3008 ;
  MQRCCF_CFIN_LENGTH_ERROR          = 3009 ;
  MQRCCF_CFST_LENGTH_ERROR          = 3010 ;
  MQRCCF_CFST_STRING_LENGTH_ERR     = 3011 ;
  MQRCCF_FORCE_VALUE_ERROR          = 3012 ;
  MQRCCF_STRUCTURE_TYPE_ERROR       = 3013 ;
  MQRCCF_CFIN_PARM_ID_ERROR         = 3014 ;
  MQRCCF_CFST_PARM_ID_ERROR         = 3015 ;
  MQRCCF_MSG_LENGTH_ERROR           = 3016 ;
  MQRCCF_CFIN_DUPLICATE_PARM        = 3017 ;
  MQRCCF_CFST_DUPLICATE_PARM        = 3018 ;
  MQRCCF_PARM_COUNT_TOO_SMALL       = 3019 ;
  MQRCCF_PARM_COUNT_TOO_BIG         = 3020 ;
  MQRCCF_Q_ALREADY_IN_CELL          = 3021 ;
  MQRCCF_Q_TYPE_ERROR               = 3022 ;
  MQRCCF_MD_FORMAT_ERROR            = 3023 ;
  MQRCCF_CFSL_LENGTH_ERROR          = 3024 ;
  MQRCCF_REPLACE_VALUE_ERROR        = 3025 ;
  MQRCCF_CFIL_DUPLICATE_VALUE       = 3026 ;
  MQRCCF_CFIL_COUNT_ERROR           = 3027 ;
  MQRCCF_CFIL_LENGTH_ERROR          = 3028 ;
  MQRCCF_QUIESCE_VALUE_ERROR        = 3029 ;
  MQRCCF_MODE_VALUE_ERROR           = 3029 ;
  MQRCCF_MSG_SEQ_NUMBER_ERROR       = 3030 ;
  MQRCCF_PING_DATA_COUNT_ERROR      = 3031 ;
  MQRCCF_PING_DATA_COMPARE_ERROR    = 3032 ;
  MQRCCF_CFSL_PARM_ID_ERROR         = 3033 ;
  MQRCCF_CHANNEL_TYPE_ERROR         = 3034 ;
  MQRCCF_PARM_SEQUENCE_ERROR        = 3035 ;
  MQRCCF_XMIT_PROTOCOL_TYPE_ERR     = 3036 ;
  MQRCCF_BATCH_SIZE_ERROR           = 3037 ;
  MQRCCF_DISC_INT_ERROR             = 3038 ;
  MQRCCF_SHORT_RETRY_ERROR          = 3039 ;
  MQRCCF_SHORT_TIMER_ERROR          = 3040 ;
  MQRCCF_LONG_RETRY_ERROR           = 3041 ;
  MQRCCF_LONG_TIMER_ERROR           = 3042 ;
  MQRCCF_SEQ_NUMBER_WRAP_ERROR      = 3043 ;
  MQRCCF_MAX_MSG_LENGTH_ERROR       = 3044 ;
  MQRCCF_PUT_AUTH_ERROR             = 3045 ;
  MQRCCF_PURGE_VALUE_ERROR          = 3046 ;
  MQRCCF_CFIL_PARM_ID_ERROR         = 3047 ;
  MQRCCF_MSG_TRUNCATED              = 3048 ;
  MQRCCF_CCSID_ERROR                = 3049 ;
  MQRCCF_ENCODING_ERROR             = 3050 ;
  MQRCCF_QUEUES_VALUE_ERROR         = 3051 ;
  MQRCCF_DATA_CONV_VALUE_ERROR      = 3052 ;
  MQRCCF_INDOUBT_VALUE_ERROR        = 3053 ;
  MQRCCF_ESCAPE_TYPE_ERROR          = 3054 ;
  MQRCCF_REPOS_VALUE_ERROR          = 3055 ;
  MQRCCF_CHANNEL_TABLE_ERROR        = 3062 ;
  MQRCCF_MCA_TYPE_ERROR             = 3063 ;
  MQRCCF_CHL_INST_TYPE_ERROR        = 3064 ;
  MQRCCF_CHL_STATUS_NOT_FOUND       = 3065 ;
  MQRCCF_CFSL_DUPLICATE_PARM        = 3066 ;
  MQRCCF_CFSL_TOTAL_LENGTH_ERROR    = 3067 ;
  MQRCCF_CFSL_COUNT_ERROR           = 3068 ;
  MQRCCF_CFSL_STRING_LENGTH_ERR     = 3069 ;
  MQRCCF_BROKER_DELETED             = 3070 ;
  MQRCCF_STREAM_ERROR               = 3071 ;
  MQRCCF_TOPIC_ERROR                = 3072 ;
  MQRCCF_NOT_REGISTERED             = 3073 ;
  MQRCCF_Q_MGR_NAME_ERROR           = 3074 ;
  MQRCCF_INCORRECT_STREAM           = 3075 ;
  MQRCCF_Q_NAME_ERROR               = 3076 ;
  MQRCCF_NO_RETAINED_MSG            = 3077 ;
  MQRCCF_DUPLICATE_IDENTITY         = 3078 ;
  MQRCCF_INCORRECT_Q                = 3079 ;
  MQRCCF_CORREL_ID_ERROR            = 3080 ;
  MQRCCF_NOT_AUTHORIZED             = 3081 ;
  MQRCCF_UNKNOWN_STREAM             = 3082 ;
  MQRCCF_REG_OPTIONS_ERROR          = 3083 ;
  MQRCCF_PUB_OPTIONS_ERROR          = 3084 ;
  MQRCCF_UNKNOWN_BROKER             = 3085 ;
  MQRCCF_Q_MGR_CCSID_ERROR          = 3086 ;
  MQRCCF_DEL_OPTIONS_ERROR          = 3087 ;
  MQRCCF_CLUSTER_NAME_CONFLICT      = 3088 ;
  MQRCCF_REPOS_NAME_CONFLICT        = 3089 ;
  MQRCCF_CLUSTER_Q_USAGE_ERROR      = 3090 ;
  MQRCCF_ACTION_VALUE_ERROR         = 3091 ;
  MQRCCF_COMMS_LIBRARY_ERROR        = 3092 ;
  MQRCCF_NETBIOS_NAME_ERROR         = 3093 ;
  MQRCCF_BROKER_COMMAND_FAILED      = 3094 ;
  MQRCCF_CFST_CONFLICTING_PARM      = 3095 ;
  MQRCCF_PATH_NOT_VALID             = 3096 ;
  MQRCCF_PARM_SYNTAX_ERROR          = 3097 ;
  MQRCCF_PWD_LENGTH_ERROR           = 3098 ;
  MQRCCF_FILTER_ERROR               = 3150 ;
  MQRCCF_WRONG_USER                 = 3151 ;
  MQRCCF_DUPLICATE_SUBSCRIPTION     = 3152 ;
  MQRCCF_SUB_NAME_ERROR             = 3153 ;
  MQRCCF_SUB_IDENTITY_ERROR         = 3154 ;
  MQRCCF_SUBSCRIPTION_IN_USE        = 3155 ;
  MQRCCF_SUBSCRIPTION_LOCKED        = 3156 ;
  MQRCCF_ALREADY_JOINED             = 3157 ;
  MQRCCF_OBJECT_IN_USE              = 3160 ;
  MQRCCF_UNKNOWN_FILE_NAME          = 3161 ;
  MQRCCF_FILE_NOT_AVAILABLE         = 3162 ;
  MQRCCF_DISC_RETRY_ERROR           = 3163 ;
  MQRCCF_ALLOC_RETRY_ERROR          = 3164 ;
  MQRCCF_ALLOC_SLOW_TIMER_ERROR     = 3165 ;
  MQRCCF_ALLOC_FAST_TIMER_ERROR     = 3166 ;
  MQRCCF_PORT_NUMBER_ERROR          = 3167 ;
  MQRCCF_CHL_SYSTEM_NOT_ACTIVE      = 3168 ;
  MQRCCF_ENTITY_NAME_MISSING        = 3169 ;
  MQRCCF_PROFILE_NAME_ERROR         = 3170 ;
  MQRCCF_AUTH_VALUE_ERROR           = 3171 ;
  MQRCCF_AUTH_VALUE_MISSING         = 3172 ;
  MQRCCF_OBJECT_TYPE_MISSING        = 3173 ;
  MQRCCF_CONNECTION_ID_ERROR        = 3174 ;
  MQRCCF_LOG_TYPE_ERROR             = 3175 ;
  MQRCCF_PROGRAM_NOT_AVAILABLE      = 3176 ;
  MQRCCF_PROGRAM_AUTH_FAILED        = 3177 ;
  MQRCCF_NONE_FOUND                 = 3200 ;
  MQRCCF_SECURITY_SWITCH_OFF        = 3201 ;
  MQRCCF_SECURITY_REFRESH_FAILED    = 3202 ;
  MQRCCF_PARM_CONFLICT              = 3203 ;
  MQRCCF_COMMAND_INHIBITED          = 3204 ;
  MQRCCF_OBJECT_BEING_DELETED       = 3205 ;
  MQRCCF_STORAGE_CLASS_IN_USE       = 3207 ;
  MQRCCF_OBJECT_NAME_RESTRICTED     = 3208 ;
  MQRCCF_OBJECT_LIMIT_EXCEEDED      = 3209 ;
  MQRCCF_OBJECT_OPEN_FORCE          = 3210 ;
  MQRCCF_DISPOSITION_CONFLICT       = 3211 ;
  MQRCCF_Q_MGR_NOT_IN_QSG           = 3212 ;
  MQRCCF_ATTR_VALUE_FIXED           = 3213 ;
  MQRCCF_NAMELIST_ERROR             = 3215 ;
  MQRCCF_NO_CHANNEL_INITIATOR       = 3217 ;
  MQRCCF_CHANNEL_INITIATOR_ERROR    = 3218 ;
  MQRCCF_COMMAND_LEVEL_CONFLICT     = 3222 ;
  MQRCCF_Q_ATTR_CONFLICT            = 3223 ;
  MQRCCF_EVENTS_DISABLED            = 3224 ;
  MQRCCF_COMMAND_SCOPE_ERROR        = 3225 ;
  MQRCCF_COMMAND_REPLY_ERROR        = 3226 ;
  MQRCCF_FUNCTION_RESTRICTED        = 3227 ;
  MQRCCF_PARM_MISSING               = 3228 ;
  MQRCCF_PARM_VALUE_ERROR           = 3229 ;
  MQRCCF_COMMAND_LENGTH_ERROR       = 3230 ;
  MQRCCF_COMMAND_ORIGIN_ERROR       = 3231 ;
  MQRCCF_LISTENER_CONFLICT          = 3232 ;
  MQRCCF_LISTENER_STARTED           = 3233 ;
  MQRCCF_LISTENER_STOPPED           = 3234 ;
  MQRCCF_CHANNEL_ERROR              = 3235 ;
  MQRCCF_CF_STRUC_ERROR             = 3236 ;
  MQRCCF_UNKNOWN_USER_ID            = 3237 ;
  MQRCCF_UNEXPECTED_ERROR           = 3238 ;
  MQRCCF_NO_XCF_PARTNER             = 3239 ;
  MQRCCF_CFGR_PARM_ID_ERROR         = 3240 ;
  MQRCCF_CFIF_LENGTH_ERROR          = 3241 ;
  MQRCCF_CFIF_OPERATOR_ERROR        = 3242 ;
  MQRCCF_CFIF_PARM_ID_ERROR         = 3243 ;
  MQRCCF_CFSF_FILTER_VAL_LEN_ERR    = 3244 ;
  MQRCCF_CFSF_LENGTH_ERROR          = 3245 ;
  MQRCCF_CFSF_OPERATOR_ERROR        = 3246 ;
  MQRCCF_CFSF_PARM_ID_ERROR         = 3247 ;
  MQRCCF_TOO_MANY_FILTERS           = 3248 ;
  MQRCCF_LISTENER_RUNNING           = 3249 ;
  MQRCCF_LSTR_STATUS_NOT_FOUND      = 3250 ;
  MQRCCF_SERVICE_RUNNING            = 3251 ;
  MQRCCF_SERV_STATUS_NOT_FOUND      = 3252 ;
  MQRCCF_SERVICE_STOPPED            = 3253 ;
  MQRCCF_CFBS_DUPLICATE_PARM        = 3254 ;
  MQRCCF_CFBS_LENGTH_ERROR          = 3255 ;
  MQRCCF_CFBS_PARM_ID_ERROR         = 3256 ;
  MQRCCF_CFBS_STRING_LENGTH_ERR     = 3257 ;
  MQRCCF_CFGR_LENGTH_ERROR          = 3258 ;
  MQRCCF_CFGR_PARM_COUNT_ERROR      = 3259 ;
  MQRCCF_CONN_NOT_STOPPED           = 3260 ;
  MQRCCF_SERVICE_REQUEST_PENDING    = 3261 ;
  MQRCCF_NO_START_CMD               = 3262 ;
  MQRCCF_NO_STOP_CMD                = 3263 ;
  MQRCCF_CFBF_LENGTH_ERROR          = 3264 ;
  MQRCCF_CFBF_PARM_ID_ERROR         = 3265 ;
  MQRCCF_CFBF_OPERATOR_ERROR        = 3266 ;
  MQRCCF_CFBF_FILTER_VAL_LEN_ERR    = 3267 ;
  MQRCCF_LISTENER_STILL_ACTIVE      = 3268 ;
  MQRCCF_OBJECT_ALREADY_EXISTS      = 4001 ;
  MQRCCF_OBJECT_WRONG_TYPE          = 4002 ;
  MQRCCF_LIKE_OBJECT_WRONG_TYPE     = 4003 ;
  MQRCCF_OBJECT_OPEN                = 4004 ;
  MQRCCF_ATTR_VALUE_ERROR           = 4005 ;
  MQRCCF_UNKNOWN_Q_MGR              = 4006 ;
  MQRCCF_Q_WRONG_TYPE               = 4007 ;
  MQRCCF_OBJECT_NAME_ERROR          = 4008 ;
  MQRCCF_ALLOCATE_FAILED            = 4009 ;
  MQRCCF_HOST_NOT_AVAILABLE         = 4010 ;
  MQRCCF_CONFIGURATION_ERROR        = 4011 ;
  MQRCCF_CONNECTION_REFUSED         = 4012 ;
  MQRCCF_ENTRY_ERROR                = 4013 ;
  MQRCCF_SEND_FAILED                = 4014 ;
  MQRCCF_RECEIVED_DATA_ERROR        = 4015 ;
  MQRCCF_RECEIVE_FAILED             = 4016 ;
  MQRCCF_CONNECTION_CLOSED          = 4017 ;
  MQRCCF_NO_STORAGE                 = 4018 ;
  MQRCCF_NO_COMMS_MANAGER           = 4019 ;
  MQRCCF_LISTENER_NOT_STARTED       = 4020 ;
  MQRCCF_BIND_FAILED                = 4024 ;
  MQRCCF_CHANNEL_INDOUBT            = 4025 ;
  MQRCCF_MQCONN_FAILED              = 4026 ;
  MQRCCF_MQOPEN_FAILED              = 4027 ;
  MQRCCF_MQGET_FAILED               = 4028 ;
  MQRCCF_MQPUT_FAILED               = 4029 ;
  MQRCCF_PING_ERROR                 = 4030 ;
  MQRCCF_CHANNEL_IN_USE             = 4031 ;
  MQRCCF_CHANNEL_NOT_FOUND          = 4032 ;
  MQRCCF_UNKNOWN_REMOTE_CHANNEL     = 4033 ;
  MQRCCF_REMOTE_QM_UNAVAILABLE      = 4034 ;
  MQRCCF_REMOTE_QM_TERMINATING      = 4035 ;
  MQRCCF_MQINQ_FAILED               = 4036 ;
  MQRCCF_NOT_XMIT_Q                 = 4037 ;
  MQRCCF_CHANNEL_DISABLED           = 4038 ;
  MQRCCF_USER_EXIT_NOT_AVAILABLE    = 4039 ;
  MQRCCF_COMMIT_FAILED              = 4040 ;
  MQRCCF_WRONG_CHANNEL_TYPE         = 4041 ;
  MQRCCF_CHANNEL_ALREADY_EXISTS     = 4042 ;
  MQRCCF_DATA_TOO_LARGE             = 4043 ;
  MQRCCF_CHANNEL_NAME_ERROR         = 4044 ;
  MQRCCF_XMIT_Q_NAME_ERROR          = 4045 ;
  MQRCCF_MCA_NAME_ERROR             = 4047 ;
  MQRCCF_SEND_EXIT_NAME_ERROR       = 4048 ;
  MQRCCF_SEC_EXIT_NAME_ERROR        = 4049 ;
  MQRCCF_MSG_EXIT_NAME_ERROR        = 4050 ;
  MQRCCF_RCV_EXIT_NAME_ERROR        = 4051 ;
  MQRCCF_XMIT_Q_NAME_WRONG_TYPE     = 4052 ;
  MQRCCF_MCA_NAME_WRONG_TYPE        = 4053 ;
  MQRCCF_DISC_INT_WRONG_TYPE        = 4054 ;
  MQRCCF_SHORT_RETRY_WRONG_TYPE     = 4055 ;
  MQRCCF_SHORT_TIMER_WRONG_TYPE     = 4056 ;
  MQRCCF_LONG_RETRY_WRONG_TYPE      = 4057 ;
  MQRCCF_LONG_TIMER_WRONG_TYPE      = 4058 ;
  MQRCCF_PUT_AUTH_WRONG_TYPE        = 4059 ;
  MQRCCF_KEEP_ALIVE_INT_ERROR       = 4060 ;
  MQRCCF_MISSING_CONN_NAME          = 4061 ;
  MQRCCF_CONN_NAME_ERROR            = 4062 ;
  MQRCCF_MQSET_FAILED               = 4063 ;
  MQRCCF_CHANNEL_NOT_ACTIVE         = 4064 ;
  MQRCCF_TERMINATED_BY_SEC_EXIT     = 4065 ;
  MQRCCF_DYNAMIC_Q_SCOPE_ERROR      = 4067 ;
  MQRCCF_CELL_DIR_NOT_AVAILABLE     = 4068 ;
  MQRCCF_MR_COUNT_ERROR             = 4069 ;
  MQRCCF_MR_COUNT_WRONG_TYPE        = 4070 ;
  MQRCCF_MR_EXIT_NAME_ERROR         = 4071 ;
  MQRCCF_MR_EXIT_NAME_WRONG_TYPE    = 4072 ;
  MQRCCF_MR_INTERVAL_ERROR          = 4073 ;
  MQRCCF_MR_INTERVAL_WRONG_TYPE     = 4074 ;
  MQRCCF_NPM_SPEED_ERROR            = 4075 ;
  MQRCCF_NPM_SPEED_WRONG_TYPE       = 4076 ;
  MQRCCF_HB_INTERVAL_ERROR          = 4077 ;
  MQRCCF_HB_INTERVAL_WRONG_TYPE     = 4078 ;
  MQRCCF_CHAD_ERROR                 = 4079 ;
  MQRCCF_CHAD_WRONG_TYPE            = 4080 ;
  MQRCCF_CHAD_EVENT_ERROR           = 4081 ;
  MQRCCF_CHAD_EVENT_WRONG_TYPE      = 4082 ;
  MQRCCF_CHAD_EXIT_ERROR            = 4083 ;
  MQRCCF_CHAD_EXIT_WRONG_TYPE       = 4084 ;
  MQRCCF_SUPPRESSED_BY_EXIT         = 4085 ;
  MQRCCF_BATCH_INT_ERROR            = 4086 ;
  MQRCCF_BATCH_INT_WRONG_TYPE       = 4087 ;
  MQRCCF_NET_PRIORITY_ERROR         = 4088 ;
  MQRCCF_NET_PRIORITY_WRONG_TYPE    = 4089 ;
  MQRCCF_CHANNEL_CLOSED             = 4090 ;
  MQRCCF_Q_STATUS_NOT_FOUND         = 4091 ;
  MQRCCF_SSL_CIPHER_SPEC_ERROR      = 4092 ;
  MQRCCF_SSL_PEER_NAME_ERROR        = 4093 ;
  MQRCCF_SSL_CLIENT_AUTH_ERROR      = 4094 ;
  MQRCCF_RETAINED_NOT_SUPPORTED     = 4095 ;

{ Integer Parameter Types }
  MQIACF_FIRST                    = 1001 ;
  MQIACF_Q_MGR_ATTRS              = 1001 ;
  MQIACF_Q_ATTRS                  = 1002 ;
  MQIACF_PROCESS_ATTRS            = 1003 ;
  MQIACF_NAMELIST_ATTRS           = 1004 ;
  MQIACF_FORCE                    = 1005 ;
  MQIACF_REPLACE                  = 1006 ;
  MQIACF_PURGE                    = 1007 ;
  MQIACF_QUIESCE                  = 1008 ;
  MQIACF_MODE                     = 1008 ;
  MQIACF_ALL                      = 1009 ;
  MQIACF_EVENT_APPL_TYPE          = 1010 ;
  MQIACF_EVENT_ORIGIN             = 1011 ;
  MQIACF_PARAMETER_ID             = 1012 ;
  MQIACF_ERROR_ID                 = 1013 ;
  MQIACF_ERROR_IDENTIFIER         = 1013 ;
  MQIACF_SELECTOR                 = 1014 ;
  MQIACF_CHANNEL_ATTRS            = 1015 ;
  MQIACF_OBJECT_TYPE              = 1016 ;
  MQIACF_ESCAPE_TYPE              = 1017 ;
  MQIACF_ERROR_OFFSET             = 1018 ;
  MQIACF_AUTH_INFO_ATTRS          = 1019 ;
  MQIACF_REASON_QUALIFIER         = 1020 ;
  MQIACF_COMMAND                  = 1021 ;
  MQIACF_OPEN_OPTIONS             = 1022 ;
  MQIACF_OPEN_TYPE                = 1023 ;
  MQIACF_PROCESS_ID               = 1024 ;
  MQIACF_THREAD_ID                = 1025 ;
  MQIACF_Q_STATUS_ATTRS           = 1026 ;
  MQIACF_UNCOMMITTED_MSGS         = 1027 ;
  MQIACF_HANDLE_STATE             = 1028 ;
  MQIACF_AUX_ERROR_DATA_INT_1     = 1070 ;
  MQIACF_AUX_ERROR_DATA_INT_2     = 1071 ;
  MQIACF_CONV_REASON_CODE         = 1072 ;
  MQIACF_BRIDGE_TYPE              = 1073 ;
  MQIACF_INQUIRY                  = 1074 ;
  MQIACF_WAIT_INTERVAL            = 1075 ;
  MQIACF_OPTIONS                  = 1076 ;
  MQIACF_BROKER_OPTIONS           = 1077 ;
  MQIACF_REFRESH_TYPE             = 1078 ;
  MQIACF_SEQUENCE_NUMBER          = 1079 ;
  MQIACF_INTEGER_DATA             = 1080 ;
  MQIACF_REGISTRATION_OPTIONS     = 1081 ;
  MQIACF_PUBLICATION_OPTIONS      = 1082 ;
  MQIACF_CLUSTER_INFO             = 1083 ;
  MQIACF_Q_MGR_DEFINITION_TYPE    = 1084 ;
  MQIACF_Q_MGR_TYPE               = 1085 ;
  MQIACF_ACTION                   = 1086 ;
  MQIACF_SUSPEND                  = 1087 ;
  MQIACF_BROKER_COUNT             = 1088 ;
  MQIACF_APPL_COUNT               = 1089 ;
  MQIACF_ANONYMOUS_COUNT          = 1090 ;
  MQIACF_REG_REG_OPTIONS          = 1091 ;
  MQIACF_DELETE_OPTIONS           = 1092 ;
  MQIACF_CLUSTER_Q_MGR_ATTRS      = 1093 ;
  MQIACF_REFRESH_INTERVAL         = 1094 ;
  MQIACF_REFRESH_REPOSITORY       = 1095 ;
  MQIACF_REMOVE_QUEUES            = 1096 ;
  MQIACF_OPEN_INPUT_TYPE          = 1098 ;
  MQIACF_OPEN_OUTPUT              = 1099 ;
  MQIACF_OPEN_SET                 = 1100 ;
  MQIACF_OPEN_INQUIRE             = 1101 ;
  MQIACF_OPEN_BROWSE              = 1102 ;
  MQIACF_Q_STATUS_TYPE            = 1103 ;
  MQIACF_Q_HANDLE                 = 1104 ;
  MQIACF_Q_STATUS                 = 1105 ;
  MQIACF_SECURITY_TYPE            = 1106 ;
  MQIACF_CONNECTION_ATTRS         = 1107 ;
  MQIACF_CONNECT_OPTIONS          = 1108 ;
  MQIACF_CONN_INFO_TYPE           = 1110 ;
  MQIACF_CONN_INFO_CONN           = 1111 ;
  MQIACF_CONN_INFO_HANDLE         = 1112 ;
  MQIACF_CONN_INFO_ALL            = 1113 ;
  MQIACF_AUTH_PROFILE_ATTRS       = 1114 ;
  MQIACF_AUTHORIZATION_LIST       = 1115 ;
  MQIACF_AUTH_ADD_AUTHS           = 1116 ;
  MQIACF_AUTH_REMOVE_AUTHS        = 1117 ;
  MQIACF_ENTITY_TYPE              = 1118 ;
  MQIACF_COMMAND_INFO             = 1120 ;
  MQIACF_CMDSCOPE_Q_MGR_COUNT     = 1121 ;
  MQIACF_Q_MGR_SYSTEM             = 1122 ;
  MQIACF_Q_MGR_EVENT              = 1123 ;
  MQIACF_Q_MGR_DQM                = 1124 ;
  MQIACF_Q_MGR_CLUSTER            = 1125 ;
  MQIACF_QSG_DISPS                = 1126 ;
  MQIACF_UOW_STATE                = 1128 ;
  MQIACF_SECURITY_ITEM            = 1129 ;
  MQIACF_CF_STRUC_STATUS          = 1130 ;
  MQIACF_UOW_TYPE                 = 1132 ;
  MQIACF_CF_STRUC_ATTRS           = 1133 ;
  MQIACF_EXCLUDE_INTERVAL         = 1134 ;
  MQIACF_CF_STATUS_TYPE           = 1135 ;
  MQIACF_CF_STATUS_SUMMARY        = 1136 ;
  MQIACF_CF_STATUS_CONNECT        = 1137 ;
  MQIACF_CF_STATUS_BACKUP         = 1138 ;
  MQIACF_CF_STRUC_TYPE            = 1139 ;
  MQIACF_CF_STRUC_SIZE_MAX        = 1140 ;
  MQIACF_CF_STRUC_SIZE_USED       = 1141 ;
  MQIACF_CF_STRUC_ENTRIES_MAX     = 1142 ;
  MQIACF_CF_STRUC_ENTRIES_USED    = 1143 ;
  MQIACF_CF_STRUC_BACKUP_SIZE     = 1144 ;
  MQIACF_MOVE_TYPE                = 1145 ;
  MQIACF_MOVE_TYPE_MOVE           = 1146 ;
  MQIACF_MOVE_TYPE_ADD            = 1147 ;
  MQIACF_Q_MGR_NUMBER             = 1148 ;
  MQIACF_Q_MGR_STATUS             = 1149 ;
  MQIACF_DB2_CONN_STATUS          = 1150 ;
  MQIACF_SECURITY_ATTRS           = 1151 ;
  MQIACF_SECURITY_TIMEOUT         = 1152 ;
  MQIACF_SECURITY_INTERVAL        = 1153 ;
  MQIACF_SECURITY_SWITCH          = 1154 ;
  MQIACF_SECURITY_SETTING         = 1155 ;
  MQIACF_STORAGE_CLASS_ATTRS      = 1156 ;
  MQIACF_USAGE_TYPE               = 1157 ;
  MQIACF_BUFFER_POOL_ID           = 1158 ;
  MQIACF_USAGE_TOTAL_PAGES        = 1159 ;
  MQIACF_USAGE_UNUSED_PAGES       = 1160 ;
  MQIACF_USAGE_PERSIST_PAGES      = 1161 ;
  MQIACF_USAGE_NONPERSIST_PAGES   = 1162 ;
  MQIACF_USAGE_RESTART_EXTENTS    = 1163 ;
  MQIACF_USAGE_EXPAND_COUNT       = 1164 ;
  MQIACF_PAGESET_STATUS           = 1165 ;
  MQIACF_USAGE_TOTAL_BUFFERS      = 1166 ;
  MQIACF_USAGE_DATA_SET_TYPE      = 1167 ;
  MQIACF_USAGE_PAGESET            = 1168 ;
  MQIACF_USAGE_DATA_SET           = 1169 ;
  MQIACF_USAGE_BUFFER_POOL        = 1170 ;
  MQIACF_MOVE_COUNT               = 1171 ;
  MQIACF_EXPIRY_Q_COUNT           = 1172 ;
  MQIACF_CONFIGURATION_OBJECTS    = 1173 ;
  MQIACF_CONFIGURATION_EVENTS     = 1174 ;
  MQIACF_SYSP_TYPE                = 1175 ;
  MQIACF_SYSP_DEALLOC_INTERVAL    = 1176 ;
  MQIACF_SYSP_MAX_ARCHIVE         = 1177 ;
  MQIACF_SYSP_MAX_READ_TAPES      = 1178 ;
  MQIACF_SYSP_IN_BUFFER_SIZE      = 1179 ;
  MQIACF_SYSP_OUT_BUFFER_SIZE     = 1180 ;
  MQIACF_SYSP_OUT_BUFFER_COUNT    = 1181 ;
  MQIACF_SYSP_ARCHIVE             = 1182 ;
  MQIACF_SYSP_DUAL_ACTIVE         = 1183 ;
  MQIACF_SYSP_DUAL_ARCHIVE        = 1184 ;
  MQIACF_SYSP_DUAL_BSDS           = 1185 ;
  MQIACF_SYSP_MAX_CONNS           = 1186 ;
  MQIACF_SYSP_MAX_CONNS_FORE      = 1187 ;
  MQIACF_SYSP_MAX_CONNS_BACK      = 1188 ;
  MQIACF_SYSP_EXIT_INTERVAL       = 1189 ;
  MQIACF_SYSP_EXIT_TASKS          = 1190 ;
  MQIACF_SYSP_CHKPOINT_COUNT      = 1191 ;
  MQIACF_SYSP_OTMA_INTERVAL       = 1192 ;
  MQIACF_SYSP_Q_INDEX_DEFER       = 1193 ;
  MQIACF_SYSP_DB2_TASKS           = 1194 ;
  MQIACF_SYSP_RESLEVEL_AUDIT      = 1195 ;
  MQIACF_SYSP_ROUTING_CODE        = 1196 ;
  MQIACF_SYSP_SMF_ACCOUNTING      = 1197 ;
  MQIACF_SYSP_SMF_STATS           = 1198 ;
  MQIACF_SYSP_SMF_INTERVAL        = 1199 ;
  MQIACF_SYSP_TRACE_CLASS         = 1200 ;
  MQIACF_SYSP_TRACE_SIZE          = 1201 ;
  MQIACF_SYSP_WLM_INTERVAL        = 1202 ;
  MQIACF_SYSP_ALLOC_UNIT          = 1203 ;
  MQIACF_SYSP_ARCHIVE_RETAIN      = 1204 ;
  MQIACF_SYSP_ARCHIVE_WTOR        = 1205 ;
  MQIACF_SYSP_BLOCK_SIZE          = 1206 ;
  MQIACF_SYSP_CATALOG             = 1207 ;
  MQIACF_SYSP_COMPACT             = 1208 ;
  MQIACF_SYSP_ALLOC_PRIMARY       = 1209 ;
  MQIACF_SYSP_ALLOC_SECONDARY     = 1210 ;
  MQIACF_SYSP_PROTECT             = 1211 ;
  MQIACF_SYSP_QUIESCE_INTERVAL    = 1212 ;
  MQIACF_SYSP_TIMESTAMP           = 1213 ;
  MQIACF_SYSP_UNIT_ADDRESS        = 1214 ;
  MQIACF_SYSP_UNIT_STATUS         = 1215 ;
  MQIACF_SYSP_LOG_COPY            = 1216 ;
  MQIACF_SYSP_LOG_USED            = 1217 ;
  MQIACF_SYSP_LOG_SUSPEND         = 1218 ;
  MQIACF_SYSP_OFFLOAD_STATUS      = 1219 ;
  MQIACF_SYSP_TOTAL_LOGS          = 1220 ;
  MQIACF_SYSP_FULL_LOGS           = 1221 ;
  MQIACF_LISTENER_ATTRS           = 1222 ;
  MQIACF_LISTENER_STATUS_ATTRS    = 1223 ;
  MQIACF_SERVICE_ATTRS            = 1224 ;
  MQIACF_SERVICE_STATUS_ATTRS     = 1225 ;
  MQIACF_Q_TIME_INDICATOR         = 1226 ;
  MQIACF_OLDEST_MSG_AGE           = 1227 ;
  MQIACF_AUTH_OPTIONS             = 1228 ;
  MQIACF_Q_MGR_STATUS_ATTRS       = 1229 ;
  MQIACF_CONNECTION_COUNT         = 1230 ;
  MQIACF_Q_MGR_FACILITY           = 1231 ;
  MQIACF_CHINIT_STATUS            = 1232 ;
  MQIACF_CMD_SERVER_STATUS        = 1233 ;
  MQIACF_ROUTE_DETAIL             = 1234 ;
  MQIACF_RECORDED_ACTIVITIES      = 1235 ;
  MQIACF_MAX_ACTIVITIES           = 1236 ;
  MQIACF_DISCONTINUITY_COUNT      = 1237 ;
  MQIACF_ROUTE_ACCUMULATION       = 1238 ;
  MQIACF_ROUTE_DELIVERY           = 1239 ;
  MQIACF_OPERATION_TYPE           = 1240 ;
  MQIACF_BACKOUT_COUNT            = 1241 ;
  MQIACF_COMP_CODE                = 1242 ;
  MQIACF_ENCODING                 = 1243 ;
  MQIACF_EXPIRY                   = 1244 ;
  MQIACF_FEEDBACK                 = 1245 ;
  MQIACF_MSG_FLAGS                = 1247 ;
  MQIACF_MSG_LENGTH               = 1248 ;
  MQIACF_MSG_TYPE                 = 1249 ;
  MQIACF_OFFSET                   = 1250 ;
  MQIACF_ORIGINAL_LENGTH          = 1251 ;
  MQIACF_PERSISTENCE              = 1252 ;
  MQIACF_PRIORITY                 = 1253 ;
  MQIACF_REASON_CODE              = 1254 ;
  MQIACF_REPORT                   = 1255 ;
  MQIACF_VERSION                  = 1256 ;
  MQIACF_UNRECORDED_ACTIVITIES    = 1257 ;
  MQIACF_MONITORING               = 1258 ;
  MQIACF_ROUTE_FORWARDING         = 1259 ;
  MQIACF_SERVICE_STATUS           = 1260 ;
  MQIACF_Q_TYPES                  = 1261 ;
  MQIACF_USER_ID_SUPPORT          = 1262 ;
  MQIACF_INTERFACE_VERSION        = 1263 ;
  MQIACF_AUTH_SERVICE_ATTRS       = 1264 ;
  MQIACF_USAGE_EXPAND_TYPE        = 1265 ;
  MQIACF_SYSP_CLUSTER_CACHE       = 1266 ;
  MQIACF_SYSP_DB2_BLOB_TASKS      = 1267 ;
  MQIACF_SYSP_WLM_INT_UNITS       = 1268 ;
  MQIACF_LAST_USED                = 1268 ;

{ Integer Channel Types }
  MQIACH_FIRST                    = 1501 ;
  MQIACH_XMIT_PROTOCOL_TYPE       = 1501 ;
  MQIACH_BATCH_SIZE               = 1502 ;
  MQIACH_DISC_INTERVAL            = 1503 ;
  MQIACH_SHORT_TIMER              = 1504 ;
  MQIACH_SHORT_RETRY              = 1505 ;
  MQIACH_LONG_TIMER               = 1506 ;
  MQIACH_LONG_RETRY               = 1507 ;
  MQIACH_PUT_AUTHORITY            = 1508 ;
  MQIACH_SEQUENCE_NUMBER_WRAP     = 1509 ;
  MQIACH_MAX_MSG_LENGTH           = 1510 ;
  MQIACH_CHANNEL_TYPE             = 1511 ;
  MQIACH_DATA_COUNT               = 1512 ;
  MQIACH_NAME_COUNT               = 1513 ;
  MQIACH_MSG_SEQUENCE_NUMBER      = 1514 ;
  MQIACH_DATA_CONVERSION          = 1515 ;
  MQIACH_IN_DOUBT                 = 1516 ;
  MQIACH_MCA_TYPE                 = 1517 ;
  MQIACH_SESSION_COUNT            = 1518 ;
  MQIACH_ADAPTER                  = 1519 ;
  MQIACH_COMMAND_COUNT            = 1520 ;
  MQIACH_SOCKET                   = 1521 ;
  MQIACH_PORT                     = 1522 ;
  MQIACH_CHANNEL_INSTANCE_TYPE    = 1523 ;
  MQIACH_CHANNEL_INSTANCE_ATTRS   = 1524 ;
  MQIACH_CHANNEL_ERROR_DATA       = 1525 ;
  MQIACH_CHANNEL_TABLE            = 1526 ;
  MQIACH_CHANNEL_STATUS           = 1527 ;
  MQIACH_INDOUBT_STATUS           = 1528 ;
  MQIACH_LAST_SEQ_NUMBER          = 1529 ;
  MQIACH_LAST_SEQUENCE_NUMBER     = 1529 ;
  MQIACH_CURRENT_MSGS             = 1531 ;
  MQIACH_CURRENT_SEQ_NUMBER       = 1532 ;
  MQIACH_CURRENT_SEQUENCE_NUMBER  = 1532 ;
  MQIACH_SSL_RETURN_CODE          = 1533 ;
  MQIACH_MSGS                     = 1534 ;
  MQIACH_BYTES_SENT               = 1535 ;
  MQIACH_BYTES_RCVD               = 1536 ;
  MQIACH_BYTES_RECEIVED           = 1536 ;
  MQIACH_BATCHES                  = 1537 ;
  MQIACH_BUFFERS_SENT             = 1538 ;
  MQIACH_BUFFERS_RCVD             = 1539 ;
  MQIACH_BUFFERS_RECEIVED         = 1539 ;
  MQIACH_LONG_RETRIES_LEFT        = 1540 ;
  MQIACH_SHORT_RETRIES_LEFT       = 1541 ;
  MQIACH_MCA_STATUS               = 1542 ;
  MQIACH_STOP_REQUESTED           = 1543 ;
  MQIACH_MR_COUNT                 = 1544 ;
  MQIACH_MR_INTERVAL              = 1545 ;
  MQIACH_NPM_SPEED                = 1562 ;
  MQIACH_HB_INTERVAL              = 1563 ;
  MQIACH_BATCH_INTERVAL           = 1564 ;
  MQIACH_NETWORK_PRIORITY         = 1565 ;
  MQIACH_KEEP_ALIVE_INTERVAL      = 1566 ;
  MQIACH_BATCH_HB                 = 1567 ;
  MQIACH_SSL_CLIENT_AUTH          = 1568 ;
  MQIACH_ALLOC_RETRY              = 1570 ;
  MQIACH_ALLOC_FAST_TIMER         = 1571 ;
  MQIACH_ALLOC_SLOW_TIMER         = 1572 ;
  MQIACH_DISC_RETRY               = 1573 ;
  MQIACH_PORT_NUMBER              = 1574 ;
  MQIACH_HDR_COMPRESSION          = 1575 ;
  MQIACH_MSG_COMPRESSION          = 1576 ;
  MQIACH_CLWL_CHANNEL_RANK        = 1577 ;
  MQIACH_CLWL_CHANNEL_PRIORITY    = 1578 ;
  MQIACH_CLWL_CHANNEL_WEIGHT      = 1579 ;
  MQIACH_CHANNEL_DISP             = 1580 ;
  MQIACH_INBOUND_DISP             = 1581 ;
  MQIACH_CHANNEL_TYPES            = 1582 ;
  MQIACH_ADAPS_STARTED            = 1583 ;
  MQIACH_ADAPS_MAX                = 1584 ;
  MQIACH_DISPS_STARTED            = 1585 ;
  MQIACH_DISPS_MAX                = 1586 ;
  MQIACH_SSLTASKS_STARTED         = 1587 ;
  MQIACH_SSLTASKS_MAX             = 1588 ;
  MQIACH_CURRENT_CHL              = 1589 ;
  MQIACH_CURRENT_CHL_MAX          = 1590 ;
  MQIACH_CURRENT_CHL_TCP          = 1591 ;
  MQIACH_CURRENT_CHL_LU62         = 1592 ;
  MQIACH_ACTIVE_CHL               = 1593 ;
  MQIACH_ACTIVE_CHL_MAX           = 1594 ;
  MQIACH_ACTIVE_CHL_PAUSED        = 1595 ;
  MQIACH_ACTIVE_CHL_STARTED       = 1596 ;
  MQIACH_ACTIVE_CHL_STOPPED       = 1597 ;
  MQIACH_ACTIVE_CHL_RETRY         = 1598 ;
  MQIACH_LISTENER_STATUS          = 1599 ;
  MQIACH_SHARED_CHL_RESTART       = 1600 ;
  MQIACH_LISTENER_CONTROL         = 1601 ;
  MQIACH_BACKLOG                  = 1602 ;
  MQIACH_XMITQ_TIME_INDICATOR     = 1604 ;
  MQIACH_NETWORK_TIME_INDICATOR   = 1605 ;
  MQIACH_EXIT_TIME_INDICATOR      = 1606 ;
  MQIACH_BATCH_SIZE_INDICATOR     = 1607 ;
  MQIACH_XMITQ_MSGS_AVAILABLE     = 1608 ;
  MQIACH_CHANNEL_SUBSTATE         = 1609 ;
  MQIACH_SSL_KEY_RESETS           = 1610 ;
  MQIACH_COMPRESSION_RATE         = 1611 ;
  MQIACH_COMPRESSION_TIME         = 1612 ;
  MQIACH_MAX_XMIT_SIZE            = 1613 ;
  MQIACH_LAST_USED                = 1613 ;

{ Character Monitoring Parameter Types }
  MQCAMO_FIRST                    = 2701 ;
  MQCAMO_CLOSE_DATE               = 2701 ;
  MQCAMO_CLOSE_TIME               = 2702 ;
  MQCAMO_CONN_DATE                = 2703 ;
  MQCAMO_CONN_TIME                = 2704 ;
  MQCAMO_DISC_DATE                = 2705 ;
  MQCAMO_DISC_TIME                = 2706 ;
  MQCAMO_END_DATE                 = 2707 ;
  MQCAMO_END_TIME                 = 2708 ;
  MQCAMO_OPEN_DATE                = 2709 ;
  MQCAMO_OPEN_TIME                = 2710 ;
  MQCAMO_START_DATE               = 2711 ;
  MQCAMO_START_TIME               = 2712 ;
  MQCAMO_LAST_USED                = 2712 ;

{ Character Parameter Types }
  MQCACF_FIRST                    = 3001 ;
  MQCACF_FROM_Q_NAME              = 3001 ;
  MQCACF_TO_Q_NAME                = 3002 ;
  MQCACF_FROM_PROCESS_NAME        = 3003 ;
  MQCACF_TO_PROCESS_NAME          = 3004 ;
  MQCACF_FROM_NAMELIST_NAME       = 3005 ;
  MQCACF_TO_NAMELIST_NAME         = 3006 ;
  MQCACF_FROM_CHANNEL_NAME        = 3007 ;
  MQCACF_TO_CHANNEL_NAME          = 3008 ;
  MQCACF_FROM_AUTH_INFO_NAME      = 3009 ;
  MQCACF_TO_AUTH_INFO_NAME        = 3010 ;
  MQCACF_Q_NAMES                  = 3011 ;
  MQCACF_PROCESS_NAMES            = 3012 ;
  MQCACF_NAMELIST_NAMES           = 3013 ;
  MQCACF_ESCAPE_TEXT              = 3014 ;
  MQCACF_LOCAL_Q_NAMES            = 3015 ;
  MQCACF_MODEL_Q_NAMES            = 3016 ;
  MQCACF_ALIAS_Q_NAMES            = 3017 ;
  MQCACF_REMOTE_Q_NAMES           = 3018 ;
  MQCACF_SENDER_CHANNEL_NAMES     = 3019 ;
  MQCACF_SERVER_CHANNEL_NAMES     = 3020 ;
  MQCACF_REQUESTER_CHANNEL_NAMES  = 3021 ;
  MQCACF_RECEIVER_CHANNEL_NAMES   = 3022 ;
  MQCACF_OBJECT_Q_MGR_NAME        = 3023 ;
  MQCACF_APPL_NAME                = 3024 ;
  MQCACF_USER_IDENTIFIER          = 3025 ;
  MQCACF_AUX_ERROR_DATA_STR_1     = 3026 ;
  MQCACF_AUX_ERROR_DATA_STR_2     = 3027 ;
  MQCACF_AUX_ERROR_DATA_STR_3     = 3028 ;
  MQCACF_BRIDGE_NAME              = 3029 ;
  MQCACF_STREAM_NAME              = 3030 ;
  MQCACF_TOPIC                    = 3031 ;
  MQCACF_PARENT_Q_MGR_NAME        = 3032 ;
  MQCACF_CORREL_ID                = 3033 ;
  MQCACF_PUBLISH_TIMESTAMP        = 3034 ;
  MQCACF_STRING_DATA              = 3035 ;
  MQCACF_SUPPORTED_STREAM_NAME    = 3036 ;
  MQCACF_REG_TOPIC                = 3037 ;
  MQCACF_REG_TIME                 = 3038 ;
  MQCACF_REG_USER_ID              = 3039 ;
  MQCACF_CHILD_Q_MGR_NAME         = 3040 ;
  MQCACF_REG_STREAM_NAME          = 3041 ;
  MQCACF_REG_Q_MGR_NAME           = 3042 ;
  MQCACF_REG_Q_NAME               = 3043 ;
  MQCACF_REG_CORREL_ID            = 3044 ;
  MQCACF_EVENT_USER_ID            = 3045 ;
  MQCACF_OBJECT_NAME              = 3046 ;
  MQCACF_EVENT_Q_MGR              = 3047 ;
  MQCACF_AUTH_INFO_NAMES          = 3048 ;
  MQCACF_EVENT_APPL_IDENTITY      = 3049 ;
  MQCACF_EVENT_APPL_NAME          = 3050 ;
  MQCACF_EVENT_APPL_ORIGIN        = 3051 ;
  MQCACF_SUBSCRIPTION_NAME        = 3052 ;
  MQCACF_REG_SUB_NAME             = 3053 ;
  MQCACF_SUBSCRIPTION_IDENTITY    = 3054 ;
  MQCACF_REG_SUB_IDENTITY         = 3055 ;
  MQCACF_SUBSCRIPTION_USER_DATA   = 3056 ;
  MQCACF_REG_SUB_USER_DATA        = 3057 ;
  MQCACF_APPL_TAG                 = 3058 ;
  MQCACF_DATA_SET_NAME            = 3059 ;
  MQCACF_UOW_START_DATE           = 3060 ;
  MQCACF_UOW_START_TIME           = 3061 ;
  MQCACF_UOW_LOG_START_DATE       = 3062 ;
  MQCACF_UOW_LOG_START_TIME       = 3063 ;
  MQCACF_UOW_LOG_EXTENT_NAME      = 3064 ;
  MQCACF_PRINCIPAL_ENTITY_NAMES   = 3065 ;
  MQCACF_GROUP_ENTITY_NAMES       = 3066 ;
  MQCACF_AUTH_PROFILE_NAME        = 3067 ;
  MQCACF_ENTITY_NAME              = 3068 ;
  MQCACF_SERVICE_COMPONENT        = 3069 ;
  MQCACF_RESPONSE_Q_MGR_NAME      = 3070 ;
  MQCACF_CURRENT_LOG_EXTENT_NAME  = 3071 ;
  MQCACF_RESTART_LOG_EXTENT_NAME  = 3072 ;
  MQCACF_MEDIA_LOG_EXTENT_NAME    = 3073 ;
  MQCACF_LOG_PATH                 = 3074 ;
  MQCACF_COMMAND_MQSC             = 3075 ;
  MQCACF_Q_MGR_CPF                = 3076 ;
  MQCACF_USAGE_LOG_RBA            = 3078 ;
  MQCACF_USAGE_LOG_LRSN           = 3079 ;
  MQCACF_COMMAND_SCOPE            = 3080 ;
  MQCACF_ASID                     = 3081 ;
  MQCACF_PSB_NAME                 = 3082 ;
  MQCACF_PST_ID                   = 3083 ;
  MQCACF_TASK_NUMBER              = 3084 ;
  MQCACF_TRANSACTION_ID           = 3085 ;
  MQCACF_Q_MGR_UOW_ID             = 3086 ;
  MQCACF_ORIGIN_NAME              = 3088 ;
  MQCACF_ENV_INFO                 = 3089 ;
  MQCACF_SECURITY_PROFILE         = 3090 ;
  MQCACF_CONFIGURATION_DATE       = 3091 ;
  MQCACF_CONFIGURATION_TIME       = 3092 ;
  MQCACF_FROM_CF_STRUC_NAME       = 3093 ;
  MQCACF_TO_CF_STRUC_NAME         = 3094 ;
  MQCACF_CF_STRUC_NAMES           = 3095 ;
  MQCACF_FAIL_DATE                = 3096 ;
  MQCACF_FAIL_TIME                = 3097 ;
  MQCACF_BACKUP_DATE              = 3098 ;
  MQCACF_BACKUP_TIME              = 3099 ;
  MQCACF_SYSTEM_NAME              = 3100 ;
  MQCACF_CF_STRUC_BACKUP_START    = 3101 ;
  MQCACF_CF_STRUC_BACKUP_END      = 3102 ;
  MQCACF_CF_STRUC_LOG_Q_MGRS      = 3103 ;
  MQCACF_FROM_STORAGE_CLASS       = 3104 ;
  MQCACF_TO_STORAGE_CLASS         = 3105 ;
  MQCACF_STORAGE_CLASS_NAMES      = 3106 ;
  MQCACF_DSG_NAME                 = 3108 ;
  MQCACF_DB2_NAME                 = 3109 ;
  MQCACF_SYSP_CMD_USER_ID         = 3110 ;
  MQCACF_SYSP_OTMA_GROUP          = 3111 ;
  MQCACF_SYSP_OTMA_MEMBER         = 3112 ;
  MQCACF_SYSP_OTMA_DRU_EXIT       = 3113 ;
  MQCACF_SYSP_OTMA_TPIPE_PFX      = 3114 ;
  MQCACF_SYSP_ARCHIVE_PFX1        = 3115 ;
  MQCACF_SYSP_ARCHIVE_UNIT1       = 3116 ;
  MQCACF_SYSP_LOG_CORREL_ID       = 3117 ;
  MQCACF_SYSP_UNIT_VOLSER         = 3118 ;
  MQCACF_SYSP_Q_MGR_TIME          = 3119 ;
  MQCACF_SYSP_Q_MGR_DATE          = 3120 ;
  MQCACF_SYSP_Q_MGR_RBA           = 3121 ;
  MQCACF_SYSP_LOG_RBA             = 3122 ;
  MQCACF_SYSP_SERVICE             = 3123 ;
  MQCACF_FROM_LISTENER_NAME       = 3124 ;
  MQCACF_TO_LISTENER_NAME         = 3125 ;
  MQCACF_FROM_SERVICE_NAME        = 3126 ;
  MQCACF_TO_SERVICE_NAME          = 3127 ;
  MQCACF_LAST_PUT_DATE            = 3128 ;
  MQCACF_LAST_PUT_TIME            = 3129 ;
  MQCACF_LAST_GET_DATE            = 3130 ;
  MQCACF_LAST_GET_TIME            = 3131 ;
  MQCACF_OPERATION_DATE           = 3132 ;
  MQCACF_OPERATION_TIME           = 3133 ;
  MQCACF_ACTIVITY_DESC            = 3134 ;
  MQCACF_APPL_IDENTITY_DATA       = 3135 ;
  MQCACF_APPL_ORIGIN_DATA         = 3136 ;
  MQCACF_PUT_DATE                 = 3137 ;
  MQCACF_PUT_TIME                 = 3138 ;
  MQCACF_REPLY_TO_Q               = 3139 ;
  MQCACF_REPLY_TO_Q_MGR           = 3140 ;
  MQCACF_RESOLVED_Q_NAME          = 3141 ;
  MQCACF_STRUC_ID                 = 3142 ;
  MQCACF_VALUE_NAME               = 3143 ;
  MQCACF_SERVICE_START_DATE       = 3144 ;
  MQCACF_SERVICE_START_TIME       = 3145 ;
  MQCACF_SYSP_OFFLINE_RBA         = 3146 ;
  MQCACF_SYSP_ARCHIVE_PFX2        = 3147 ;
  MQCACF_SYSP_ARCHIVE_UNIT2       = 3148 ;
  MQCACF_LAST_USED                = 3148 ;

{ Character Channel Parameter Types }
  MQCACH_FIRST                    = 3501 ;
  MQCACH_CHANNEL_NAME             = 3501 ;
  MQCACH_DESC                     = 3502 ;
  MQCACH_MODE_NAME                = 3503 ;
  MQCACH_TP_NAME                  = 3504 ;
  MQCACH_XMIT_Q_NAME              = 3505 ;
  MQCACH_CONNECTION_NAME          = 3506 ;
  MQCACH_MCA_NAME                 = 3507 ;
  MQCACH_SEC_EXIT_NAME            = 3508 ;
  MQCACH_MSG_EXIT_NAME            = 3509 ;
  MQCACH_SEND_EXIT_NAME           = 3510 ;
  MQCACH_RCV_EXIT_NAME            = 3511 ;
  MQCACH_CHANNEL_NAMES            = 3512 ;
  MQCACH_SEC_EXIT_USER_DATA       = 3513 ;
  MQCACH_MSG_EXIT_USER_DATA       = 3514 ;
  MQCACH_SEND_EXIT_USER_DATA      = 3515 ;
  MQCACH_RCV_EXIT_USER_DATA       = 3516 ;
  MQCACH_USER_ID                  = 3517 ;
  MQCACH_PASSWORD                 = 3518 ;
  MQCACH_LOCAL_ADDRESS            = 3520 ;
  MQCACH_LOCAL_NAME               = 3521 ;
  MQCACH_LAST_MSG_TIME            = 3524 ;
  MQCACH_LAST_MSG_DATE            = 3525 ;
  MQCACH_MCA_USER_ID              = 3527 ;
  MQCACH_CHANNEL_START_TIME       = 3528 ;
  MQCACH_CHANNEL_START_DATE       = 3529 ;
  MQCACH_MCA_JOB_NAME             = 3530 ;
  MQCACH_LAST_LUWID               = 3531 ;
  MQCACH_CURRENT_LUWID            = 3532 ;
  MQCACH_FORMAT_NAME              = 3533 ;
  MQCACH_MR_EXIT_NAME             = 3534 ;
  MQCACH_MR_EXIT_USER_DATA        = 3535 ;
  MQCACH_SSL_CIPHER_SPEC          = 3544 ;
  MQCACH_SSL_PEER_NAME            = 3545 ;
  MQCACH_SSL_HANDSHAKE_STAGE      = 3546 ;
  MQCACH_SSL_SHORT_PEER_NAME      = 3547 ;
  MQCACH_REMOTE_APPL_TAG          = 3548 ;
  MQCACH_SSL_CERT_USER_ID         = 3549 ;
  MQCACH_SSL_CERT_ISSUER_NAME     = 3550 ;
  MQCACH_LU_NAME                  = 3551 ;
  MQCACH_IP_ADDRESS               = 3552 ;
  MQCACH_TCP_NAME                 = 3553 ;
  MQCACH_LISTENER_NAME            = 3554 ;
  MQCACH_LISTENER_DESC            = 3555 ;
  MQCACH_LISTENER_START_DATE      = 3556 ;
  MQCACH_LISTENER_START_TIME      = 3557 ;
  MQCACH_SSL_KEY_RESET_DATE       = 3558 ;
  MQCACH_SSL_KEY_RESET_TIME       = 3559 ;
  MQCACH_LAST_USED                = 3559 ;

{ Channel Status }
  MQCHS_INACTIVE     = 0 ;
  MQCHS_BINDING      = 1 ;
  MQCHS_STARTING     = 2 ;
  MQCHS_RUNNING      = 3 ;
  MQCHS_STOPPING     = 4 ;
  MQCHS_RETRYING     = 5 ;
  MQCHS_STOPPED      = 6 ;
  MQCHS_REQUESTING   = 7 ;
  MQCHS_PAUSED       = 8 ;
  MQCHS_INITIALIZING = 13 ;

{ --- SAG, Jul-2006 }

type

  MQLONG     = Longint;
  PMQLONG    = ^MQLONG;
  MQHOBJ     = MQLONG;
  PMQHOBJ    = ^MQHOBJ;
  MQHCONN    = MQLONG;
  PMQHCONN   = ^MQHCONN;
  
  MQPTR      = Pointer;
  PMQVOID    = Pointer ;

  MQCHAR     = AnsiChar ;                    // a character type guaranteed to be 8 bits in size {20150520}
  MQCHAR4    = array [0..3]   of AnsiChar ;
  MQCHAR8    = array [0..7]   of AnsiChar ;
  MQCHAR12   = array [0..11]  of AnsiChar ;
  MQCHAR20   = array [0..19]  of AnsiChar ;
  MQCHAR28   = array [0..27]  of AnsiChar ;
  MQCHAR32   = array [0..31]  of AnsiChar ;
  MQCHAR48   = array [0..47]  of AnsiChar ;
  MQCHAR64   = array [0..63]  of AnsiChar ;
  MQCHAR128  = array [0..127] of AnsiChar ;
  MQCHAR256  = array [0..255] of AnsiChar ;
  MQCHAR264  = array [0..263] of AnsiChar ;
  PMQCHAR    = PChar;
  PMQCHAR4   = ^MQCHAR4;
  PMQCHAR8   = ^MQCHAR8;
  PMQCHAR12  = ^MQCHAR12;
  PMQCHAR20  = ^MQCHAR20;
  PMQCHAR28  = ^MQCHAR28;
  PMQCHAR32  = ^MQCHAR32;
  PMQCHAR48  = ^MQCHAR48;
  PMQCHAR64  = ^MQCHAR64;
  PMQCHAR128 = ^MQCHAR128;
  PMQCHAR256 = ^MQCHAR256;
  PMQCHAR264 = ^MQCHAR264;
  MQBYTE4    = array [0..3]  of Byte;
  MQBYTE8    = array [0..7]  of Byte;
  MQBYTE16   = array [0..15]  of Byte;
  MQBYTE24   = array [0..23]  of Byte;
  MQBYTE32   = array [0..31]  of Byte;
  MQBYTE40   = array [0..39]  of Byte;
  MQBYTE128  = array [0..127] of Byte;

{ +++ SAG, Jul-2006 }

  MQHBAG     = MQLONG ;
  PMQHBAG    = ^MQHBAG ;

  MQBYTE     = byte ; { *** unsigned char ; *** }
  PMQBYTE    = ^MQBYTE ;
  MQINT64    = int64 ;
  PMQINT64   = ^MQINT64 ;

{ --- SAG, Jul-2006 }

{ +++ SAG, Oct-2012 }
  MQHMSG    = MQINT64 ;
{ --- SAG, Oct-2012 }


const
 MQMI_NONE    : MQBYTE24  = ( $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
 MQCI_NONE    : MQBYTE24  = ( $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
 MQCT_NONE    : MQCHAR128 = ( #0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,
#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0);
 MQACT_NONE   : MQBYTE32  = ( $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
 MQGI_NONE    : MQBYTE24  = ( $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
 MQSID_NONE   : MQBYTE40  = ( $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
 MQCFAC_NONE  : MQCHAR8   = ( #0,#0,#0,#0,#0,#0,#0,#0);
 MQMTOK_NONE  : MQBYTE16  = ( $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
 MQIAUT_NONE  : MQCHAR8   = '        ';


type

  MQCHARV = record
    VSPtr     : MQPTR ;
    VSOffset  : MQLONG ;
    VSBufSize : MQLONG ;
    VSLength  : MQLONG ;
    VSCCSID   : MQLONG ;
  end ;
  PMQCHARV = ^MQCHARV ;

  MQOD = record
    StrucId             : MQCHAR4 ;
    Version             : MQLONG ;
    ObjectType          : MQLONG ;
    ObjectName          : MQCHAR48 ;
    ObjectQMgrName      : MQCHAR48 ;
    DynamicQName        : MQCHAR48 ;
    AlternateUserID     : MQCHAR12 ;
{ Ver:1 }
    RecsPresent         : MQLONG ;
    KnownDestCount      : MQLONG ;
    UnKnownDestCount    : MQLONG ;
    InvalidDestCount    : MQLONG ;
    ObjectRecOffset     : MQLONG ;
    ResponseRecOffset   : MQLONG ;
    ObjectPointer       : MQPTR ;
    ResponseRecPointer  : MQPTR ;
{ Ver:2 }
    AlternateSecurityID : MQBYTE40 ;
    ResolvedQName       : MQCHAR48 ;
    ResolvedQMgrName    : MQCHAR48 ;
{ Ver:3 }
    ObjectString        : MQCHARV ;
    SelectionString     : MQCHARV ;
    ResObjectString     : MQCHARV ;
    ResolvedType        : MQLONG ;
  end ;
  PMQOD = ^MQOD ;

  MQMD = record
    StrucId             : MQCHAR4;
    Version             : MQLONG;
    Report              : MQLONG;
    MsgType             : MQLONG;
    Expiry              : MQLONG;
    FeedBack            : MQLONG;
    Encoding            : MQLONG;
    CodedCharSetId      : MQLONG;
    Format              : MQCHAR8;
    Priority            : MQLONG;
    Persistence         : MQLONG;
    MsgId               : MQBYTE24;
    CorrelId            : MQBYTE24;
    BackoutCount        : MQLONG;
    ReplyToQ            : MQCHAR48;
    ReplyToQMgr         : MQCHAR48;
    UserIdentifier      : MQCHAR12;
    AccountingToken     : MQBYTE32;
    ApplIdentityData    : MQCHAR32;
    PutApplType         : MQLONG;
    PutApplName         : MQCHAR28;
    PutDate             : MQCHAR8;
    PutTime             : MQCHAR8;
    ApplOriginData      : MQCHAR4;
    GroupId             : MQBYTE24;
    MsgSeqNumber        : MQLONG;
    Offset              : MQLONG;
    MsgFlags            : MQLONG;
    OriginalLength      : MQLONG;
  end;
  PMQMD = ^MQMD;

  MQMD1 = record
    StrucId             : MQCHAR4;
    Version             : MQLONG;
    Report              : MQLONG;
    MsgType             : MQLONG;
    Expiry              : MQLONG;
    FeedBack            : MQLONG;
    Encoding            : MQLONG;
    CodedCharSetId      : MQLONG;
    Format              : MQCHAR8;
    Priority            : MQLONG;
    Persistence         : MQLONG;
    MsgId               : MQBYTE24;
    CorrelId            : MQBYTE24;
    BackoutCount        : MQLONG;
    ReplyToQ            : MQCHAR48;
    ReplyToQMgr         : MQCHAR48;
    UserIdentifier      : MQCHAR12;
    AccountingToken     : MQBYTE32;
    ApplIdentityData    : MQCHAR32;
    PutApplType         : MQLONG;
    PutApplName         : MQCHAR28;
    PutDate             : MQCHAR8;
    PutTime             : MQCHAR8;
    ApplOriginData      : MQCHAR4;
  end;
  PMQMD1= ^MQMD1;

  MQMDE = record
    StrucId            : MQCHAR4;
    Version            : MQLONG;
    StrucLength        : MQLONG;
    Encoding           : MQLONG;
    CodedCharSetId     : MQLONG;
    Format             : MQCHAR8;
    Flags              : MQLONG;
    GroupId            : MQBYTE24;
    MsgSeqNumber       : MQLONG;
    Offset             : MQLONG;
    MsgFlags           : MQLONG;
    OriginalLength     : MQLONG;
  end;
  PMQMDE = ^MQMDE;

  MQPMO = record
    StrucId             : MQCHAR4;
    Version             : MQLONG;
    Options             : MQLONG;
    TimeOut             : MQLONG;
    Context             : MQHOBJ;
    KnownDestCount      : MQLONG;
    UnKnownDestCount    : MQLONG;
    InvalidDestCount    : MQLONG;
    ResolvedQName       : MQCHAR48;
    ResolvedQMgrName    : MQCHAR48;
{ Ver:1 }
    RecsPresent         : MQLONG;
    PutMsgRecFields     : MQLONG;
    PutMsgRecOffset     : MQLONG;
    ResponseRecOffset   : MQLONG;
    PutMsgRecPtr        : MQPTR;
    ResponseRecPtr      : MQPTR;
{ Ver:2 }
    OriginalMsgHandle   : MQHMSG ;
    NewMsgHandle        : MQHMSG ;
    Action              : MQLONG ;
    PubLevel            : MQLONG ;
{ Ver:3 }
  end ;
  PMQPMO = ^MQPMO;

  MQGMO = record
    StrucId             : MQCHAR4 ;
    Version             : MQLONG ;
    Options             : MQLONG ;
    WaitInterval        : MQLONG ;
    Signal1             : MQLONG ;
    Signal2             : MQLONG ;
    ResolvedQName       : MQCHAR48 ;
{ Ver:1 }
    MatchOptions        : MQLONG ;
    GroupStatus         : MQCHAR ;
    SegmentStatus       : MQCHAR ;
    Segmentation        : MQCHAR ;
    Reserved1           : MQCHAR ;
{ Ver:2 }
    MsgToken            : MQBYTE16 ;
    ReturnedLength      : MQLONG ;
{ Ver:3 }
    Reserved2           : MQLONG ;
    MsgHandle           : MQHMSG ;
{ Ver:4 }
  end ;
  PMQGMO = ^MQGMO;

  MQBO = record
    StrucId : MQCHAR4;
    Version : MQLONG;
    Options : MQLONG;
  end;
  PMQBO = ^MQBO;

  MQAIR = record
    StrucId            : MQCHAR4 ;
    Version            : MQLONG ;
    AuthInfoType       : MQLONG ;
    AuthInfoConnName   : MQCHAR264 ;
    LDAPUserNamePtr    : PMQCHAR ;
    LDAPUserNameOffset : MQLONG ;
    LDAPUserNameLength : MQLONG ;
    LDAPPassword       : MQCHAR32 ;
{ Ver:1 }
    OCSPResponderURL   : MQCHAR256 ;
{ Ver:2 }
  end ;
  PMQAIR = ^MQAIR;

  MQSCO = record
    StrucId           : MQCHAR4 ;
    Version           : MQLONG ;
    KeyRepository     : MQCHAR256 ;
    CryptoHardware    : MQCHAR256 ;
    AuthInfoRecCount  : MQLONG ;
    AuthInfoRecOffset : MQLONG ;
    AuthInfoRecPtr    : PMQAIR ;
{ Ver:1 }
    KeyResetCount     : MQLONG ;
    FipsRequired      : MQLONG ;
{ Ver:2 }
  end ;
  PMQSCO = ^MQSCO;

  MQCSP = record
    StrucId             : MQCHAR4 ;
    Version             : MQLONG ;
    AuthenticationType  : MQLONG ;
    Reserved1           : MQBYTE4 ;
    CSPUserIdPtr        : MQPTR ;
    CSPUserIdOffset     : MQLONG ;
    CSPUserIdLength     : MQLONG ;
    Reserved2           : MQBYTE8 ;
    CSPPasswordPtr      : MQPTR ;
    CSPPasswordOffset   : MQLONG ;
    CSPPasswordLength   : MQLONG ;
  end ;
  PMQCSP = ^MQCSP ;

  MQCNO = record
    StrucId          : MQCHAR4 ;
    Version          : MQLONG ;
    Options          : MQLONG ;
{ Ver:1 }
    ClientConnOffset : MQLONG ;
    ClientConnPtr    : MQPTR ;
{ Ver:2 }
    ConnTag          : MQBYTE128 ;
{ Ver:3 }
    SSLConfigPtr     : PMQSCO ;
    SSLConfigOffset  : MQLONG ;
{ Ver:4 }
    ConnectionId        : MQBYTE24 ;
    SecurityParmsOffset : MQLONG ;
    SecurityParmsPtr    : PMQCSP ;
{ Ver:5 }
  end ;
  PMQCNO = ^ MQCNO;

  MQRFH = record
    StrucId          : MQCHAR4;
    Version          : MQLONG;
    StrucLength      : MQLONG;
    Encoding         : MQLONG;
    CodedCharSetId   : MQLONG;
    Format           : MQCHAR8;
    Flags            : MQLONG;
  end;
  PMQRFH = ^MQRFH;

  MQRFH2 = record
    StrucId          : MQCHAR4;
    Version          : MQLONG;
    StrucLength      : MQLONG;
    Encoding         : MQLONG;
    CodedCharSetId   : MQLONG;
    Format           : MQCHAR8;
    Flags            : MQLONG;
    NameValueCCSID   : MQLONG;
  end;
  PMQRFH2 = ^MQRFH2;

  MQDLH = record
    StrucId          : MQCHAR4;
    Version          : MQLONG;
    Reason           : MQLONG;
    DestQName        : MQCHAR48;
    DestQMgrName     : MQCHAR48;
    Encoding         : MQLONG;
    CodedCharSetId   : MQLONG;
    Format           : MQCHAR8;
    PutApplType      : MQLONG;
    PutApplName      : MQCHAR28;
    PutDate          : MQCHAR8;
    PutTime          : MQCHAR8;
  end;
  PMQDLH = ^MQDLH;

  MQIIH = record
    StrucId          : MQCHAR4;
    Version          : MQLONG;
    StrucLength      : MQLONG;
    Encoding         : MQLONG;
    CodedCharSetId   : MQLONG;
    Format           : MQCHAR8;
    Flags            : MQLONG;
    LTermOverride    : MQCHAR8;
    MFSMapName       : MQCHAR8;
    ReplyToFormat    : MQCHAR8;
    Authenticator    : MQCHAR8;
    TranInstanceId   : MQBYTE16;
    TranState        : MQCHAR;
    CommitMode       : MQCHAR;
    SecurityScope    : MQCHAR;
    Reserved         : MQCHAR;
  end;
  PMQIIH = ^MQIIH;

  MQCIH = record
    StrucId            : MQCHAR4;
    Version            : MQLONG;
    StrucLength        : MQLONG;
    Encoding           : MQLONG;
    CodedCharSetId     : MQLONG;
    Format             : MQCHAR8;
    Flags              : MQLONG;
    ReturnCode         : MQLONG;
    CompCode           : MQLONG;
    Reason             : MQLONG;
    UOWControl         : MQLONG;
    GetWaitInterval    : MQLONG;
    LinkType           : MQLONG;
    OutputDataLength   : MQLONG;
    FacilityKeepTime   : MQLONG;
    ADSDescriptor      : MQLONG;
    ConversationalTask : MQLONG;
    TaskEndStatus      : MQLONG;
    Facility           : MQCHAR8;
    Func               : MQCHAR4;
    AbendCode          : MQCHAR4;
    Authenticator      : MQCHAR8;
    Reserved1          : MQCHAR8;
    ReplyToFormat      : MQCHAR8;
    RemoteSysId        : MQCHAR4;
    RemoteTransId      : MQCHAR4;
    TransactionId      : MQCHAR4;
    FacilityLike       : MQCHAR4;
    AttentionId        : MQCHAR4;
    StartCode          : MQCHAR4;
    CancelCode         : MQCHAR4;
    NextTransactionId  : MQCHAR4;
    Reserved2          : MQCHAR8;
    Reserved3          : MQCHAR8;
    CursorPosition     : MQLONG;
    ErrorOffset        : MQLONG;
    InputItem          : MQLONG;
    Reserved4          : MQLONG;
  end;
  PMQCIH = ^MQCIH;

  MQDH = record
    StrucId            : MQCHAR4;
    Version            : MQLONG;
    StrucLength        : MQLONG;
    Encoding           : MQLONG;
    CodedCharSetId     : MQLONG;
    Format             : MQCHAR8;
    Flags              : MQLONG;
    PutMsgRecFields    : MQLONG;
    RecsPresent        : MQLONG;
    ObjectRecOffset    : MQLONG;
    PutMsgRecOffset    : MQLONG;
  end;
  PMQDH = ^MQDH;

  MQOR = record
    ObjectName         : MQCHAR48;
    ObjectQMgrName     : MQCHAR48;
  end;
  PMQOR = ^MQOR;

  MQRR = record
    CompCode           : MQLONG;
    Reason             : MQLONG;
  end;
  PMQRR = ^MQRR;

  MQPMR = record
    MsgId              : MQBYTE24;
    CorrelId           : MQBYTE24;
    GroupId            : MQBYTE24;
    FeedBack           : MQLONG;
    AccountingToken    : MQBYTE32;
  end;
  PMQPMR = ^MQPMR;

  MQRMH = record
    StrucId            : MQCHAR4;
    Version            : MQLONG;
    StrucLength        : MQLONG;
    Encoding           : MQLONG;
    CodedCharSetId     : MQLONG;
    Format             : MQCHAR8;
    Flags              : MQLONG;
    ObjectType         : MQCHAR8;
    ObjectInstanceId   : MQBYTE24;
    SrcEnvLength       : MQLONG;
    SrcEnvOffset       : MQLONG;
    SrcNameLength      : MQLONG;
    SrcNameOffset      : MQLONG;
    DestEnvLength      : MQLONG;
    DestEnvOffset      : MQLONG;
    DestNameLength     : MQLONG;
    DestNameOffset     : MQLONG;
    DataLogicalLength  : MQLONG;
    DataLogicalOffset  : MQLONG;
    DataLogicalOffset2 : MQLONG;
  end;
  PMQRMH = ^MQRMH;

  MQSD = record
    StrucId             : MQCHAR4 ;   // Structure identifier
    Version             : MQLONG ;    // Structure version number
    Options             : MQLONG ;    // Options associated with subscribing
    ObjectName          : MQCHAR48 ;  // Object name
    AlternateUserId     : MQCHAR12 ;  // Alternate user identifier
    AlternateSecurityId : MQBYTE40 ;  // Alternate security identifier
    SubExpiry           : MQLONG ;    // Expiry of Subscription
    ObjectString        : MQCHARV ;   // Object long name
    SubName             : MQCHARV ;   // Subscription name
    SubUserData         : MQCHARV ;   // Subscription user data
    SubCorrelId         : MQBYTE24 ;  // Correlation Id related to this subscription
    PubPriority         : MQLONG ;    // Priority set in publications
    PubAccountingToken  : MQBYTE32 ;  // Accounting Token set in publications
    PubApplIdentityData : MQCHAR32 ;  // Appl Identity Data set in publications
    SelectionString     : MQCHARV ;   // Message selector structure
    SubLevel            : MQLONG ;    // Subscription level
    ResObjectString     : MQCHARV ;   // Resolved long object name
   // Ver:1 
  end ; // MQSD record
  PMQSD =  ^MQSD ;

  MQTM = record
    StrucId            : MQCHAR4;
    Version            : MQLONG;
    QName              : MQCHAR48;
    ProcessName        : MQCHAR48;
    TriggerData        : MQCHAR64;
    ApplType           : MQLONG;
    ApplId             : MQCHAR256;
    EnvData            : MQCHAR128;
    UserData           : MQCHAR128;
  end;
  PMQTM = ^MQTM;

  MQTMC2 = record
    StrucId            : MQCHAR4;
    Version            : MQCHAR4;
    QName              : MQCHAR48;
    ProcessName        : MQCHAR48;
    TriggerData        : MQCHAR64;
    ApplType           : MQLONG;
    ApplId             : MQCHAR256;
    EnvData            : MQCHAR128;
    UserData           : MQCHAR128;
    QMgrName           : MQCHAR48;
  end;
  PMQTMC2= ^MQTMC2;

  MQWIH = record
    StrucId            : MQCHAR4;
    Version            : MQLONG;
    StrucLength        : MQLONG;
    Encoding           : MQLONG;
    CodedCharSetId     : MQLONG;
    Format             : MQCHAR8;
    Flags              : MQLONG;
    ServiceName        : MQCHAR32;
    ServiceStep        : MQCHAR8;
    MsgToken           : MQBYTE16;
    Reserved           : MQCHAR32;
  end;
  PMQWIH = ^MQWIH;

  MQXP = record
    StrucId            : MQCHAR4;
    Version            : MQLONG;
    ExitId             : MQLONG;
    ExitReason         : MQLONG;
    ExitResponse       : MQLONG;
    ExitCommand        : MQLONG;
    ExitParamCount     : MQLONG;
    Reserved           : MQLONG;
    ExitUserArea       : MQBYTE16;
  end;
  PMQXP = ^MQXP;

  MQXQH = record
    StrucId            : MQCHAR4;
    Version            : MQLONG;
    RemoteQName        : MQCHAR48;
    RemoteQMgrName     : MQCHAR48;
    MsgDesc            : MQMD1;
  end;
  PMQXQH = ^MQXQH;

{ #### data to init the structures #### }

const
  MQOD_DEFAULT : MQOD = (StrucId:MQOD_STRUC_ID;
                         Version:MQOD_VERSION_1;
                         ObjectType:MQOT_Q;
                         ObjectName:#0;
                         ObjectQMgrName:#0;
                         DynamicQName:'AMQ.*'#0;
                         RecsPresent:0;
                         KnownDestCount:0;
                         UnKnownDestCount:0;
                         InvalidDestCount:0;
                         ObjectRecOffset:0;
                         ResponseRecOffset:0;
                         ObjectPointer:nil;
                         ResponseRecPointer:nil;
                         AlternateSecurityID:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                         ResolvedQName:#0;
                         ResolvedQMgrName:#0;
                         ObjectString:( VSPtr:nil ; VSOffset:$0 ; VSBufSize:$0 ; VSLength:$0 ; VSCCSID:MQCCSI_APPL ; ) ; 
                         SelectionString:( VSPtr:nil ; VSOffset:$0 ; VSBufSize:$0 ; VSLength:$0 ; VSCCSID:MQCCSI_APPL ; ) ; 
                         ResObjectString:( VSPtr:nil ; VSOffset:$0 ; VSBufSize:$0 ; VSLength:$0 ; VSCCSID:MQCCSI_APPL ; ) ; 
                         ResolvedType:MQOT_NONE;
                         );
   MQMD_DEFAULT : MQMD = (StrucId:MQMD_STRUC_ID;
                          Version:MQMD_VERSION_1;
                          Report:MQRO_NONE;
                          MsgType:MQMT_DATAGRAM;
                          Expiry:MQEI_UNLIMITED;
                          FeedBack:MQFB_NONE;
                          Encoding:MQENC_NATIVE;
                          CodedCharSetId:MQCCSI_Q_MGR;
                          Format:MQFMT_NONE;
                          Priority:MQPRI_PRIORITY_AS_Q_DEF;
                          Persistence:MQPER_PERSISTENCE_AS_Q_DEF;
                          MsgId:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                          CorrelId:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                          BackoutCount:0;
                          ReplyToQ:#0;
                          ReplyToQMgr:#0;
                          UserIdentifier:#0;
                          AccountingToken:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                          ApplIdentityData:#0;
                          PutApplType:MQAT_NO_CONTEXT;
                          PutApplName:#0;
                          PutDate:#0;
                          PutTime:#0;
                          ApplOriginData:#0;
                          GroupId:( $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                          MsgSeqNumber:1;
                          Offset:0;
                          MsgFlags:MQMF_NONE;
                          OriginalLength:MQOL_UNDEFINED;
                         );
   MQMD1_DEFAULT : MQMD= (StrucId:MQMD_STRUC_ID;
                          Version:MQMD_VERSION_1;
                          Report:MQRO_NONE;
                          MsgType:MQMT_DATAGRAM;
                          Expiry:MQEI_UNLIMITED;
                          FeedBack:MQFB_NONE;
                          Encoding:MQENC_NATIVE;
                          CodedCharSetId:MQCCSI_Q_MGR;
                          Format:MQFMT_NONE;
                          Priority:MQPRI_PRIORITY_AS_Q_DEF;
                          Persistence:MQPER_PERSISTENCE_AS_Q_DEF;
                          MsgId:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                          CorrelId:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                          BackoutCount:0;
                          ReplyToQ:#0;
                          ReplyToQMgr:#0;
                          UserIdentifier:#0;
                          AccountingToken:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                          ApplIdentityData:#0;
                          PutApplType:MQAT_NO_CONTEXT;
                          PutApplName:#0;
                          PutDate:#0;
                          PutTime:#0;
                          ApplOriginData:#0;
                         );
  MQMDE_DEFAULT : MQMDE = (StrucId:MQMDE_STRUC_ID;
                           Version:MQMDE_VERSION_2;
                           StrucLength:MQMDE_LENGTH_2;
                           Encoding:MQENC_NATIVE;
                           CodedCharSetId:MQCCSI_UNDEFINED;
                           Format:(#0,#0,#0,#0,#0,#0,#0,#0);
                           Flags:MQMDEF_NONE;
                           GroupId:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                           MsgSeqNumber:1;
                           Offset:0;
                           MsgFlags:MQMF_NONE;
                           OriginalLength:MQOL_UNDEFINED;
                          );
  MQPMO_DEFAULT : MQPMO = (StrucId:MQPMO_STRUC_ID;
                           Version:MQPMO_VERSION_1;
                           Options:MQPMO_NONE;
                           TimeOut:-1;
                           Context:0;
                           KnownDestCount:0;
                           UnKnownDestCount:0;
                           InvalidDestCount:0;
                           ResolvedQName:#0;
                           ResolvedQMgrName:#0;
                           RecsPresent:0;
                           PutMsgRecFields:MQPMRF_NONE;
                           PutMsgRecOffset:0;
                           ResponseRecOffset:0;
                           PutMsgRecPtr:nil;
                           ResponseRecPtr:nil;
                           OriginalMsgHandle:MQHM_NONE;
                           NewMsgHandle:MQHM_NONE;
                           Action:MQACTP_NEW;
                           PubLevel:9;
                          );
  MQGMO_DEFAULT : MQGMO = (StrucId:MQGMO_STRUC_ID;
                           Version:MQGMO_VERSION_1;
                           Options:MQGMO_NO_WAIT;
                           WaitInterval:0;
                           Signal1:0;
                           Signal2:0;
                           ResolvedQName:#0;
                           MatchOptions:(MQMO_MATCH_MSG_ID+MQMO_MATCH_CORREL_ID);
                           GroupStatus:MQGS_NOT_IN_GROUP;
                           SegmentStatus: MQSS_NOT_A_SEGMENT;
                           Segmentation:MQSEG_INHIBITED;
                           Reserved1:' ';
                           MsgToken:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                           ReturnedLength:MQRL_UNDEFINED;
                           Reserved2:0;
                           MsgHandle:MQHM_NONE;
                          );
  MQBO_DEFAULT : MQBO = (  StrucId:MQBO_STRUC_ID;
                           Version:MQBO_VERSION_1;
                           Options:MQBO_NONE;
                           );
   MQRR_DEFAULT : MQRR  = (CompCode:MQCC_OK;
                           Reason:MQRC_NONE;
                          );
   MQAIR_DEFAULT : MQAIR = (StrucId:MQAIR_STRUC_ID;
                            Version:MQAIR_VERSION_1;
                            AuthInfoType:MQAIT_CRL_LDAP;
                            AuthInfoConnName:#0;
                            LDAPUserNamePtr:nil;
                            LDAPUserNameOffset:0;
                            LDAPUserNameLength:0;
                            LDAPPassword:#0;
                            OCSPResponderURL:#0;
                            );
   MQCNO_DEFAULT : MQCNO = (StrucId:MQCNO_STRUC_ID;
                            Version:MQCNO_VERSION_1;
                            Options:MQCNO_NONE;
                            ClientConnOffset:0;
                            ClientConnPtr:nil;
                            ConnTag:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                            SSLConfigPtr:nil;
                            SSLConfigOffset:0;
                            ConnectionId:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                            SecurityParmsOffset:0;
                            SecurityParmsPtr:nil;
                           );
   MQSCO_DEFAULT : MQSCO = (StrucId:MQSCO_STRUC_ID;
                            Version:MQSCO_VERSION_1;
                            KeyRepository:#0;
                            CryptoHardware:#0;
                            AuthInfoRecCount:0;
                            AuthInfoRecOffset:0;
                            AuthInfoRecPtr:nil;
                            KeyResetCount:MQSCO_RESET_COUNT_DEFAULT;
                            FipsRequired:MQSSL_FIPS_NO;
                           );
   MQRFH2_DEFAULT : MQRFH2=(StrucId:MQRFH_STRUC_ID;
                            Version:MQRFH_VERSION_2;
                            StrucLength:MQRFH_STRUC_LENGTH_FIXED_2;
                            Encoding:MQENC_NATIVE;
                            CodedCharSetId:MQCCSI_INHERIT;
                            Format:'        ';
                            Flags:MQRFH_NONE;
                            NameValueCCSID:1208;
                           );
   MQRFH_DEFAULT : MQRFH = (StrucId:MQRFH_STRUC_ID;
                            Version:MQRFH_VERSION_1;
                            StrucLength:MQRFH_STRUC_LENGTH_FIXED;
                            Encoding:MQENC_NATIVE;
                            CodedCharSetId:MQCCSI_UNDEFINED;
                            Format:'        ';
                            Flags:MQRFH_NONE;
                           );
  MQDLH_DEFAULT : MQDLH  = (StrucId:MQDLH_STRUC_ID;
                            Version:MQDLH_VERSION_1;
                            DestQName:#0;
                            DestQMgrName:#0;
                            Encoding:0;
                            CodedCharSetId:MQCCSI_UNDEFINED;
                            Format:(#0,#0,#0,#0,#0,#0,#0,#0);
                            PutApplType:0;
                            PutApplName:#0;
                            PutDate:#0;
                            PutTime:#0;
                           );
  MQIIH_DEFAULT : MQIIH  = (StrucId:MQIIH_STRUC_ID;
                            Version:MQIIH_VERSION_1;
                            StrucLength:MQIIH_LENGTH_1;
                            Encoding:0;
                            CodedCharSetId:0;
                            Format:(#0,#0,#0,#0,#0,#0,#0,#0);
                            Flags:MQIIH_NONE;
                            LTermOverride:'        ';
                            MFSMapName:'        ';
                            ReplyToFormat:MQFMT_NONE;
                            Authenticator:'        ';
                            TranInstanceId:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                            TranState:MQITS_NOT_IN_CONVERSATION;
                            CommitMode:MQICM_COMMIT_THEN_SEND;
                            SecurityScope:MQISS_CHECK;
                            Reserved:' ';
                           );
  MQCIH_DEFAULT : MQCIH =  (StrucId:MQCIH_STRUC_ID;
                            Version:MQCIH_VERSION_2;
                            StrucLength:MQCIH_LENGTH_2;
                            Encoding:0;
                            CodedCharSetId:0;
                            Format:(#0,#0,#0,#0,#0,#0,#0,#0);
                            Flags:MQCIH_NONE;
                            ReturnCode:MQCRC_OK;
                            CompCode:MQCC_OK;
                            Reason:MQRC_NONE;
                            UOWControl:MQCUOWC_ONLY;
                            GetWaitInterval:MQCGWI_DEFAULT;
                            LinkType:MQCLT_PROGRAM;
                            OutputDataLength:MQCODL_AS_INPUT;
                            FacilityKeepTime:0;
                            ADSDescriptor:MQCADSD_NONE;
                            ConversationalTask:MQCCT_NO;
                            TaskEndStatus:MQCTES_NOSYNC;
                            Facility:(#0,#0,#0,#0,#0,#0,#0,#0);
                            Func:MQCFUNC_NONE;
                            AbendCode:'    ';
                            Authenticator:'        ';
                            Reserved1:'        ';
                            ReplyToFormat:MQFMT_NONE;
                            RemoteSysId:'    ';
                            RemoteTransId:'    ';
                            TransactionId:'    ';
                            FacilityLike:'    ';
                            AttentionId:'    ';
                            StartCode:MQCSC_NONE;
                            CancelCode:'    ';
                            NextTransactionId:'    ';
                            Reserved2:'        ';
                            Reserved3:'        ';
                            CursorPosition:0;
                            ErrorOffset:0;
                            InputItem:0;
                            Reserved4:0;
                           );
  MQDH_DEFAULT : MQDH    = (StrucId:MQDH_STRUC_ID;
                            Version:MQDH_VERSION_1;
                            StrucLength:0;
                            Encoding:0;
                            CodedCharSetId:MQCCSI_UNDEFINED;
                            Format:(#0,#0,#0,#0,#0,#0,#0,#0);
                            Flags:MQDHF_NONE;
                            PutMsgRecFields:MQPMRF_NONE;
                            RecsPresent:0;
                            ObjectRecOffset:0;
                            PutMsgRecOffset:0;
                           );
  MQOR_DEFAULT : MQOR    = (ObjectName:#0;
                             ObjectQMgrName:#0;
                           );
  MQRMH_DEFAULT : MQRMH  = (StrucId:MQRMH_STRUC_ID;
                            Version:MQRMH_VERSION_1;
                            StrucLength:0;
                            Encoding:MQENC_NATIVE;
                            CodedCharSetId:MQCCSI_UNDEFINED;
                            Format:(#0,#0,#0,#0,#0,#0,#0,#0);
                            Flags:MQRMHF_NOT_LAST;
                            ObjectType:'        ';
                            ObjectInstanceId:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                            SrcEnvLength:0;
                            SrcEnvOffset:0;
                            SrcNameLength:0;
                            SrcNameOffset:0;
                            DestEnvLength:0;
                            DestEnvOffset:0;
                            DestNameLength:0;
                            DestNameOffset:0;
                            DataLogicalLength:0;
                            DataLogicalOffset:0;
                            DataLogicalOffset2:0;
                           );

  MQSD_DEFAULT : MQSD    = ( StrucId             : MQSD_STRUC_ID_ARRAY ;
                             Version             : MQSD_VERSION_1 ;
                             Options             : 0 ;
                             ObjectName          : #0 ;
                             AlternateUserId     : #0 ;
                             AlternateSecurityId : ($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0) ;
                             SubExpiry           : MQEI_UNLIMITED ;
                             ObjectString        : ( VSPtr:nil ; VSOffset:$0 ; VSBufSize:$0 ; VSLength:$0 ; VSCCSID:MQCCSI_APPL ; ) ;  // MQCHARV_DEFAULT
                             SubName             : ( VSPtr:nil ; VSOffset:$0 ; VSBufSize:$0 ; VSLength:$0 ; VSCCSID:MQCCSI_APPL ; ) ;  // MQCHARV_DEFAULT
                             SubUserData         : ( VSPtr:nil ; VSOffset:$0 ; VSBufSize:$0 ; VSLength:$0 ; VSCCSID:MQCCSI_APPL ; ) ;  // MQCHARV_DEFAULT
                             SubCorrelId         : ($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0) ;
                             PubPriority         : MQPRI_PRIORITY_AS_PUBLISHED ;
                             PubAccountingToken  : ($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0) ;
                             PubApplIdentityData : #0 ;
                             SelectionString     : ( VSPtr:nil ; VSOffset:$0 ; VSBufSize:$0 ; VSLength:$0 ; VSCCSID:MQCCSI_APPL ; ) ;  // MQCHARV_DEFAULT
                             SubLevel            : 1 ;
                             ResObjectString     : ( VSPtr:nil ; VSOffset:$0 ; VSBufSize:$0 ; VSLength:$0 ; VSCCSID:MQCCSI_APPL ; ) ;  // MQCHARV_DEFAULT
                           ) ; // sag, 20130316.

  MQTM_DEFAULT : MQTM    = (StrucId:MQTM_STRUC_ID;
                            Version:MQTM_VERSION_1;
                            QName:#0;
                            ProcessName:#0;
                            TriggerData:#0;
                            ApplType:0;
                            ApplId:#0;
                            EnvData:#0;
                            UserData:#0;
                           );
  MQTMC2_DEFAULT : MQTMC2 = (StrucId:MQTMC_STRUC_ID;
                             Version:MQTMC_VERSION_2;
                             QName:#0;
                             ProcessName:#0;
                             TriggerData:#0;
                             ApplType:0;
                             ApplId:#0;
                             EnvData:#0;
                             UserData:#0;
                             QMgrName:#0;
                            );
  MQWIH_DEFAULT : MQWIH  = (StrucId:MQWIH_STRUC_ID;
                            Version:MQWIH_VERSION_1;
                            StrucLength:MQWIH_LENGTH_1;
                            Encoding:0;
                            CodedCharSetId:MQCCSI_UNDEFINED;
                            Format:(#0,#0,#0,#0,#0,#0,#0,#0);
                            Flags:MQWIH_NONE;
                            ServiceName:'                                ';
                            ServiceStep:'        ';
                            MsgToken:($0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
                            Reserved:'                                ';
                           );

  procedure MQCONN ( pQMgrName: PMQCHAR48; pHConn: PMQHCONN; pCompcode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQCONNX( pQMgrName: PMQCHAR48; pConnectOpts: PMQCNO; pHconn: PMQHCONN; pCompcode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQDISC ( pHConn: PMQHCONN; pCompcode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQOPEN ( HConn: MQHCONN; pObjDesc: PMQVOID; Options: MQLONG; pHobj: PMQHOBJ; pCompCode, pReason: PMQLONG ); cdecl; external 'mqm.DLL' ;
  procedure MQCLOSE( HConn: MQHCONN; pHObj: PMQHOBJ; Options: MQLONG; pCompcode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQPUT  ( HConn: MQHCONN; HObj: MQHOBJ; pMsgDesc: PMQVOID; pPutMsgOptions: PMQVOID; BufferLength: MQLONG; pBuffer: PMQVOID; pCompCode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQGET  ( Hconn: MQHCONN; HObj: MQHOBJ; pMsgDesc: PMQVOID; pGetMsgOptions: PMQVOID; BufferLength: MQLONG; pBuffer: PMQVOID; pDataLength: PMQLONG; pCompCode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQPUT1 ( Hconn: MQHCONN; pObjDesc: PMQVOID; pMsgDesc: PMQVOID; pPutMsgOptions: PMQVOID; BufferLength: MQLONG; pBuffer: PMQVOID; pCompCode, pReason: PMQLONG); cdecl; external 'mqm.DLL' ;
  procedure MQINQ  ( Hconn: MQHCONN; HObj: MQHOBJ; SelectorCount: MQLONG; pSelectors: PMQLONG; IntAttrCount: MQLONG; pIntAttrs: PMQLONG; CharAttrLength: MQLONG; pCharAttrs: PMQCHAR; pCompCode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQSET  ( Hconn: MQHCONN; HObj: MQHOBJ; SelectorCount: MQLONG; pSelectors: PMQLONG; IntAttrCount: MQLONG; pIntAttrs: PMQLONG; CharAttrLength: MQLONG; pCharAttrs: PMQCHAR; pCompCode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQBEGIN( Hconn: MQHCONN; pBeginOptions: PMQVOID; pCompCode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQBACK ( Hconn: MQHCONN; pCompCode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;
  procedure MQCMIT ( Hconn: MQHCONN; pCompCode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;

{ +++ SAG, Jul-2006 }

  procedure mqAddBag ( Bag: MQHBAG; Selector: MQLONG; ItemValue: MQHBAG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqAddByteString ( Bag: MQHBAG; Selector: MQLONG; BufferLength: MQLONG; pBuffer: PMQBYTE; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqAddByteStringFilter ( Bag: MQHBAG; Selector: MQLONG; BufferLength: MQLONG; pBuffer: PMQBYTE; Operator: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqAddInquiry ( Bag: MQHBAG; Selector: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqAddInteger ( Bag: MQHBAG; Selector: MQLONG; ItemValue: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqAddInteger64 ( Bag: MQHBAG; Selector: MQLONG; ItemValue: MQINT64; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqAddIntegerFilter ( Bag: MQHBAG; Selector: MQLONG; ItemValue: MQLONG; Operator: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqAddString ( Bag: MQHBAG; Selector: MQLONG; BufferLength: MQLONG; pBuffer: PMQCHAR; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqAddStringFilter ( Bag: MQHBAG; Selector: MQLONG; BufferLength: MQLONG; pBuffer: PMQCHAR; Operator: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqBagToBuffer ( OptionsBag: MQHBAG; DataBag: MQHBAG; BufferLength: MQLONG; pBuffer: PChar; pDataLength: PMQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqBufferToBag ( OptionsBag: MQHBAG; BufferLength: MQLONG; pBuffer: PChar; DataBag: MQHBAG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqClearBag ( Bag: MQHBAG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqCountItems ( Bag: MQHBAG; Selector: MQLONG; pItemCount: PMQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqCreateBag ( Options: MQLONG; pBag: PMQHBAG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqDeleteBag ( pBag: PMQHBAG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqDeleteItem ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqExecute ( Hconn: MQHCONN; Command: MQLONG; OptionsBag: MQHBAG; AdminBag: MQHBAG; ResponseBag: MQHBAG; AdminQ: MQHOBJ; ResponseQ: MQHOBJ; pCompCode, pReason: PMQLONG);cdecl;external 'mqm.DLL';
  procedure mqGetBag ( Hconn: MQHCONN; Hobj: MQHOBJ; pMsgDesc: PMQMD; pGetMsgOpts: PMQGMO; Bag: MQHBAG; pCompCode, pReason: PMQLONG);cdecl;external 'mqm.DLL';
  procedure mqInquireBag ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; pItemValue: PMQHBAG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqInquireByteString ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; BufferLength: MQLONG; pBuffer: PMQBYTE; pByteStringLength: PMQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqInquireByteStringFilter ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; BufferLength: MQLONG; pBuffer: PMQBYTE; pByteStringLength: PMQLONG; pOperator: PMQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqInquireInteger ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; pItemValue: PMQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqInquireInteger64 ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; pItemValue: PMQINT64; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqInquireIntegerFilter ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; pItemValue: PMQLONG; pOperator: PMQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqInquireItemInfo ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; pOutSelector: PMQLONG; pItemType: PMQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqInquireString ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; BufferLength: MQLONG; pBuffer: PMQCHAR; pStringLength: PMQLONG; pCodedCharSetId: PMQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqInquireStringFilter (Bag:MQHBAG; Selector:MQLONG; ItemIndex:MQLONG; BufferLength:MQLONG; pBuffer:PMQCHAR; pStringLength:PMQLONG; pCodedCharSetId:PMQLONG; pOperator:PMQLONG; pCompCode,pReason:PMQLONG);cdecl;external'mqm.DLL';
  procedure mqPad ( pString: PMQCHAR; BufferLength: MQLONG; pBuffer: PMQCHAR; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqPutBag ( Hconn: MQHCONN; Hobj: MQHOBJ; pMsgDesc: PMQMD; pPutMsgOpts: PMQPMO; Bag: MQHBAG; pCompCode, pReason: PMQLONG);cdecl;external 'mqm.DLL';
  procedure mqSetByteString ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; BufferLength: MQLONG; pBuffer: PMQBYTE; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqSetByteStringFilter ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; BufferLength: MQLONG; pBuffer: PMQBYTE; Operator: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqSetInteger ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; ItemValue: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqSetInteger64 ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; ItemValue: MQINT64; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqSetIntegerFilter ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; ItemValue: MQLONG; Operator: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqSetString ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; BufferLength: MQLONG; pBuffer: PMQCHAR; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqSetStringFilter ( Bag: MQHBAG; Selector: MQLONG; ItemIndex: MQLONG; BufferLength: MQLONG; pBuffer: PMQCHAR; Operator: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqTrim ( BufferLength: MQLONG; pBuffer: PMQCHAR; pString: PMQCHAR; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;
  procedure mqTruncateBag ( Bag: MQHBAG; ItemCount: MQLONG; pCompCode, pReason: PMQLONG ) ; cdecl ; external 'mqm.DLL' ;

{ --- SAG, Oct-2006 }

{ +++ SAG, 2013-Mar : include MQSUB() - complementary is "mqput()" to a topic }

  procedure MQSUB ( Hconn: MQHCONN; pSubDesc: PMQVOID; pHobj: PMQHOBJ; pHsub: PMQHOBJ; pCompCode, pReason: PMQLONG ) ; cdecl; external 'mqm.DLL' ;

{ --- SAG, 2013-Mar : include MQSUB() }

implementation

end.
