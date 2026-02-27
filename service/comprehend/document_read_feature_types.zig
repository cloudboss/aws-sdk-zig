/// TABLES or FORMS
pub const DocumentReadFeatureTypes = enum {
    tables,
    forms,

    pub const json_field_names = .{
        .tables = "TABLES",
        .forms = "FORMS",
    };
};
