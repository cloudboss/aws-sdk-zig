/// An endpoint information details.
pub const Endpoint = struct {
    /// IP address of the endpoint.
    address: []const u8,

    /// Endpoint cache time to live (TTL) value.
    cache_period_in_minutes: i64,

    pub const json_field_names = .{
        .address = "Address",
        .cache_period_in_minutes = "CachePeriodInMinutes",
    };
};
