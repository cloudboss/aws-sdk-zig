/// The type of log file. Can be one of the following:
///
/// * **INDEX_SLOW_LOGS** - Index slow logs contain
/// insert requests that took more time than the configured index query log
/// threshold to execute.
///
/// * **SEARCH_SLOW_LOGS** - Search slow logs contain
/// search queries that took more time than the configured search query log
/// threshold to execute.
///
/// * **ES_APPLICATION_LOGS** - OpenSearch application
/// logs contain information about errors and warnings raised during the
/// operation
/// of the service and can be useful for troubleshooting.
///
/// * **AUDIT_LOGS** - Audit logs contain records of
/// user requests for access to the domain.
pub const LogType = enum {
    index_slow_logs,
    search_slow_logs,
    es_application_logs,
    audit_logs,

    pub const json_field_names = .{
        .index_slow_logs = "INDEX_SLOW_LOGS",
        .search_slow_logs = "SEARCH_SLOW_LOGS",
        .es_application_logs = "ES_APPLICATION_LOGS",
        .audit_logs = "AUDIT_LOGS",
    };
};
