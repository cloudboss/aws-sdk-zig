const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberProductType = @import("phone_number_product_type.zig").PhoneNumberProductType;
const PhoneNumberOrder = @import("phone_number_order.zig").PhoneNumberOrder;

pub const CreatePhoneNumberOrderInput = struct {
    /// List of phone numbers, in E.164 format.
    e164_phone_numbers: []const []const u8,

    /// Specifies the name assigned to one or more phone numbers.
    name: ?[]const u8 = null,

    /// The phone number product type.
    product_type: PhoneNumberProductType,

    pub const json_field_names = .{
        .e164_phone_numbers = "E164PhoneNumbers",
        .name = "Name",
        .product_type = "ProductType",
    };
};

pub const CreatePhoneNumberOrderOutput = struct {
    /// The phone number order details.
    phone_number_order: ?PhoneNumberOrder = null,

    pub const json_field_names = .{
        .phone_number_order = "PhoneNumberOrder",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePhoneNumberOrderInput, options: CallOptions) !CreatePhoneNumberOrderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePhoneNumberOrderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/phone-number-orders";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"E164PhoneNumbers\":");
    try aws.json.writeValue(@TypeOf(input.e164_phone_numbers), input.e164_phone_numbers, allocator, &body_buf);
    has_prev = true;
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProductType\":");
    try aws.json.writeValue(@TypeOf(input.product_type), input.product_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePhoneNumberOrderOutput {
    const result: CreatePhoneNumberOrderOutput = try aws.json.parseJsonObject(
        CreatePhoneNumberOrderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
