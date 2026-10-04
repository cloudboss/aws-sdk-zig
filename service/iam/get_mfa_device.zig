const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const GetMFADeviceInput = struct {
    /// Serial number that uniquely identifies the MFA device. For this API, we only
    /// accept
    /// FIDO security key
    /// [ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html).
    serial_number: []const u8,

    /// The friendly name identifying the user.
    user_name: ?[]const u8 = null,
};

pub const GetMFADeviceOutput = struct {
    /// The certifications of a specified user's MFA device. We currently provide
    /// FIPS-140-2,
    /// FIPS-140-3, and FIDO certification levels obtained from [ FIDO Alliance
    /// Metadata Service
    /// (MDS)](https://fidoalliance.org/metadata/).
    certifications: ?[]const aws.map.StringMapEntry = null,

    /// The date that a specified user's MFA device was first enabled.
    enable_date: ?i64 = null,

    /// Serial number that uniquely identifies the MFA device. For this API, we only
    /// accept
    /// FIDO security key
    /// [ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html).
    serial_number: []const u8,

    /// The friendly name identifying the user.
    user_name: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMFADeviceInput, options: CallOptions) !GetMFADeviceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMFADeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetMFADevice&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&SerialNumber=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.serial_number);
    if (input.user_name) |v| {
        try body_buf.appendSlice(allocator, "&UserName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMFADeviceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetMFADeviceResult")) break;
            },
            else => {},
        }
    }

    var result: GetMFADeviceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Certifications")) {
                    result.certifications = try serde.deserializeCertificationMapType(allocator, &reader, "entry");
                } else if (std.mem.eql(u8, e.local, "EnableDate")) {
                    result.enable_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SerialNumber")) {
                    result.serial_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
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
