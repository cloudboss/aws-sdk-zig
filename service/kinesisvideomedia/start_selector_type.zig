pub const StartSelectorType = enum {
    fragment_number,
    server_timestamp,
    producer_timestamp,
    now,
    earliest,
    continuation_token,

    pub const json_field_names = .{
        .fragment_number = "FRAGMENT_NUMBER",
        .server_timestamp = "SERVER_TIMESTAMP",
        .producer_timestamp = "PRODUCER_TIMESTAMP",
        .now = "NOW",
        .earliest = "EARLIEST",
        .continuation_token = "CONTINUATION_TOKEN",
    };
};
