/// The filter that specifies the Amazon Resource Names (ARNs) of pricing plans,
/// to retrieve pricing plan information.
pub const ListPricingPlansFilter = struct {
    /// A list of pricing plan Amazon Resource Names (ARNs) to retrieve information.
    arns: ?[]const []const u8,

    pub const json_field_names = .{
        .arns = "Arns",
    };
};
