pub const CallLegType = enum {
    caller,
    callee,

    pub const json_field_names = .{
        .caller = "CALLER",
        .callee = "CALLEE",
    };
};
