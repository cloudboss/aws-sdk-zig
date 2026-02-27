const EntityRejectionErrorType = @import("entity_rejection_error_type.zig").EntityRejectionErrorType;

/// If an entity is rejected when a `PutLogEvents` request was made, this
/// includes
/// details about the reason for the rejection.
pub const RejectedEntityInfo = struct {
    /// The type of error that caused the rejection of the entity when calling
    /// `PutLogEvents`.
    error_type: EntityRejectionErrorType,

    pub const json_field_names = .{
        .error_type = "errorType",
    };
};
