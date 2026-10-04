/// An account that is charged all or a portion of the total Support charge and
/// the percentage of the charge allocated to it.
pub const ChargeAccount = struct {
    /// The account ID.
    account_id: []const u8,

    /// The percentage of the total Support charge allocated to this account. This
    /// is 0.0 when supportAllocationMethod = Proportional.
    charge_percentage: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .charge_percentage = "chargePercentage",
    };
};
