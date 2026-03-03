const aws = @import("aws");

const MonitoringBaselineConfig = @import("monitoring_baseline_config.zig").MonitoringBaselineConfig;
const MonitoringAppSpecification = @import("monitoring_app_specification.zig").MonitoringAppSpecification;
const MonitoringInput = @import("monitoring_input.zig").MonitoringInput;
const MonitoringOutputConfig = @import("monitoring_output_config.zig").MonitoringOutputConfig;
const MonitoringResources = @import("monitoring_resources.zig").MonitoringResources;
const NetworkConfig = @import("network_config.zig").NetworkConfig;
const MonitoringStoppingCondition = @import("monitoring_stopping_condition.zig").MonitoringStoppingCondition;

/// Defines the monitoring job.
pub const MonitoringJobDefinition = struct {
    /// Baseline configuration used to validate that the data conforms to the
    /// specified constraints and statistics
    baseline_config: ?MonitoringBaselineConfig = null,

    /// Sets the environment variables in the Docker container.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// Configures the monitoring job to run a specified Docker container image.
    monitoring_app_specification: MonitoringAppSpecification,

    /// The array of inputs for the monitoring job. Currently we support monitoring
    /// an Amazon SageMaker AI Endpoint.
    monitoring_inputs: []const MonitoringInput,

    /// The array of outputs from the monitoring job to be uploaded to Amazon S3.
    monitoring_output_config: MonitoringOutputConfig,

    /// Identifies the resources, ML compute instances, and ML storage volumes to
    /// deploy for a monitoring job. In distributed processing, you specify more
    /// than one instance.
    monitoring_resources: MonitoringResources,

    /// Specifies networking options for an monitoring job.
    network_config: ?NetworkConfig = null,

    /// The Amazon Resource Name (ARN) of an IAM role that Amazon SageMaker AI can
    /// assume to perform tasks on your behalf.
    role_arn: []const u8,

    /// Specifies a time limit for how long the monitoring job is allowed to run.
    stopping_condition: ?MonitoringStoppingCondition = null,

    pub const json_field_names = .{
        .baseline_config = "BaselineConfig",
        .environment = "Environment",
        .monitoring_app_specification = "MonitoringAppSpecification",
        .monitoring_inputs = "MonitoringInputs",
        .monitoring_output_config = "MonitoringOutputConfig",
        .monitoring_resources = "MonitoringResources",
        .network_config = "NetworkConfig",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
    };
};
