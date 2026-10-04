const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallDomainListsItem = @import("firewall_domain_lists_item.zig").FirewallDomainListsItem;

pub const ListFirewallDomainListsInput = struct {
    /// The ID of the Global Resolver that contains the DNS view the domain lists
    /// are associated to.
    global_resolver_id: ?[]const u8 = null,

    /// The maximum number of results to retrieve in a single call.
    max_results: ?i32 = null,

    /// A pagination token used for large sets of results that can't be returned in
    /// a single response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .global_resolver_id = "globalResolverId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListFirewallDomainListsOutput = struct {
    /// List of the DNS Firewall domain lists.
    firewall_domain_lists: ?[]const FirewallDomainListsItem = null,

    /// A pagination token used for large sets of results that can't be returned in
    /// a single response. Provide this token in the next call to get the results
    /// not returned in this call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_domain_lists = "firewallDomainLists",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFirewallDomainListsInput, options: CallOptions) !ListFirewallDomainListsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFirewallDomainListsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/firewall-domain-lists";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.global_resolver_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "global_resolver_id=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFirewallDomainListsOutput {
    const result: ListFirewallDomainListsOutput = try aws.json.parseJsonObject(
        ListFirewallDomainListsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
