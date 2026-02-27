pub const IndexType = enum {
    /// local index
    local,
    /// aggregator index
    aggregator,

    pub const json_field_names = .{
        .local = "LOCAL",
        .aggregator = "AGGREGATOR",
    };
};
