pub const AssessmentInvoker = enum {
    user,
    system,

    pub const json_field_names = .{
        .user = "USER",
        .system = "SYSTEM",
    };
};
