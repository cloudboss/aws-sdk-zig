pub const PolicyEffect = enum {
    permit,
    forbid,

    pub const json_field_names = .{
        .permit = "PERMIT",
        .forbid = "FORBID",
    };
};
