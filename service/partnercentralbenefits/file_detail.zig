const FileType = @import("file_type.zig").FileType;

/// Represents detailed information about a file attached to a benefit
/// application.
pub const FileDetail = struct {
    /// The business purpose or use case that this file supports in the benefit
    /// application.
    business_use_case: ?[]const u8 = null,

    /// The timestamp when the file was uploaded.
    created_at: ?i64 = null,

    /// The identifier of the user who uploaded the file.
    created_by: ?[]const u8 = null,

    /// The original name of the uploaded file.
    file_name: ?[]const u8 = null,

    /// The current processing status of the file (e.g., uploaded, processing,
    /// approved, rejected).
    file_status: ?[]const u8 = null,

    /// The reason for that particulat file status.
    file_status_reason: ?[]const u8 = null,

    /// The type or category of the file (e.g., document, image, spreadsheet).
    file_type: ?FileType = null,

    /// The URI or location where the file is stored.
    file_uri: []const u8,

    pub const json_field_names = .{
        .business_use_case = "BusinessUseCase",
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .file_name = "FileName",
        .file_status = "FileStatus",
        .file_status_reason = "FileStatusReason",
        .file_type = "FileType",
        .file_uri = "FileURI",
    };
};
