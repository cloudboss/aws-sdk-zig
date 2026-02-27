const SecurityConfiguration = @import("security_configuration.zig").SecurityConfiguration;

pub const DescribeSecurityConfigurationResponse = struct {
    /// Details of the security configuration.
    security_configuration: ?SecurityConfiguration,

    pub const json_field_names = .{
        .security_configuration = "securityConfiguration",
    };
};
