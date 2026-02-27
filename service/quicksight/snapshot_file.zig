const SnapshotFileFormatType = @import("snapshot_file_format_type.zig").SnapshotFileFormatType;
const SnapshotFileSheetSelection = @import("snapshot_file_sheet_selection.zig").SnapshotFileSheetSelection;

/// A structure that contains the information for the snapshot that you want to
/// generate. This information is provided by you when you start a new snapshot
/// job.
pub const SnapshotFile = struct {
    /// The format of the snapshot file to be generated. You can choose between
    /// `CSV`, `Excel`, or `PDF`.
    format_type: SnapshotFileFormatType,

    /// A list of `SnapshotFileSheetSelection` objects that contain information on
    /// the dashboard sheet that is exported. These objects provide information
    /// about the snapshot artifacts that are generated during the job. This
    /// structure can hold a maximum of 5 CSV configurations, 5 Excel
    /// configurations, or 1 configuration for PDF.
    sheet_selections: []const SnapshotFileSheetSelection,

    pub const json_field_names = .{
        .format_type = "FormatType",
        .sheet_selections = "SheetSelections",
    };
};
