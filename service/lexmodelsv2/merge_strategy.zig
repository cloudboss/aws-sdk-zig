pub const MergeStrategy = enum {
    overwrite,
    fail_on_conflict,
    append,

    pub const json_field_names = .{
        .overwrite = "Overwrite",
        .fail_on_conflict = "FailOnConflict",
        .append = "Append",
    };
};
