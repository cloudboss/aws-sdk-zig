const DnsProperties = @import("dns_properties.zig").DnsProperties;
const HttpProperties = @import("http_properties.zig").HttpProperties;

/// A complex type that contains information that's specific to the namespace
/// type.
pub const NamespaceProperties = struct {
    /// A complex type that contains the ID for the Route 53 hosted zone that Cloud
    /// Map creates when
    /// you create a namespace.
    dns_properties: ?DnsProperties,

    /// A complex type that contains the name of an HTTP namespace.
    http_properties: ?HttpProperties,

    pub const json_field_names = .{
        .dns_properties = "DnsProperties",
        .http_properties = "HttpProperties",
    };
};
