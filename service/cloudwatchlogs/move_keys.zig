const MoveKeyEntry = @import("move_key_entry.zig").MoveKeyEntry;

/// This processor moves a key from one field to another. The original key is
/// deleted.
///
/// For more information about this processor including examples, see [
/// moveKeys](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-moveKeys) in the *CloudWatch Logs User Guide*.
pub const MoveKeys = struct {
    /// An array of objects, where each object contains the information about one
    /// key to move.
    entries: []const MoveKeyEntry,

    pub const json_field_names = .{
        .entries = "entries",
    };
};
