const LicenseServerEndpointProvisioningStatus = @import("license_server_endpoint_provisioning_status.zig").LicenseServerEndpointProvisioningStatus;
const LicenseServer = @import("license_server.zig").LicenseServer;
const ServerEndpoint = @import("server_endpoint.zig").ServerEndpoint;
const ServerType = @import("server_type.zig").ServerType;

/// Contains details about a network endpoint for a Remote Desktop Services
/// (RDS) license server.
pub const LicenseServerEndpoint = struct {
    /// The timestamp when License Manager created the license server endpoint.
    creation_time: ?i64,

    /// The Amazon Resource Name (ARN) of the identity provider that's associated
    /// with the RDS license server endpoint.
    identity_provider_arn: ?[]const u8,

    /// The ARN of the `ServerEndpoint` resource for the RDS license server.
    license_server_endpoint_arn: ?[]const u8,

    /// The ID of the license server endpoint.
    license_server_endpoint_id: ?[]const u8,

    /// The current state of the provisioning process for the RDS license server
    /// endpoint
    license_server_endpoint_provisioning_status: ?LicenseServerEndpointProvisioningStatus,

    /// An array of `LicenseServer` resources that represent the license servers
    /// that are accessed through this endpoint.
    license_servers: ?[]const LicenseServer,

    /// The `ServerEndpoint` resource contains the network address of the RDS
    /// license server endpoint.
    server_endpoint: ?ServerEndpoint,

    /// The type of license server.
    server_type: ?ServerType,

    /// The message associated with the provisioning status, if there is one.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .identity_provider_arn = "IdentityProviderArn",
        .license_server_endpoint_arn = "LicenseServerEndpointArn",
        .license_server_endpoint_id = "LicenseServerEndpointId",
        .license_server_endpoint_provisioning_status = "LicenseServerEndpointProvisioningStatus",
        .license_servers = "LicenseServers",
        .server_endpoint = "ServerEndpoint",
        .server_type = "ServerType",
        .status_message = "StatusMessage",
    };
};
