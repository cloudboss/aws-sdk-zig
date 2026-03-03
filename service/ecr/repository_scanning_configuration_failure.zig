const ScanningConfigurationFailureCode = @import("scanning_configuration_failure_code.zig").ScanningConfigurationFailureCode;

/// The details about any failures associated with the scanning configuration of
/// a
/// repository.
pub const RepositoryScanningConfigurationFailure = struct {
    /// The failure code.
    failure_code: ?ScanningConfigurationFailureCode = null,

    /// The reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The name of the repository.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .failure_reason = "failureReason",
        .repository_name = "repositoryName",
    };
};
