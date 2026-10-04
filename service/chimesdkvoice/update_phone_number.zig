const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberProductType = @import("phone_number_product_type.zig").PhoneNumberProductType;
const PhoneNumber = @import("phone_number.zig").PhoneNumber;

pub const UpdatePhoneNumberInput = struct {
    /// The outbound calling name associated with the phone number.
    calling_name: ?[]const u8 = null,

    /// Specifies the updated name assigned to one or more phone numbers.
    name: ?[]const u8 = null,

    /// The phone number ID.
    phone_number_id: []const u8,

    /// The product type.
    product_type: ?PhoneNumberProductType = null,

    pub const json_field_names = .{
        .calling_name = "CallingName",
        .name = "Name",
        .phone_number_id = "PhoneNumberId",
        .product_type = "ProductType",
    };
};

pub const UpdatePhoneNumberOutput = struct {
    /// The updated phone number details.
    phone_number: ?PhoneNumber = null,

    pub const json_field_names = .{
        .phone_number = "PhoneNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePhoneNumberInput, options: CallOptions) !UpdatePhoneNumberOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePhoneNumberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/phone-numbers/");
    try path_buf.appendSlice(allocator, input.phone_number_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.calling_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CallingName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.product_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProductType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePhoneNumberOutput {
    var result: UpdatePhoneNumberOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdatePhoneNumberOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
