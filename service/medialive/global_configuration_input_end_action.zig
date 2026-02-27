/// Global Configuration Input End Action
pub const GlobalConfigurationInputEndAction = enum {
    none,
    switch_and_loop_inputs,

    pub const json_field_names = .{
        .none = "NONE",
        .switch_and_loop_inputs = "SWITCH_AND_LOOP_INPUTS",
    };
};
