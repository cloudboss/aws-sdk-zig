const DeviceUnderTest = @import("device_under_test.zig").DeviceUnderTest;

/// Gets suite run configuration.
pub const SuiteRunConfiguration = struct {
    /// TRUE if multiple test suites run in parallel.
    parallel_run: ?bool = null,

    /// Sets the primary device for the test suite run. This requires a thing ARN or
    /// a
    /// certificate ARN.
    primary_device: DeviceUnderTest,

    /// Sets test case list.
    selected_test_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .parallel_run = "parallelRun",
        .primary_device = "primaryDevice",
        .selected_test_list = "selectedTestList",
    };
};
