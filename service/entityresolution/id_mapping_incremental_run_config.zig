const IdMappingIncrementalRunType = @import("id_mapping_incremental_run_type.zig").IdMappingIncrementalRunType;

/// Incremental run configuration for an ID mapping workflow.
pub const IdMappingIncrementalRunConfig = struct {
    /// The incremental run type for an ID mapping workflow.
    ///
    /// It takes only one value: `ON_DEMAND`. This setting runs the ID mapping
    /// workflow when it's manually triggered through the `StartIdMappingJob` API.
    incremental_run_type: ?IdMappingIncrementalRunType = null,

    pub const json_field_names = .{
        .incremental_run_type = "incrementalRunType",
    };
};
