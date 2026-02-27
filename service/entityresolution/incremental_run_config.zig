const IncrementalRunType = @import("incremental_run_type.zig").IncrementalRunType;

/// Optional. An object that defines the incremental run type. This object
/// contains only the `incrementalRunType` field, which appears as "Automatic"
/// in the console.
///
/// For workflows where `resolutionType` is `ML_MATCHING` or `PROVIDER`,
/// incremental processing is not supported.
pub const IncrementalRunConfig = struct {
    /// The type of incremental run. The only valid value is `IMMEDIATE`. This
    /// appears as "Automatic" in the console.
    ///
    /// For workflows where `resolutionType` is `ML_MATCHING` or `PROVIDER`,
    /// incremental processing is not supported.
    incremental_run_type: ?IncrementalRunType,

    pub const json_field_names = .{
        .incremental_run_type = "incrementalRunType",
    };
};
