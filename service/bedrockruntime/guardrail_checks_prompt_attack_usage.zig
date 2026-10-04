/// The text unit usage for the prompt attack check.
pub const GuardrailChecksPromptAttackUsage = struct {
    /// The number of text units consumed by the prompt attack check.
    text_units: i32,

    pub const json_field_names = .{
        .text_units = "textUnits",
    };
};
