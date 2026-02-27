/// This object defines one log field that will be split with the [
/// splitString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-splitString) processor.
pub const SplitStringEntry = struct {
    /// The separator characters to split the string entry on.
    delimiter: []const u8,

    /// The key of the field to split.
    source: []const u8,

    pub const json_field_names = .{
        .delimiter = "delimiter",
        .source = "source",
    };
};
