const AthenaIntegration = @import("athena_integration.zig").AthenaIntegration;

/// Describes service integrations with VPC Flow logs.
pub const IntegrateServices = struct {
    /// Information about the integration with Amazon Athena.
    athena_integrations: ?[]const AthenaIntegration = null,
};
