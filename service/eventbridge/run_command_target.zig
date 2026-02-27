/// Information about the EC2 instances that are to be sent the command,
/// specified as
/// key-value pairs. Each `RunCommandTarget` block can include only one key, but
/// this
/// key may specify multiple values.
pub const RunCommandTarget = struct {
    /// Can be either `tag:`
    /// *tag-key* or
    /// `InstanceIds`.
    key: []const u8,

    /// If `Key` is `tag:`
    /// *tag-key*, `Values`
    /// is a list of tag values. If `Key` is `InstanceIds`, `Values`
    /// is a list of Amazon EC2 instance IDs.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
