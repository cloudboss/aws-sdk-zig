const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotCopyConfiguration = @import("snapshot_copy_configuration.zig").SnapshotCopyConfiguration;

pub const ListSnapshotCopyConfigurationsInput = struct {
    /// An optional parameter that specifies the maximum number of results to
    /// return. You can use `nextToken` to display the next page of results.
    max_results: ?i32 = null,

    /// The namespace from which to list all snapshot copy configurations.
    namespace_name: ?[]const u8 = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .namespace_name = "namespaceName",
        .next_token = "nextToken",
    };
};

pub const ListSnapshotCopyConfigurationsOutput = struct {
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// All of the returned snapshot copy configurations.
    snapshot_copy_configurations: ?[]const SnapshotCopyConfiguration = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .snapshot_copy_configurations = "snapshotCopyConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSnapshotCopyConfigurationsInput, options: CallOptions) !ListSnapshotCopyConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSnapshotCopyConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.ListSnapshotCopyConfigurations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSnapshotCopyConfigurationsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListSnapshotCopyConfigurationsOutput, body, allocator);
}
