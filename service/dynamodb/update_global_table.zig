const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicaUpdate = @import("replica_update.zig").ReplicaUpdate;
const GlobalTableDescription = @import("global_table_description.zig").GlobalTableDescription;

pub const UpdateGlobalTableInput = struct {
    /// The global table name.
    global_table_name: []const u8,

    /// A list of Regions that should be added or removed from the global table.
    replica_updates: []const ReplicaUpdate,

    pub const json_field_names = .{
        .global_table_name = "GlobalTableName",
        .replica_updates = "ReplicaUpdates",
    };
};

pub const UpdateGlobalTableOutput = struct {
    /// Contains the details of the global table.
    global_table_description: ?GlobalTableDescription = null,

    pub const json_field_names = .{
        .global_table_description = "GlobalTableDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGlobalTableInput, options: CallOptions) !UpdateGlobalTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGlobalTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.UpdateGlobalTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGlobalTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGlobalTableOutput, body, allocator);
}
