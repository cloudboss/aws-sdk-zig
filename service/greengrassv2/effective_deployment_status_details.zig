/// Contains all error-related information for the deployment record. The status
/// details will
/// be null if the deployment is in a success state.
///
/// Greengrass nucleus v2.8.0 or later is required to get an accurate
/// `errorStack` and
/// `errorTypes` response. This field will not be returned for earlier
/// Greengrass nucleus
/// versions.
pub const EffectiveDeploymentStatusDetails = struct {
    /// Contains an ordered list of short error codes that range from the most
    /// generic error to
    /// the most specific one. The error codes describe the reason for failure
    /// whenever the
    /// `coreDeviceExecutionStatus` is in a failed state. The response will be an
    /// empty
    /// list if there is no error.
    error_stack: ?[]const []const u8,

    /// Contains tags which describe the error. You can use the error types to
    /// classify errors to
    /// assist with remediating the failure. The response will be an empty list if
    /// there is no
    /// error.
    error_types: ?[]const []const u8,

    pub const json_field_names = .{
        .error_stack = "errorStack",
        .error_types = "errorTypes",
    };
};
