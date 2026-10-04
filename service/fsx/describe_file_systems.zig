const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileSystem = @import("file_system.zig").FileSystem;

pub const DescribeFileSystemsInput = struct {
    /// IDs of the file systems whose descriptions you want to retrieve
    /// (String).
    file_system_ids: ?[]const []const u8 = null,

    /// Maximum number of file systems to return in the response (integer). This
    /// parameter value must be greater than 0. The number of items that Amazon FSx
    /// returns is
    /// the minimum of the `MaxResults` parameter specified in the request and the
    /// service's internal maximum number of items per page.
    max_results: ?i32 = null,

    /// Opaque pagination token returned from a previous `DescribeFileSystems`
    /// operation (String). If a token present, the operation continues the list
    /// from where the
    /// returning call left off.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_ids = "FileSystemIds",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeFileSystemsOutput = struct {
    /// An array of file system descriptions.
    file_systems: ?[]const FileSystem = null,

    /// Present if there are more file systems than returned in the response
    /// (String). You
    /// can use the `NextToken` value in the later request to fetch the
    /// descriptions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_systems = "FileSystems",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFileSystemsInput, options: CallOptions) !DescribeFileSystemsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFileSystemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DescribeFileSystems");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFileSystemsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFileSystemsOutput, body, allocator);
}
