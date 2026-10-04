const IpAddressDetail = @import("ip_address_detail.zig").IpAddressDetail;
const IpAddressFamily = @import("ip_address_family.zig").IpAddressFamily;

/// A complex type for the set of IP addresses for an accelerator.
pub const IpSet = struct {
    /// The array of IP addresses in the IP address set, with detailed information
    /// about the IP addresses.
    /// An IP address set can have a maximum of two IP addresses.
    ip_address_details: ?[]const IpAddressDetail = null,

    /// The array of IP addresses in the IP address set. An IP address set can have
    /// a maximum of two IP addresses.
    ip_addresses: ?[]const []const u8 = null,

    /// The types of IP addresses included in this IP set.
    ip_address_family: ?IpAddressFamily = null,

    /// IpFamily is deprecated and has been replaced by IpAddressFamily.
    ip_family: ?[]const u8 = null,

    pub const json_field_names = .{
        .ip_address_details = "IpAddressDetails",
        .ip_addresses = "IpAddresses",
        .ip_address_family = "IpAddressFamily",
        .ip_family = "IpFamily",
    };
};
