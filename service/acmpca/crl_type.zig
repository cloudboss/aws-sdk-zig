pub const CrlType = enum {
    complete,
    partitioned,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .partitioned = "PARTITIONED",
    };
};
