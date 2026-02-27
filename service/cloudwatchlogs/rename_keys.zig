const RenameKeyEntry = @import("rename_key_entry.zig").RenameKeyEntry;

/// Use this processor to rename keys in a log event.
///
/// For more information about this processor including examples, see [
/// renameKeys](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-renameKeys) in the *CloudWatch Logs User Guide*.
pub const RenameKeys = struct {
    /// An array of `RenameKeyEntry` objects, where each object contains the
    /// information about a single key to rename.
    entries: []const RenameKeyEntry,

    pub const json_field_names = .{
        .entries = "entries",
    };
};
