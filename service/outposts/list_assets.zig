const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetType = @import("asset_type.zig").AssetType;
const AssetState = @import("asset_state.zig").AssetState;
const AssetInfo = @import("asset_info.zig").AssetInfo;

pub const ListAssetsInput = struct {
    /// Filters the results by asset type.
    ///
    /// * COMPUTE - Server asset used for customer compute
    ///
    /// * STORAGE - Server asset used by storage services
    ///
    /// * POWERSHELF - Powershelf assets
    ///
    /// * SWITCH - Switch assets
    ///
    /// * NETWORKING - Asset managed by Amazon Web Services for networking purposes
    asset_type_filter: ?[]const AssetType = null,

    /// Filters the results by the host ID of a Dedicated Host.
    host_id_filter: ?[]const []const u8 = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// The ID or the Amazon Resource Name (ARN) of the Outpost.
    outpost_identifier: []const u8,

    /// Filters the results by state.
    status_filter: ?[]const AssetState = null,

    pub const json_field_names = .{
        .asset_type_filter = "AssetTypeFilter",
        .host_id_filter = "HostIdFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .outpost_identifier = "OutpostIdentifier",
        .status_filter = "StatusFilter",
    };
};

pub const ListAssetsOutput = struct {
    /// Information about the hardware assets.
    assets: ?[]const AssetInfo = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assets = "Assets",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssetsInput, options: CallOptions) !ListAssetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/outposts/");
    try path_buf.appendSlice(allocator, input.outpost_identifier);
    try path_buf.appendSlice(allocator, "/assets");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.asset_type_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "AssetTypeFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.host_id_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "HostIdFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "StatusFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAssetsOutput {
    const result: ListAssetsOutput = try aws.json.parseJsonObject(
        ListAssetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
