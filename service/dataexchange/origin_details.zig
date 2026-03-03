/// Details about the origin of the data set.
pub const OriginDetails = struct {
    /// The ID of the data grant.
    data_grant_id: ?[]const u8 = null,

    /// The product ID of the origin of the data set.
    product_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_grant_id = "DataGrantId",
        .product_id = "ProductId",
    };
};
