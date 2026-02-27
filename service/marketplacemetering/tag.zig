/// Metadata assigned to an allocation. Each tag is made up of a `key` and a
/// `value`.
pub const Tag = struct {
    /// One part of a key-value pair that makes up a `tag`. A `key` is a
    /// label that acts like a category for the specific tag values.
    key: []const u8,

    /// One part of a key-value pair that makes up a `tag`. A `value`
    /// acts as a descriptor within a tag category (key). The value can be empty or
    /// null.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
