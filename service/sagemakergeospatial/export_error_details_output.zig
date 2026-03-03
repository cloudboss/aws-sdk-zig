const ExportErrorType = @import("export_error_type.zig").ExportErrorType;

/// The structure representing the errors in an export EarthObservationJob
/// operation.
pub const ExportErrorDetailsOutput = struct {
    /// A detailed message describing the error in an export EarthObservationJob
    /// operation.
    message: ?[]const u8 = null,

    /// The type of error in an export EarthObservationJob operation.
    @"type": ?ExportErrorType = null,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
    };
};
