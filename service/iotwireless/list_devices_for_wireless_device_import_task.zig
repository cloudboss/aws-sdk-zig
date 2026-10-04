const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OnboardStatus = @import("onboard_status.zig").OnboardStatus;
const ImportedWirelessDevice = @import("imported_wireless_device.zig").ImportedWirelessDevice;
const PositioningConfigStatus = @import("positioning_config_status.zig").PositioningConfigStatus;
const SidewalkListDevicesForImportInfo = @import("sidewalk_list_devices_for_import_info.zig").SidewalkListDevicesForImportInfo;

pub const ListDevicesForWirelessDeviceImportTaskInput = struct {
    /// The identifier of the import task for which wireless devices are listed.
    id: []const u8,

    max_results: ?i32 = null,

    /// To retrieve the next set of results, the `nextToken` value from a previous
    /// response; otherwise `null` to receive the first set of results.
    next_token: ?[]const u8 = null,

    /// The status of the devices in the import task.
    status: ?OnboardStatus = null,

    pub const json_field_names = .{
        .id = "Id",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListDevicesForWirelessDeviceImportTaskOutput = struct {
    /// The name of the Sidewalk destination that describes the IoT rule to route
    /// messages
    /// received from devices in an import task that are onboarded to AWS IoT
    /// Wireless.
    destination_name: ?[]const u8 = null,

    /// List of wireless devices in an import task and their onboarding status.
    imported_wireless_device_list: ?[]const ImportedWirelessDevice = null,

    /// The token to use to get the next set of results, or `null` if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    /// The integration status of the Device Location feature for Sidewalk devices.
    positioning: ?PositioningConfigStatus = null,

    /// The Sidewalk object containing Sidewalk-related device information.
    sidewalk: ?SidewalkListDevicesForImportInfo = null,

    pub const json_field_names = .{
        .destination_name = "DestinationName",
        .imported_wireless_device_list = "ImportedWirelessDeviceList",
        .next_token = "NextToken",
        .positioning = "Positioning",
        .sidewalk = "Sidewalk",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDevicesForWirelessDeviceImportTaskInput, options: CallOptions) !ListDevicesForWirelessDeviceImportTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDevicesForWirelessDeviceImportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/wireless_device_import_task";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "id=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.id);
    query_has_prev = true;
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
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDevicesForWirelessDeviceImportTaskOutput {
    const result: ListDevicesForWirelessDeviceImportTaskOutput = try aws.json.parseJsonObject(
        ListDevicesForWirelessDeviceImportTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
