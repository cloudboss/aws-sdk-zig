/// A user-defined key-value pair that describes metadata added to an DMS
/// resource and
/// that is used by operations such as the following:
///
/// * `AddTagsToResource`
///
/// * `ListTagsForResource`
///
/// * `RemoveTagsFromResource`
pub const Tag = struct {
    /// A key is the required name of the tag. The string value can be 1-128 Unicode
    /// characters
    /// in length and can't be prefixed with "aws:" or "dms:". The string can only
    /// contain
    /// only the set of Unicode letters, digits, white-space, '_', '.', '/', '=',
    /// '+', '-' (Java
    /// regular expressions: "^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-]*)$").
    key: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) string that uniquely identifies the resource
    /// for which
    /// the tag is created.
    resource_arn: ?[]const u8 = null,

    /// A value is the optional value of the tag. The string value can be 1-256
    /// Unicode
    /// characters in length and can't be prefixed with "aws:" or "dms:". The string
    /// can only
    /// contain only the set of Unicode letters, digits, white-space, '_', '.', '/',
    /// '=', '+', '-'
    /// (Java regular expressions: "^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-]*)$").
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .resource_arn = "ResourceArn",
        .value = "Value",
    };
};
