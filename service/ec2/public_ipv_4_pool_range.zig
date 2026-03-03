/// Describes an address range of an IPv4 address pool.
pub const PublicIpv4PoolRange = struct {
    /// The number of addresses in the range.
    address_count: ?i32 = null,

    /// The number of available addresses in the range.
    available_address_count: ?i32 = null,

    /// The first IP address in the range.
    first_address: ?[]const u8 = null,

    /// The last IP address in the range.
    last_address: ?[]const u8 = null,
};
