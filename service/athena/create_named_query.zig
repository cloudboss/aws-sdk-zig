const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateNamedQueryInput = struct {
    /// A unique case-sensitive string used to ensure the request to create the
    /// query is
    /// idempotent (executes only once). If another `CreateNamedQuery` request is
    /// received, the same response is returned and another query is not created. If
    /// a parameter
    /// has changed, for example, the `QueryString`, an error is returned.
    ///
    /// This token is listed as not required because Amazon Web Services SDKs (for
    /// example
    /// the Amazon Web Services SDK for Java) auto-generate the token for users. If
    /// you are
    /// not using the Amazon Web Services SDK or the Amazon Web Services CLI, you
    /// must provide
    /// this token or the action will fail.
    client_request_token: ?[]const u8 = null,

    /// The database to which the query belongs.
    database: []const u8,

    /// The query description.
    description: ?[]const u8 = null,

    /// The query name.
    name: []const u8,

    /// The contents of the query with all query statements.
    query_string: []const u8,

    /// The name of the workgroup in which the named query is being created.
    work_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .database = "Database",
        .description = "Description",
        .name = "Name",
        .query_string = "QueryString",
        .work_group = "WorkGroup",
    };
};

pub const CreateNamedQueryOutput = struct {
    /// The unique ID of the query.
    named_query_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .named_query_id = "NamedQueryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNamedQueryInput, options: CallOptions) !CreateNamedQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNamedQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.CreateNamedQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNamedQueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateNamedQueryOutput, body, allocator);
}
