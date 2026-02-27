const ResourceType = @import("resource_type.zig").ResourceType;

/// Filters the resource count based on account ID, region, and resource type.
pub const ResourceCountFilters = struct {
    /// The 12-digit ID of the account.
    account_id: ?[]const u8,

    /// The region where the account is located.
    region: ?[]const u8,

    /// The type of the Amazon Web Services resource.
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .region = "Region",
        .resource_type = "ResourceType",
    };
};
