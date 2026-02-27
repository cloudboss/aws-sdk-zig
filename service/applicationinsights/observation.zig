const CloudWatchEventSource = @import("cloud_watch_event_source.zig").CloudWatchEventSource;
const LogFilter = @import("log_filter.zig").LogFilter;

/// Describes an anomaly or error with the application.
pub const Observation = struct {
    /// The detail type of the CloudWatch Event-based observation, for example, `EC2
    /// Instance State-change Notification`.
    cloud_watch_event_detail_type: ?[]const u8,

    /// The ID of the CloudWatch Event-based observation related to the detected
    /// problem.
    cloud_watch_event_id: ?[]const u8,

    /// The source of the CloudWatch Event.
    cloud_watch_event_source: ?CloudWatchEventSource,

    /// The CodeDeploy application to which the deployment belongs.
    code_deploy_application: ?[]const u8,

    /// The deployment group to which the CodeDeploy deployment belongs.
    code_deploy_deployment_group: ?[]const u8,

    /// The deployment ID of the CodeDeploy-based observation related to the
    /// detected problem.
    code_deploy_deployment_id: ?[]const u8,

    /// The instance group to which the CodeDeploy instance belongs.
    code_deploy_instance_group_id: ?[]const u8,

    /// The status of the CodeDeploy deployment, for example `SUCCESS` or `
    /// FAILURE`.
    code_deploy_state: ?[]const u8,

    /// The cause of an EBS CloudWatch event.
    ebs_cause: ?[]const u8,

    /// The type of EBS CloudWatch event, such as `createVolume`,
    /// `deleteVolume` or `attachVolume`.
    ebs_event: ?[]const u8,

    /// The request ID of an EBS CloudWatch event.
    ebs_request_id: ?[]const u8,

    /// The result of an EBS CloudWatch event, such as `failed` or
    /// `succeeded`.
    ebs_result: ?[]const u8,

    /// The state of the instance, such as `STOPPING` or `TERMINATING`.
    ec_2_state: ?[]const u8,

    /// The time when the observation ended, in epoch seconds.
    end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the Health Event-based observation.
    health_event_arn: ?[]const u8,

    /// The description of the Health event provided by the service, such as Amazon
    /// EC2.
    health_event_description: ?[]const u8,

    /// The category of the Health event, such as `issue`.
    health_event_type_category: ?[]const u8,

    /// The type of the Health event, for example,
    /// `AWS_EC2_POWER_CONNECTIVITY_ISSUE`.
    health_event_type_code: ?[]const u8,

    /// The service to which the Health Event belongs, such as EC2.
    health_service: ?[]const u8,

    /// The ID of the observation type.
    id: ?[]const u8,

    /// The timestamp in the CloudWatch Logs that specifies when the matched line
    /// occurred.
    line_time: ?i64,

    /// The log filter of the observation.
    log_filter: ?LogFilter,

    /// The log group name.
    log_group: ?[]const u8,

    /// The log text of the observation.
    log_text: ?[]const u8,

    /// The name of the observation metric.
    metric_name: ?[]const u8,

    /// The namespace of the observation metric.
    metric_namespace: ?[]const u8,

    /// The category of an RDS event.
    rds_event_categories: ?[]const u8,

    /// The message of an RDS event.
    rds_event_message: ?[]const u8,

    /// The name of the S3 CloudWatch Event-based observation.
    s3_event_name: ?[]const u8,

    /// The source resource ARN of the observation.
    source_arn: ?[]const u8,

    /// The source type of the observation.
    source_type: ?[]const u8,

    /// The time when the observation was first detected, in epoch seconds.
    start_time: ?i64,

    /// The Amazon Resource Name (ARN) of the step function-based observation.
    states_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the step function execution-based
    /// observation.
    states_execution_arn: ?[]const u8,

    /// The input to the step function-based observation.
    states_input: ?[]const u8,

    /// The status of the step function-related observation.
    states_status: ?[]const u8,

    /// The unit of the source observation metric.
    unit: ?[]const u8,

    /// The value of the source observation metric.
    value: ?f64,

    /// The X-Ray request error percentage for this node.
    x_ray_error_percent: ?i32,

    /// The X-Ray request fault percentage for this node.
    x_ray_fault_percent: ?i32,

    /// The name of the X-Ray node.
    x_ray_node_name: ?[]const u8,

    /// The type of the X-Ray node.
    x_ray_node_type: ?[]const u8,

    /// The X-Ray node request average latency for this node.
    x_ray_request_average_latency: ?i64,

    /// The X-Ray request count for this node.
    x_ray_request_count: ?i32,

    /// The X-Ray request throttle percentage for this node.
    x_ray_throttle_percent: ?i32,

    pub const json_field_names = .{
        .cloud_watch_event_detail_type = "CloudWatchEventDetailType",
        .cloud_watch_event_id = "CloudWatchEventId",
        .cloud_watch_event_source = "CloudWatchEventSource",
        .code_deploy_application = "CodeDeployApplication",
        .code_deploy_deployment_group = "CodeDeployDeploymentGroup",
        .code_deploy_deployment_id = "CodeDeployDeploymentId",
        .code_deploy_instance_group_id = "CodeDeployInstanceGroupId",
        .code_deploy_state = "CodeDeployState",
        .ebs_cause = "EbsCause",
        .ebs_event = "EbsEvent",
        .ebs_request_id = "EbsRequestId",
        .ebs_result = "EbsResult",
        .ec_2_state = "Ec2State",
        .end_time = "EndTime",
        .health_event_arn = "HealthEventArn",
        .health_event_description = "HealthEventDescription",
        .health_event_type_category = "HealthEventTypeCategory",
        .health_event_type_code = "HealthEventTypeCode",
        .health_service = "HealthService",
        .id = "Id",
        .line_time = "LineTime",
        .log_filter = "LogFilter",
        .log_group = "LogGroup",
        .log_text = "LogText",
        .metric_name = "MetricName",
        .metric_namespace = "MetricNamespace",
        .rds_event_categories = "RdsEventCategories",
        .rds_event_message = "RdsEventMessage",
        .s3_event_name = "S3EventName",
        .source_arn = "SourceARN",
        .source_type = "SourceType",
        .start_time = "StartTime",
        .states_arn = "StatesArn",
        .states_execution_arn = "StatesExecutionArn",
        .states_input = "StatesInput",
        .states_status = "StatesStatus",
        .unit = "Unit",
        .value = "Value",
        .x_ray_error_percent = "XRayErrorPercent",
        .x_ray_fault_percent = "XRayFaultPercent",
        .x_ray_node_name = "XRayNodeName",
        .x_ray_node_type = "XRayNodeType",
        .x_ray_request_average_latency = "XRayRequestAverageLatency",
        .x_ray_request_count = "XRayRequestCount",
        .x_ray_throttle_percent = "XRayThrottlePercent",
    };
};
