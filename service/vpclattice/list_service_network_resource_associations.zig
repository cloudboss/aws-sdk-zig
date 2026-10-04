const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceNetworkResourceAssociationSummary = @import("service_network_resource_association_summary.zig").ServiceNetworkResourceAssociationSummary;

pub const ListServiceNetworkResourceAssociationsInput = struct {
    /// Include service network resource associations of the child resource
    /// configuration with the grouped resource configuration.
    ///
    /// The type is boolean and the default value is false.
    include_children: ?bool = null,

    /// The maximum page size.
    max_results: ?i32 = null,

    /// If there are additional results, a pagination token for the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The ID of the resource configuration.
    resource_configuration_identifier: ?[]const u8 = null,

    /// The ID of the service network.
    service_network_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_children = "includeChildren",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_configuration_identifier = "resourceConfigurationIdentifier",
        .service_network_identifier = "serviceNetworkIdentifier",
    };
};

pub const ListServiceNetworkResourceAssociationsOutput = struct {
    /// Information about the associations.
    items: ?[]const ServiceNetworkResourceAssociationSummary = null,

    /// If there are additional results, a pagination token for the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceNetworkResourceAssociationsInput, options: CallOptions) !ListServiceNetworkResourceAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceNetworkResourceAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/servicenetworkresourceassociations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_children) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeChildren=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
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
    if (input.resource_configuration_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resourceConfigurationIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.service_network_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "serviceNetworkIdentifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceNetworkResourceAssociationsOutput {
    var result: ListServiceNetworkResourceAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListServiceNetworkResourceAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
