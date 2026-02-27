/// A structure that describes a resource type supported by Amazon Web Services
/// Resource Explorer.
pub const SupportedResourceType = struct {
    /// The unique identifier of the resource type.
    resource_type: ?[]const u8,

    /// The Amazon Web Services service that is associated with the resource type.
    /// This is the primary service that lets you create and interact with resources
    /// of this type.
    service: ?[]const u8,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .service = "Service",
    };
};
