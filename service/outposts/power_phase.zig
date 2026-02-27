pub const PowerPhase = enum {
    single_phase,
    three_phase,

    pub const json_field_names = .{
        .single_phase = "SINGLE_PHASE",
        .three_phase = "THREE_PHASE",
    };
};
