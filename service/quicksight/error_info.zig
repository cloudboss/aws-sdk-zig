const IngestionErrorType = @import("ingestion_error_type.zig").IngestionErrorType;

/// Error information for the SPICE ingestion of a dataset.
pub const ErrorInfo = struct {
    /// Error message.
    message: ?[]const u8 = null,

    /// Error type.
    @"type": ?IngestionErrorType = null,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
    };
};
