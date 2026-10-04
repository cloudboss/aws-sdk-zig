const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPCConnectionAvailabilityStatus = @import("vpc_connection_availability_status.zig").VPCConnectionAvailabilityStatus;
const VPCConnectionResourceStatus = @import("vpc_connection_resource_status.zig").VPCConnectionResourceStatus;

pub const DeleteVPCConnectionInput = struct {
    /// The Amazon Web Services account ID of the account where you want to delete a
    /// VPC
    /// connection.
    aws_account_id: []const u8,

    /// The ID of the VPC connection that you're creating. This ID is a unique
    /// identifier for each Amazon Web Services Region in an
    /// Amazon Web Services account.
    vpc_connection_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .vpc_connection_id = "VPCConnectionId",
    };
};

pub const DeleteVPCConnectionOutput = struct {
    /// The Amazon Resource Name (ARN) of the deleted VPC connection.
    arn: ?[]const u8 = null,

    /// The availability status of the VPC connection.
    availability_status: ?VPCConnectionAvailabilityStatus = null,

    /// The deletion status of the VPC connection.
    deletion_status: ?VPCConnectionResourceStatus = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The ID of the VPC connection that
    /// you're creating. This ID is a unique identifier for each Amazon Web Services
    /// Region in an
    /// Amazon Web Services account.
    vpc_connection_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_status = "AvailabilityStatus",
        .deletion_status = "DeletionStatus",
        .request_id = "RequestId",
        .status = "Status",
        .vpc_connection_id = "VPCConnectionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVPCConnectionInput, options: CallOptions) !DeleteVPCConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVPCConnectionInput, config: *aws.Config) !aws.http.Request {
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
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVPCConnectionOutput {
    var result: DeleteVPCConnectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteVPCConnectionOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
