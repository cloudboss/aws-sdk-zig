/// A tag that can be added to an MemoryDB resource. Tags are composed of a
/// Key/Value pair. You can use tags to categorize and track all your MemoryDB
/// resources.
/// When you add or remove tags on clusters, those actions will be replicated to
/// all nodes in the cluster. A tag with a null Value is permitted. For more
/// information, see
/// [Tagging your MemoryDB
/// resources](https://docs.aws.amazon.com/MemoryDB/latest/devguide/tagging-resources.html)
pub const Tag = struct {
    /// The key for the tag. May not be null.
    key: ?[]const u8,

    /// The tag's value. May be null.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
