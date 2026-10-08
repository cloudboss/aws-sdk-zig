/// Information about a seller, including the profile identifier and display
/// name.
pub const SellerInformation = struct {
    /// The human-readable name of the seller.
    display_name: []const u8,

    /// The unique identifier of the seller profile.
    seller_profile_id: []const u8,

    pub const json_field_names = .{
        .display_name = "displayName",
        .seller_profile_id = "sellerProfileId",
    };
};
