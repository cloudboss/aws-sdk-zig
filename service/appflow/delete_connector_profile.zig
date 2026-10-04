const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteConnectorProfileInput = struct {
    /// The name of the connector profile. The name is unique for each
    /// `ConnectorProfile` in your account.
    connector_profile_name: []const u8,

    /// Indicates whether Amazon AppFlow should delete the profile, even if it is
    /// currently
    /// in use in one or more flows.
    force_delete: ?bool = null,

    pub const json_field_names = .{
        .connector_profile_name = "connectorProfileName",
        .force_delete = "forceDelete",
    };
};

pub const DeleteConnectorProfileOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteConnectorProfileInput, options: CallOptions) !DeleteConnectorProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appflow", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteConnectorProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/delete-connector-profile";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorProfileName\":");
    try aws.json.writeValue(@TypeOf(input.connector_profile_name), input.connector_profile_name, allocator, &body_buf);
    has_prev = true;
    if (input.force_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"forceDelete\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteConnectorProfileOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteConnectorProfileOutput = .{};

    return result;
}
