const TableOptimizerConfiguration = @import("table_optimizer_configuration.zig").TableOptimizerConfiguration;
const ConfigurationSource = @import("configuration_source.zig").ConfigurationSource;
const TableOptimizerRun = @import("table_optimizer_run.zig").TableOptimizerRun;
const TableOptimizerType = @import("table_optimizer_type.zig").TableOptimizerType;

/// Contains details about an optimizer associated with a table.
pub const TableOptimizer = struct {
    /// A `TableOptimizerConfiguration` object that was specified when creating or
    /// updating a table optimizer.
    configuration: ?TableOptimizerConfiguration,

    /// Specifies the source of the optimizer configuration. This indicates how the
    /// table optimizer was configured and which entity or service
    /// initiated the configuration.
    configuration_source: ?ConfigurationSource,

    /// A `TableOptimizerRun` object representing the last run of the table
    /// optimizer.
    last_run: ?TableOptimizerRun,

    /// The type of table optimizer. The valid values are:
    ///
    /// * `compaction`: for managing compaction with a table optimizer.
    ///
    /// * `retention`: for managing the retention of snapshot with a table
    ///   optimizer.
    ///
    /// * `orphan_file_deletion`: for managing the deletion of orphan files with a
    ///   table optimizer.
    type: ?TableOptimizerType,

    pub const json_field_names = .{
        .configuration = "configuration",
        .configuration_source = "configurationSource",
        .last_run = "lastRun",
        .type = "type",
    };
};
