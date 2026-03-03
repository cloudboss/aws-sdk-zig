const SnapshotFileSheetSelectionScope = @import("snapshot_file_sheet_selection_scope.zig").SnapshotFileSheetSelectionScope;

/// A structure that contains information that identifies the snapshot that
/// needs to be generated.
pub const SnapshotFileSheetSelection = struct {
    /// The selection scope of the visuals on a sheet of a dashboard that you are
    /// generating a snapthot of. You can choose one of the following options.
    ///
    /// * `ALL_VISUALS` - Selects all visuals that are on the sheet. This value is
    ///   required if the snapshot is a PDF.
    ///
    /// * `SELECTED_VISUALS` - Select the visual that you want to add to the
    ///   snapshot. This value is required if the snapshot is a CSV or Excel
    ///   workbook.
    selection_scope: SnapshotFileSheetSelectionScope,

    /// The sheet ID of the dashboard to generate the snapshot artifact from. This
    /// value is required for CSV, Excel, and PDF format types.
    sheet_id: []const u8,

    /// A structure that lists the IDs of the visuals in the selected sheet.
    /// Supported visual types are table, pivot table visuals. This value is
    /// required if you are generating a CSV or Excel workbook. This value supports
    /// a maximum of 1 visual ID for CSV and 5 visual IDs across up to 5 sheet
    /// selections for Excel. If you are generating an Excel workbook, the order of
    /// the visual IDs provided in this structure determines the order of the
    /// worksheets in the Excel file.
    visual_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .selection_scope = "SelectionScope",
        .sheet_id = "SheetId",
        .visual_ids = "VisualIds",
    };
};
