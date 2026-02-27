const aws = @import("aws");

const OptimizerType = @import("optimizer_type.zig").OptimizerType;

/// A structure describing the configuration and details of a storage optimizer.
pub const StorageOptimizer = struct {
    /// A map of the storage optimizer configuration. Currently contains only one
    /// key-value pair: `is_enabled` indicates true or false for acceleration.
    config: ?[]const aws.map.StringMapEntry,

    /// A message that contains information about any error (if present).
    ///
    /// When an acceleration result has an enabled status, the error message is
    /// empty.
    ///
    /// When an acceleration result has a disabled status, the message describes an
    /// error or simply indicates "disabled by the user".
    error_message: ?[]const u8,

    /// When an acceleration result has an enabled status, contains the details of
    /// the last job run.
    last_run_details: ?[]const u8,

    /// The specific type of storage optimizer. The supported value is `compaction`.
    storage_optimizer_type: ?OptimizerType,

    /// A message that contains information about any warnings (if present).
    warnings: ?[]const u8,

    pub const json_field_names = .{
        .config = "Config",
        .error_message = "ErrorMessage",
        .last_run_details = "LastRunDetails",
        .storage_optimizer_type = "StorageOptimizerType",
        .warnings = "Warnings",
    };
};
