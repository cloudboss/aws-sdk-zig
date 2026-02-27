/// The selection type that determines which managed data identifiers a
/// classification job uses to analyze data. Valid values are:
pub const ManagedDataIdentifierSelector = enum {
    all,
    exclude,
    include,
    none,
    recommended,

    pub const json_field_names = .{
        .all = "ALL",
        .exclude = "EXCLUDE",
        .include = "INCLUDE",
        .none = "NONE",
        .recommended = "RECOMMENDED",
    };
};
