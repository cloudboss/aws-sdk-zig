pub const VerificationState = enum {
    false_positive,
    benign_positive,
    true_positive,
    unknown,

    pub const json_field_names = .{
        .false_positive = "FALSE_POSITIVE",
        .benign_positive = "BENIGN_POSITIVE",
        .true_positive = "TRUE_POSITIVE",
        .unknown = "UNKNOWN",
    };
};
