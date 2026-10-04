const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskInstanceStatus = @import("task_instance_status.zig").TaskInstanceStatus;

pub const GetTaskInstanceInput = struct {
    /// The unique identifier of the workflow run that contains the task instance.
    run_id: []const u8,

    /// The unique identifier of the task instance to retrieve.
    task_instance_id: []const u8,

    /// The Amazon Resource Name (ARN) of the workflow that contains the task
    /// instance.
    workflow_arn: []const u8,

    pub const json_field_names = .{
        .run_id = "RunId",
        .task_instance_id = "TaskInstanceId",
        .workflow_arn = "WorkflowArn",
    };
};

pub const GetTaskInstanceOutput = struct {
    /// The attempt number for this task instance.
    attempt_number: ?i32 = null,

    /// The duration of the task instance execution in seconds. This value is null
    /// if the task is not complete.
    duration_in_seconds: ?i32 = null,

    /// The timestamp when the task instance completed execution, in ISO 8601
    /// date-time format. This value is null if the task is not complete.
    ended_at: ?i64 = null,

    /// The error message if the task instance failed. This value is null if the
    /// task completed successfully.
    error_message: ?[]const u8 = null,

    /// The CloudWatch log stream name for this task instance execution.
    log_stream: ?[]const u8 = null,

    /// The timestamp when the task instance was last modified, in ISO 8601
    /// date-time format.
    modified_at: ?i64 = null,

    /// The name of the Apache Airflow operator used for this task instance.
    operator_name: ?[]const u8 = null,

    /// The unique identifier of the workflow run that contains this task instance.
    run_id: []const u8,

    /// The timestamp when the task instance started execution, in ISO 8601
    /// date-time format. This value is null if the task has not started.
    started_at: ?i64 = null,

    /// The current status of the task instance.
    status: ?TaskInstanceStatus = null,

    /// The unique identifier of the task definition within the workflow.
    task_id: ?[]const u8 = null,

    /// The unique identifier of this task instance.
    task_instance_id: []const u8,

    /// The Amazon Resource Name (ARN) of the workflow that contains this task
    /// instance.
    workflow_arn: []const u8,

    /// The version of the workflow that contains this task instance.
    workflow_version: ?[]const u8 = null,

    /// Cross-communication data exchanged between tasks in the workflow execution.
    xcom: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .attempt_number = "AttemptNumber",
        .duration_in_seconds = "DurationInSeconds",
        .ended_at = "EndedAt",
        .error_message = "ErrorMessage",
        .log_stream = "LogStream",
        .modified_at = "ModifiedAt",
        .operator_name = "OperatorName",
        .run_id = "RunId",
        .started_at = "StartedAt",
        .status = "Status",
        .task_id = "TaskId",
        .task_instance_id = "TaskInstanceId",
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
        .xcom = "Xcom",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTaskInstanceInput, options: CallOptions) !GetTaskInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "airflow-serverless", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetTaskInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("airflow-serverless", "MWAA Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMWAAServerless.GetTaskInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTaskInstanceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetTaskInstanceOutput, body, allocator);
}
