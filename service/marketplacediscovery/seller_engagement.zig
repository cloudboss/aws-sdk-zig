const SellerEngagementContentType = @import("seller_engagement_content_type.zig").SellerEngagementContentType;
const SellerEngagementType = @import("seller_engagement_type.zig").SellerEngagementType;

/// An engagement option available to potential buyers of a product, such as
/// requesting a private offer or a demo.
pub const SellerEngagement = struct {
    /// The format of the engagement value, such as a URL.
    content_type: SellerEngagementContentType,

    /// The type of engagement, such as `REQUEST_FOR_PRIVATE_OFFER` or
    /// `REQUEST_FOR_DEMO`.
    engagement_type: SellerEngagementType,

    /// The engagement value, such as a URL to the engagement form.
    value: []const u8,

    pub const json_field_names = .{
        .content_type = "contentType",
        .engagement_type = "engagementType",
        .value = "value",
    };
};
