/// A summary view of a seller profile containing basic identifying information.
pub const SellerProfileSummary = struct {
    /// The unique identifier of the seller profile.
    id: []const u8,

    /// The display name of the seller.
    name: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
    };
};
