const ACMManaged = @import("acm_managed.zig").ACMManaged;
const None = @import("none.zig").None;

/// Represents an endpoint configuration.
pub const EndpointConfigurationRequest = struct {
    /// Represents a domain name and certificate for a portal.
    acm_managed: ?ACMManaged,

    /// Use the default portal domain name that is generated and managed by API
    /// Gateway.
    none: ?None,

    pub const json_field_names = .{
        .acm_managed = "AcmManaged",
        .none = "None",
    };
};
