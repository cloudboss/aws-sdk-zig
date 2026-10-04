const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingDetails = @import("finding_details.zig").FindingDetails;
const FindingType = @import("finding_type.zig").FindingType;
const ResourceType = @import("resource_type.zig").ResourceType;
const FindingStatus = @import("finding_status.zig").FindingStatus;

pub const GetFindingV2Input = struct {
    /// The [ARN of the
    /// analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-getting-started.html#permission-resources) that generated the finding.
    analyzer_arn: []const u8,

    /// The ID of the finding to retrieve.
    id: []const u8,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .analyzer_arn = "analyzerArn",
        .id = "id",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const GetFindingV2Output = struct {
    /// The time at which the resource-based policy or IAM entity that generated the
    /// finding was analyzed.
    analyzed_at: i64,

    /// The time at which the finding was created.
    created_at: i64,

    /// An error.
    @"error": ?[]const u8 = null,

    /// A localized message that explains the finding and provides guidance on how
    /// to address it.
    finding_details: ?[]const FindingDetails = null,

    /// The type of the finding. For external access analyzers, the type is
    /// `ExternalAccess`. For unused access analyzers, the type can be
    /// `UnusedIAMRole`, `UnusedIAMUserAccessKey`, `UnusedIAMUserPassword`, or
    /// `UnusedPermission`. For internal access analyzers, the type is
    /// `InternalAccess`.
    finding_type: ?FindingType = null,

    /// The ID of the finding to retrieve.
    id: []const u8,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    /// The resource that generated the finding.
    resource: ?[]const u8 = null,

    /// Tye Amazon Web Services account ID that owns the resource.
    resource_owner_account: []const u8,

    /// The type of the resource identified in the finding.
    resource_type: ResourceType,

    /// The status of the finding.
    status: FindingStatus,

    /// The time at which the finding was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .analyzed_at = "analyzedAt",
        .created_at = "createdAt",
        .@"error" = "error",
        .finding_details = "findingDetails",
        .finding_type = "findingType",
        .id = "id",
        .next_token = "nextToken",
        .resource = "resource",
        .resource_owner_account = "resourceOwnerAccount",
        .resource_type = "resourceType",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingV2Input, options: CallOptions) !GetFindingV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "access-analyzer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/findingv2/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "analyzerArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.analyzer_arn);
    query_has_prev = true;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingV2Output {
    const result: GetFindingV2Output = try aws.json.parseJsonObject(
        GetFindingV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
