const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortObject = @import("sort_object.zig").SortObject;
const ResourceSnapshotJobStatus = @import("resource_snapshot_job_status.zig").ResourceSnapshotJobStatus;
const ResourceSnapshotJobSummary = @import("resource_snapshot_job_summary.zig").ResourceSnapshotJobSummary;

pub const ListResourceSnapshotJobsInput = struct {
    /// Specifies the catalog related to the request.
    catalog: []const u8,

    /// The identifier of the engagement to filter the response.
    engagement_identifier: ?[]const u8 = null,

    /// The maximum number of results to return in a single call. If omitted,
    /// defaults to 50.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// Configures the sorting of the response. If omitted, results are sorted by
    /// `CreatedDate` in descending order.
    sort: ?SortObject = null,

    /// The status of the jobs to filter the response.
    status: ?ResourceSnapshotJobStatus = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .engagement_identifier = "EngagementIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort = "Sort",
        .status = "Status",
    };
};

pub const ListResourceSnapshotJobsOutput = struct {
    /// The token to retrieve the next set of results. If there are no additional
    /// results, this value is null.
    next_token: ?[]const u8 = null,

    /// An array of resource snapshot job summary objects.
    resource_snapshot_job_summaries: ?[]const ResourceSnapshotJobSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_snapshot_job_summaries = "ResourceSnapshotJobSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceSnapshotJobsInput, options: CallOptions) !ListResourceSnapshotJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceSnapshotJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListResourceSnapshotJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceSnapshotJobsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListResourceSnapshotJobsOutput, body, allocator);
}
