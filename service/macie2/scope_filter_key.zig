/// The property to use in a condition that determines whether an S3 object is
/// included or excluded from a classification job. Valid values are:
pub const ScopeFilterKey = enum {
    object_extension,
    object_last_modified_date,
    object_size,
    object_key,

    pub const json_field_names = .{
        .object_extension = "OBJECT_EXTENSION",
        .object_last_modified_date = "OBJECT_LAST_MODIFIED_DATE",
        .object_size = "OBJECT_SIZE",
        .object_key = "OBJECT_KEY",
    };
};
