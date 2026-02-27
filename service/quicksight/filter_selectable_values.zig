/// A list of selectable values that are used in a control.
pub const FilterSelectableValues = struct {
    /// The values that are used in the `FilterSelectableValues`.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .values = "Values",
    };
};
