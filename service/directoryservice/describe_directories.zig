const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DirectoryDescription = @import("directory_description.zig").DirectoryDescription;

pub const DescribeDirectoriesInput = struct {
    /// A list of identifiers of the directories for which to obtain the
    /// information. If this
    /// member is null, all directories that belong to the current account are
    /// returned.
    ///
    /// An empty list results in an `InvalidParameterException` being thrown.
    directory_ids: ?[]const []const u8 = null,

    /// The maximum number of items to return. If this value is zero, the maximum
    /// number of items
    /// is specified by the limitations of the operation.
    limit: ?i32 = null,

    /// The `DescribeDirectoriesResult.NextToken` value from a previous call to
    /// DescribeDirectories. Pass null if this is the first call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_ids = "DirectoryIds",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const DescribeDirectoriesOutput = struct {
    /// The list of available DirectoryDescription objects that were
    /// retrieved.
    ///
    /// It is possible that this list contains less than the number of items
    /// specified in the
    /// `Limit` member of the request. This occurs if there are less than the
    /// requested
    /// number of items left to retrieve, or if the limitations of the operation
    /// have been
    /// exceeded.
    directory_descriptions: ?[]const DirectoryDescription = null,

    /// If not null, more results are available. Pass this value for the `NextToken`
    /// parameter in a subsequent call to DescribeDirectories to retrieve the next
    /// set of items.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_descriptions = "DirectoryDescriptions",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDirectoriesInput, options: CallOptions) !DescribeDirectoriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDirectoriesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeDirectories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDirectoriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDirectoriesOutput, body, allocator);
}
