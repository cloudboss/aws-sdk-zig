/// This object defines one value to be copied with the [
/// copyValue](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-copoyValue) processor.
pub const CopyValueEntry = struct {
    /// Specifies whether to overwrite the value if the destination key already
    /// exists. If you
    /// omit this, the default is `false`.
    overwrite_if_exists: bool = false,

    /// The key to copy.
    source: []const u8,

    /// The key of the field to copy the value to.
    target: []const u8,

    pub const json_field_names = .{
        .overwrite_if_exists = "overwriteIfExists",
        .source = "source",
        .target = "target",
    };
};
