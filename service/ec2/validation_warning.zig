const ValidationError = @import("validation_error.zig").ValidationError;

/// The error codes and error messages that are returned for the parameters or
/// parameter
/// combinations that are not valid when a new launch template or new version of
/// a launch
/// template is created.
pub const ValidationWarning = struct {
    /// The error codes and error messages.
    errors: ?[]const ValidationError = null,
};
