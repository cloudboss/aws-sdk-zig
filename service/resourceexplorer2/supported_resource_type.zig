/// A structure that describes a resource type supported by Amazon Web Services
/// Resource Explorer.
pub const SupportedResourceType = struct {
    /// The CloudFormation resource type identifiers for this resource type, such as
    /// `AWS::EC2::Instance`.
    cfn_resource_types: ?[]const []const u8 = null,

    /// The unique identifier of the resource type.
    resource_type: ?[]const u8 = null,

    /// The Amazon Web Services service that is associated with the resource type.
    /// This is the primary service that lets you create and interact with resources
    /// of this type.
    service: ?[]const u8 = null,

    pub const json_field_names = .{
        .cfn_resource_types = "CFNResourceTypes",
        .resource_type = "ResourceType",
        .service = "Service",
    };
};
