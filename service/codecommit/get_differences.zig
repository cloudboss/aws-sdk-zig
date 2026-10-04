const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Difference = @import("difference.zig").Difference;

pub const GetDifferencesInput = struct {
    /// The branch, tag, HEAD, or other fully qualified reference used to identify a
    /// commit.
    after_commit_specifier: []const u8,

    /// The file path in which to check differences. Limits the results to this
    /// path. Can also
    /// be used to specify the changed name of a directory or folder, if it has
    /// changed. If not
    /// specified, differences are shown for all paths.
    after_path: ?[]const u8 = null,

    /// The branch, tag, HEAD, or other fully qualified reference used to identify a
    /// commit
    /// (for example, the full commit ID). Optional. If not specified, all changes
    /// before the
    /// `afterCommitSpecifier` value are shown. If you do not use
    /// `beforeCommitSpecifier` in your request, consider limiting the results
    /// with `maxResults`.
    before_commit_specifier: ?[]const u8 = null,

    /// The file path in which to check for differences. Limits the results to this
    /// path. Can
    /// also be used to specify the previous name of a directory or folder. If
    /// `beforePath` and `afterPath` are not specified, differences
    /// are shown for all paths.
    before_path: ?[]const u8 = null,

    /// A non-zero, non-negative integer used to limit the number of returned
    /// results.
    max_results: ?i32 = null,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    /// The name of the repository where you want to get differences.
    repository_name: []const u8,

    pub const json_field_names = .{
        .after_commit_specifier = "afterCommitSpecifier",
        .after_path = "afterPath",
        .before_commit_specifier = "beforeCommitSpecifier",
        .before_path = "beforePath",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .repository_name = "repositoryName",
    };
};

pub const GetDifferencesOutput = struct {
    /// A data type object that contains information about the differences,
    /// including whether
    /// the difference is added, modified, or deleted (A, D, M).
    differences: ?[]const Difference = null,

    /// An enumeration token that can be used in a request to return the next batch
    /// of the results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .differences = "differences",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDifferencesInput, options: CallOptions) !GetDifferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDifferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetDifferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDifferencesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDifferencesOutput, body, allocator);
}
