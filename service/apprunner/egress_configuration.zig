const EgressType = @import("egress_type.zig").EgressType;

/// Describes configuration settings related to outbound network traffic of an
/// App Runner service.
pub const EgressConfiguration = struct {
    /// The type of egress configuration.
    ///
    /// Set to `DEFAULT` for access to resources hosted on public networks.
    ///
    /// Set to `VPC` to associate your service to a custom VPC specified by
    /// `VpcConnectorArn`.
    egress_type: ?EgressType,

    /// The Amazon Resource Name (ARN) of the App Runner VPC connector that you want
    /// to associate with your App Runner service. Only valid when `EgressType =
    /// VPC`.
    vpc_connector_arn: ?[]const u8,

    pub const json_field_names = .{
        .egress_type = "EgressType",
        .vpc_connector_arn = "VpcConnectorArn",
    };
};
