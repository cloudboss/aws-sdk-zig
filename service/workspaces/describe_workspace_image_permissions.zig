const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImagePermission = @import("image_permission.zig").ImagePermission;

pub const DescribeWorkspaceImagePermissionsInput = struct {
    /// The identifier of the image.
    image_id: []const u8,

    /// The maximum number of items to return.
    max_results: ?i32 = null,

    /// If you received a `NextToken` from a previous call that was paginated,
    /// provide this token to receive the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_id = "ImageId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeWorkspaceImagePermissionsOutput = struct {
    /// The identifier of the image.
    image_id: ?[]const u8 = null,

    /// The identifiers of the Amazon Web Services accounts that the image has been
    /// shared
    /// with.
    image_permissions: ?[]const ImagePermission = null,

    /// The token to use to retrieve the next page of results. This value is null
    /// when there are
    /// no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_id = "ImageId",
        .image_permissions = "ImagePermissions",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkspaceImagePermissionsInput, options: CallOptions) !DescribeWorkspaceImagePermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkspaceImagePermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.DescribeWorkspaceImagePermissions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkspaceImagePermissionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeWorkspaceImagePermissionsOutput, body, allocator);
}
