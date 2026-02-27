/// Object for field Options information.
pub const FieldOption = struct {
    /// Describes whether the `FieldOption` is active (displayed) or inactive.
    active: bool,

    /// `FieldOptionName` has max length 100 and disallows trailing spaces.
    name: []const u8,

    /// `FieldOptionValue` has max length 100 and must be alphanumeric with hyphens
    /// and underscores.
    value: []const u8,

    pub const json_field_names = .{
        .active = "active",
        .name = "name",
        .value = "value",
    };
};
