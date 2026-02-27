const aws = @import("aws");

const ContainerProvider = @import("container_provider.zig").ContainerProvider;
const SecurityConfigurationData = @import("security_configuration_data.zig").SecurityConfigurationData;

pub const CreateSecurityConfigurationRequest = struct {
    /// The client idempotency token to use when creating the security
    /// configuration.
    client_token: []const u8,

    /// The container provider associated with the security configuration.
    container_provider: ?ContainerProvider,

    /// The name of the security configuration.
    name: []const u8,

    /// Security configuration input for the request.
    security_configuration_data: SecurityConfigurationData,

    /// The tags to add to the security configuration.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .container_provider = "containerProvider",
        .name = "name",
        .security_configuration_data = "securityConfigurationData",
        .tags = "tags",
    };
};
