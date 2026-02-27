pub const GroupDefinitionType = enum {
    dimension,
    tag,
    cost_category,

    pub const json_field_names = .{
        .dimension = "DIMENSION",
        .tag = "TAG",
        .cost_category = "COST_CATEGORY",
    };
};
