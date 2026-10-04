const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SupportedHardwareType = @import("supported_hardware_type.zig").SupportedHardwareType;
const Outpost = @import("outpost.zig").Outpost;

pub const CreateOutpostInput = struct {
    availability_zone: ?[]const u8 = null,

    availability_zone_id: ?[]const u8 = null,

    description: ?[]const u8 = null,

    name: []const u8,

    /// The ID or the Amazon Resource Name (ARN) of the site.
    site_id: []const u8,

    /// The type of hardware for this Outpost.
    supported_hardware_type: ?SupportedHardwareType = null,

    /// The tags to apply to the Outpost.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .availability_zone_id = "AvailabilityZoneId",
        .description = "Description",
        .name = "Name",
        .site_id = "SiteId",
        .supported_hardware_type = "SupportedHardwareType",
        .tags = "Tags",
    };
};

pub const CreateOutpostOutput = struct {
    outpost: ?Outpost = null,

    pub const json_field_names = .{
        .outpost = "Outpost",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOutpostInput, options: CallOptions) !CreateOutpostOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOutpostInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/outposts";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.availability_zone) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AvailabilityZone\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.availability_zone_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AvailabilityZoneId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SiteId\":");
    try aws.json.writeValue(@TypeOf(input.site_id), input.site_id, allocator, &body_buf);
    has_prev = true;
    if (input.supported_hardware_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SupportedHardwareType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOutpostOutput {
    var result: CreateOutpostOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateOutpostOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
