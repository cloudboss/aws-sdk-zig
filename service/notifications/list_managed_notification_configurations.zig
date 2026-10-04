const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ManagedNotificationConfigurationStructure = @import("managed_notification_configuration_structure.zig").ManagedNotificationConfigurationStructure;

pub const ListManagedNotificationConfigurationsInput = struct {
    /// The identifier or ARN of the notification channel to filter configurations
    /// by.
    channel_identifier: ?[]const u8 = null,

    /// The maximum number of results to be returned in this call. Defaults to 20.
    max_results: ?i32 = null,

    /// The start token for paginated calls. Retrieved from the response of a
    /// previous ListManagedNotificationChannelAssociations call. Next token uses
    /// Base64 encoding.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_identifier = "channelIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListManagedNotificationConfigurationsOutput = struct {
    /// A list of Managed Notification Configurations matching the request criteria.
    managed_notification_configurations: ?[]const ManagedNotificationConfigurationStructure = null,

    /// A pagination token. If a non-null pagination token is returned in a result,
    /// pass its value in another request to retrieve more entries.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .managed_notification_configurations = "managedNotificationConfigurations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListManagedNotificationConfigurationsInput, options: CallOptions) !ListManagedNotificationConfigurationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListManagedNotificationConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/managed-notification-configurations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.channel_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "channelIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListManagedNotificationConfigurationsOutput {
    const result: ListManagedNotificationConfigurationsOutput = try aws.json.parseJsonObject(
        ListManagedNotificationConfigurationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
