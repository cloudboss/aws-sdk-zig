pub const OpenZFSCopyStrategy = enum {
    clone,
    full_copy,
    incremental_copy,

    pub const json_field_names = .{
        .clone = "CLONE",
        .full_copy = "FULL_COPY",
        .incremental_copy = "INCREMENTAL_COPY",
    };
};
