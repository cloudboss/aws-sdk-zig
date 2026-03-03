const DisplayData = @import("display_data.zig").DisplayData;
const FederationProtocol = @import("federation_protocol.zig").FederationProtocol;
const ResourceServerConfig = @import("resource_server_config.zig").ResourceServerConfig;

/// A structure that describes a provider that can be used to connect an Amazon
/// Web Services managed application or customer managed application to IAM
/// Identity Center.
pub const ApplicationProvider = struct {
    /// The ARN of the application provider.
    application_provider_arn: []const u8,

    /// A structure that describes how IAM Identity Center represents the
    /// application provider in the portal.
    display_data: ?DisplayData = null,

    /// The protocol that the application provider uses to perform federation.
    federation_protocol: ?FederationProtocol = null,

    /// A structure that describes the application provider's resource server.
    resource_server_config: ?ResourceServerConfig = null,

    pub const json_field_names = .{
        .application_provider_arn = "ApplicationProviderArn",
        .display_data = "DisplayData",
        .federation_protocol = "FederationProtocol",
        .resource_server_config = "ResourceServerConfig",
    };
};
