const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplacementValueEntry = @import("replacement_value_entry.zig").ReplacementValueEntry;
const Role = @import("role.zig").Role;
const serde = @import("serde.zig");

pub const AcquireRoleInput = struct {
    /// A map of values to substitute for the parameters that are defined in the
    /// role template
    /// version. Each key is a parameter name from the template, and each value is a
    /// structure
    /// that contains the replacement values for that parameter.
    replacement_values: ?[]const aws.map.MapEntry(ReplacementValueEntry) = null,

    /// The Amazon Resource Name (ARN) of the role template to create the role from.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    template_arn: []const u8,

    /// The minor version of the role template to use. If you do not specify a minor
    /// version,
    /// the service uses the template's default minor version.
    template_minor_version: ?i32 = null,
};

pub const AcquireRoleOutput = struct {
    /// A structure that contains details about the IAM role that was created.
    role: ?Role = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcquireRoleInput, options: CallOptions) !AcquireRoleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AcquireRoleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=AcquireRole&Version=2010-05-08");
    if (input.replacement_values) |entries| {
        for (entries, 0..) |entry, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const key_prefix = std.fmt.bufPrint(&prefix_buf, "&ReplacementValues.entry.{d}.key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, key_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, entry.key);
            }
        }
    }
    try body_buf.appendSlice(allocator, "&TemplateArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.template_arn);
    if (input.template_minor_version) |v| {
        try body_buf.appendSlice(allocator, "&TemplateMinorVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcquireRoleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AcquireRoleResult")) break;
            },
            else => {},
        }
    }

    var result: AcquireRoleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Role")) {
                    result.role = try serde.deserializeRole(allocator, &reader);
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
