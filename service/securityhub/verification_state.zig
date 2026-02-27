pub const VerificationState = enum {
    unknown,
    true_positive,
    false_positive,
    benign_positive,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .true_positive = "TRUE_POSITIVE",
        .false_positive = "FALSE_POSITIVE",
        .benign_positive = "BENIGN_POSITIVE",
    };
};
