/// The image signing status. Possible values include `IN_PROGRESS`,
/// `COMPLETE`, and `FAILED`.
pub const SigningStatus = enum {
    in_progress,
    complete,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
    };
};
