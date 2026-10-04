const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Parameters = @import("parameters.zig").Parameters;

pub const GetDbParameterGroupInput = struct {
    /// The id of the DB parameter group.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub const GetDbParameterGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the DB parameter group.
    arn: []const u8,

    /// A description of the DB parameter group.
    description: ?[]const u8 = null,

    /// A service-generated unique identifier.
    id: []const u8,

    /// The customer-supplied name that uniquely identifies the DB parameter group
    /// when interacting with the Amazon Timestream for InfluxDB API and CLI
    /// commands.
    name: []const u8,

    /// The parameters that comprise the DB parameter group.
    parameters: ?Parameters = null,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .id = "id",
        .name = "name",
        .parameters = "parameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDbParameterGroupInput, options: CallOptions) !GetDbParameterGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream-influxdb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDbParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("timestream-influxdb", "Timestream InfluxDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonTimestreamInfluxDB.GetDbParameterGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDbParameterGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDbParameterGroupOutput, body, allocator);
}
