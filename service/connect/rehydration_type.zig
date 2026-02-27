pub const RehydrationType = enum {
    entire_past_session,
    from_segment,

    pub const json_field_names = .{
        .entire_past_session = "ENTIRE_PAST_SESSION",
        .from_segment = "FROM_SEGMENT",
    };
};
