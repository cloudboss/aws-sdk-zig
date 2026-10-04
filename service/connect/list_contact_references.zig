const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReferenceType = @import("reference_type.zig").ReferenceType;
const ReferenceSummary = @import("reference_summary.zig").ReferenceSummary;

pub const ListContactReferencesInput = struct {
    /// The identifier of the initial contact.
    contact_id: []const u8,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    ///
    /// This is not expected to be set, because the value returned in the previous
    /// response is always null.
    next_token: ?[]const u8 = null,

    /// The type of reference.
    reference_types: []const ReferenceType,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .instance_id = "InstanceId",
        .next_token = "NextToken",
        .reference_types = "ReferenceTypes",
    };
};

pub const ListContactReferencesOutput = struct {
    /// If there are additional results, this is the token for the next set of
    /// results.
    ///
    /// This is always returned as null in the response.
    next_token: ?[]const u8 = null,

    /// Information about the flows.
    reference_summary_list: ?[]const ReferenceSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .reference_summary_list = "ReferenceSummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListContactReferencesInput, options: CallOptions) !ListContactReferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListContactReferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/contact/references/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.contact_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    for (input.reference_types) |item| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "referenceTypes=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListContactReferencesOutput {
    const result: ListContactReferencesOutput = try aws.json.parseJsonObject(
        ListContactReferencesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
