pub const MergeType = enum {
    manual_merge,
    auto_merge,

    pub const json_field_names = .{
        .manual_merge = "MANUAL_MERGE",
        .auto_merge = "AUTO_MERGE",
    };
};
