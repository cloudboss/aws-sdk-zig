const aws = @import("aws");

/// Describes the target resource of an import operation.
pub const ResourceToImport = struct {
    /// The logical ID of the target resource as specified in the template.
    logical_resource_id: []const u8,

    /// A key-value pair that identifies the target resource. The key is an
    /// identifier property (for
    /// example, `BucketName` for `AWS::S3::Bucket` resources) and the value is the
    /// actual property value (for example, `MyS3Bucket`).
    resource_identifier: []const aws.map.StringMapEntry,

    /// The type of resource to import into your stack, such as `AWS::S3::Bucket`.
    /// For a
    /// list of supported resource types, see [Resource type
    /// support for imports and drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html) in the
    /// *CloudFormation User Guide*.
    resource_type: []const u8,
};
