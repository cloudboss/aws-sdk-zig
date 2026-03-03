/// Detailed information about the bad request exception error when creating a
/// hosted
/// configuration version.
pub const InvalidConfigurationDetail = struct {
    /// The invalid or out-of-range validation constraint in your JSON schema that
    /// failed
    /// validation.
    constraint: ?[]const u8 = null,

    /// Location of the validation constraint in the configuration JSON schema that
    /// failed
    /// validation.
    location: ?[]const u8 = null,

    /// The reason for an invalid configuration error.
    reason: ?[]const u8 = null,

    /// The type of error for an invalid configuration.
    @"type": ?[]const u8 = null,

    /// Details about an error with Lambda when a synchronous extension
    /// experiences an error during an invocation.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .constraint = "Constraint",
        .location = "Location",
        .reason = "Reason",
        .@"type" = "Type",
        .value = "Value",
    };
};
