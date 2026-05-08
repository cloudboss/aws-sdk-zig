/// Enables you and your customers to move your existing agreements to AWS
/// Marketplace. The customer won't be charged for product usage in AWS
/// Marketplace because they already paid for the product outside of AWS
/// Marketplace.
pub const ByolPricingTerm = struct {
    /// The unique identifier for the term.
    id: ?[]const u8 = null,

    /// Type of the term being updated.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};
