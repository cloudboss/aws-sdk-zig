const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SharedImagePermissions = @import("shared_image_permissions.zig").SharedImagePermissions;

pub const DescribeImagePermissionsInput = struct {
    /// The maximum size of each page of results.
    max_results: ?i32 = null,

    /// The name of the private image for which to describe permissions. The image
    /// must be one that you own.
    name: []const u8,

    /// The pagination token to use to retrieve the next page of results for this
    /// operation. If this value is null, it retrieves the first page.
    next_token: ?[]const u8 = null,

    /// The 12-digit identifier of one or more AWS accounts with which the image is
    /// shared.
    shared_aws_account_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .name = "Name",
        .next_token = "NextToken",
        .shared_aws_account_ids = "SharedAwsAccountIds",
    };
};

pub const DescribeImagePermissionsOutput = struct {
    /// The name of the private image.
    name: ?[]const u8 = null,

    /// The pagination token to use to retrieve the next page of results for this
    /// operation. If there are no more pages, this value is null.
    next_token: ?[]const u8 = null,

    /// The permissions for a private image that you own.
    shared_image_permissions_list: ?[]const SharedImagePermissions = null,

    pub const json_field_names = .{
        .name = "Name",
        .next_token = "NextToken",
        .shared_image_permissions_list = "SharedImagePermissionsList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeImagePermissionsInput, options: CallOptions) !DescribeImagePermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeImagePermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.DescribeImagePermissions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeImagePermissionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeImagePermissionsOutput, body, allocator);
}
