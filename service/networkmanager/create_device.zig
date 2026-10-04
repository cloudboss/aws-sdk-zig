const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AWSLocation = @import("aws_location.zig").AWSLocation;
const Location = @import("location.zig").Location;
const Tag = @import("tag.zig").Tag;
const Device = @import("device.zig").Device;

pub const CreateDeviceInput = struct {
    /// The Amazon Web Services location of the device, if applicable. For an
    /// on-premises device, you can omit this parameter.
    aws_location: ?AWSLocation = null,

    /// A description of the device.
    ///
    /// Constraints: Maximum length of 256 characters.
    description: ?[]const u8 = null,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The location of the device.
    location: ?Location = null,

    /// The model of the device.
    ///
    /// Constraints: Maximum length of 128 characters.
    model: ?[]const u8 = null,

    /// The serial number of the device.
    ///
    /// Constraints: Maximum length of 128 characters.
    serial_number: ?[]const u8 = null,

    /// The ID of the site.
    site_id: ?[]const u8 = null,

    /// The tags to apply to the resource during creation.
    tags: ?[]const Tag = null,

    /// The type of the device.
    @"type": ?[]const u8 = null,

    /// The vendor of the device.
    ///
    /// Constraints: Maximum length of 128 characters.
    vendor: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_location = "AWSLocation",
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .location = "Location",
        .model = "Model",
        .serial_number = "SerialNumber",
        .site_id = "SiteId",
        .tags = "Tags",
        .@"type" = "Type",
        .vendor = "Vendor",
    };
};

pub const CreateDeviceOutput = struct {
    /// Information about the device.
    device: ?Device = null,

    pub const json_field_names = .{
        .device = "Device",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeviceInput, options: CallOptions) !CreateDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/devices");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aws_location) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AWSLocation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.location) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Location\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.model) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Model\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.serial_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SerialNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.site_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SiteId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.@"type") |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Type\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vendor) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Vendor\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeviceOutput {
    var result: CreateDeviceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDeviceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
