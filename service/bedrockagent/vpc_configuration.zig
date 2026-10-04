const VpcProtocol = @import("vpc_protocol.zig").VpcProtocol;
const VpcResolutionMode = @import("vpc_resolution_mode.zig").VpcResolutionMode;
const VpcConfigurationStatus = @import("vpc_configuration_status.zig").VpcConfigurationStatus;

/// Contains the details of a VPC configuration, including its connection
/// settings, resolution mode, and current lifecycle status.
pub const VpcConfiguration = struct {
    /// The time at which the VPC configuration was created.
    created_at: i64,

    /// The description of the VPC configuration, if provided.
    description: ?[]const u8 = null,

    /// The HTTP `Host` header value sent when invoking the resource, if configured.
    host_header: ?[]const u8 = null,

    /// The human-readable name of the VPC configuration, if provided.
    name: ?[]const u8 = null,

    /// The port on which the resource is reached.
    port: i32,

    /// The protocol used to connect to the resource.
    protocol: VpcProtocol,

    /// Specifies how the resource target is resolved.
    resolution_mode: VpcResolutionMode,

    /// The private IPv4 address or DNS name of the resource.
    resource_target: []const u8,

    /// The current lifecycle status of the VPC configuration.
    status: VpcConfigurationStatus,

    /// Additional detail about the current status, such as the cause of a
    /// `CREATE_FAILED` or `DELETE_FAILED` status.
    status_message: ?[]const u8 = null,

    /// The subnets that the knowledge base uses to connect to the resource.
    subnet_ids: []const []const u8,

    /// The expected TLS server name that the service matches against the Subject
    /// Alternative Names on the resource's TLS certificate. Present when `protocol`
    /// is `HTTPS`.
    tls_server_name: ?[]const u8 = null,

    /// The time at which the VPC configuration was last updated.
    updated_at: i64,

    /// The unique identifier of the VPC configuration.
    vpc_configuration_id: []const u8,

    /// The identifier of the VPC that the knowledge base connects through to reach
    /// the resource.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .host_header = "hostHeader",
        .name = "name",
        .port = "port",
        .protocol = "protocol",
        .resolution_mode = "resolutionMode",
        .resource_target = "resourceTarget",
        .status = "status",
        .status_message = "statusMessage",
        .subnet_ids = "subnetIds",
        .tls_server_name = "tlsServerName",
        .updated_at = "updatedAt",
        .vpc_configuration_id = "vpcConfigurationId",
        .vpc_id = "vpcId",
    };
};
