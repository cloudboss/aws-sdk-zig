const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeaturedDocument = @import("featured_document.zig").FeaturedDocument;
const FeaturedResultsSetStatus = @import("featured_results_set_status.zig").FeaturedResultsSetStatus;
const FeaturedResultsSet = @import("featured_results_set.zig").FeaturedResultsSet;

pub const UpdateFeaturedResultsSetInput = struct {
    /// A new description for the set of featured results.
    description: ?[]const u8 = null,

    /// A list of document IDs for the documents you want to feature at the
    /// top of the search results page. For more information on the list of
    /// featured documents, see
    /// [FeaturedResultsSet](https://docs.aws.amazon.com/kendra/latest/dg/API_FeaturedResultsSet.html).
    featured_documents: ?[]const FeaturedDocument = null,

    /// The identifier of the set of featured results that you want to update.
    featured_results_set_id: []const u8,

    /// A new name for the set of featured results.
    featured_results_set_name: ?[]const u8 = null,

    /// The identifier of the index used for featuring results.
    index_id: []const u8,

    /// A list of queries for featuring results. For more information on the
    /// list of queries, see
    /// [FeaturedResultsSet](https://docs.aws.amazon.com/kendra/latest/dg/API_FeaturedResultsSet.html).
    query_texts: ?[]const []const u8 = null,

    /// You can set the status to `ACTIVE` or `INACTIVE`.
    /// When the value is `ACTIVE`, featured results are ready for
    /// use. You can still configure your settings before setting the status
    /// to `ACTIVE`. The queries you specify for featured results
    /// must be unique per featured results set for each index, whether the
    /// status is `ACTIVE` or `INACTIVE`.
    status: ?FeaturedResultsSetStatus = null,

    pub const json_field_names = .{
        .description = "Description",
        .featured_documents = "FeaturedDocuments",
        .featured_results_set_id = "FeaturedResultsSetId",
        .featured_results_set_name = "FeaturedResultsSetName",
        .index_id = "IndexId",
        .query_texts = "QueryTexts",
        .status = "Status",
    };
};

pub const UpdateFeaturedResultsSetOutput = struct {
    /// Information on the set of featured results. This includes the identifier
    /// of the featured results set, whether the featured results set is active
    /// or inactive, when the featured results set was last updated, and more.
    featured_results_set: ?FeaturedResultsSet = null,

    pub const json_field_names = .{
        .featured_results_set = "FeaturedResultsSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFeaturedResultsSetInput, options: CallOptions) !UpdateFeaturedResultsSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFeaturedResultsSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.UpdateFeaturedResultsSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFeaturedResultsSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateFeaturedResultsSetOutput, body, allocator);
}
