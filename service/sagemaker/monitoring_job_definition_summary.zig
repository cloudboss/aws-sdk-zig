/// Summary information about a monitoring job.
pub const MonitoringJobDefinitionSummary = struct {
    /// The time that the monitoring job was created.
    creation_time: i64,

    /// The name of the endpoint that the job monitors.
    endpoint_name: []const u8,

    /// The Amazon Resource Name (ARN) of the monitoring job.
    monitoring_job_definition_arn: []const u8,

    /// The name of the monitoring job.
    monitoring_job_definition_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_name = "EndpointName",
        .monitoring_job_definition_arn = "MonitoringJobDefinitionArn",
        .monitoring_job_definition_name = "MonitoringJobDefinitionName",
    };
};
