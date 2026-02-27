pub const StopCisSessionStatus = enum {
    success,
    failed,
    interrupted,
    unsupported_os,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
        .unsupported_os = "UNSUPPORTED_OS",
    };
};
