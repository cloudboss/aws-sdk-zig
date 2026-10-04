const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisassociateClientDeviceFromCoreDeviceEntry = @import("disassociate_client_device_from_core_device_entry.zig").DisassociateClientDeviceFromCoreDeviceEntry;
const DisassociateClientDeviceFromCoreDeviceErrorEntry = @import("disassociate_client_device_from_core_device_error_entry.zig").DisassociateClientDeviceFromCoreDeviceErrorEntry;

pub const BatchDisassociateClientDeviceFromCoreDeviceInput = struct {
    /// The name of the core device. This is also the name of the IoT thing.
    core_device_thing_name: []const u8,

    /// The list of client devices to disassociate.
    entries: ?[]const DisassociateClientDeviceFromCoreDeviceEntry = null,

    pub const json_field_names = .{
        .core_device_thing_name = "coreDeviceThingName",
        .entries = "entries",
    };
};

pub const BatchDisassociateClientDeviceFromCoreDeviceOutput = struct {
    /// The list of any errors for the entries in the request. Each error entry
    /// contains the name
    /// of the IoT thing that failed to disassociate.
    error_entries: ?[]const DisassociateClientDeviceFromCoreDeviceErrorEntry = null,

    pub const json_field_names = .{
        .error_entries = "errorEntries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDisassociateClientDeviceFromCoreDeviceInput, options: CallOptions) !BatchDisassociateClientDeviceFromCoreDeviceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDisassociateClientDeviceFromCoreDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "GreengrassV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/v2/coreDevices/");
    try path_buf.appendSlice(allocator, input.core_device_thing_name);
    try path_buf.appendSlice(allocator, "/disassociateClientDevices");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.entries) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entries\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDisassociateClientDeviceFromCoreDeviceOutput {
    const result: BatchDisassociateClientDeviceFromCoreDeviceOutput = try aws.json.parseJsonObject(
        BatchDisassociateClientDeviceFromCoreDeviceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
