/// Details about a related finding.
pub const RelatedFinding = struct {
    /// The product-generated identifier for a related finding.
    id: []const u8,

    /// The ARN of the product that generated a related finding.
    product_arn: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .product_arn = "ProductArn",
    };
};
