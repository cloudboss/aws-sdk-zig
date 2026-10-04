/// A fixed price increase that is applied each time the agreement renews.
pub const FixedPercentage = struct {
    /// The percentage by which the price increases at each renewal, from `0.00` to
    /// `100.00` with up to two decimal places. A value of `0.00` means that the
    /// agreement renews at the same price.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value = "value",
    };
};
