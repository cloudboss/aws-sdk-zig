const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionStatus = @import("action_status.zig").ActionStatus;

pub const UpdateActionInput = struct {
    /// The name of the action to update.
    action_name: []const u8,

    /// The new description for the action.
    description: ?[]const u8 = null,

    /// The new list of properties. Overwrites the current property list.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// A list of properties to remove.
    properties_to_remove: ?[]const []const u8 = null,

    /// The new status for the action.
    status: ?ActionStatus = null,

    pub const json_field_names = .{
        .action_name = "ActionName",
        .description = "Description",
        .properties = "Properties",
        .properties_to_remove = "PropertiesToRemove",
        .status = "Status",
    };
};

pub const UpdateActionOutput = struct {
    /// The Amazon Resource Name (ARN) of the action.
    action_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_arn = "ActionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateActionInput, options: CallOptions) !UpdateActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateAction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateActionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateActionOutput, body, allocator);
}
