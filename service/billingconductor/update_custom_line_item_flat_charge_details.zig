/// A representation of the new charge details that are associated with a flat
/// custom line item.
pub const UpdateCustomLineItemFlatChargeDetails = struct {
    /// The custom line item's new fixed charge value in USD.
    charge_value: f64,

    pub const json_field_names = .{
        .charge_value = "ChargeValue",
    };
};
