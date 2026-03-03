const DeviceUnderTest = @import("device_under_test.zig").DeviceUnderTest;
const Protocol = @import("protocol.zig").Protocol;

/// Information about the suite definition.
pub const SuiteDefinitionInformation = struct {
    /// Date (in Unix epoch time) when the test suite was created.
    created_at: ?i64 = null,

    /// Specifies the devices that are under test for the test suite.
    default_devices: ?[]const DeviceUnderTest = null,

    /// Specifies if the test suite is intended for qualification.
    intended_for_qualification: ?bool = null,

    /// Verifies if the test suite is a long duration test.
    is_long_duration_test: ?bool = null,

    /// Gets the MQTT protocol that is configured in the suite definition.
    protocol: ?Protocol = null,

    /// Suite definition ID of the test suite.
    suite_definition_id: ?[]const u8 = null,

    /// Suite name of the test suite.
    suite_definition_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .default_devices = "defaultDevices",
        .intended_for_qualification = "intendedForQualification",
        .is_long_duration_test = "isLongDurationTest",
        .protocol = "protocol",
        .suite_definition_id = "suiteDefinitionId",
        .suite_definition_name = "suiteDefinitionName",
    };
};
