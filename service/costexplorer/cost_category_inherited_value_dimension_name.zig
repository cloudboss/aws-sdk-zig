pub const CostCategoryInheritedValueDimensionName = enum {
    linked_account_name,
    tag,

    pub const json_field_names = .{
        .linked_account_name = "LINKED_ACCOUNT_NAME",
        .tag = "TAG",
    };
};
