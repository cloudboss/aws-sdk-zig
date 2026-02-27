/// Dataset Kind
pub const DatasetKind = enum {
    tabular,
    non_tabular,

    pub const json_field_names = .{
        .tabular = "TABULAR",
        .non_tabular = "NON_TABULAR",
    };
};
