const ValidationExceptionReason = @import("validation_exception_reason.zig").ValidationExceptionReason;

/// Detailed information about a single request field that failed
/// validation, including the field's location, the reason it failed, and a
/// human-readable message.
pub const ValidationExceptionField = struct {
    /// The change type the failing field applies to, if the field is part of a
    /// change request. For example, `AddDeliveryOptions`.
    change_type: ?[]const u8 = null,

    /// The entity identifier the failing field applies to, if the field is on a
    /// specific entity.
    entity_id: ?[]const u8 = null,

    /// The entity type the failing field applies to, if the field is on a
    /// specific entity. For example, `AmiProduct@1.0`.
    entity_type: ?[]const u8 = null,

    /// The name of the request field that failed validation, expressed as a
    /// JSON path (for example, `Details.DeliveryOptions[0].Type`).
    field: ?[]const u8 = null,

    /// A human-readable message describing why the field failed
    /// validation.
    message: ?[]const u8 = null,

    /// The reason the field failed validation.
    reason: ?ValidationExceptionReason = null,

    pub const json_field_names = .{
        .change_type = "ChangeType",
        .entity_id = "EntityId",
        .entity_type = "EntityType",
        .field = "Field",
        .message = "Message",
        .reason = "Reason",
    };
};
