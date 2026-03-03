/// Specifies an option value.
pub const Option = struct {
    /// Specifies the description of the option.
    description: ?[]const u8 = null,

    /// Specifies the label of the option.
    label: ?[]const u8 = null,

    /// Specifies the value of the option.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .label = "Label",
        .value = "Value",
    };
};
