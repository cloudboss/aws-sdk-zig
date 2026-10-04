const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CoreNetworkRoutingInformation = @import("core_network_routing_information.zig").CoreNetworkRoutingInformation;

pub const ListCoreNetworkRoutingInformationInput = struct {
    /// BGP community values to match when filtering routing information.
    community_matches: ?[]const []const u8 = null,

    /// The ID of the core network to retrieve routing information for.
    core_network_id: []const u8,

    /// The edge location to filter routing information by.
    edge_location: []const u8,

    /// Exact AS path values to match when filtering routing information.
    exact_as_path_matches: ?[]const []const u8 = null,

    /// Local preference values to match when filtering routing information.
    local_preference_matches: ?[]const []const u8 = null,

    /// The maximum number of routing information entries to return in a single
    /// page.
    max_results: ?i32 = null,

    /// Multi-Exit Discriminator (MED) values to match when filtering routing
    /// information.
    med_matches: ?[]const []const u8 = null,

    /// Filters to apply based on next hop information.
    next_hop_filters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The name of the segment to filter routing information by.
    segment_name: []const u8,

    pub const json_field_names = .{
        .community_matches = "CommunityMatches",
        .core_network_id = "CoreNetworkId",
        .edge_location = "EdgeLocation",
        .exact_as_path_matches = "ExactAsPathMatches",
        .local_preference_matches = "LocalPreferenceMatches",
        .max_results = "MaxResults",
        .med_matches = "MedMatches",
        .next_hop_filters = "NextHopFilters",
        .next_token = "NextToken",
        .segment_name = "SegmentName",
    };
};

pub const ListCoreNetworkRoutingInformationOutput = struct {
    /// The list of routing information for the core network.
    core_network_routing_information: ?[]const CoreNetworkRoutingInformation = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .core_network_routing_information = "CoreNetworkRoutingInformation",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCoreNetworkRoutingInformationInput, options: CallOptions) !ListCoreNetworkRoutingInformationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCoreNetworkRoutingInformationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/core-networks/");
    try path_buf.appendSlice(allocator, input.core_network_id);
    try path_buf.appendSlice(allocator, "/core-network-routing-information");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.community_matches) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CommunityMatches\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EdgeLocation\":");
    try aws.json.writeValue(@TypeOf(input.edge_location), input.edge_location, allocator, &body_buf);
    has_prev = true;
    if (input.exact_as_path_matches) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExactAsPathMatches\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.local_preference_matches) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LocalPreferenceMatches\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.med_matches) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MedMatches\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_hop_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextHopFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SegmentName\":");
    try aws.json.writeValue(@TypeOf(input.segment_name), input.segment_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCoreNetworkRoutingInformationOutput {
    const result: ListCoreNetworkRoutingInformationOutput = try aws.json.parseJsonObject(
        ListCoreNetworkRoutingInformationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
