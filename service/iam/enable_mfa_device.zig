const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const EnableMFADeviceInput = struct {
    /// An authentication code emitted by the device.
    ///
    /// The format for this parameter is a string of six digits.
    ///
    /// Submit your request immediately after generating the authentication codes.
    /// If you
    /// generate the codes and then wait too long to submit the request, the MFA
    /// device
    /// successfully associates with the user but the MFA device becomes out of
    /// sync. This
    /// happens because time-based one-time passwords (TOTP) expire after a short
    /// period of
    /// time. If this happens, you can [resync the
    /// device](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_sync.html).
    authentication_code_1: []const u8,

    /// A subsequent authentication code emitted by the device.
    ///
    /// The format for this parameter is a string of six digits.
    ///
    /// Submit your request immediately after generating the authentication codes.
    /// If you
    /// generate the codes and then wait too long to submit the request, the MFA
    /// device
    /// successfully associates with the user but the MFA device becomes out of
    /// sync. This
    /// happens because time-based one-time passwords (TOTP) expire after a short
    /// period of
    /// time. If this happens, you can [resync the
    /// device](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_sync.html).
    authentication_code_2: []const u8,

    /// The serial number that uniquely identifies the MFA device. For virtual MFA
    /// devices,
    /// the serial number is the device ARN.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric characters with no spaces. You can also
    /// include any of the
    /// following characters: =,.@:/-
    serial_number: []const u8,

    /// The name of the IAM user for whom you want to enable the MFA device.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    user_name: []const u8,
};

pub const EnableMFADeviceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableMFADeviceInput, options: CallOptions) !EnableMFADeviceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableMFADeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=EnableMFADevice&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&AuthenticationCode1=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.authentication_code_1);
    try body_buf.appendSlice(allocator, "&AuthenticationCode2=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.authentication_code_2);
    try body_buf.appendSlice(allocator, "&SerialNumber=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.serial_number);
    try body_buf.appendSlice(allocator, "&UserName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.user_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableMFADeviceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: EnableMFADeviceOutput = .{};

    return result;
}
