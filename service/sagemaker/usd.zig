/// Represents an amount of money in United States dollars.
pub const USD = struct {
    /// The fractional portion, in cents, of the amount.
    cents: ?i32,

    /// The whole number of dollars in the amount.
    dollars: ?i32,

    /// Fractions of a cent, in tenths.
    tenth_fractions_of_a_cent: ?i32,

    pub const json_field_names = .{
        .cents = "Cents",
        .dollars = "Dollars",
        .tenth_fractions_of_a_cent = "TenthFractionsOfACent",
    };
};
