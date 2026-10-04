const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutConfigurationSetTrackingOptionsInput = struct {
    /// The name of the configuration set that you want to add a custom tracking
    /// domain
    /// to.
    configuration_set_name: []const u8,

    /// The domain that you want to use to track open and click events.
    custom_redirect_domain: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .custom_redirect_domain = "CustomRedirectDomain",
    };
};

pub const PutConfigurationSetTrackingOptionsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutConfigurationSetTrackingOptionsInput, options: CallOptions) !PutConfigurationSetTrackingOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutConfigurationSetTrackingOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "Pinpoint Email", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/email/configuration-sets/");
    try path_buf.appendSlice(allocator, input.configuration_set_name);
    try path_buf.appendSlice(allocator, "/tracking-options");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.custom_redirect_domain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomRedirectDomain\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutConfigurationSetTrackingOptionsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutConfigurationSetTrackingOptionsOutput = .{};

    return result;
}
