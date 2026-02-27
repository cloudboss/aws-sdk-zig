pub const OrderBy = enum {
    /// Order by timestamp in descending order.
    timestamp_descending,
    /// Order by timestamp in ascending order.
    timestamp_ascending,

    pub const json_field_names = .{
        .timestamp_descending = "TIMESTAMP_DESCENDING",
        .timestamp_ascending = "TIMESTAMP_ASCENDING",
    };
};
