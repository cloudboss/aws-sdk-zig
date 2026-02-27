const FeatureEnableParameter = @import("feature_enable_parameter.zig").FeatureEnableParameter;

pub const SupportedEmailDomainsParameters = struct {
    allowed_domains: ?[]const []const u8,

    enabled: ?FeatureEnableParameter,

    pub const json_field_names = .{
        .allowed_domains = "allowedDomains",
        .enabled = "enabled",
    };
};
