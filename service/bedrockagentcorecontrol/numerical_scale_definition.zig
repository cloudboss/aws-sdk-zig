/// The definition of a numerical rating scale option that provides a numeric
/// value with its description for evaluation scoring.
pub const NumericalScaleDefinition = struct {
    /// The description that explains what this numerical rating represents and when
    /// it should be used.
    definition: []const u8,

    /// The label or name that describes this numerical rating option.
    label: []const u8,

    /// The numerical value for this rating scale option.
    value: f64,

    pub const json_field_names = .{
        .definition = "definition",
        .label = "label",
        .value = "value",
    };
};
