const RowLevelPermissionConfiguration = @import("row_level_permission_configuration.zig").RowLevelPermissionConfiguration;

/// A semantic table that represents the final analytical structure of the data.
pub const SemanticTable = struct {
    /// Alias for the semantic table.
    alias: []const u8,

    /// The identifier of the destination table from data preparation that provides
    /// data to this semantic table.
    destination_table_id: []const u8,

    /// Configuration for row level security that control data access for this
    /// semantic table.
    row_level_permission_configuration: ?RowLevelPermissionConfiguration,

    pub const json_field_names = .{
        .alias = "Alias",
        .destination_table_id = "DestinationTableId",
        .row_level_permission_configuration = "RowLevelPermissionConfiguration",
    };
};
