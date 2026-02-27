pub const ValidationExceptionReason = enum {
    field_validation_failed,
    invalid_ca_subject,
    invalid_permission,
    invalid_state,
    mismatched_connector,
    mismatched_vpc,
    no_client_token,
    unknown_operation,
    other,

    pub const json_field_names = .{
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .invalid_ca_subject = "INVALID_CA_SUBJECT",
        .invalid_permission = "INVALID_PERMISSION",
        .invalid_state = "INVALID_STATE",
        .mismatched_connector = "MISMATCHED_CONNECTOR",
        .mismatched_vpc = "MISMATCHED_VPC",
        .no_client_token = "NO_CLIENT_TOKEN",
        .unknown_operation = "UNKNOWN_OPERATION",
        .other = "OTHER",
    };
};
