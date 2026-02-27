const ValidationSeverity = @import("validation_severity.zig").ValidationSeverity;

/// An error or warning for a desired configuration option value.
pub const ValidationMessage = struct {
    /// A message describing the error or warning.
    message: ?[]const u8,

    /// The namespace to which the option belongs.
    namespace: ?[]const u8,

    /// The name of the option.
    option_name: ?[]const u8,

    /// An indication of the severity of this message:
    ///
    /// * `error`: This message indicates that this is not a valid setting for an
    /// option.
    ///
    /// * `warning`: This message is providing information you should take into
    /// account.
    severity: ?ValidationSeverity,
};
