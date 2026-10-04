const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteVirtualMFADeviceInput = struct {
    /// The serial number that uniquely identifies the MFA device. For virtual MFA
    /// devices,
    /// the serial number is the same as the ARN.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric characters with no spaces. You can also
    /// include any of the
    /// following characters: =,.@:/-
    serial_number: []const u8,
};

pub const DeleteVirtualMFADeviceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVirtualMFADeviceInput, options: CallOptions) !DeleteVirtualMFADeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVirtualMFADeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteVirtualMFADevice&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&SerialNumber=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.serial_number);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVirtualMFADeviceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: DeleteVirtualMFADeviceOutput = .{};

    return result;
}
