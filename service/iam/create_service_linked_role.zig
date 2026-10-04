const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Role = @import("role.zig").Role;
const serde = @import("serde.zig");

pub const CreateServiceLinkedRoleInput = struct {
    /// The service principal for the Amazon Web Services service to which this role
    /// is attached. You use a
    /// string similar to a URL but without the http:// in front. For example:
    /// `elasticbeanstalk.amazonaws.com`.
    ///
    /// Service principals are unique and case-sensitive. To find the exact service
    /// principal
    /// for your service-linked role, see [Amazon Web Services services
    /// that work with
    /// IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html) in the *IAM User Guide*. Look for
    /// the services that have **Yes **in the **Service-Linked Role** column. Choose
    /// the **Yes** link to view the service-linked role documentation for that
    /// service.
    aws_service_name: []const u8,

    /// A string that you provide, which is combined with the service-provided
    /// prefix to form
    /// the complete role name. If you make multiple requests for the same service,
    /// then you
    /// must supply a different `CustomSuffix` for each request. Otherwise the
    /// request fails with a duplicate role name error. For example, you could add
    /// `-1` or `-debug` to the suffix.
    ///
    /// Some services do not support the `CustomSuffix` parameter. If you provide
    /// an optional suffix and the operation fails, try the operation again without
    /// the
    /// suffix.
    custom_suffix: ?[]const u8 = null,

    /// The description of the role.
    description: ?[]const u8 = null,
};

pub const CreateServiceLinkedRoleOutput = struct {
    /// A [Role](https://docs.aws.amazon.com/IAM/latest/APIReference/API_Role.html)
    /// object that contains details about the newly created role.
    role: ?Role = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceLinkedRoleInput, options: CallOptions) !CreateServiceLinkedRoleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceLinkedRoleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateServiceLinkedRole&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&AWSServiceName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.aws_service_name);
    if (input.custom_suffix) |v| {
        try body_buf.appendSlice(allocator, "&CustomSuffix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceLinkedRoleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateServiceLinkedRoleResult")) break;
            },
            else => {},
        }
    }

    var result: CreateServiceLinkedRoleOutput = .{};
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
