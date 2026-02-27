pub const LcmOperationType = enum {
    instantiate,
    update,
    terminate,

    pub const json_field_names = .{
        .instantiate = "INSTANTIATE",
        .update = "UPDATE",
        .terminate = "TERMINATE",
    };
};
