const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CACertificate = @import("ca_certificate.zig").CACertificate;

pub const ListCACertificatesInput = struct {
    /// Determines the order of the results.
    ascending_order: ?bool = null,

    /// The marker for the next set of results.
    marker: ?[]const u8 = null,

    /// The result page size.
    page_size: ?i32 = null,

    /// The name of the provisioning template.
    template_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .ascending_order = "ascendingOrder",
        .marker = "marker",
        .page_size = "pageSize",
        .template_name = "templateName",
    };
};

pub const ListCACertificatesOutput = struct {
    /// The CA certificates registered in your Amazon Web Services account.
    certificates: ?[]const CACertificate = null,

    /// The current position within the list of CA certificates.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificates = "certificates",
        .next_marker = "nextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCACertificatesInput, options: CallOptions) !ListCACertificatesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCACertificatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cacertificates";

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
    if (input.template_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "templateName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCACertificatesOutput {
    var result: ListCACertificatesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListCACertificatesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
