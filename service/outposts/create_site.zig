const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Address = @import("address.zig").Address;
const RackPhysicalProperties = @import("rack_physical_properties.zig").RackPhysicalProperties;
const Site = @import("site.zig").Site;

pub const CreateSiteInput = struct {
    description: ?[]const u8 = null,

    name: []const u8,

    /// Additional information that you provide about site access requirements,
    /// electrician
    /// scheduling, personal protective equipment, or regulation of equipment
    /// materials that could
    /// affect your installation process.
    notes: ?[]const u8 = null,

    /// The location to install and power on the hardware. This address might be
    /// different from
    /// the shipping address.
    operating_address: ?Address = null,

    /// Information about the physical and logistical details for the rack at this
    /// site.
    /// For more information
    /// about hardware requirements for racks, see [Network
    /// readiness
    /// checklist](https://docs.aws.amazon.com/outposts/latest/userguide/outposts-requirements.html#checklist) in the Amazon Web Services Outposts User Guide.
    rack_physical_properties: ?RackPhysicalProperties = null,

    /// The location to ship the hardware. This address might be different from the
    /// operating
    /// address.
    shipping_address: ?Address = null,

    /// The tags to apply to a site.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .notes = "Notes",
        .operating_address = "OperatingAddress",
        .rack_physical_properties = "RackPhysicalProperties",
        .shipping_address = "ShippingAddress",
        .tags = "Tags",
    };
};

pub const CreateSiteOutput = struct {
    site: ?Site = null,

    pub const json_field_names = .{
        .site = "Site",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSiteInput, options: CallOptions) !CreateSiteOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSiteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sites";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.notes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Notes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.operating_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OperatingAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.rack_physical_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RackPhysicalProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.shipping_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ShippingAddress\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSiteOutput {
    var result: CreateSiteOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSiteOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
