/// The list of resources involved in the agreement.
pub const Resource = struct {
    /// The unique identifier of the resource.
    ///
    /// We mention the term resource, which is most commonly a product, so a
    /// `resourceId` is also a `productId`.
    id: ?[]const u8,

    /// Type of the resource, which is the product. Values include `SaaSProduct` or
    /// `AmiProduct`.
    type: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .type = "type",
    };
};
