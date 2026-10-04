const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContactFlowStatus = @import("contact_flow_status.zig").ContactFlowStatus;
const ContactFlowType = @import("contact_flow_type.zig").ContactFlowType;

pub const CreateContactFlowInput = struct {
    /// The JSON string that represents the content of the flow. For an example, see
    /// [Example
    /// flow in Connect Customer Flow
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/flow-language-example.html).
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 256000.
    content: []const u8,

    /// The description of the flow.
    description: ?[]const u8 = null,

    /// The identifier of the Connect Customer instance.
    instance_id: []const u8,

    /// The name of the flow.
    name: []const u8,

    /// Indicates the flow status as either `SAVED` or `PUBLISHED`. The `PUBLISHED`
    /// status will initiate validation on the content. the `SAVED` status does not
    /// initiate validation of the
    /// content. `SAVED` | `PUBLISHED`.
    status: ?ContactFlowStatus = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the flow. For descriptions of the available types, see [Choose a
    /// flow
    /// type](https://docs.aws.amazon.com/connect/latest/adminguide/create-contact-flow.html#contact-flow-types) in the
    /// *Connect Customer Administrator Guide*.
    @"type": ContactFlowType,

    pub const json_field_names = .{
        .content = "Content",
        .description = "Description",
        .instance_id = "InstanceId",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub const CreateContactFlowOutput = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    contact_flow_arn: ?[]const u8 = null,

    /// The identifier of the flow.
    contact_flow_id: ?[]const u8 = null,

    /// Indicates the checksum value of the latest published flow content.
    flow_content_sha_256: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_flow_arn = "ContactFlowArn",
        .contact_flow_id = "ContactFlowId",
        .flow_content_sha_256 = "FlowContentSha256",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContactFlowInput, options: CallOptions) !CreateContactFlowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContactFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/contact-flows/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
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
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContactFlowOutput {
    const result: CreateContactFlowOutput = try aws.json.parseJsonObject(
        CreateContactFlowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
