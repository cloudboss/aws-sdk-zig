pub const ResponseMode = enum {
    incremental,
    complete,

    pub const json_field_names = .{
        .incremental = "INCREMENTAL",
        .complete = "COMPLETE",
    };
};
