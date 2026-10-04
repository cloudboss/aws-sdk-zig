const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HostedZoneAssociationSummary = @import("hosted_zone_association_summary.zig").HostedZoneAssociationSummary;

pub const ListHostedZoneAssociationsInput = struct {
    /// The maximum number of results to retrieve in a single call.
    max_results: ?i32 = null,

    /// A pagination token used for large sets of results that can't be returned in
    /// a single response.
    next_token: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the DNS view.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_arn = "resourceArn",
    };
};

pub const ListHostedZoneAssociationsOutput = struct {
    /// List of the private hosted zone associations.
    hosted_zone_associations: ?[]const HostedZoneAssociationSummary = null,

    /// A pagination token used for large sets of results that can't be returned in
    /// a single response. Provide this token in the next call to get the results
    /// not returned in this call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .hosted_zone_associations = "hostedZoneAssociations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHostedZoneAssociationsInput, options: CallOptions) !ListHostedZoneAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53globalresolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHostedZoneAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/hosted-zone-associations/resource-arn/");
    try path_buf.appendSlice(allocator, input.resource_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max_results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next_token=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHostedZoneAssociationsOutput {
    var result: ListHostedZoneAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListHostedZoneAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
