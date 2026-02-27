pub const OnboardStatus = enum {
    initialized,
    pending,
    onboarded,
    failed,

    pub const json_field_names = .{
        .initialized = "INITIALIZED",
        .pending = "PENDING",
        .onboarded = "ONBOARDED",
        .failed = "FAILED",
    };
};
