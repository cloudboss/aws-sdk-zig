const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListPoliciesGrantingServiceAccessEntry = @import("list_policies_granting_service_access_entry.zig").ListPoliciesGrantingServiceAccessEntry;
const serde = @import("serde.zig");

pub const ListPoliciesGrantingServiceAccessInput = struct {
    /// The ARN of the IAM identity (user, group, or role) whose policies you want
    /// to
    /// list.
    arn: []const u8,

    /// Use this parameter only when paginating results and only after
    /// you receive a response indicating that the results are truncated. Set it to
    /// the value of the
    /// `Marker` element in the response that you received to indicate where the
    /// next call
    /// should start.
    marker: ?[]const u8 = null,

    /// The service namespace for the Amazon Web Services services whose policies
    /// you want to list.
    ///
    /// To learn the service namespace for a service, see [Actions, resources, and
    /// condition keys for Amazon Web Services
    /// services](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html) in the
    /// *IAM User Guide*. Choose the name of the service to view
    /// details for that service. In the first paragraph, find the service prefix.
    /// For example,
    /// `(service prefix: a4b)`. For more information about service namespaces,
    /// see [Amazon Web Services
    /// service
    /// namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces) in the *Amazon Web Services General Reference*.
    service_namespaces: []const []const u8,
};

pub const ListPoliciesGrantingServiceAccessOutput = struct {
    /// A flag that indicates whether there are more items to return. If your
    /// results were
    /// truncated, you can make a subsequent pagination request using the `Marker`
    /// request parameter to retrieve more items. We recommend that you check
    /// `IsTruncated` after every call to ensure that you receive all your
    /// results.
    is_truncated: ?bool = null,

    /// When `IsTruncated` is `true`, this element
    /// is present and contains the value to use for the `Marker` parameter in a
    /// subsequent
    /// pagination request.
    marker: ?[]const u8 = null,

    /// A `ListPoliciesGrantingServiceAccess` object that contains details about
    /// the permissions policies attached to the specified identity (user, group, or
    /// role).
    policies_granting_service_access: ?[]const ListPoliciesGrantingServiceAccessEntry = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPoliciesGrantingServiceAccessInput, options: CallOptions) !ListPoliciesGrantingServiceAccessOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPoliciesGrantingServiceAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListPoliciesGrantingServiceAccess&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&Arn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.arn);
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    for (input.service_namespaces, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ServiceNamespaces.member.{d}=", .{n}) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPoliciesGrantingServiceAccessOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListPoliciesGrantingServiceAccessResult")) break;
            },
            else => {},
        }
    }

    var result: ListPoliciesGrantingServiceAccessOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PoliciesGrantingServiceAccess")) {
                    result.policies_granting_service_access = try serde.deserializelistPolicyGrantingServiceAccessResponseListType(allocator, &reader, "member");
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
