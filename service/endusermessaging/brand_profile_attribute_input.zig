const BrandProfileAttributeType = @import("brand_profile_attribute_type.zig").BrandProfileAttributeType;

/// Specifies an attribute to create for a brand profile.
pub const BrandProfileAttributeInput = struct {
    /// The binary content for an attribute of type IMAGE or DOCUMENT. The content
    /// is base64-encoded when it is sent over the wire.
    attachment_body: ?[]const u8 = null,

    /// The name of the brand profile attribute. The name is unique within a brand
    /// profile.
    attribute_name: []const u8,

    /// The type of the attribute. TEXT stores an inline value. IMAGE and DOCUMENT
    /// store binary media that you upload.
    attribute_type: BrandProfileAttributeType,

    /// The text value for the attribute. This value applies to attributes of type
    /// TEXT. For attributes of type IMAGE or DOCUMENT, provide the media through
    /// the attachment body instead.
    attribute_value: ?[]const u8 = null,

    /// The category of the attribute.
    category: ?[]const u8 = null,

    /// A description of the attribute.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment_body = "attachmentBody",
        .attribute_name = "attributeName",
        .attribute_type = "attributeType",
        .attribute_value = "attributeValue",
        .category = "category",
        .description = "description",
    };
};
