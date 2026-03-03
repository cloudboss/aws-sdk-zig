const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;

/// The encryption configuration details that include the status information of
/// the Key Management Service (KMS) key and the KMS access role.
pub const ConfigurationDetails = struct {
    /// The health status of KMS key and KMS access role. If either KMS key or KMS
    /// access role
    /// is `UNHEALTHY`, the return value will be `UNHEALTHY`. To use a
    /// customer managed KMS key, the value of `configurationStatus` must be
    /// `HEALTHY`.
    configuration_status: ?ConfigurationStatus = null,

    /// The error code that indicates either the KMS key or the KMS access role is
    /// `UNHEALTHY`.
    /// Valid values: `KMS_KEY_VALIDATION_ERROR` and `ROLE_VALIDATION_ERROR`.
    error_code: ?[]const u8 = null,

    /// The detailed error message that corresponds to the `errorCode`.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_status = "configurationStatus",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
