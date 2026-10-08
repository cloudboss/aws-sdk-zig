const BrandProfileAttributeType = @import("brand_profile_attribute_type.zig").BrandProfileAttributeType;

/// Contains information about an attribute that was created for a brand
/// profile.
pub const BrandProfileAttributeOutput = struct {
    /// The name of the brand profile attribute. The name is unique within a brand
    /// profile.
    attribute_name: []const u8,

    /// The type of the attribute. TEXT stores an inline value. IMAGE and DOCUMENT
    /// store binary media that you upload.
    attribute_type: BrandProfileAttributeType,

    /// A presigned Amazon S3 URL that you can use to download the attribute media.
    /// The URL is valid for one hour and is present only for attributes of type
    /// IMAGE or DOCUMENT.
    media_download_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .attribute_type = "attributeType",
        .media_download_url = "mediaDownloadUrl",
    };
};
