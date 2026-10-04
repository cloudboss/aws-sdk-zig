/// The text unit usage for the sensitive information check.
pub const GuardrailChecksSensitiveInformationUsage = struct {
    /// The number of text units consumed by the sensitive information check.
    text_units: i32,

    pub const json_field_names = .{
        .text_units = "textUnits",
    };
};
