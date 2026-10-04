const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributePayload = @import("attribute_payload.zig").AttributePayload;

pub const CreateThingInput = struct {
    /// The attribute payload, which consists of up to three name/value pairs in a
    /// JSON
    /// document. For example:
    ///
    /// `{\"attributes\":{\"string1\":\"string2\"}}`
    attribute_payload: ?AttributePayload = null,

    /// The name of the billing group the thing will be added to.
    billing_group_name: ?[]const u8 = null,

    /// The name of the thing to create.
    ///
    /// You can't change a thing's name after you create it. To change a thing's
    /// name, you must create a
    /// new thing, give it the new name, and then delete the old thing.
    thing_name: []const u8,

    /// The name of the thing type associated with the new thing.
    thing_type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_payload = "attributePayload",
        .billing_group_name = "billingGroupName",
        .thing_name = "thingName",
        .thing_type_name = "thingTypeName",
    };
};

pub const CreateThingOutput = struct {
    /// The ARN of the new thing.
    thing_arn: ?[]const u8 = null,

    /// The thing ID.
    thing_id: ?[]const u8 = null,

    /// The name of the new thing.
    thing_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .thing_arn = "thingArn",
        .thing_id = "thingId",
        .thing_name = "thingName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateThingInput, options: CallOptions) !CreateThingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateThingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attribute_payload) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributePayload\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.billing_group_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"billingGroupName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.thing_type_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"thingTypeName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateThingOutput {
    const result: CreateThingOutput = try aws.json.parseJsonObject(
        CreateThingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
