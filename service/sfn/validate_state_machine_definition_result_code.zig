pub const ValidateStateMachineDefinitionResultCode = enum {
    ok,
    fail,

    pub const json_field_names = .{
        .ok = "OK",
        .fail = "FAIL",
    };
};
