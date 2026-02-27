/// A relation within an analysis.
pub const AnalysisSchema = struct {
    /// The tables referenced in the analysis schema.
    referenced_tables: ?[]const []const u8,

    pub const json_field_names = .{
        .referenced_tables = "referencedTables",
    };
};
