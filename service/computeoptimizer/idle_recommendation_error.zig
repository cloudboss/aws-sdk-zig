const IdleRecommendationResourceType = @import("idle_recommendation_resource_type.zig").IdleRecommendationResourceType;

/// Returns of list of resources that doesn't have idle recommendations.
pub const IdleRecommendationError = struct {
    /// The error code.
    code: ?[]const u8,

    /// The ID of the error.
    identifier: ?[]const u8,

    /// The error message.
    message: ?[]const u8,

    /// The type of resource associated with the error.
    resource_type: ?IdleRecommendationResourceType,

    pub const json_field_names = .{
        .code = "code",
        .identifier = "identifier",
        .message = "message",
        .resource_type = "resourceType",
    };
};
