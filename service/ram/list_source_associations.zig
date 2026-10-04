const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceShareAssociationStatus = @import("resource_share_association_status.zig").ResourceShareAssociationStatus;
const AssociatedSource = @import("associated_source.zig").AssociatedSource;

pub const ListSourceAssociationsInput = struct {
    /// The status of the source associations that you want to retrieve.
    association_status: ?ResourceShareAssociationStatus = null,

    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining results, make another call with the returned `nextToken` value.
    max_results: ?i32 = null,

    /// The pagination token that indicates the next set of results to retrieve.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Names (ARNs) of the resource shares for which you want
    /// to retrieve source associations.
    resource_share_arns: ?[]const []const u8 = null,

    /// The identifier of the source for which you want to retrieve associations.
    /// This can be an account ID, Amazon Resource Name (ARN), organization ID, or
    /// organization path.
    source_id: ?[]const u8 = null,

    /// The type of source for which you want to retrieve associations.
    source_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_status = "associationStatus",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_share_arns = "resourceShareArns",
        .source_id = "sourceId",
        .source_type = "sourceType",
    };
};

pub const ListSourceAssociationsOutput = struct {
    /// The pagination token to use to retrieve the next page of results. This value
    /// is `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// Information about the source associations.
    source_associations: ?[]const AssociatedSource = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .source_associations = "sourceAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSourceAssociationsInput, options: CallOptions) !ListSourceAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ram", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSourceAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listsourceassociations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.association_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"associationStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_share_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceShareArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSourceAssociationsOutput {
    var result: ListSourceAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSourceAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
