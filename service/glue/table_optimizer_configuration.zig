const CompactionConfiguration = @import("compaction_configuration.zig").CompactionConfiguration;
const OrphanFileDeletionConfiguration = @import("orphan_file_deletion_configuration.zig").OrphanFileDeletionConfiguration;
const RetentionConfiguration = @import("retention_configuration.zig").RetentionConfiguration;
const TableOptimizerVpcConfiguration = @import("table_optimizer_vpc_configuration.zig").TableOptimizerVpcConfiguration;

/// Contains details on the configuration of a table optimizer. You pass this
/// configuration when creating or updating a table optimizer.
pub const TableOptimizerConfiguration = struct {
    /// The configuration for a compaction optimizer. This configuration defines how
    /// data files in your table will be compacted to
    /// improve query performance and reduce storage costs.
    compaction_configuration: ?CompactionConfiguration = null,

    /// Whether table optimization is enabled.
    enabled: ?bool = null,

    /// The configuration for an orphan file deletion optimizer.
    orphan_file_deletion_configuration: ?OrphanFileDeletionConfiguration = null,

    /// The configuration for a snapshot retention optimizer.
    retention_configuration: ?RetentionConfiguration = null,

    /// A role passed by the caller which gives the service permission to update the
    /// resources associated with the optimizer on the caller's behalf.
    role_arn: ?[]const u8 = null,

    /// A `TableOptimizerVpcConfiguration` object representing the VPC configuration
    /// for a table optimizer.
    ///
    /// This configuration is necessary to perform optimization on tables that are
    /// in a customer VPC.
    vpc_configuration: ?TableOptimizerVpcConfiguration = null,

    pub const json_field_names = .{
        .compaction_configuration = "compactionConfiguration",
        .enabled = "enabled",
        .orphan_file_deletion_configuration = "orphanFileDeletionConfiguration",
        .retention_configuration = "retentionConfiguration",
        .role_arn = "roleArn",
        .vpc_configuration = "vpcConfiguration",
    };
};
