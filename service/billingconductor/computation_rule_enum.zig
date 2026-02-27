/// The display settings of the custom line item
pub const ComputationRuleEnum = enum {
    itemized,
    consolidated,

    pub const json_field_names = .{
        .itemized = "ITEMIZED",
        .consolidated = "CONSOLIDATED",
    };
};
