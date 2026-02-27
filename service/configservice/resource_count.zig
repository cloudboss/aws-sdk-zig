const ResourceType = @import("resource_type.zig").ResourceType;

/// An object that contains the resource type and the number of
/// resources.
pub const ResourceCount = struct {
    /// The number of resources.
    count: i64 = 0,

    /// The resource type (for example,
    /// `"AWS::EC2::Instance"`).
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .count = "count",
        .resource_type = "resourceType",
    };
};
