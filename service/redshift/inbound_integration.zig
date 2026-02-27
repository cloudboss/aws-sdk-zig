const IntegrationError = @import("integration_error.zig").IntegrationError;
const ZeroETLIntegrationStatus = @import("zero_etl_integration_status.zig").ZeroETLIntegrationStatus;

/// The content of an inbound integration.
pub const InboundIntegration = struct {
    /// The creation time of an inbound integration.
    create_time: ?i64,

    /// The outstanding errors of an inbound integration. Each item is an
    /// "IntegrationError". This is null if there is no error.
    errors: ?[]const IntegrationError,

    /// The Amazon Resource Name (ARN) of an inbound integration.
    integration_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the source of an inbound integration.
    source_arn: ?[]const u8,

    /// The status of an inbound integration.
    status: ?ZeroETLIntegrationStatus,

    /// The Amazon Resource Name (ARN) of the target of an inbound integration.
    target_arn: ?[]const u8,
};
