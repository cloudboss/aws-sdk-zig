const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListOrganizationalUnitsInput = struct {
    /// The maximum number of organizational units to return in a single call. Valid
    /// values are 1-100.
    max_results: ?i32 = null,

    /// The token for the next page of results. Use the value returned in the
    /// previous response.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the notification configuration used to
    /// filter the organizational units.
    notification_configuration_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .notification_configuration_arn = "notificationConfigurationArn",
    };
};

pub const ListOrganizationalUnitsOutput = struct {
    /// The token to use for the next page of results. If there are no additional
    /// results, this value is null.
    next_token: ?[]const u8 = null,

    /// The list of organizational units that match the specified criteria.
    organizational_units: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .organizational_units = "organizationalUnits",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOrganizationalUnitsInput, options: CallOptions) !ListOrganizationalUnitsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "notifications", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOrganizationalUnitsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/organizational-units";

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
    try query_buf.appendSlice(allocator, "notificationConfigurationArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.notification_configuration_arn);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOrganizationalUnitsOutput {
    var result: ListOrganizationalUnitsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListOrganizationalUnitsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
