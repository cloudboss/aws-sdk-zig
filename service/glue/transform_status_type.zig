pub const TransformStatusType = enum {
    not_ready,
    ready,
    deleting,

    pub const json_field_names = .{
        .not_ready = "NOT_READY",
        .ready = "READY",
        .deleting = "DELETING",
    };
};
