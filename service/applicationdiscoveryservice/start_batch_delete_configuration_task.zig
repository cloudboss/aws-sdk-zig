const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletionConfigurationItemType = @import("deletion_configuration_item_type.zig").DeletionConfigurationItemType;

pub const StartBatchDeleteConfigurationTaskInput = struct {
    /// The list of configuration IDs that will be deleted by the task.
    configuration_ids: []const []const u8,

    /// The type of configuration item to delete. Supported types are: SERVER.
    configuration_type: DeletionConfigurationItemType,

    pub const json_field_names = .{
        .configuration_ids = "configurationIds",
        .configuration_type = "configurationType",
    };
};

pub const StartBatchDeleteConfigurationTaskOutput = struct {
    /// The unique identifier associated with the newly started deletion task.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartBatchDeleteConfigurationTaskInput, options: CallOptions) !StartBatchDeleteConfigurationTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "discovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartBatchDeleteConfigurationTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery", "Application Discovery Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.StartBatchDeleteConfigurationTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartBatchDeleteConfigurationTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartBatchDeleteConfigurationTaskOutput, body, allocator);
}
