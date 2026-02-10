/// Information about a customer-owned IP address range.
pub const CoipCidr = struct {
    /// An address range in a customer-owned IP address space.
    cidr: ?[]const u8,

    /// The ID of the address pool.
    coip_pool_id: ?[]const u8,

    /// The ID of the local gateway route table.
    local_gateway_route_table_id: ?[]const u8,
};
