/// An object to specify the expiration of a routing step.
pub const Expiry = struct {
    /// The number of seconds to wait before expiring the routing step.
    duration_in_seconds: ?i32 = null,

    /// The timestamp indicating when the routing step expires.
    expiry_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
        .expiry_timestamp = "ExpiryTimestamp",
    };
};
