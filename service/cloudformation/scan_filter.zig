/// A filter that is used to specify which resource types to scan.
pub const ScanFilter = struct {
    /// An array of strings where each string represents an Amazon Web Services
    /// resource type you want to scan.
    /// Each string defines the resource type using the format
    /// `AWS::ServiceName::ResourceType`, for example, `AWS::DynamoDB::Table`. For
    /// the full list of supported resource types, see the [Resource type
    /// support](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html) table in the *CloudFormation User Guide*.
    ///
    /// To scan all resource types within a service, you can use a wildcard,
    /// represented by an
    /// asterisk (`*`). You can place an asterisk at only the end of the string, for
    /// example,
    /// `AWS::S3::*`.
    types: ?[]const []const u8,
};
