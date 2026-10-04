/// An additional charge applied to an Enterprise Support contract.
pub const AdditionalCharge = struct {
    /// The charge amount.
    amount: ?[]const u8 = null,

    /// The type of additional charge.
    charge_type: ?[]const u8 = null,

    /// A description of the additional charge.
    description: []const u8,

    pub const json_field_names = .{
        .amount = "amount",
        .charge_type = "chargeType",
        .description = "description",
    };
};
