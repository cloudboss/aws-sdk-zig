const DestinationTableSource = @import("destination_table_source.zig").DestinationTableSource;

/// Defines a destination table in data preparation that receives the final
/// transformed data.
pub const DestinationTable = struct {
    /// Alias for the destination table.
    alias: []const u8,

    /// The source configuration that specifies which transform operation provides
    /// data to this destination table.
    source: DestinationTableSource,

    pub const json_field_names = .{
        .alias = "Alias",
        .source = "Source",
    };
};
