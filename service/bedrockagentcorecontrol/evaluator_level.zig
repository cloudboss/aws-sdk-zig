pub const EvaluatorLevel = enum {
    tool_call,
    trace,
    session,

    pub const json_field_names = .{
        .tool_call = "TOOL_CALL",
        .trace = "TRACE",
        .session = "SESSION",
    };
};
