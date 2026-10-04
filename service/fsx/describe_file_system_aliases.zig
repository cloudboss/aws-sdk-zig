const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Alias = @import("alias.zig").Alias;

pub const DescribeFileSystemAliasesInput = struct {
    client_request_token: ?[]const u8 = null,

    /// The ID of the file system to return the associated DNS aliases for
    /// (String).
    file_system_id: []const u8,

    /// Maximum number of DNS aliases to return in the response (integer). This
    /// parameter value must be greater than 0. The number of items that Amazon FSx
    /// returns is
    /// the minimum of the `MaxResults` parameter specified in the request and the
    /// service's internal maximum number of items per page.
    max_results: ?i32 = null,

    /// Opaque pagination token returned from a previous
    /// `DescribeFileSystemAliases` operation (String). If a token is included in
    /// the request, the action
    /// continues the list from where the previous returning call left off.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .file_system_id = "FileSystemId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeFileSystemAliasesOutput = struct {
    /// An array of one or more DNS aliases currently associated with the specified
    /// file system.
    aliases: ?[]const Alias = null,

    /// Present if there are more DNS aliases than returned in the response
    /// (String). You
    /// can use the `NextToken` value in a later request to fetch additional
    /// descriptions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aliases = "Aliases",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFileSystemAliasesInput, options: CallOptions) !DescribeFileSystemAliasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFileSystemAliasesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DescribeFileSystemAliases");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFileSystemAliasesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFileSystemAliasesOutput, body, allocator);
}
