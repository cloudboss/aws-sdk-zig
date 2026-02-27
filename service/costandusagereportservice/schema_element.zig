/// Whether or not Amazon Web Services includes resource IDs in the report.
pub const SchemaElement = enum {
    resources,
    split_cost_allocation_data,
    manual_discount_compatibility,

    pub const json_field_names = .{
        .resources = "RESOURCES",
        .split_cost_allocation_data = "SPLIT_COST_ALLOCATION_DATA",
        .manual_discount_compatibility = "MANUAL_DISCOUNT_COMPATIBILITY",
    };
};
