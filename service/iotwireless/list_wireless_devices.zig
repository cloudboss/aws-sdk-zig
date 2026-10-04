const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WirelessDeviceType = @import("wireless_device_type.zig").WirelessDeviceType;
const WirelessDeviceStatistics = @import("wireless_device_statistics.zig").WirelessDeviceStatistics;

pub const ListWirelessDevicesInput = struct {
    /// A filter to list only the wireless devices that use as uplink destination.
    destination_name: ?[]const u8 = null,

    /// A filter to list only the wireless devices that use this device profile.
    device_profile_id: ?[]const u8 = null,

    fuota_task_id: ?[]const u8 = null,

    /// The maximum number of results to return in this operation.
    max_results: ?i32 = null,

    multicast_group_id: ?[]const u8 = null,

    /// To retrieve the next set of results, the `nextToken` value from a previous
    /// response; otherwise **null** to receive the first set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A filter to list only the wireless devices that use this service profile.
    service_profile_id: ?[]const u8 = null,

    /// A filter to list only the wireless devices that use this wireless device
    /// type.
    wireless_device_type: ?WirelessDeviceType = null,

    pub const json_field_names = .{
        .destination_name = "DestinationName",
        .device_profile_id = "DeviceProfileId",
        .fuota_task_id = "FuotaTaskId",
        .max_results = "MaxResults",
        .multicast_group_id = "MulticastGroupId",
        .next_token = "NextToken",
        .service_profile_id = "ServiceProfileId",
        .wireless_device_type = "WirelessDeviceType",
    };
};

pub const ListWirelessDevicesOutput = struct {
    /// The token to use to get the next set of results, or **null** if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    /// The ID of the wireless device.
    wireless_device_list: ?[]const WirelessDeviceStatistics = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .wireless_device_list = "WirelessDeviceList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWirelessDevicesInput, options: CallOptions) !ListWirelessDevicesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWirelessDevicesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/wireless-devices";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.destination_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "destinationName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.device_profile_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "deviceProfileId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.fuota_task_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "fuotaTaskId=");
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
    if (input.multicast_group_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "multicastGroupId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.service_profile_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "serviceProfileId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.wireless_device_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "wirelessDeviceType=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWirelessDevicesOutput {
    var result: ListWirelessDevicesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListWirelessDevicesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
