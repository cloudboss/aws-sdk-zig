const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateContactFlowVersionInput = struct {
    /// The identifier of the flow.
    contact_flow_id: []const u8,

    /// The identifier of the flow version.
    contact_flow_version: ?i64 = null,

    /// The description of the flow version.
    description: ?[]const u8 = null,

    /// Indicates the checksum value of the flow content.
    flow_content_sha_256: ?[]const u8 = null,

    /// The identifier of the Connect Customer instance.
    instance_id: []const u8,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .contact_flow_id = "ContactFlowId",
        .contact_flow_version = "ContactFlowVersion",
        .description = "Description",
        .flow_content_sha_256 = "FlowContentSha256",
        .instance_id = "InstanceId",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
    };
};

pub const CreateContactFlowVersionOutput = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    contact_flow_arn: ?[]const u8 = null,

    /// The identifier of the flow version.
    version: ?i64 = null,

    pub const json_field_names = .{
        .contact_flow_arn = "ContactFlowArn",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContactFlowVersionInput, options: CallOptions) !CreateContactFlowVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContactFlowVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/contact-flows/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.contact_flow_id);
    try path_buf.appendSlice(allocator, "/version");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.contact_flow_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContactFlowVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.flow_content_sha_256) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FlowContentSha256\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.last_modified_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LastModifiedRegion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.last_modified_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LastModifiedTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContactFlowVersionOutput {
    const result: CreateContactFlowVersionOutput = try aws.json.parseJsonObject(
        CreateContactFlowVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
