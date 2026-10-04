/// A range of price increase percentages that the proposer can choose from
/// before the adjustment deadline of the agreement.
///
/// `MinValue` will be less than `MaxValue`, and `DefaultValue` will fall within
/// the range. When the proposer authorizes a single percentage instead of a
/// range, `PriceIncrease` is a `FixedPercentage` rather than a
/// `PercentageRange`.
pub const PercentageRange = struct {
    /// The percentage that is applied if the proposer doesn't choose a value before
    /// the adjustment deadline. Valid values range from `0.00` to `100.00`, with up
    /// to two decimal places.
    default_value: ?[]const u8 = null,

    /// The highest percentage that the proposer can choose, from `0.00` to `100.00`
    /// with up to two decimal places.
    max_value: ?[]const u8 = null,

    /// The lowest percentage that the proposer can choose, from `0.00` to `100.00`
    /// with up to two decimal places.
    min_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .max_value = "maxValue",
        .min_value = "minValue",
    };
};
