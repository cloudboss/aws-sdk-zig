/// Contains additional resource information needed for specific datasets.
pub const Metadata = struct {
    /// The Amazon Resource Name (ARN) associated with the dataset. Currently,
    /// DataBrew
    /// only supports ARNs from Amazon AppFlow.
    source_arn: ?[]const u8,

    pub const json_field_names = .{
        .source_arn = "SourceArn",
    };
};
