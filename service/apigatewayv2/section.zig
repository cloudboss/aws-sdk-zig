/// Contains the section name and list of product REST endpoints for a product.
pub const Section = struct {
    /// The ARNs of the product REST endpoint pages in a portal product.
    product_rest_endpoint_page_arns: []const []const u8,

    /// The section name.
    section_name: []const u8,

    pub const json_field_names = .{
        .product_rest_endpoint_page_arns = "ProductRestEndpointPageArns",
        .section_name = "SectionName",
    };
};
