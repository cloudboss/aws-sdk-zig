/// This object defines one key that will be moved with the [
/// moveKey](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-moveKey) processor.
pub const MoveKeyEntry = struct {
    /// Specifies whether to overwrite the value if the destination key already
    /// exists. If you
    /// omit this, the default is `false`.
    overwrite_if_exists: bool = false,

    /// The key to move.
    source: []const u8,

    /// The key to move to.
    target: []const u8,

    pub const json_field_names = .{
        .overwrite_if_exists = "overwriteIfExists",
        .source = "source",
        .target = "target",
    };
};
