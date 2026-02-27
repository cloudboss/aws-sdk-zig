const AssociationErrorCode = @import("association_error_code.zig").AssociationErrorCode;

/// Indicates the reason that the association deployment failed, including the
/// error code and error message.
pub const AssociationStateReason = struct {
    /// The error code of the association deployment failure.
    error_code: ?AssociationErrorCode,

    /// The error message of the association deployment failure.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
