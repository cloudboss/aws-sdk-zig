const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const Scheme = @import("scheme.zig").Scheme;

/// Filter criteria specific to Application Load Balancers.
pub const AlbConfiguration = struct {
    /// The IP address type of the Application Load Balancer.
    ip_address_type: ?IpAddressType = null,

    /// The scheme of the Application Load Balancer, either `internet-facing` or
    /// `internal`.
    scheme: ?Scheme = null,

    pub const json_field_names = .{
        .ip_address_type = "ipAddressType",
        .scheme = "scheme",
    };
};
