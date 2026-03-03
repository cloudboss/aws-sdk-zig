const aws = @import("aws");

/// Represents a detailed validation error with message, reason, and field
/// mapping for comprehensive error reporting.
pub const ValidationError = struct {
    /// A mapping of field names to specific validation issues within the
    /// configuration.
    field_map: ?[]const aws.map.StringMapEntry = null,

    /// The error message describing the validation issue.
    message: ?[]const u8 = null,

    /// The reason code or category for the validation error.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_map = "FieldMap",
        .message = "Message",
        .reason = "Reason",
    };
};
