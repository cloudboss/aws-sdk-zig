const IngestionErrorType = @import("ingestion_error_type.zig").IngestionErrorType;

/// Error information for the SPICE ingestion of a dataset.
pub const ErrorInfo = struct {
    /// Error message.
    message: ?[]const u8,

    /// Error type.
    type: ?IngestionErrorType,

    pub const json_field_names = .{
        .message = "Message",
        .type = "Type",
    };
};
