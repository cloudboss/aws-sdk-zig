const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CoreDeviceStatus = @import("core_device_status.zig").CoreDeviceStatus;
const CoreDevice = @import("core_device.zig").CoreDevice;

pub const ListCoreDevicesInput = struct {
    /// The maximum number of results to be returned per paginated request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// The runtime to be used by the core device. The runtime can be:
    ///
    /// * `aws_nucleus_classic`
    ///
    /// * `aws_nucleus_lite`
    runtime: ?[]const u8 = null,

    /// The core device status by which to filter. If you specify this parameter,
    /// the list
    /// includes only core devices that have this status. Choose one of the
    /// following options:
    ///
    /// * `HEALTHY` – The IoT Greengrass Core software and all components run on the
    ///   core device without issue.
    ///
    /// * `UNHEALTHY` – The IoT Greengrass Core software or a component is in a
    ///   failed state
    /// on the core device.
    status: ?CoreDeviceStatus = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the IoT thing group by which to filter. If you specify this parameter,
    /// the list includes only core devices that have successfully deployed a
    /// deployment that targets
    /// the thing group. When you remove a core device from a thing group, the list
    /// continues to
    /// include that core device.
    thing_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .runtime = "runtime",
        .status = "status",
        .thing_group_arn = "thingGroupArn",
    };
};

pub const ListCoreDevicesOutput = struct {
    /// A list that summarizes each core device.
    core_devices: ?[]const CoreDevice = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .core_devices = "coreDevices",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCoreDevicesInput, options: CallOptions) !ListCoreDevicesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCoreDevicesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "GreengrassV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/greengrass/v2/coreDevices";

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
    if (input.runtime) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "runtime=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.thing_group_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "thingGroupArn=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCoreDevicesOutput {
    const result: ListCoreDevicesOutput = try aws.json.parseJsonObject(
        ListCoreDevicesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
