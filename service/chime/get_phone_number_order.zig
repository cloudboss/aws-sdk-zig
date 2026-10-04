const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberOrder = @import("phone_number_order.zig").PhoneNumberOrder;

pub const GetPhoneNumberOrderInput = struct {
    /// The ID for the phone number order.
    phone_number_order_id: []const u8,

    pub const json_field_names = .{
        .phone_number_order_id = "PhoneNumberOrderId",
    };
};

pub const GetPhoneNumberOrderOutput = struct {
    /// The phone number order details.
    phone_number_order: ?PhoneNumberOrder = null,

    pub const json_field_names = .{
        .phone_number_order = "PhoneNumberOrder",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPhoneNumberOrderInput, options: CallOptions) !GetPhoneNumberOrderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPhoneNumberOrderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chime", "Chime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/phone-number-orders/");
    try path_buf.appendSlice(allocator, input.phone_number_order_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPhoneNumberOrderOutput {
    const result: GetPhoneNumberOrderOutput = try aws.json.parseJsonObject(
        GetPhoneNumberOrderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
