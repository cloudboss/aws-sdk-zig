const IcebergCompactionStrategy = @import("iceberg_compaction_strategy.zig").IcebergCompactionStrategy;

/// Contains details about the compaction settings for an Iceberg table.
pub const IcebergCompactionSettings = struct {
    /// The compaction strategy to use for the table. This determines how files are
    /// selected and combined during compaction operations.
    strategy: ?IcebergCompactionStrategy,

    /// The target file size for the table in MB.
    target_file_size_mb: ?i32,

    pub const json_field_names = .{
        .strategy = "strategy",
        .target_file_size_mb = "targetFileSizeMB",
    };
};
