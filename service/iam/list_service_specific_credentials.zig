const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceSpecificCredentialMetadata = @import("service_specific_credential_metadata.zig").ServiceSpecificCredentialMetadata;
const serde = @import("serde.zig");

pub const ListServiceSpecificCredentialsInput = struct {
    /// A flag indicating whether to list service specific credentials for all
    /// users. This
    /// parameter cannot be specified together with UserName. When true, returns all
    /// credentials
    /// associated with the specified service.
    all_users: ?bool = null,

    /// Use this parameter only when paginating results and only after you receive a
    /// response
    /// indicating that the results are truncated. Set it to the value of the Marker
    /// from the
    /// response that you received to indicate where the next call should start.
    marker: ?[]const u8 = null,

    /// Use this only when paginating results to indicate the maximum number of
    /// items you want
    /// in the response. If additional items exist beyond the maximum you specify,
    /// the
    /// IsTruncated response element is true.
    max_items: ?i32 = null,

    /// Filters the returned results to only those for the specified Amazon Web
    /// Services service. If not
    /// specified, then Amazon Web Services returns service-specific credentials for
    /// all services.
    service_name: ?[]const u8 = null,

    /// The name of the user whose service-specific credentials you want information
    /// about. If
    /// this value is not specified, then the operation assumes the user whose
    /// credentials are
    /// used to call the operation.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    user_name: ?[]const u8 = null,
};

pub const ListServiceSpecificCredentialsOutput = struct {
    /// A flag that indicates whether there are more items to return. If your
    /// results were
    /// truncated, you can make a subsequent pagination request using the Marker
    /// request
    /// parameter to retrieve more items.
    is_truncated: ?bool = null,

    /// When IsTruncated is true, this element is present and contains the value to
    /// use for
    /// the Marker parameter in a subsequent pagination request.
    marker: ?[]const u8 = null,

    /// A list of structures that each contain details about a service-specific
    /// credential.
    service_specific_credentials: ?[]const ServiceSpecificCredentialMetadata = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceSpecificCredentialsInput, options: CallOptions) !ListServiceSpecificCredentialsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceSpecificCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListServiceSpecificCredentials&Version=2010-05-08");
    if (input.all_users) |v| {
        try body_buf.appendSlice(allocator, "&AllUsers=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_items) |v| {
        try body_buf.appendSlice(allocator, "&MaxItems=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.service_name) |v| {
        try body_buf.appendSlice(allocator, "&ServiceName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceSpecificCredentialsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListServiceSpecificCredentialsResult")) break;
            },
            else => {},
        }
    }

    var result: ListServiceSpecificCredentialsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceSpecificCredentials")) {
                    result.service_specific_credentials = try serde.deserializeServiceSpecificCredentialsListType(allocator, &reader, "member");
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
