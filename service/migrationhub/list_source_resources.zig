const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceResource = @import("source_resource.zig").SourceResource;

pub const ListSourceResourcesInput = struct {
    /// The maximum number of results to include in the response. If more results
    /// exist than the
    /// value that you specify here for `MaxResults`, the response will include a
    /// token
    /// that you can use to retrieve the next set of results.
    max_results: ?i32 = null,

    /// A unique identifier that references the migration task. *Do not store
    /// confidential data in this field.*
    migration_task_name: []const u8,

    /// If `NextToken` was returned by a previous call, there are more results
    /// available. The value of `NextToken` is a unique pagination token for each
    /// page.
    /// To retrieve the next page of results, specify the `NextToken` value that the
    /// previous call returned. Keep all other arguments unchanged. Each pagination
    /// token expires
    /// after 24 hours. Using an expired pagination token will return an HTTP 400
    /// InvalidToken
    /// error.
    next_token: ?[]const u8 = null,

    /// The name of the progress-update stream, which is used for access control as
    /// well as a
    /// namespace for migration-task names that is implicitly linked to your AWS
    /// account. The
    /// progress-update stream must uniquely identify the migration tool as it is
    /// used for all
    /// updates made by the tool; however, it does not need to be unique for each
    /// AWS account
    /// because it is scoped to the AWS account.
    progress_update_stream: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .migration_task_name = "MigrationTaskName",
        .next_token = "NextToken",
        .progress_update_stream = "ProgressUpdateStream",
    };
};

pub const ListSourceResourcesOutput = struct {
    /// If the response includes a `NextToken` value, that means that there are more
    /// results available. The value of `NextToken` is a unique pagination token for
    /// each page. To retrieve the next page of results, call this API again and
    /// specify this
    /// `NextToken` value in the request. Keep all other arguments unchanged. Each
    /// pagination token expires after 24 hours. Using an expired pagination token
    /// will return an
    /// HTTP 400 InvalidToken error.
    next_token: ?[]const u8 = null,

    /// The list of source resources.
    source_resource_list: ?[]const SourceResource = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .source_resource_list = "SourceResourceList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSourceResourcesInput, options: CallOptions) !ListSourceResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgh", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSourceResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgh", "Migration Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHub.ListSourceResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSourceResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSourceResourcesOutput, body, allocator);
}
