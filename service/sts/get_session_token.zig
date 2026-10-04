const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Credentials = @import("credentials.zig").Credentials;
const serde = @import("serde.zig");

pub const GetSessionTokenInput = struct {
    /// The duration, in seconds, that the credentials should remain valid.
    /// Acceptable durations
    /// for IAM user sessions range from 900 seconds (15 minutes) to 129,600 seconds
    /// (36 hours), with 43,200 seconds (12 hours) as the default. Sessions for
    /// Amazon Web Services account
    /// owners are restricted to a maximum of 3,600 seconds (one hour). If the
    /// duration is longer
    /// than one hour, the session for Amazon Web Services account owners defaults
    /// to one hour.
    duration_seconds: ?i32 = null,

    /// The identification number of the MFA device that is associated with the IAM
    /// user who is making the `GetSessionToken` call. Specify this value
    /// if the IAM user has a policy that requires MFA authentication. The value is
    /// either the serial number for a hardware device (such as `GAHT12345678`) or
    /// an
    /// Amazon Resource Name (ARN) for a virtual device (such as
    /// `arn:aws:iam::123456789012:mfa/user`). You can find the device for an IAM
    /// user by going to the Amazon Web Services Management Console and viewing the
    /// user's security credentials.
    ///
    /// The regex used to validate this parameter is a string of
    /// characters consisting of upper- and lower-case alphanumeric characters with
    /// no spaces.
    /// You can also include underscores or any of the following characters: =,.@:/-
    serial_number: ?[]const u8 = null,

    /// The value provided by the MFA device, if MFA is required. If any policy
    /// requires the
    /// IAM user to submit an MFA code, specify this value. If MFA authentication
    /// is required, the user must provide a code when requesting a set of temporary
    /// security
    /// credentials. A user who fails to provide the code receives an "access
    /// denied" response when
    /// requesting resources that require MFA authentication.
    ///
    /// The format for this parameter, as described by its regex pattern, is a
    /// sequence of six
    /// numeric digits.
    token_code: ?[]const u8 = null,
};

pub const GetSessionTokenOutput = struct {
    /// The temporary security credentials, which include an access key ID, a secret
    /// access key,
    /// and a security (or session) token.
    ///
    /// The size of the security token that STS API operations return is not fixed.
    /// We
    /// strongly recommend that you make no assumptions about the maximum size.
    credentials: ?Credentials = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionTokenInput, options: CallOptions) !GetSessionTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sts", "STS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetSessionToken&Version=2011-06-15");
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(allocator, "&DurationSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.serial_number) |v| {
        try body_buf.appendSlice(allocator, "&SerialNumber=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.token_code) |v| {
        try body_buf.appendSlice(allocator, "&TokenCode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionTokenOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetSessionTokenResult")) break;
            },
            else => {},
        }
    }

    var result: GetSessionTokenOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
