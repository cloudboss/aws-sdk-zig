pub const ImageSelectorType = enum {
    server_timestamp,
    producer_timestamp,

    pub const json_field_names = .{
        .server_timestamp = "SERVER_TIMESTAMP",
        .producer_timestamp = "PRODUCER_TIMESTAMP",
    };
};
