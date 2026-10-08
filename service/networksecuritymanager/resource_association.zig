const ServiceResourceType = @import("service_resource_type.zig").ServiceResourceType;

/// Describes an association between a resource and another entity.
pub const ResourceAssociation = struct {
    /// The ARN of the associated resource.
    arn: []const u8,

    /// The type of the associated resource, such as `Policy`, `Template`, or
    /// `Deployment`.
    resource_type: ServiceResourceType,

    pub const json_field_names = .{
        .arn = "arn",
        .resource_type = "resourceType",
    };
};
