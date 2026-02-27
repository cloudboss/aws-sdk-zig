/// A representation of the charge details that are associated with a percentage
/// custom line item.
pub const CustomLineItemPercentageChargeDetails = struct {
    /// A list of resource ARNs to associate to the percentage custom line item.
    associated_values: ?[]const []const u8,

    /// The custom line item's percentage value. This will be multiplied against the
    /// combined value of its associated resources to determine its charge value.
    percentage_value: f64,

    pub const json_field_names = .{
        .associated_values = "AssociatedValues",
        .percentage_value = "PercentageValue",
    };
};
