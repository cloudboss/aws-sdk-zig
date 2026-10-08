const ImportTrigger = @import("import_trigger.zig").ImportTrigger;

/// Specifies a rule that controls how data is imported from S3 into the file
/// system.
pub const ImportDataRule = struct {
    /// The S3 key prefix that scopes this import rule. Only objects with keys
    /// beginning with this prefix are subject to the rule.
    prefix: []const u8,

    /// The upper size limit in bytes for this import rule. Only objects with a size
    /// strictly less than this value will have data imported into the file system.
    size_less_than: i64,

    /// The event that triggers data import. Valid values are
    /// `ON_DIRECTORY_FIRST_ACCESS` (import when a directory is first accessed) and
    /// `ON_FILE_ACCESS` (import when a file is accessed).
    trigger: ImportTrigger,

    pub const json_field_names = .{
        .prefix = "prefix",
        .size_less_than = "sizeLessThan",
        .trigger = "trigger",
    };
};
