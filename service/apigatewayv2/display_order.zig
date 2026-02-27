const Section = @import("section.zig").Section;

/// The display order.
pub const DisplayOrder = struct {
    /// Represents a list of sections which include section name and list of product
    /// REST endpoints for a product.
    contents: ?[]const Section,

    /// The ARN of the overview page.
    overview_page_arn: ?[]const u8,

    /// The product page ARNs.
    product_page_arns: ?[]const []const u8,

    pub const json_field_names = .{
        .contents = "Contents",
        .overview_page_arn = "OverviewPageArn",
        .product_page_arns = "ProductPageArns",
    };
};
