const BrandProfileAttributeType = @import("brand_profile_attribute_type.zig").BrandProfileAttributeType;

/// Contains summary information about a brand profile attribute in a list
/// response.
pub const BrandProfileAttributeSummary = struct {
    /// The name of the brand profile attribute. The name is unique within a brand
    /// profile.
    attribute_name: []const u8,

    /// The type of the attribute. TEXT stores an inline value. IMAGE and DOCUMENT
    /// store binary media that you upload.
    attribute_type: BrandProfileAttributeType,

    /// The category of the attribute.
    category: ?[]const u8 = null,

    /// The time when the resource was created, in Unix epoch time.
    created_at: i64,

    /// A description of the attribute.
    description: ?[]const u8 = null,

    /// The time when the resource was last updated, in Unix epoch time.
    updated_at: i64,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .attribute_type = "attributeType",
        .category = "category",
        .created_at = "createdAt",
        .description = "description",
        .updated_at = "updatedAt",
    };
};
