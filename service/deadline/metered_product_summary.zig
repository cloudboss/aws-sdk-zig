/// The details of a metered product.
pub const MeteredProductSummary = struct {
    /// The family to which the metered product belongs.
    family: []const u8,

    /// The port on which the metered product should run.
    port: i32,

    /// The product ID.
    product_id: []const u8,

    /// The vendor.
    vendor: []const u8,

    pub const json_field_names = .{
        .family = "family",
        .port = "port",
        .product_id = "productId",
        .vendor = "vendor",
    };
};
