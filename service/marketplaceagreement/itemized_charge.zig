/// A breakdown of individual charges or line items within a billing or pricing
/// context.
pub const ItemizedCharge = struct {
    /// The identifier of the expected charge that this itemized charge contributes
    /// to.
    charge_reference: ?[]const u8 = null,

    /// The dimension key as specified in the accepted term.
    dimension_key: ?[]const u8 = null,

    /// The total incremental charge amount for this dimension.
    incremental_charge_amount: ?[]const u8 = null,

    /// The requested quantity for this dimension.
    new_quantity: ?i32 = null,

    /// The existing quantity for this dimension from the source agreement. This
    /// value is `0` for NEW intent.
    old_quantity: ?i32 = null,

    pub const json_field_names = .{
        .charge_reference = "chargeReference",
        .dimension_key = "dimensionKey",
        .incremental_charge_amount = "incrementalChargeAmount",
        .new_quantity = "newQuantity",
        .old_quantity = "oldQuantity",
    };
};
