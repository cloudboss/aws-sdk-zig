const ExpressGatewayServiceStatus = @import("express_gateway_service_status.zig").ExpressGatewayServiceStatus;
const ExpressGatewayServiceConfiguration = @import("express_gateway_service_configuration.zig").ExpressGatewayServiceConfiguration;

/// An object that describes an Express service to be updated.
pub const UpdatedExpressGatewayService = struct {
    /// The cluster associated with the Express service that is being updated.
    cluster: ?[]const u8,

    /// The Unix timestamp for when the Express service that is being updated was
    /// created.
    created_at: ?i64,

    /// The ARN of the Express service that is being updated.
    service_arn: ?[]const u8,

    /// The name of the Express service that is being updated.
    service_name: ?[]const u8,

    /// The status of the Express service that is being updated.
    status: ?ExpressGatewayServiceStatus,

    /// The configuration to which the current Express service is being updated to.
    target_configuration: ?ExpressGatewayServiceConfiguration,

    /// The Unix timestamp for when the Express service that is being updated was
    /// most recently updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .cluster = "cluster",
        .created_at = "createdAt",
        .service_arn = "serviceArn",
        .service_name = "serviceName",
        .status = "status",
        .target_configuration = "targetConfiguration",
        .updated_at = "updatedAt",
    };
};
