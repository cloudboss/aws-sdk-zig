const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputPredefinedAttributeConfiguration = @import("input_predefined_attribute_configuration.zig").InputPredefinedAttributeConfiguration;
const PredefinedAttributeValues = @import("predefined_attribute_values.zig").PredefinedAttributeValues;

pub const UpdatePredefinedAttributeInput = struct {
    /// Custom metadata that is associated to predefined attributes to control
    /// behavior
    /// in upstream services, such as controlling
    /// how a predefined attribute should be displayed in the Connect Customer admin
    /// website.
    attribute_configuration: ?InputPredefinedAttributeConfiguration = null,

    /// The identifier of the Connect Customer instance. You can find the instance
    /// ID in the Amazon Resource Name (ARN) of the
    /// instance.
    instance_id: []const u8,

    /// The name of the predefined attribute.
    name: []const u8,

    /// Values that enable you to categorize your predefined attributes. You can use
    /// them in custom UI elements across the Connect Customer admin website.
    purposes: ?[]const []const u8 = null,

    /// The values of the predefined attribute.
    values: ?PredefinedAttributeValues = null,

    pub const json_field_names = .{
        .attribute_configuration = "AttributeConfiguration",
        .instance_id = "InstanceId",
        .name = "Name",
        .purposes = "Purposes",
        .values = "Values",
    };
};

pub const UpdatePredefinedAttributeOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePredefinedAttributeInput, options: CallOptions) !UpdatePredefinedAttributeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePredefinedAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/predefined-attributes/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attribute_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AttributeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.purposes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Purposes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.values) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Values\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePredefinedAttributeOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdatePredefinedAttributeOutput = .{};

    return result;
}
