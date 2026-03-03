/// Allows filtering on the `SolutionId` of an offer set.
pub const OfferSetSolutionIdFilter = struct {
    /// Allows filtering on the `SolutionId` of an offer set with list input.
    value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
