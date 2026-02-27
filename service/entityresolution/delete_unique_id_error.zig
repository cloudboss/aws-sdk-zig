const DeleteUniqueIdErrorType = @import("delete_unique_id_error_type.zig").DeleteUniqueIdErrorType;

/// The error information provided when the delete unique ID operation doesn't
/// complete.
pub const DeleteUniqueIdError = struct {
    /// The error type for the delete unique ID operation.
    ///
    /// The `SERVICE_ERROR` value indicates that an internal service-side problem
    /// occurred during the deletion operation.
    ///
    /// The `VALIDATION_ERROR` value indicates that the deletion operation couldn't
    /// complete because of invalid input parameters or data.
    error_type: DeleteUniqueIdErrorType,

    /// The unique ID that couldn't be deleted.
    unique_id: []const u8,

    pub const json_field_names = .{
        .error_type = "errorType",
        .unique_id = "uniqueId",
    };
};
