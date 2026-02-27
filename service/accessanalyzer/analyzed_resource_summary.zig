const ResourceType = @import("resource_type.zig").ResourceType;

/// Contains the ARN of the analyzed resource.
pub const AnalyzedResourceSummary = struct {
    /// The ARN of the analyzed resource.
    resource_arn: []const u8,

    /// The Amazon Web Services account ID that owns the resource.
    resource_owner_account: []const u8,

    /// The type of resource that was analyzed.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .resource_owner_account = "resourceOwnerAccount",
        .resource_type = "resourceType",
    };
};
