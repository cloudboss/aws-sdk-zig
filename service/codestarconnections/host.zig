const ProviderType = @import("provider_type.zig").ProviderType;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// A resource that represents the infrastructure where a third-party provider
/// is installed.
/// The host is used when you create connections to an installed third-party
/// provider type, such
/// as GitHub Enterprise Server. You create one host for all connections to that
/// provider.
///
/// A host created through the CLI or the SDK is in `PENDING` status by
/// default. You can make its status `AVAILABLE` by setting up the host in the
/// console.
pub const Host = struct {
    /// The Amazon Resource Name (ARN) of the host.
    host_arn: ?[]const u8,

    /// The name of the host.
    name: ?[]const u8,

    /// The endpoint of the infrastructure where your provider type is installed.
    provider_endpoint: ?[]const u8,

    /// The name of the installed provider to be associated with your connection.
    /// The host
    /// resource represents the infrastructure where your provider type is
    /// installed. The valid
    /// provider type is GitHub Enterprise Server.
    provider_type: ?ProviderType,

    /// The status of the host, such as PENDING, AVAILABLE, VPC_CONFIG_DELETING,
    /// VPC_CONFIG_INITIALIZING, and VPC_CONFIG_FAILED_INITIALIZATION.
    status: ?[]const u8,

    /// The status description for the host.
    status_message: ?[]const u8,

    /// The VPC configuration provisioned for the host.
    vpc_configuration: ?VpcConfiguration,

    pub const json_field_names = .{
        .host_arn = "HostArn",
        .name = "Name",
        .provider_endpoint = "ProviderEndpoint",
        .provider_type = "ProviderType",
        .status = "Status",
        .status_message = "StatusMessage",
        .vpc_configuration = "VpcConfiguration",
    };
};
