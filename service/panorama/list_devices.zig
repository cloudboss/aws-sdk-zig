const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeviceAggregatedStatus = @import("device_aggregated_status.zig").DeviceAggregatedStatus;
const ListDevicesSortBy = @import("list_devices_sort_by.zig").ListDevicesSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const Device = @import("device.zig").Device;

pub const ListDevicesInput = struct {
    /// Filter based on a device's status.
    device_aggregated_status_filter: ?DeviceAggregatedStatus = null,

    /// The maximum number of devices to return in one page of results.
    max_results: ?i32 = null,

    /// Filter based on device's name. Prefixes supported.
    name_filter: ?[]const u8 = null,

    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The target column to be sorted on. Default column sort is CREATED_TIME.
    sort_by: ?ListDevicesSortBy = null,

    /// The sorting order for the returned list. SortOrder is DESCENDING by default
    /// based on CREATED_TIME. Otherwise, SortOrder is ASCENDING.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .device_aggregated_status_filter = "DeviceAggregatedStatusFilter",
        .max_results = "MaxResults",
        .name_filter = "NameFilter",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListDevicesOutput = struct {
    /// A list of devices.
    devices: ?[]const Device = null,

    /// A pagination token that's included if more results are available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .devices = "Devices",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDevicesInput, options: CallOptions) !ListDevicesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDevicesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/devices";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.device_aggregated_status_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "DeviceAggregatedStatusFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
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
    if (input.name_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NameFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.sort_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "SortBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.sort_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "SortOrder=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDevicesOutput {
    var result: ListDevicesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDevicesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
