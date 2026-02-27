pub const PurchaseAgreementType = enum {
    savings_plans,
    reserved_instance,

    pub const json_field_names = .{
        .savings_plans = "SAVINGS_PLANS",
        .reserved_instance = "RESERVED_INSTANCE",
    };
};
