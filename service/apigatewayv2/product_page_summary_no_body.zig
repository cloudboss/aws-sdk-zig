/// Represents a product page summary without listing any page content.
pub const ProductPageSummaryNoBody = struct {
    /// The timestamp when the product page was last modified.
    last_modified: i64,

    /// The page title.
    page_title: []const u8,

    /// The ARN of the product page.
    product_page_arn: []const u8,

    /// The product page identifier.
    product_page_id: []const u8,

    pub const json_field_names = .{
        .last_modified = "LastModified",
        .page_title = "PageTitle",
        .product_page_arn = "ProductPageArn",
        .product_page_id = "ProductPageId",
    };
};
