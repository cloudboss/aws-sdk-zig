pub const VerificationError = enum {
    service_error,
    dns_server_error,
    host_not_found,
    type_not_found,
    invalid_value,
    replication_access_denied,
    replication_primary_not_found,
    replication_primary_byo_dkim_not_supported,
    replication_replica_as_primary_not_supported,
    replication_primary_invalid_region,

    pub const json_field_names = .{
        .service_error = "SERVICE_ERROR",
        .dns_server_error = "DNS_SERVER_ERROR",
        .host_not_found = "HOST_NOT_FOUND",
        .type_not_found = "TYPE_NOT_FOUND",
        .invalid_value = "INVALID_VALUE",
        .replication_access_denied = "REPLICATION_ACCESS_DENIED",
        .replication_primary_not_found = "REPLICATION_PRIMARY_NOT_FOUND",
        .replication_primary_byo_dkim_not_supported = "REPLICATION_PRIMARY_BYO_DKIM_NOT_SUPPORTED",
        .replication_replica_as_primary_not_supported = "REPLICATION_REPLICA_AS_PRIMARY_NOT_SUPPORTED",
        .replication_primary_invalid_region = "REPLICATION_PRIMARY_INVALID_REGION",
    };
};
