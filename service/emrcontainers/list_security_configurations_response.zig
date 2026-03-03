const SecurityConfiguration = @import("security_configuration.zig").SecurityConfiguration;

pub const ListSecurityConfigurationsResponse = struct {
    /// The token for the next set of security configurations to return.
    next_token: ?[]const u8 = null,

    /// The list of returned security configurations.
    security_configurations: ?[]const SecurityConfiguration = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .security_configurations = "securityConfigurations",
    };
};
