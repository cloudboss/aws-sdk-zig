const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkerConfigurationRevisionDescription = @import("worker_configuration_revision_description.zig").WorkerConfigurationRevisionDescription;
const WorkerConfigurationState = @import("worker_configuration_state.zig").WorkerConfigurationState;

pub const DescribeWorkerConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the worker configuration that you want to
    /// get information about.
    worker_configuration_arn: []const u8,

    pub const json_field_names = .{
        .worker_configuration_arn = "workerConfigurationArn",
    };
};

pub const DescribeWorkerConfigurationOutput = struct {
    /// The time that the worker configuration was created.
    creation_time: ?i64 = null,

    /// The description of the worker configuration.
    description: ?[]const u8 = null,

    /// The latest revision of the custom configuration.
    latest_revision: ?WorkerConfigurationRevisionDescription = null,

    /// The name of the worker configuration.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the custom configuration.
    worker_configuration_arn: ?[]const u8 = null,

    /// The state of the worker configuration.
    worker_configuration_state: ?WorkerConfigurationState = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .latest_revision = "latestRevision",
        .name = "name",
        .worker_configuration_arn = "workerConfigurationArn",
        .worker_configuration_state = "workerConfigurationState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkerConfigurationInput, options: CallOptions) !DescribeWorkerConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafkaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkerConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/worker-configurations/");
    try path_buf.appendSlice(allocator, input.worker_configuration_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkerConfigurationOutput {
    const result: DescribeWorkerConfigurationOutput = try aws.json.parseJsonObject(
        DescribeWorkerConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
