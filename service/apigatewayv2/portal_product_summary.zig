const aws = @import("aws");

/// Represents a portal product.
pub const PortalProductSummary = struct {
    /// The description.
    description: []const u8,

    /// The display name of a portal product.
    display_name: []const u8,

    /// The timestamp when the portal product was last modified.
    last_modified: i64,

    /// The ARN of a portal product.
    portal_product_arn: []const u8,

    /// The portal product identifier.
    portal_product_id: []const u8,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .last_modified = "LastModified",
        .portal_product_arn = "PortalProductArn",
        .portal_product_id = "PortalProductId",
        .tags = "Tags",
    };
};
