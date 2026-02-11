pub const UpdateRuntimeOn = enum {
    auto,
    manual,
    function_update,

    pub const json_field_names = .{
        .auto = "Auto",
        .manual = "Manual",
        .function_update = "FunctionUpdate",
    };
};
