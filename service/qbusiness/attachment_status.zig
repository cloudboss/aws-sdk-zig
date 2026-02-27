pub const AttachmentStatus = enum {
    failed,
    success,

    pub const json_field_names = .{
        .failed = "FAILED",
        .success = "SUCCESS",
    };
};
