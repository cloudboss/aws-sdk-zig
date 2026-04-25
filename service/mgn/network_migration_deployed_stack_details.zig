const NetworkMigrationFailedResourceDetails = @import("network_migration_failed_resource_details.zig").NetworkMigrationFailedResourceDetails;
const NetworkMigrationDeployedStackStatus = @import("network_migration_deployed_stack_status.zig").NetworkMigrationDeployedStackStatus;

/// Details about a CloudFormation stack that has been deployed as part of the
/// network migration.
pub const NetworkMigrationDeployedStackDetails = struct {
    /// A list of resources that failed to deploy.
    failed_resources: ?[]const NetworkMigrationFailedResourceDetails = null,

    /// The ID of the segment that this stack was deployed for.
    segment_id: ?[]const u8 = null,

    /// The logical ID of the stack.
    stack_logical_id: ?[]const u8 = null,

    /// The physical ID of the CloudFormation stack.
    stack_physical_id: ?[]const u8 = null,

    /// The current status of the deployed stack.
    status: ?NetworkMigrationDeployedStackStatus = null,

    /// The target AWS account where the stack was deployed.
    target_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .failed_resources = "failedResources",
        .segment_id = "segmentID",
        .stack_logical_id = "stackLogicalID",
        .stack_physical_id = "stackPhysicalID",
        .status = "status",
        .target_account = "targetAccount",
    };
};
