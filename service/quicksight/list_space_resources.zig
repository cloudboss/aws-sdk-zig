const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SpaceResourceSummary = @import("space_resource_summary.zig").SpaceResourceSummary;

pub const ListSpaceResourcesInput = struct {
    /// The ID of the Amazon Web Services account that contains the space.
    aws_account_id: []const u8,

    /// The ID of the space that you want to list resources for.
    space_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .space_id = "SpaceId",
    };
};

pub const ListSpaceResourcesOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The ARN of the space.
    space_arn: ?[]const u8 = null,

    /// The ID of the space.
    space_id: []const u8,

    /// A list of resource summaries in the space.
    space_resources: ?[]const SpaceResourceSummary = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .space_arn = "spaceArn",
        .space_id = "spaceId",
        .space_resources = "SpaceResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSpaceResourcesInput, options: CallOptions) !ListSpaceResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSpaceResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/spaces/");
    try path_buf.appendSlice(allocator, input.space_id);
    try path_buf.appendSlice(allocator, "/resources");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSpaceResourcesOutput {
    const result: ListSpaceResourcesOutput = try aws.json.parseJsonObject(
        ListSpaceResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
