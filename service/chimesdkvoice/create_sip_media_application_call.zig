const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SipMediaApplicationCall = @import("sip_media_application_call.zig").SipMediaApplicationCall;

pub const CreateSipMediaApplicationCallInput = struct {
    /// Context passed to a CreateSipMediaApplication API call. For example, you
    /// could pass
    /// key-value pairs such as: `"FirstName": "John", "LastName": "Doe"`
    arguments_map: ?[]const aws.map.StringMapEntry = null,

    /// The phone number that a user calls from. This is a phone number in your
    /// Amazon Chime SDK phone number inventory.
    from_phone_number: []const u8,

    /// The SIP headers added to an outbound call leg.
    sip_headers: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the SIP media application.
    sip_media_application_id: []const u8,

    /// The phone number that the service should call.
    to_phone_number: []const u8,

    pub const json_field_names = .{
        .arguments_map = "ArgumentsMap",
        .from_phone_number = "FromPhoneNumber",
        .sip_headers = "SipHeaders",
        .sip_media_application_id = "SipMediaApplicationId",
        .to_phone_number = "ToPhoneNumber",
    };
};

pub const CreateSipMediaApplicationCallOutput = struct {
    /// The actual call.
    sip_media_application_call: ?SipMediaApplicationCall = null,

    pub const json_field_names = .{
        .sip_media_application_call = "SipMediaApplicationCall",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSipMediaApplicationCallInput, options: CallOptions) !CreateSipMediaApplicationCallOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSipMediaApplicationCallInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sip-media-applications/");
    try path_buf.appendSlice(allocator, input.sip_media_application_id);
    try path_buf.appendSlice(allocator, "/calls");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.arguments_map) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ArgumentsMap\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FromPhoneNumber\":");
    try aws.json.writeValue(@TypeOf(input.from_phone_number), input.from_phone_number, allocator, &body_buf);
    has_prev = true;
    if (input.sip_headers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SipHeaders\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ToPhoneNumber\":");
    try aws.json.writeValue(@TypeOf(input.to_phone_number), input.to_phone_number, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSipMediaApplicationCallOutput {
    const result: CreateSipMediaApplicationCallOutput = try aws.json.parseJsonObject(
        CreateSipMediaApplicationCallOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
