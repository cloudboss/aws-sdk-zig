const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;

/// Contains summary information about an S3 Table integration for listing
/// operations.
pub const IntegrationSummary = struct {
    /// The Amazon Resource Name (ARN) of the S3 Table integration.
    arn: ?[]const u8 = null,

    /// The current status of the S3 Table integration.
    status: ?IntegrationStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .status = "Status",
    };
};
