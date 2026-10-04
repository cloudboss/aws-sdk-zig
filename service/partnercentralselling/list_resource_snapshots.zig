const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;
const ResourceSnapshotSummary = @import("resource_snapshot_summary.zig").ResourceSnapshotSummary;

pub const ListResourceSnapshotsInput = struct {
    /// Specifies the catalog related to the request.
    catalog: []const u8,

    /// Filters the response to include only snapshots of resources owned by the
    /// specified AWS account.
    created_by: ?[]const u8 = null,

    /// The unique identifier of the engagement associated with the snapshots.
    engagement_identifier: []const u8,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// Filters the response to include only snapshots of the specified resource.
    resource_identifier: ?[]const u8 = null,

    /// Filters the response to include only snapshots created using the specified
    /// template.
    resource_snapshot_template_identifier: ?[]const u8 = null,

    /// Filters the response to include only snapshots of the specified resource
    /// type.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .created_by = "CreatedBy",
        .engagement_identifier = "EngagementIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_identifier = "ResourceIdentifier",
        .resource_snapshot_template_identifier = "ResourceSnapshotTemplateIdentifier",
        .resource_type = "ResourceType",
    };
};

pub const ListResourceSnapshotsOutput = struct {
    /// The token to retrieve the next set of results. If there are no additional
    /// results, this value is null.
    next_token: ?[]const u8 = null,

    /// An array of resource snapshot summary objects.
    resource_snapshot_summaries: ?[]const ResourceSnapshotSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_snapshot_summaries = "ResourceSnapshotSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceSnapshotsInput, options: CallOptions) !ListResourceSnapshotsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceSnapshotsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListResourceSnapshots");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceSnapshotsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListResourceSnapshotsOutput, body, allocator);
}
