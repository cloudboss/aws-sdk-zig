const FeatureEnableStatus = @import("feature_enable_status.zig").FeatureEnableStatus;

pub const SupportedEmailDomainsStatus = struct {
    allowed_domains: ?[]const []const u8 = null,

    enabled: ?FeatureEnableStatus = null,

    pub const json_field_names = .{
        .allowed_domains = "allowedDomains",
        .enabled = "enabled",
    };
};
