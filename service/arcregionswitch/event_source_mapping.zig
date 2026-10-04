/// The Amazon Web Services Lambda event source mapping configuration,
/// containing the resource ARN and optional cross-account configuration.
pub const EventSourceMapping = struct {
    /// The Amazon Resource Name (ARN) of the Lambda event source mapping.
    arn: []const u8,

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
    };
};
