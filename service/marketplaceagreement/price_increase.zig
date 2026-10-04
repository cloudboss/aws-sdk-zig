const FixedPercentage = @import("fixed_percentage.zig").FixedPercentage;
const PercentageRange = @import("percentage_range.zig").PercentageRange;

/// The price increase that is applied each time the agreement renews. Exactly
/// one of the following fields is set.
pub const PriceIncrease = union(enum) {
    /// A fixed price increase percentage that is applied at each renewal.
    fixed_percentage: ?FixedPercentage,
    /// A range of price increase percentages that the proposer can choose from
    /// before the adjustment deadline of the agreement.
    percentage_range: ?PercentageRange,

    pub const json_field_names = .{
        .fixed_percentage = "fixedPercentage",
        .percentage_range = "percentageRange",
    };
};
