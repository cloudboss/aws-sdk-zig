pub const SbomValidationResult = enum {
    failed,
    succeeded,

    pub const json_field_names = .{
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
    };
};
