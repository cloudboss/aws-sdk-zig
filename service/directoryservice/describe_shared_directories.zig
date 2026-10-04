const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SharedDirectory = @import("shared_directory.zig").SharedDirectory;

pub const DescribeSharedDirectoriesInput = struct {
    /// The number of shared directories to return in the response object.
    limit: ?i32 = null,

    /// The `DescribeSharedDirectoriesResult.NextToken` value from a previous call
    /// to
    /// DescribeSharedDirectories. Pass null if this is the first call.
    next_token: ?[]const u8 = null,

    /// Returns the identifier of the directory in the directory owner account.
    owner_directory_id: []const u8,

    /// A list of identifiers of all shared directories in your account.
    shared_directory_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .next_token = "NextToken",
        .owner_directory_id = "OwnerDirectoryId",
        .shared_directory_ids = "SharedDirectoryIds",
    };
};

pub const DescribeSharedDirectoriesOutput = struct {
    /// If not null, token that indicates that more results are available. Pass this
    /// value for the
    /// `NextToken` parameter in a subsequent call to DescribeSharedDirectories to
    /// retrieve the next set of items.
    next_token: ?[]const u8 = null,

    /// A list of all shared directories in your account.
    shared_directories: ?[]const SharedDirectory = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .shared_directories = "SharedDirectories",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSharedDirectoriesInput, options: CallOptions) !DescribeSharedDirectoriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSharedDirectoriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeSharedDirectories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSharedDirectoriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSharedDirectoriesOutput, body, allocator);
}
