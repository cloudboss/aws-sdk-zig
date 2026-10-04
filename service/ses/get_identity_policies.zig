const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const GetIdentityPoliciesInput = struct {
    /// The identity for which the policies are retrieved. You can specify an
    /// identity by
    /// using its name or by using its Amazon Resource Name (ARN). Examples:
    /// `user@example.com`, `example.com`,
    /// `arn:aws:ses:us-east-1:123456789012:identity/example.com`.
    ///
    /// To successfully call this operation, you must own the identity.
    identity: []const u8,

    /// A list of the names of policies to be retrieved. You can retrieve a maximum
    /// of 20
    /// policies at a time. If you do not know the names of the policies that are
    /// attached to
    /// the identity, you can use `ListIdentityPolicies`.
    policy_names: []const []const u8,
};

pub const GetIdentityPoliciesOutput = struct {
    /// A map of policy names to policies.
    policies: ?[]const aws.map.StringMapEntry = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentityPoliciesInput, options: CallOptions) !GetIdentityPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentityPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetIdentityPolicies&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&Identity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.identity);
    for (input.policy_names, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyNames.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentityPoliciesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetIdentityPoliciesResult")) break;
            },
            else => {},
        }
    }

    var result: GetIdentityPoliciesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Policies")) {
                    result.policies = try serde.deserializePolicyMap(allocator, &reader, "entry");
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
