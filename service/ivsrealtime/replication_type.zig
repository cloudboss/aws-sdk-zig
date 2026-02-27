pub const ReplicationType = enum {
    source,
    replica,
    none,

    pub const json_field_names = .{
        .source = "SOURCE",
        .replica = "REPLICA",
        .none = "NONE",
    };
};
