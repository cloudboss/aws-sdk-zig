/// Information about a route filter prefix that a customer can advertise
/// through Border Gateway Protocol (BGP)
/// over a public virtual interface.
pub const RouteFilterPrefix = struct {
    /// The CIDR block for the advertised route. Separate multiple routes using
    /// commas. An IPv6 CIDR must use /64 or shorter.
    cidr: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr = "cidr",
    };
};
