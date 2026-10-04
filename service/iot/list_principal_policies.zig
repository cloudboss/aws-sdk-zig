const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Policy = @import("policy.zig").Policy;

pub const ListPrincipalPoliciesInput = struct {
    /// Specifies the order for results. If true, results are returned in ascending
    /// creation
    /// order.
    ascending_order: ?bool = null,

    /// The marker for the next set of results.
    marker: ?[]const u8 = null,

    /// The result page size.
    page_size: ?i32 = null,

    /// The principal. Valid principals are CertificateArn
    /// (arn:aws:iot:*region*:*accountId*:cert/*certificateId*), thingGroupArn
    /// (arn:aws:iot:*region*:*accountId*:thinggroup/*groupName*) and CognitoId
    /// (*region*:*id*).
    principal: []const u8,

    pub const json_field_names = .{
        .ascending_order = "ascendingOrder",
        .marker = "marker",
        .page_size = "pageSize",
        .principal = "principal",
    };
};

pub const ListPrincipalPoliciesOutput = struct {
    /// The marker for the next set of results, or null if there are no additional
    /// results.
    next_marker: ?[]const u8 = null,

    /// The policies.
    policies: ?[]const Policy = null,

    pub const json_field_names = .{
        .next_marker = "nextMarker",
        .policies = "policies",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPrincipalPoliciesInput, options: CallOptions) !ListPrincipalPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPrincipalPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/principal-policies";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.ascending_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "isAscendingOrder=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.page_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "pageSize=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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
    try request.headers.put(allocator, "x-amzn-iot-principal", input.principal);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPrincipalPoliciesOutput {
    var result: ListPrincipalPoliciesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPrincipalPoliciesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
