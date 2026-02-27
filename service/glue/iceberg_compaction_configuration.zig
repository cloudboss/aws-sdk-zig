const CompactionStrategy = @import("compaction_strategy.zig").CompactionStrategy;

/// The configuration for an Iceberg compaction optimizer. This configuration
/// defines parameters for optimizing the layout of data files in Iceberg
/// tables.
pub const IcebergCompactionConfiguration = struct {
    /// The minimum number of deletes that must be present in a data file to make it
    /// eligible for compaction. This parameter helps optimize compaction by
    /// focusing on files that contain a significant number of delete operations,
    /// which can improve query performance by removing deleted records. If an input
    /// is not provided, the default value 1 will be used.
    delete_file_threshold: ?i32,

    /// The minimum number of data files that must be present in a partition before
    /// compaction will actually compact files. This parameter helps control when
    /// compaction is triggered, preventing unnecessary compaction operations on
    /// partitions with few files. If an input is not provided, the default value
    /// 100 will be used.
    min_input_files: ?i32,

    /// The strategy to use for compaction. Valid values are:
    ///
    /// * `binpack`: Combines small files into larger files, typically targeting
    ///   sizes over 100MB, while applying any pending deletes.
    /// This is the recommended compaction strategy for most use cases.
    ///
    /// * `sort`: Organizes data based on specified columns which are sorted
    ///   hierarchically during compaction, improving query
    /// performance for filtered operations. This strategy is recommended when your
    /// queries frequently filter on specific columns. To use this strategy,
    /// you must first define a sort order in your Iceberg table properties using
    /// the `sort_order` table property.
    ///
    /// * `z-order`: Optimizes data organization by blending multiple attributes
    ///   into a single scalar value that can be used for sorting,
    /// allowing efficient querying across multiple dimensions. This strategy is
    /// recommended when you need to query data across multiple dimensions
    /// simultaneously. To use this strategy, you must first define a sort order in
    /// your Iceberg table properties using the
    /// `sort_order` table property.
    ///
    /// If an input is not provided, the default value 'binpack' will be used.
    strategy: ?CompactionStrategy,

    pub const json_field_names = .{
        .delete_file_threshold = "deleteFileThreshold",
        .min_input_files = "minInputFiles",
        .strategy = "strategy",
    };
};
