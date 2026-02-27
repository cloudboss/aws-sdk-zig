/// Specifies the key-value pair that are assigned to a file during the
/// execution of a Tagging step.
pub const S3Tag = struct {
    /// The name assigned to the tag that you create.
    key: []const u8,

    /// The value that corresponds to the key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
