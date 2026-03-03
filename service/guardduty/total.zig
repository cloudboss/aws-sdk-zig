/// Contains the total usage with the corresponding currency unit for that
/// value.
pub const Total = struct {
    /// The total usage.
    amount: ?[]const u8 = null,

    /// The currency unit that the amount is given in.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .amount = "Amount",
        .unit = "Unit",
    };
};
