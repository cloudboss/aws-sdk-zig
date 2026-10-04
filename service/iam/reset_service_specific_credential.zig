const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceSpecificCredential = @import("service_specific_credential.zig").ServiceSpecificCredential;
const serde = @import("serde.zig");

pub const ResetServiceSpecificCredentialInput = struct {
    /// The unique identifier of the service-specific credential.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters that can
    /// consist of any upper or lowercased letter or digit.
    service_specific_credential_id: []const u8,

    /// The name of the IAM user associated with the service-specific credential. If
    /// this
    /// value is not specified, then the operation assumes the user whose
    /// credentials are used
    /// to call the operation.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    user_name: ?[]const u8 = null,
};

pub const ResetServiceSpecificCredentialOutput = struct {
    /// A structure with details about the updated service-specific credential,
    /// including the
    /// new password.
    ///
    /// This is the **only** time that you can access the
    /// password. You cannot recover the password later, but you can reset it again.
    service_specific_credential: ?ServiceSpecificCredential = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResetServiceSpecificCredentialInput, options: CallOptions) !ResetServiceSpecificCredentialOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ResetServiceSpecificCredentialInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ResetServiceSpecificCredential&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&ServiceSpecificCredentialId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.service_specific_credential_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResetServiceSpecificCredentialOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResetServiceSpecificCredentialResult")) break;
            },
            else => {},
        }
    }

    var result: ResetServiceSpecificCredentialOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ServiceSpecificCredential")) {
                    result.service_specific_credential = try serde.deserializeServiceSpecificCredential(allocator, &reader);
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
