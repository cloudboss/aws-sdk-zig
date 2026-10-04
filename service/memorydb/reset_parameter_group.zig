const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParameterGroup = @import("parameter_group.zig").ParameterGroup;

pub const ResetParameterGroupInput = struct {
    /// If true, all parameters in the parameter group are reset to their default
    /// values. If false, only the parameters listed by ParameterNames are reset to
    /// their default values.
    all_parameters: ?bool = null,

    /// The name of the parameter group to reset.
    parameter_group_name: []const u8,

    /// An array of parameter names to reset to their default values. If
    /// AllParameters is true, do not use ParameterNames. If AllParameters is false,
    /// you must specify the name of at least one parameter to reset.
    parameter_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .all_parameters = "AllParameters",
        .parameter_group_name = "ParameterGroupName",
        .parameter_names = "ParameterNames",
    };
};

pub const ResetParameterGroupOutput = struct {
    /// The parameter group being reset.
    parameter_group: ?ParameterGroup = null,

    pub const json_field_names = .{
        .parameter_group = "ParameterGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResetParameterGroupInput, options: CallOptions) !ResetParameterGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ResetParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.ResetParameterGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResetParameterGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ResetParameterGroupOutput, body, allocator);
}
