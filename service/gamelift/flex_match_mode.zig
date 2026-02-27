pub const FlexMatchMode = enum {
    standalone,
    with_queue,

    pub const json_field_names = .{
        .standalone = "STANDALONE",
        .with_queue = "WITH_QUEUE",
    };
};
