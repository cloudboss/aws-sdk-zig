/// The key value store. Use this to separate data from function code, allowing
/// you to update data without having to publish a new version of a function.
/// The key value store holds keys and their corresponding values.
pub const KeyValueStore = struct {
    /// The Amazon Resource Name (ARN) of the key value store.
    arn: []const u8,

    /// A comment for the key value store.
    comment: []const u8,

    /// The unique Id for the key value store.
    id: []const u8,

    /// The last-modified time of the key value store.
    last_modified_time: i64,

    /// The name of the key value store.
    name: []const u8,

    /// The status of the key value store.
    status: ?[]const u8,
};
