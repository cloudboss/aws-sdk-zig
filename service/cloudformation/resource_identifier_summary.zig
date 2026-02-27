/// Describes the target resources of a specific type in your import template
/// (for example,
/// all `AWS::S3::Bucket` resources) and the properties you can provide during
/// the
/// import to identify resources of that type.
pub const ResourceIdentifierSummary = struct {
    /// The logical IDs of the target resources of the specified `ResourceType`, as
    /// defined in the import template.
    logical_resource_ids: ?[]const []const u8,

    /// The resource properties you can provide during the import to identify your
    /// target
    /// resources. For example, `BucketName` is a possible identifier property for
    /// `AWS::S3::Bucket` resources.
    resource_identifiers: ?[]const []const u8,

    /// The template resource type of the target resources, such as
    /// `AWS::S3::Bucket`.
    resource_type: ?[]const u8,
};
