/// The text unit usage for the content filter check.
pub const GuardrailChecksContentFilterUsage = struct {
    /// The number of text units consumed by the content filter check.
    text_units: i32,

    pub const json_field_names = .{
        .text_units = "textUnits",
    };
};
