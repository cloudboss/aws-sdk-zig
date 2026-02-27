/// Validation rules for a select field.
pub const SelectValidation = struct {
    /// The maximum number of choices for the select.
    max_choices: i32,

    /// The minimum number of choices for the select.
    min_choices: i32,

    /// An array of strings for the possible selection options.
    options: []const []const u8,

    pub const json_field_names = .{
        .max_choices = "MaxChoices",
        .min_choices = "MinChoices",
        .options = "Options",
    };
};
