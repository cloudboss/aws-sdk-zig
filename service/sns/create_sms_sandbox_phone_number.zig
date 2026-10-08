const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageCodeString = @import("language_code_string.zig").LanguageCodeString;

pub const CreateSMSSandboxPhoneNumberInput = struct {
    /// The language to use for sending the OTP. The default value is
    /// `en-US`.
    language_code: ?LanguageCodeString = null,

    /// The destination phone number to verify. On verification, Amazon SNS adds
    /// this phone number
    /// to the list of verified phone numbers that you can send SMS messages to.
    phone_number: []const u8,
};

pub const CreateSMSSandboxPhoneNumberOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSMSSandboxPhoneNumberInput, options: CallOptions) !CreateSMSSandboxPhoneNumberOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSMSSandboxPhoneNumberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateSMSSandboxPhoneNumber&Version=2010-03-31");
    if (input.language_code) |v| {
        try body_buf.appendSlice(allocator, "&LanguageCode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&PhoneNumber=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.phone_number);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSMSSandboxPhoneNumberOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CreateSMSSandboxPhoneNumberOutput = .{};

    return result;
}
