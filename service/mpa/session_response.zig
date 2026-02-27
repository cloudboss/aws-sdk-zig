pub const SessionResponse = enum {
    approved,
    rejected,
    no_response,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .no_response = "NO_RESPONSE",
    };
};
