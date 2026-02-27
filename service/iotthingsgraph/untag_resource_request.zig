pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource whose tags are to be removed.
    resource_arn: []const u8,

    /// A list of tag key names to remove from the resource. You don't specify the
    /// value. Both the key and its associated value are removed.
    ///
    /// This parameter to the API requires a JSON text string argument. For
    /// information on how to format a JSON parameter for the various command line
    /// tool environments, see [Using JSON for
    /// Parameters](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters.html#cli-using-param-json) in the *AWS CLI User Guide*.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
