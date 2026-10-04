const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationConfigurationUpdate = @import("application_configuration_update.zig").ApplicationConfigurationUpdate;
const CloudWatchLoggingOptionUpdate = @import("cloud_watch_logging_option_update.zig").CloudWatchLoggingOptionUpdate;
const RunConfigurationUpdate = @import("run_configuration_update.zig").RunConfigurationUpdate;
const RuntimeEnvironment = @import("runtime_environment.zig").RuntimeEnvironment;
const ApplicationDetail = @import("application_detail.zig").ApplicationDetail;

pub const UpdateApplicationInput = struct {
    /// Describes application configuration updates.
    application_configuration_update: ?ApplicationConfigurationUpdate = null,

    /// The name of the application to update.
    application_name: []const u8,

    /// Describes application Amazon CloudWatch logging option updates. You can only
    /// update
    /// existing CloudWatch logging options with this action. To add a new
    /// CloudWatch logging option,
    /// use AddApplicationCloudWatchLoggingOption.
    cloud_watch_logging_option_updates: ?[]const CloudWatchLoggingOptionUpdate = null,

    /// A value you use to implement strong concurrency for application updates. You
    /// must
    /// provide the `CurrentApplicationVersionId` or the `ConditionalToken`. You
    /// get the application's current `ConditionalToken` using DescribeApplication.
    /// For better concurrency support, use the
    /// `ConditionalToken` parameter instead of
    /// `CurrentApplicationVersionId`.
    conditional_token: ?[]const u8 = null,

    /// The current application version ID. You must provide the
    /// `CurrentApplicationVersionId` or the `ConditionalToken`.You can
    /// retrieve the application version ID using DescribeApplication. For better
    /// concurrency support, use the `ConditionalToken` parameter instead of
    /// `CurrentApplicationVersionId`.
    current_application_version_id: ?i64 = null,

    /// Describes updates to the application's starting parameters.
    run_configuration_update: ?RunConfigurationUpdate = null,

    /// Updates the Managed Service for Apache Flink runtime environment used to run
    /// your code. To avoid issues you must:
    ///
    /// * Ensure your new jar and dependencies are compatible with the new runtime
    ///   selected.
    ///
    /// * Ensure your new code's state is compatible with the snapshot from which
    ///   your application will start
    runtime_environment_update: ?RuntimeEnvironment = null,

    /// Describes updates to the service execution role.
    service_execution_role_update: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_configuration_update = "ApplicationConfigurationUpdate",
        .application_name = "ApplicationName",
        .cloud_watch_logging_option_updates = "CloudWatchLoggingOptionUpdates",
        .conditional_token = "ConditionalToken",
        .current_application_version_id = "CurrentApplicationVersionId",
        .run_configuration_update = "RunConfigurationUpdate",
        .runtime_environment_update = "RuntimeEnvironmentUpdate",
        .service_execution_role_update = "ServiceExecutionRoleUpdate",
    };
};

pub const UpdateApplicationOutput = struct {
    /// Describes application updates.
    application_detail: ?ApplicationDetail = null,

    /// The operation ID that can be used to track the request.
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_detail = "ApplicationDetail",
        .operation_id = "OperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationInput, options: CallOptions) !UpdateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisanalytics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.UpdateApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateApplicationOutput, body, allocator);
}
