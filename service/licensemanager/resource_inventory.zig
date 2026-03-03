const ResourceType = @import("resource_type.zig").ResourceType;

/// Details about a resource.
pub const ResourceInventory = struct {
    /// Amazon Machine Image (AMI) ID associated with the resource.
    ami_id: ?[]const u8 = null,

    /// Dedicated Host ID where the resource is running.
    host_id: ?[]const u8 = null,

    /// EC2 instance type of the resource.
    instance_type: ?[]const u8 = null,

    /// List of Marketplace product codes associated with the resource.
    marketplace_product_codes: ?[]const []const u8 = null,

    /// Platform of the resource.
    platform: ?[]const u8 = null,

    /// Platform version of the resource in the inventory.
    platform_version: ?[]const u8 = null,

    /// Region where the resource is located.
    region: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8 = null,

    /// ID of the resource.
    resource_id: ?[]const u8 = null,

    /// ID of the account that owns the resource.
    resource_owning_account_id: ?[]const u8 = null,

    /// Type of resource.
    resource_type: ?ResourceType = null,

    /// Usage operation value that corresponds to the license type for billing
    /// purposes.
    usage_operation: ?[]const u8 = null,

    pub const json_field_names = .{
        .ami_id = "AmiId",
        .host_id = "HostId",
        .instance_type = "InstanceType",
        .marketplace_product_codes = "MarketplaceProductCodes",
        .platform = "Platform",
        .platform_version = "PlatformVersion",
        .region = "Region",
        .resource_arn = "ResourceArn",
        .resource_id = "ResourceId",
        .resource_owning_account_id = "ResourceOwningAccountId",
        .resource_type = "ResourceType",
        .usage_operation = "UsageOperation",
    };
};
