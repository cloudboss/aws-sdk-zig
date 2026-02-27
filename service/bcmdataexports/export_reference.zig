const ExportStatus = @import("export_status.zig").ExportStatus;

/// The reference details for a given export.
pub const ExportReference = struct {
    /// The Amazon Resource Name (ARN) for this export.
    export_arn: []const u8,

    /// The name of this specific data export.
    export_name: []const u8,

    /// The status of this specific data export.
    export_status: ExportStatus,

    pub const json_field_names = .{
        .export_arn = "ExportArn",
        .export_name = "ExportName",
        .export_status = "ExportStatus",
    };
};
