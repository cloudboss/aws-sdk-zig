const DeviceUnderTest = @import("device_under_test.zig").DeviceUnderTest;
const Protocol = @import("protocol.zig").Protocol;

/// Gets the suite definition configuration.
pub const SuiteDefinitionConfiguration = struct {
    /// Gets the device permission ARN. This is a required parameter.
    device_permission_role_arn: []const u8,

    /// Gets the devices configured.
    devices: ?[]const DeviceUnderTest,

    /// Gets the tests intended for qualification in a suite.
    intended_for_qualification: ?bool,

    /// Verifies if the test suite is a long duration test.
    is_long_duration_test: ?bool,

    /// Sets the MQTT protocol that is configured in the suite definition.
    protocol: ?Protocol,

    /// Gets the test suite root group. This is a required parameter.
    /// For updating or creating the latest qualification suite,
    /// if `intendedForQualification` is set to true,
    /// `rootGroup` can be an empty string. If `intendedForQualification` is false,
    /// `rootGroup` cannot be an empty string.
    /// If `rootGroup` is empty, and
    /// `intendedForQualification` is set to true,
    /// all the qualification tests are included, and the configuration is default.
    ///
    /// For a qualification suite, the minimum length is 0, and the maximum is 2048.
    /// For a
    /// non-qualification suite, the minimum length is 1, and the maximum is 2048.
    root_group: []const u8,

    /// Gets the suite definition name. This is a required parameter.
    suite_definition_name: []const u8,

    pub const json_field_names = .{
        .device_permission_role_arn = "devicePermissionRoleArn",
        .devices = "devices",
        .intended_for_qualification = "intendedForQualification",
        .is_long_duration_test = "isLongDurationTest",
        .protocol = "protocol",
        .root_group = "rootGroup",
        .suite_definition_name = "suiteDefinitionName",
    };
};
