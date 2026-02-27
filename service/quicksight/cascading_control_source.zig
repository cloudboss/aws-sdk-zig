const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// The source controls that are used in a `CascadingControlConfiguration`.
pub const CascadingControlSource = struct {
    /// The column identifier that determines which column to look up for the source
    /// sheet control.
    column_to_match: ?ColumnIdentifier,

    /// The source sheet control ID of a `CascadingControlSource`.
    source_sheet_control_id: ?[]const u8,

    pub const json_field_names = .{
        .column_to_match = "ColumnToMatch",
        .source_sheet_control_id = "SourceSheetControlId",
    };
};
