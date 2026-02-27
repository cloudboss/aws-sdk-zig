/// This object defines one key that will be renamed with the [
/// renameKey](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-renameKey) processor.
pub const RenameKeyEntry = struct {
    /// The key to rename
    key: []const u8,

    /// Specifies whether to overwrite the existing value if the destination key
    /// already exists.
    /// The default is `false`
    overwrite_if_exists: bool = false,

    /// The string to use for the new key name
    rename_to: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .overwrite_if_exists = "overwriteIfExists",
        .rename_to = "renameTo",
    };
};
