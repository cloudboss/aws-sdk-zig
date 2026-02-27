/// A collection of error messages for any views that Amazon Web Services
/// Resource Explorer couldn't retrieve details.
pub const BatchGetViewError = struct {
    /// The description of the error for the specified view.
    error_message: []const u8,

    /// The [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the view for which Resource Explorer failed to retrieve details.
    view_arn: []const u8,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .view_arn = "ViewArn",
    };
};
