const DnsConfigChange = @import("dns_config_change.zig").DnsConfigChange;
const HealthCheckConfig = @import("health_check_config.zig").HealthCheckConfig;

/// A complex type that contains changes to an existing service.
pub const ServiceChange = struct {
    /// A description for the service.
    description: ?[]const u8 = null,

    /// Information about the Route 53 DNS records that you want Cloud Map to create
    /// when you register
    /// an instance.
    dns_config: ?DnsConfigChange = null,

    /// *Public DNS and HTTP namespaces only.* Settings for an optional health
    /// check. If you specify settings for a health check, Cloud Map associates the
    /// health check with
    /// the records that you specify in `DnsConfig`.
    health_check_config: ?HealthCheckConfig = null,

    pub const json_field_names = .{
        .description = "Description",
        .dns_config = "DnsConfig",
        .health_check_config = "HealthCheckConfig",
    };
};
