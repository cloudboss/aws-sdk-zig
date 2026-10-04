const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceEndpointAssociationSummary = @import("resource_endpoint_association_summary.zig").ResourceEndpointAssociationSummary;

pub const ListResourceEndpointAssociationsInput = struct {
    /// The maximum page size.
    max_results: ?i32 = null,

    /// A pagination token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The ID for the resource configuration associated with the VPC endpoint.
    resource_configuration_identifier: []const u8,

    /// The ID of the association.
    resource_endpoint_association_identifier: ?[]const u8 = null,

    /// The ID of the VPC endpoint in the association.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The owner of the VPC endpoint in the association.
    vpc_endpoint_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_configuration_identifier = "resourceConfigurationIdentifier",
        .resource_endpoint_association_identifier = "resourceEndpointAssociationIdentifier",
        .vpc_endpoint_id = "vpcEndpointId",
        .vpc_endpoint_owner = "vpcEndpointOwner",
    };
};

pub const ListResourceEndpointAssociationsOutput = struct {
    /// Information about the VPC endpoint associations.
    items: ?[]const ResourceEndpointAssociationSummary = null,

    /// If there are additional results, a pagination token for the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceEndpointAssociationsInput, options: CallOptions) !ListResourceEndpointAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceEndpointAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/resourceendpointassociations";

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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceConfigurationIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_configuration_identifier);
    query_has_prev = true;
    if (input.resource_endpoint_association_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resourceEndpointAssociationIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.vpc_endpoint_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "vpcEndpointId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.vpc_endpoint_owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "vpcEndpointOwner=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceEndpointAssociationsOutput {
    var result: ListResourceEndpointAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListResourceEndpointAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
