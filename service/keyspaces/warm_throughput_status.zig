pub const WarmThroughputStatus = enum {
    available,
    updating,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .updating = "UPDATING",
    };
};
