const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CancelledChangeProperty = @import("cancelled_change_property.zig").CancelledChangeProperty;

pub const CancelDomainConfigChangeInput = struct {
    /// Name of the OpenSearch Service domain configuration request to cancel.
    domain_name: []const u8,

    /// When set to **True**, returns the list of change IDs and properties that
    /// will be cancelled without actually cancelling the change.
    dry_run: ?bool = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .dry_run = "DryRun",
    };
};

pub const CancelDomainConfigChangeOutput = struct {
    /// The unique identifiers of the changes that were cancelled.
    cancelled_change_ids: ?[]const []const u8 = null,

    /// The domain change properties that were cancelled.
    cancelled_change_properties: ?[]const CancelledChangeProperty = null,

    /// Whether or not the request was a dry run. If **True**, the changes were not
    /// actually cancelled.
    dry_run: ?bool = null,

    pub const json_field_names = .{
        .cancelled_change_ids = "CancelledChangeIds",
        .cancelled_change_properties = "CancelledChangeProperties",
        .dry_run = "DryRun",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelDomainConfigChangeInput, options: CallOptions) !CancelDomainConfigChangeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelDomainConfigChangeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/config/cancel");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRun\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelDomainConfigChangeOutput {
    const result: CancelDomainConfigChangeOutput = try aws.json.parseJsonObject(
        CancelDomainConfigChangeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
