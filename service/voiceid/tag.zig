/// The tags used to organize, track, or control access for this resource. For
/// example, {
/// "tags": {"key1":"value1", "key2":"value2"} }.
pub const Tag = struct {
    /// The first part of a key:value pair that forms a tag associated with a given
    /// resource.
    /// For example, in the tag 'Department':'Sales', the key is 'Department'.
    key: []const u8,

    /// The second part of a key:value pair that forms a tag associated with a given
    /// resource.
    /// For example, in the tag 'Department':'Sales', the value is 'Sales'.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
