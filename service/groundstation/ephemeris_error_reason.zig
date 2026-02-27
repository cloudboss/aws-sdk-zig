const EphemerisErrorCode = @import("ephemeris_error_code.zig").EphemerisErrorCode;

/// Detailed error information for ephemeris validation failures.
///
/// Provides an error code and descriptive message to help diagnose and resolve
/// validation issues.
pub const EphemerisErrorReason = struct {
    /// The error code identifying the type of validation failure.
    ///
    /// See the [Troubleshooting Invalid Ephemerides
    /// guide](https://docs.aws.amazon.com/ground-station/latest/ug/troubleshooting-invalid-ephemerides.html) for error code details.
    error_code: EphemerisErrorCode,

    /// A human-readable message describing the validation failure.
    ///
    /// Provides specific details about what failed and may include suggestions for
    /// remediation.
    error_message: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
