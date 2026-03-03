/// The filter that specifies criteria that the pricing rules returned by the
/// `ListPricingRules` API will adhere to.
pub const ListPricingRulesFilter = struct {
    /// A list containing the pricing rule Amazon Resource Names (ARNs) to include
    /// in the API response.
    arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arns = "Arns",
    };
};
