/// The definition of a categorical rating scale option that provides a named
/// category with its description for evaluation scoring.
pub const CategoricalScaleDefinition = struct {
    /// The description that explains what this categorical rating represents and
    /// when it should be used.
    definition: []const u8,

    /// The label or name of this categorical rating option.
    label: []const u8,

    pub const json_field_names = .{
        .definition = "definition",
        .label = "label",
    };
};
