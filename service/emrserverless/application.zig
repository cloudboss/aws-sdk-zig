const aws = @import("aws");

const Architecture = @import("architecture.zig").Architecture;
const AutoStartConfig = @import("auto_start_config.zig").AutoStartConfig;
const AutoStopConfig = @import("auto_stop_config.zig").AutoStopConfig;
const DiskEncryptionConfiguration = @import("disk_encryption_configuration.zig").DiskEncryptionConfiguration;
const IdentityCenterConfiguration = @import("identity_center_configuration.zig").IdentityCenterConfiguration;
const ImageConfiguration = @import("image_configuration.zig").ImageConfiguration;
const InitialCapacityConfig = @import("initial_capacity_config.zig").InitialCapacityConfig;
const InteractiveConfiguration = @import("interactive_configuration.zig").InteractiveConfiguration;
const JobLevelCostAllocationConfiguration = @import("job_level_cost_allocation_configuration.zig").JobLevelCostAllocationConfiguration;
const MaximumAllowedResources = @import("maximum_allowed_resources.zig").MaximumAllowedResources;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const Configuration = @import("configuration.zig").Configuration;
const SchedulerConfiguration = @import("scheduler_configuration.zig").SchedulerConfiguration;
const ApplicationState = @import("application_state.zig").ApplicationState;
const WorkerTypeSpecification = @import("worker_type_specification.zig").WorkerTypeSpecification;

/// Information about an application. Amazon EMR Serverless uses applications to
/// run jobs.
pub const Application = struct {
    /// The ID of the application.
    application_id: []const u8,

    /// The CPU architecture of an application.
    architecture: ?Architecture = null,

    /// The ARN of the application.
    arn: []const u8,

    /// The configuration for an application to automatically start on job
    /// submission.
    auto_start_configuration: ?AutoStartConfig = null,

    /// The configuration for an application to automatically stop after a certain
    /// amount of time being idle.
    auto_stop_configuration: ?AutoStopConfig = null,

    /// The date and time when the application run was created.
    created_at: i64,

    /// The configuration object that allows encrypting local disks.
    disk_encryption_configuration: ?DiskEncryptionConfiguration = null,

    /// The IAM Identity Center configuration applied to enable trusted identity
    /// propagation.
    identity_center_configuration: ?IdentityCenterConfiguration = null,

    /// The image configuration applied to all worker types.
    image_configuration: ?ImageConfiguration = null,

    /// The initial capacity of the application.
    initial_capacity: ?[]const aws.map.MapEntry(InitialCapacityConfig) = null,

    /// The interactive configuration object that enables the interactive use cases
    /// for an application.
    interactive_configuration: ?InteractiveConfiguration = null,

    /// The configuration object that enables job level cost allocation.
    job_level_cost_allocation_configuration: ?JobLevelCostAllocationConfiguration = null,

    /// The maximum capacity of the application. This is cumulative across all
    /// workers at any given point in time during the lifespan of the application is
    /// created. No new resources will be created once any one of the defined limits
    /// is hit.
    maximum_capacity: ?MaximumAllowedResources = null,

    monitoring_configuration: ?MonitoringConfiguration = null,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// The network configuration for customer VPC connectivity for the application.
    network_configuration: ?NetworkConfiguration = null,

    /// The Amazon EMR release associated with the application.
    release_label: []const u8,

    /// The
    /// [Configuration](https://docs.aws.amazon.com/emr-serverless/latest/APIReference/API_Configuration.html) specifications of an application. Each configuration consists of a classification and properties. You use this parameter when creating or updating an application. To see the runtimeConfiguration object of an application, run the [GetApplication](https://docs.aws.amazon.com/emr-serverless/latest/APIReference/API_GetApplication.html) API operation.
    runtime_configuration: ?[]const Configuration = null,

    /// The scheduler configuration for batch and streaming jobs running on this
    /// application. Supported with release labels emr-7.0.0 and above.
    scheduler_configuration: ?SchedulerConfiguration = null,

    /// The state of the application.
    state: ApplicationState,

    /// The state details of the application.
    state_details: ?[]const u8 = null,

    /// The tags assigned to the application.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of application, such as Spark or Hive.
    @"type": []const u8,

    /// The date and time when the application run was last updated.
    updated_at: i64,

    /// The specification applied to each worker type.
    worker_type_specifications: ?[]const aws.map.MapEntry(WorkerTypeSpecification) = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .architecture = "architecture",
        .arn = "arn",
        .auto_start_configuration = "autoStartConfiguration",
        .auto_stop_configuration = "autoStopConfiguration",
        .created_at = "createdAt",
        .disk_encryption_configuration = "diskEncryptionConfiguration",
        .identity_center_configuration = "identityCenterConfiguration",
        .image_configuration = "imageConfiguration",
        .initial_capacity = "initialCapacity",
        .interactive_configuration = "interactiveConfiguration",
        .job_level_cost_allocation_configuration = "jobLevelCostAllocationConfiguration",
        .maximum_capacity = "maximumCapacity",
        .monitoring_configuration = "monitoringConfiguration",
        .name = "name",
        .network_configuration = "networkConfiguration",
        .release_label = "releaseLabel",
        .runtime_configuration = "runtimeConfiguration",
        .scheduler_configuration = "schedulerConfiguration",
        .state = "state",
        .state_details = "stateDetails",
        .tags = "tags",
        .@"type" = "type",
        .updated_at = "updatedAt",
        .worker_type_specifications = "workerTypeSpecifications",
    };
};
