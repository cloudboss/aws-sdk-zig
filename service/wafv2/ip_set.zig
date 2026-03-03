const IPAddressVersion = @import("ip_address_version.zig").IPAddressVersion;

/// Contains zero or more IP addresses or blocks of IP addresses specified in
/// Classless
/// Inter-Domain Routing (CIDR) notation. WAF supports all IPv4 and IPv6 CIDR
/// ranges
/// except for /0. For information about CIDR notation, see the Wikipedia entry
/// [Classless
/// Inter-Domain
/// Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
///
/// WAF assigns an ARN to each `IPSet` that you create. To use an IP set in a
/// rule, you provide the ARN to the Rule statement IPSetReferenceStatement.
pub const IPSet = struct {
    /// Contains an array of strings that specifies zero or more IP addresses or
    /// blocks of IP addresses that you want WAF to inspect for in incoming
    /// requests. All addresses must be specified using Classless Inter-Domain
    /// Routing (CIDR) notation. WAF supports all IPv4 and IPv6 CIDR ranges except
    /// for `/0`.
    ///
    /// Example address strings:
    ///
    /// * For requests that originated from the IP address 192.0.2.44, specify
    ///   `192.0.2.44/32`.
    ///
    /// * For requests that originated from IP addresses from 192.0.2.0 to
    ///   192.0.2.255, specify
    /// `192.0.2.0/24`.
    ///
    /// * For requests that originated from the IP address
    ///   1111:0000:0000:0000:0000:0000:0000:0111, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0111/128`.
    ///
    /// * For requests that originated from IP addresses
    ///   1111:0000:0000:0000:0000:0000:0000:0000 to
    ///   1111:0000:0000:0000:ffff:ffff:ffff:ffff, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0000/64`.
    ///
    /// For more information about CIDR notation, see the Wikipedia entry [Classless
    /// Inter-Domain
    /// Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    ///
    /// Example JSON `Addresses` specifications:
    ///
    /// * Empty array: `"Addresses": []`
    ///
    /// * Array with one address: `"Addresses": ["192.0.2.44/32"]`
    ///
    /// * Array with three addresses: `"Addresses": ["192.0.2.44/32",
    ///   "192.0.2.0/24", "192.0.0.0/16"]`
    ///
    /// * INVALID specification: `"Addresses": [""]` INVALID
    addresses: []const []const u8,

    /// The Amazon Resource Name (ARN) of the entity.
    arn: []const u8,

    /// A description of the IP set that helps with identification.
    description: ?[]const u8 = null,

    /// A unique identifier for the set. This ID is returned in the responses to
    /// create and list commands. You provide it to operations like update and
    /// delete.
    id: []const u8,

    /// The version of the IP addresses, either `IPV4` or `IPV6`.
    ip_address_version: IPAddressVersion,

    /// The name of the IP set. You cannot change the name of an `IPSet` after you
    /// create it.
    name: []const u8,

    pub const json_field_names = .{
        .addresses = "Addresses",
        .arn = "ARN",
        .description = "Description",
        .id = "Id",
        .ip_address_version = "IPAddressVersion",
        .name = "Name",
    };
};
