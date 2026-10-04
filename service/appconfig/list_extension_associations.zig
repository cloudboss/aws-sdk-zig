const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExtensionAssociationSummary = @import("extension_association_summary.zig").ExtensionAssociationSummary;

pub const ListExtensionAssociationsInput = struct {
    /// The name, the ID, or the Amazon Resource Name (ARN) of the extension.
    extension_identifier: ?[]const u8 = null,

    /// The version number for the extension defined in the association.
    extension_version_number: ?i32 = null,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that
    /// you can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// A token to start the list. Use this token to get the next set of results or
    /// pass null to
    /// get the first set of results.
    next_token: ?[]const u8 = null,

    /// The ARN of an application, configuration profile, or environment.
    resource_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .extension_identifier = "ExtensionIdentifier",
        .extension_version_number = "ExtensionVersionNumber",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_identifier = "ResourceIdentifier",
    };
};

pub const ListExtensionAssociationsOutput = struct {
    /// The list of extension associations. Each item represents an extension
    /// association to an
    /// application, environment, or configuration profile.
    items: ?[]const ExtensionAssociationSummary = null,

    /// The token for the next set of items to return. Use this token to get the
    /// next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExtensionAssociationsInput, options: CallOptions) !ListExtensionAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExtensionAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/extensionassociations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.extension_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "extension_identifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.extension_version_number) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "extension_version_number=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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
    if (input.resource_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resource_identifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExtensionAssociationsOutput {
    const result: ListExtensionAssociationsOutput = try aws.json.parseJsonObject(
        ListExtensionAssociationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
