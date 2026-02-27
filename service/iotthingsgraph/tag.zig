/// Metadata assigned to an AWS IoT Things Graph resource consisting of a
/// key-value pair.
pub const Tag = struct {
    /// The required name of the tag. The string value can be from 1 to 128 Unicode
    /// characters in length.
    key: []const u8,

    /// The optional value of the tag. The string value can be from 1 to 256 Unicode
    /// characters in length.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
