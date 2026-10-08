const ErrorMessageType = @import("error_message_type.zig").ErrorMessageType;

/// A structure that defines the level of detail included in error messages
/// returned by PySpark jobs. This configuration allows you to control the
/// verbosity of error messages to help with troubleshooting PySpark jobs while
/// maintaining appropriate security controls.
pub const ErrorMessageConfiguration = struct {
    /// The level of detail for error messages returned by the PySpark job. When set
    /// to DETAILED, error messages include more information to help troubleshoot
    /// issues with your PySpark job.
    ///
    /// Because this setting may expose sensitive data, it is recommended for
    /// development and testing environments.
    type: ErrorMessageType,

    pub const json_field_names = .{
        .type = "type",
    };
};
