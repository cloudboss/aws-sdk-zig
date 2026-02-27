/// Input preference when deciding which input to make active when a previously
/// failed input has recovered.
/// If \"EQUAL_INPUT_PREFERENCE\", then the active input will stay active as
/// long as it is healthy.
/// If \"PRIMARY_INPUT_PREFERRED\", then always switch back to the primary input
/// when it is healthy.
pub const InputPreference = enum {
    equal_input_preference,
    primary_input_preferred,

    pub const json_field_names = .{
        .equal_input_preference = "EQUAL_INPUT_PREFERENCE",
        .primary_input_preferred = "PRIMARY_INPUT_PREFERRED",
    };
};
