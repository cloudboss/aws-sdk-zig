const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiffHunk = @import("diff_hunk.zig").DiffHunk;

pub const GetBlobDifferencesInput = struct {
    /// The ID of the "after" (destination) blob in the diff. Typically the value of
    /// `afterBlob.blobId` from a `Difference` object returned by
    /// GetDifferences.
    after_blob_id: []const u8,

    /// The ID of the "before" (source) blob in the diff. Typically the value of
    /// `beforeBlob.blobId` from a `Difference` object returned by
    /// GetDifferences.
    ///
    /// If you do not specify a value, the operation returns a diff against an empty
    /// before-state. This is equivalent to treating the file as newly added.
    before_blob_id: ?[]const u8 = null,

    /// The number of unchanged lines of context to include before and after each
    /// block of
    /// changes in a hunk. Valid values are 0 through 20. Defaults to `3`.
    context_lines: ?i32 = null,

    /// Specifies whether to ignore whitespace-only changes when computing the diff.
    /// When
    /// `true`, the operation treats lines that differ only in whitespace as
    /// unchanged. Defaults to `false`.
    ignore_whitespace: ?bool = null,

    /// The maximum number of `DiffHunk` entries to return in a single response
    /// page. Defaults to `100`.
    max_results: ?i32 = null,

    /// An enumeration token that returns the next batch of results when present in
    /// a
    /// request.
    next_token: ?[]const u8 = null,

    /// The name of the repository that contains the blobs to compare.
    repository_name: []const u8,

    pub const json_field_names = .{
        .after_blob_id = "afterBlobId",
        .before_blob_id = "beforeBlobId",
        .context_lines = "contextLines",
        .ignore_whitespace = "ignoreWhitespace",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .repository_name = "repositoryName",
    };
};

pub const GetBlobDifferencesOutput = struct {
    /// The size, in bytes, of the blob identified by `afterBlobId`.
    after_blob_size: ?i64 = null,

    /// The size, in bytes, of the blob identified by `beforeBlobId`. Returns
    /// `0` when you do not specify `beforeBlobId`.
    before_blob_size: ?i64 = null,

    /// An ordered list of diff hunks. Each hunk represents a contiguous run of
    /// changed and
    /// adjacent context lines. The list is empty when the blobs are identical or
    /// when the
    /// content is binary. The list is also empty when a paginated request has
    /// already returned
    /// all hunks in earlier pages, in which case `NextToken` is also
    /// `null`.
    hunks: ?[]const DiffHunk = null,

    /// Specifies whether the operation treated the diff content as binary. When
    /// `true`, the operation does not compute a line-level diff and
    /// `hunks` is empty.
    is_binary: bool,

    /// An enumeration token that can be used in a request to return the next batch
    /// of
    /// `DiffHunk` entries. `null` when the response contains the final
    /// page of the diff.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_blob_size = "afterBlobSize",
        .before_blob_size = "beforeBlobSize",
        .hunks = "hunks",
        .is_binary = "isBinary",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBlobDifferencesInput, options: CallOptions) !GetBlobDifferencesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBlobDifferencesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetBlobDifferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBlobDifferencesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetBlobDifferencesOutput, body, allocator);
}
