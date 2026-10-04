const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SolutionVersionSummary = @import("solution_version_summary.zig").SolutionVersionSummary;

pub const ListSolutionVersionsInput = struct {
    /// The maximum number of solution versions to return.
    max_results: ?i32 = null,

    /// A token returned from the previous call to `ListSolutionVersions` for
    /// getting
    /// the next set of solution versions (if they exist).
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the solution.
    solution_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .solution_arn = "solutionArn",
    };
};

pub const ListSolutionVersionsOutput = struct {
    /// A token for getting the next set of solution versions (if they exist).
    next_token: ?[]const u8 = null,

    /// A list of solution versions describing the version properties.
    solution_versions: ?[]const SolutionVersionSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .solution_versions = "solutionVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSolutionVersionsInput, options: CallOptions) !ListSolutionVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSolutionVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.ListSolutionVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSolutionVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSolutionVersionsOutput, body, allocator);
}
