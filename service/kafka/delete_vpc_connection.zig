const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcConnectionState = @import("vpc_connection_state.zig").VpcConnectionState;

pub const DeleteVpcConnectionInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies an MSK VPC
    /// connection.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const DeleteVpcConnectionOutput = struct {
    /// The state of the VPC connection.
    state: ?VpcConnectionState = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies an MSK VPC
    /// connection.
    vpc_connection_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .state = "State",
        .vpc_connection_arn = "VpcConnectionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVpcConnectionInput, options: CallOptions) !DeleteVpcConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVpcConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/vpc-connection/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVpcConnectionOutput {
    const result: DeleteVpcConnectionOutput = try aws.json.parseJsonObject(
        DeleteVpcConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
