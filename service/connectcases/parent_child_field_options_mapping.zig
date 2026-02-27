/// A mapping between a parent field option value and child field option values.
pub const ParentChildFieldOptionsMapping = struct {
    /// A list of allowed values in the child field.
    child_field_option_values: []const []const u8,

    /// The value in the parent field.
    parent_field_option_value: []const u8,

    pub const json_field_names = .{
        .child_field_option_values = "childFieldOptionValues",
        .parent_field_option_value = "parentFieldOptionValue",
    };
};
