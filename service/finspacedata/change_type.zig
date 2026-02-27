/// Indicates how the given change will be applied to the dataset.
pub const ChangeType = enum {
    replace,
    append,
    modify,

    pub const json_field_names = .{
        .replace = "REPLACE",
        .append = "APPEND",
        .modify = "MODIFY",
    };
};
