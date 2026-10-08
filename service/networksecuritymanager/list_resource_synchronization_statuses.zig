const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SynchronizationStatus = @import("synchronization_status.zig").SynchronizationStatus;
const ResourceSynchronizationStatusSummary = @import("resource_synchronization_status_summary.zig").ResourceSynchronizationStatusSummary;

pub const ListResourceSynchronizationStatusesInput = struct {
    /// The identifier of the deployment to list synchronization statuses for. This
    /// is the deployment's Amazon Resource Name (ARN).
    deployment_identifier: []const u8,

    /// The maximum number of results to return in a single call. Valid range:
    /// 1-100. To retrieve the remaining results, use the returned `nextToken` value
    /// in a subsequent call.
    max_results: ?i32 = null,

    /// The token for the next page of results. To retrieve the next page, call the
    /// operation again and provide this value. When there are no more results, this
    /// value is null.
    next_token: ?[]const u8 = null,

    /// Filters the results by synchronization status, such as `IN_SYNC` or
    /// `OUT_OF_SYNC`.
    synchronization_status: ?SynchronizationStatus = null,

    pub const json_field_names = .{
        .deployment_identifier = "deploymentIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .synchronization_status = "synchronizationStatus",
    };
};

pub const ListResourceSynchronizationStatusesOutput = struct {
    /// The token for the next page of results. To retrieve the next page, call the
    /// operation again and provide this value. When there are no more results, this
    /// value is null.
    next_token: ?[]const u8 = null,

    /// The list of resource synchronization statuses.
    resource_synchronization_statuses: ?[]const ResourceSynchronizationStatusSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .resource_synchronization_statuses = "resourceSynchronizationStatuses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceSynchronizationStatusesInput, options: CallOptions) !ListResourceSynchronizationStatusesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-security-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceSynchronizationStatusesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/resource-sync-statuses";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "deploymentIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.deployment_identifier);
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
    if (input.synchronization_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "synchronizationStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceSynchronizationStatusesOutput {
    const result: ListResourceSynchronizationStatusesOutput = try aws.json.parseJsonObject(
        ListResourceSynchronizationStatusesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
