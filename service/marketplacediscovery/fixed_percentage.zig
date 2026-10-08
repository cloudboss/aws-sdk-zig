/// A single fixed price increase percentage applied at each renewal cycle.
pub const FixedPercentage = struct {
    /// The percentage value applied at each renewal cycle.
    percentage_value: []const u8,

    pub const json_field_names = .{
        .percentage_value = "percentageValue",
    };
};
