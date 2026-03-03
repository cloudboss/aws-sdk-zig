const ExportStatus = @import("export_status.zig").ExportStatus;
const ImportExportFileFormat = @import("import_export_file_format.zig").ImportExportFileFormat;
const ExportResourceSpecification = @import("export_resource_specification.zig").ExportResourceSpecification;

/// Provides summary information about an export in an export list.
pub const ExportSummary = struct {
    /// The date and time that the export was created.
    creation_date_time: ?i64 = null,

    /// The unique identifier that Amazon Lex assigned to the export.
    export_id: ?[]const u8 = null,

    /// The status of the export. When the status is `Completed`
    /// the export is ready to download.
    export_status: ?ExportStatus = null,

    /// The file format used in the export files.
    file_format: ?ImportExportFileFormat = null,

    /// The date and time that the export was last updated.
    last_updated_date_time: ?i64 = null,

    /// Information about the bot or bot locale that was exported.
    resource_specification: ?ExportResourceSpecification = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .export_id = "exportId",
        .export_status = "exportStatus",
        .file_format = "fileFormat",
        .last_updated_date_time = "lastUpdatedDateTime",
        .resource_specification = "resourceSpecification",
    };
};
