const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateSourceNetworkInput = struct {
    /// Account containing the VPC to protect.
    origin_account_id: []const u8,

    /// Region containing the VPC to protect.
    origin_region: []const u8,

    /// A set of tags to be associated with the Source Network resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Which VPC ID to protect.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .origin_account_id = "originAccountID",
        .origin_region = "originRegion",
        .tags = "tags",
        .vpc_id = "vpcID",
    };
};

pub const CreateSourceNetworkOutput = struct {
    /// ID of the created Source Network.
    source_network_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_network_id = "sourceNetworkID",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSourceNetworkInput, options: CallOptions) !CreateSourceNetworkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "drs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSourceNetworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateSourceNetwork";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"originAccountID\":");
    try aws.json.writeValue(@TypeOf(input.origin_account_id), input.origin_account_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"originRegion\":");
    try aws.json.writeValue(@TypeOf(input.origin_region), input.origin_region, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"vpcID\":");
    try aws.json.writeValue(@TypeOf(input.vpc_id), input.vpc_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSourceNetworkOutput {
    const result: CreateSourceNetworkOutput = try aws.json.parseJsonObject(
        CreateSourceNetworkOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
