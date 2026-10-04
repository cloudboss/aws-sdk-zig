const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OtaMechanism = @import("ota_mechanism.zig").OtaMechanism;
const OtaTaskSchedulingConfig = @import("ota_task_scheduling_config.zig").OtaTaskSchedulingConfig;
const OtaTaskExecutionRetryConfig = @import("ota_task_execution_retry_config.zig").OtaTaskExecutionRetryConfig;
const OtaType = @import("ota_type.zig").OtaType;
const OtaProtocol = @import("ota_protocol.zig").OtaProtocol;
const OtaStatus = @import("ota_status.zig").OtaStatus;
const TaskProcessingDetails = @import("task_processing_details.zig").TaskProcessingDetails;

pub const GetOtaTaskInput = struct {
    /// The over-the-air (OTA) task id.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetOtaTaskOutput = struct {
    /// The timestamp value of when the over-the-air (OTA) task was created.
    created_at: ?i64 = null,

    /// The description of the over-the-air (OTA) task.
    description: ?[]const u8 = null,

    /// The timestamp value of when the over-the-air (OTA) task was last updated at.
    last_updated_at: ?i64 = null,

    /// The deployment mechanism for the over-the-air (OTA) task.
    ota_mechanism: ?OtaMechanism = null,

    ota_scheduling_config: ?OtaTaskSchedulingConfig = null,

    /// The query string to add things to the thing group.
    ota_target_query_string: ?[]const u8 = null,

    ota_task_execution_retry_config: ?OtaTaskExecutionRetryConfig = null,

    /// The frequency type for the over-the-air (OTA) task.
    ota_type: ?OtaType = null,

    /// The connection protocol the over-the-air (OTA) task uses to update the
    /// device.
    protocol: ?OtaProtocol = null,

    /// The URL to the Amazon S3 bucket where the over-the-air (OTA) task is stored.
    s3_url: ?[]const u8 = null,

    /// The status of the over-the-air (OTA) task.
    status: ?OtaStatus = null,

    /// A set of key/value pairs that are used to manage the over-the-air (OTA)
    /// task.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The device targeted for the over-the-air (OTA) task.
    target: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the over-the-air (OTA) task
    task_arn: ?[]const u8 = null,

    /// The identifier for the over-the-air (OTA) task configuration.
    task_configuration_id: ?[]const u8 = null,

    /// The id of the over-the-air (OTA) task.
    task_id: ?[]const u8 = null,

    /// The processing details of all over-the-air (OTA) tasks.
    task_processing_details: ?TaskProcessingDetails = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .last_updated_at = "LastUpdatedAt",
        .ota_mechanism = "OtaMechanism",
        .ota_scheduling_config = "OtaSchedulingConfig",
        .ota_target_query_string = "OtaTargetQueryString",
        .ota_task_execution_retry_config = "OtaTaskExecutionRetryConfig",
        .ota_type = "OtaType",
        .protocol = "Protocol",
        .s3_url = "S3Url",
        .status = "Status",
        .tags = "Tags",
        .target = "Target",
        .task_arn = "TaskArn",
        .task_configuration_id = "TaskConfigurationId",
        .task_id = "TaskId",
        .task_processing_details = "TaskProcessingDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOtaTaskInput, options: CallOptions) !GetOtaTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOtaTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/ota-tasks/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOtaTaskOutput {
    const result: GetOtaTaskOutput = try aws.json.parseJsonObject(
        GetOtaTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
