pub const SchemaStatus = enum {
    ready,
    not_ready,

    pub const json_field_names = .{
        .ready = "READY",
        .not_ready = "NOT_READY",
    };
};
