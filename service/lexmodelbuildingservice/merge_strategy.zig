pub const MergeStrategy = enum {
    overwrite_latest,
    fail_on_conflict,

    pub const json_field_names = .{
        .overwrite_latest = "OVERWRITE_LATEST",
        .fail_on_conflict = "FAIL_ON_CONFLICT",
    };
};
