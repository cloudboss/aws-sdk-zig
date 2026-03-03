const ImportFailureStatus = @import("import_failure_status.zig").ImportFailureStatus;

/// Provides information about an import failure.
pub const ImportFailureListItem = struct {
    /// Provides the reason the import failed.
    error_message: ?[]const u8 = null,

    /// The type of import error.
    error_type: ?[]const u8 = null,

    /// When the import was last updated.
    last_updated_time: ?i64 = null,

    /// The location of the failure in the S3 bucket.
    location: ?[]const u8 = null,

    /// The status of the import.
    status: ?ImportFailureStatus = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .error_type = "ErrorType",
        .last_updated_time = "LastUpdatedTime",
        .location = "Location",
        .status = "Status",
    };
};
