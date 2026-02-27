/// Enumeration of condition matching requirements: MEETS_ALL requires all
/// conditions to match, MEETS_ANY requires at least one.
pub const FilterRequirement = enum {
    meets_all,
    meets_any,

    pub const json_field_names = .{
        .meets_all = "MEETS_ALL",
        .meets_any = "MEETS_ANY",
    };
};
