pub const FragmentSelectorType = enum {
    producer_timestamp,
    server_timestamp,

    pub const json_field_names = .{
        .producer_timestamp = "ProducerTimestamp",
        .server_timestamp = "ServerTimestamp",
    };
};
