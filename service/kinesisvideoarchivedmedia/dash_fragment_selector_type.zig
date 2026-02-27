pub const DASHFragmentSelectorType = enum {
    producer_timestamp,
    server_timestamp,

    pub const json_field_names = .{
        .producer_timestamp = "PRODUCER_TIMESTAMP",
        .server_timestamp = "SERVER_TIMESTAMP",
    };
};
