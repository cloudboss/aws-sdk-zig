pub const UpdateStatus = enum {
    ready,
    updating,

    pub const json_field_names = .{
        .ready = "READY",
        .updating = "UPDATING",
    };
};
