const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutAccessGrantsInstanceResourcePolicyInput = struct {
    /// The Amazon Web Services account ID of the S3 Access Grants instance.
    account_id: []const u8,

    /// The Organization of the resource policy of the S3 Access Grants instance.
    organization: ?[]const u8 = null,

    /// The resource policy of the S3 Access Grants instance that you are updating.
    policy: []const u8,
};

pub const PutAccessGrantsInstanceResourcePolicyOutput = struct {
    /// The date and time when you created the S3 Access Grants instance resource
    /// policy.
    created_at: ?i64 = null,

    /// The Organization of the resource policy of the S3 Access Grants instance.
    organization: ?[]const u8 = null,

    /// The updated resource policy of the S3 Access Grants instance.
    policy: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccessGrantsInstanceResourcePolicyInput, options: CallOptions) !PutAccessGrantsInstanceResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAccessGrantsInstanceResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20180820/accessgrantsinstance/resourcepolicy";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<PutAccessGrantsInstanceResourcePolicyRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    if (input.organization) |v| {
        try body_buf.appendSlice(allocator, "<Organization>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Organization>");
    }
    try body_buf.appendSlice(allocator, "<Policy>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.policy);
    try body_buf.appendSlice(allocator, "</Policy>");
    try body_buf.appendSlice(allocator, "</PutAccessGrantsInstanceResourcePolicyRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAccessGrantsInstanceResourcePolicyOutput {
    var result: PutAccessGrantsInstanceResourcePolicyOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Organization")) {
                    result.organization = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
