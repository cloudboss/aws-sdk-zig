/// Provides context for the cause of the bad request. The only supported value
/// is
/// `CODE_ERROR`.
pub const BadRequestReason = enum {
    code_error,

    pub const json_field_names = .{
        .code_error = "CODE_ERROR",
    };
};
