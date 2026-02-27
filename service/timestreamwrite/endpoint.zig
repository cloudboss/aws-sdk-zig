/// Represents an available endpoint against which to make API calls against, as
/// well as the
/// TTL for that endpoint.
pub const Endpoint = struct {
    /// An endpoint address.
    address: []const u8,

    /// The TTL for the endpoint, in minutes.
    cache_period_in_minutes: i64 = 0,

    pub const json_field_names = .{
        .address = "Address",
        .cache_period_in_minutes = "CachePeriodInMinutes",
    };
};
