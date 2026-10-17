const NetworkAccessConfiguration = @import("network_access_configuration.zig").NetworkAccessConfiguration;

/// Configuration for a release management environment.
pub const ReleaseManagementConfiguration = struct {
    /// The name for this release management environment.
    name: []const u8,

    /// Specifies how AWS DevOps Agent reaches your application using a Release
    /// Management Environment
    network_access: NetworkAccessConfiguration,

    pub const json_field_names = .{
        .name = "name",
        .network_access = "networkAccess",
    };
};
