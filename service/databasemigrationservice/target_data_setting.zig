const TablePreparationMode = @import("table_preparation_mode.zig").TablePreparationMode;

/// Defines settings for a target data provider for a data migration.
pub const TargetDataSetting = struct {
    /// This setting determines how DMS handles the target tables before starting a
    /// data
    /// migration, either by leaving them untouched, dropping and recreating them,
    /// or truncating
    /// the existing data in the target tables.
    table_preparation_mode: ?TablePreparationMode,

    pub const json_field_names = .{
        .table_preparation_mode = "TablePreparationMode",
    };
};
