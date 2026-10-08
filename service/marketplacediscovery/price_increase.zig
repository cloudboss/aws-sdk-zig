const FixedPercentage = @import("fixed_percentage.zig").FixedPercentage;
const PercentageRange = @import("percentage_range.zig").PercentageRange;

/// The pricing adjustment that applies at each renewal cycle, expressed as
/// either a fixed percentage or a percentage range. Exactly one variant is
/// present.
pub const PriceIncrease = union(enum) {
    /// A single fixed percentage applied uniformly at every renewal cycle.
    fixed_percentage: ?FixedPercentage,
    /// A percentage band with minimum, maximum, and default values that bound the
    /// price increase at each renewal cycle.
    percentage_range: ?PercentageRange,

    pub const json_field_names = .{
        .fixed_percentage = "fixedPercentage",
        .percentage_range = "percentageRange",
    };
};
