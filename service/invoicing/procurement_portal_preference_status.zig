pub const ProcurementPortalPreferenceStatus = enum {
    pending_verification,
    test_initialized,
    test_initialization_failed,
    test_failed,
    active,
    suspended,

    pub const json_field_names = .{
        .pending_verification = "PENDING_VERIFICATION",
        .test_initialized = "TEST_INITIALIZED",
        .test_initialization_failed = "TEST_INITIALIZATION_FAILED",
        .test_failed = "TEST_FAILED",
        .active = "ACTIVE",
        .suspended = "SUSPENDED",
    };
};
