/// An account that is covered by the Enterprise Support contract.
pub const ContractAccount = struct {
    /// The account ID.
    account_id: []const u8,

    /// When true, Support charges are calculated on charges before private
    /// discounts. When false, they are calculated after private discounts.
    is_gdn: bool,

    pub const json_field_names = .{
        .account_id = "accountId",
        .is_gdn = "isGdn",
    };
};
