const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPCConnection = @import("vpc_connection.zig").VPCConnection;

pub const DescribeVPCConnectionInput = struct {
    /// The Amazon Web Services account ID of the account that contains the VPC
    /// connection that
    /// you want described.
    aws_account_id: []const u8,

    /// The ID of the VPC connection that
    /// you're creating. This ID is a unique identifier for each Amazon Web Services
    /// Region in an Amazon Web Services account.
    vpc_connection_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .vpc_connection_id = "VPCConnectionId",
    };
};

pub const DescribeVPCConnectionOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// A response object that provides information for the specified VPC
    /// connection.
    vpc_connection: ?VPCConnection = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .status = "Status",
        .vpc_connection = "VPCConnection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeVPCConnectionInput, options: CallOptions) !DescribeVPCConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVPCConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/vpc-connections/");
    try path_buf.appendSlice(allocator, input.vpc_connection_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeVPCConnectionOutput {
    var result: DescribeVPCConnectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeVPCConnectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
