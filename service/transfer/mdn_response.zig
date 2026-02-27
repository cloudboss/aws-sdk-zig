pub const MdnResponse = enum {
    sync,
    none,
    async,

    pub const json_field_names = .{
        .sync = "SYNC",
        .none = "NONE",
        .async = "ASYNC",
    };
};
