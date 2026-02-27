const InvalidConfigurationDetail = @import("invalid_configuration_detail.zig").InvalidConfigurationDetail;

/// Detailed information about the input that failed to satisfy the constraints
/// specified by
/// a call.
pub const BadRequestDetails = union(enum) {
    /// Detailed information about the bad request exception error when creating a
    /// hosted
    /// configuration version.
    invalid_configuration: ?[]const InvalidConfigurationDetail,

    pub const json_field_names = .{
        .invalid_configuration = "InvalidConfiguration",
    };
};
