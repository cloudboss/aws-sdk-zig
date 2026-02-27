const LineageImportStatus = @import("lineage_import_status.zig").LineageImportStatus;

/// The run lineage summary of a data source.
pub const DataSourceRunLineageSummary = struct {
    /// The import status that's part of the run lineage summary of a data source.
    import_status: ?LineageImportStatus,

    pub const json_field_names = .{
        .import_status = "importStatus",
    };
};
