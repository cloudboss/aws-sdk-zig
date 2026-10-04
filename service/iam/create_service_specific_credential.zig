const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceSpecificCredential = @import("service_specific_credential.zig").ServiceSpecificCredential;
const serde = @import("serde.zig");

pub const CreateServiceSpecificCredentialInput = struct {
    /// The number of days until the service specific credential expires. This field
    /// is only
    /// valid for Bedrock and CloudWatch Logs API keys and must be a positive
    /// integer. When not specified, the
    /// credential will not expire.
    credential_age_days: ?i32 = null,

    /// The name of the Amazon Web Services service that is to be associated with
    /// the credentials. The
    /// service you specify here is the only service that can be accessed using
    /// these
    /// credentials.
    service_name: []const u8,

    /// The name of the IAM user that is to be associated with the credentials. The
    /// new
    /// service-specific credentials have the same permissions as the associated
    /// user except
    /// that they can be used only to access the specified service.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    user_name: []const u8,
};

pub const CreateServiceSpecificCredentialOutput = struct {
    /// A structure that contains information about the newly created
    /// service-specific
    /// credential.
    ///
    /// This is the only time that the password for this credential set is
    /// available. It
    /// cannot be recovered later. Instead, you must reset the password with
    /// [ResetServiceSpecificCredential](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ResetServiceSpecificCredential.html).
    service_specific_credential: ?ServiceSpecificCredential = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceSpecificCredentialInput, options: CallOptions) !CreateServiceSpecificCredentialOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceSpecificCredentialInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateServiceSpecificCredential&Version=2010-05-08");
    if (input.credential_age_days) |v| {
        try body_buf.appendSlice(allocator, "&CredentialAgeDays=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&ServiceName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.service_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceSpecificCredentialOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateServiceSpecificCredentialResult")) break;
            },
            else => {},
        }
    }

    var result: CreateServiceSpecificCredentialOutput = .{};
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
