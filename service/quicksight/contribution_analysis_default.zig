const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// The contribution analysis visual display for a line, pie, or bar chart.
pub const ContributionAnalysisDefault = struct {
    /// The dimensions columns that are used in the contribution analysis,
    /// usually a list of `ColumnIdentifiers`.
    contributor_dimensions: []const ColumnIdentifier,

    /// The measure field that is used in the contribution analysis.
    measure_field_id: []const u8,

    pub const json_field_names = .{
        .contributor_dimensions = "ContributorDimensions",
        .measure_field_id = "MeasureFieldId",
    };
};
