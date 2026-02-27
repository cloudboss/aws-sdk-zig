/// Updated Start of
/// Authority (SOA) properties for a public or private DNS namespace.
pub const SOAChange = struct {
    /// The updated time to
    /// live (TTL) for purposes of negative caching.
    ttl: i64,

    pub const json_field_names = .{
        .ttl = "TTL",
    };
};
