const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceShareAssociation = @import("resource_share_association.zig").ResourceShareAssociation;

pub const DisassociateResourceShareInput = struct {
    /// Specifies a unique, case-sensitive identifier that you provide to
    /// ensure the idempotency of the request. This lets you safely retry the
    /// request without
    /// accidentally performing the same operation a second time. Passing the same
    /// value to a
    /// later call to an operation requires that you also pass the same value for
    /// all other
    /// parameters. We recommend that you use a [UUID type of
    /// value.](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for
    /// you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with
    /// different parameters, the retry fails with an `IdempotentParameterMismatch`
    /// error.
    client_token: ?[]const u8 = null,

    /// Specifies a list of one or more principals that no longer are to have access
    /// to the
    /// resources in this resource share.
    ///
    /// You can include the following values:
    ///
    /// * An Amazon Web Services account ID, for example: `123456789012`
    ///
    /// * An [Amazon Resource Name
    ///   (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of an organization in Organizations, for example:
    /// `organizations::123456789012:organization/o-exampleorgid`
    ///
    /// * An ARN of an organizational unit (OU) in Organizations, for example:
    /// `organizations::123456789012:ou/o-exampleorgid/ou-examplerootid-exampleouid123`
    ///
    /// * An ARN of an IAM role, for example:
    /// `iam::123456789012:role/rolename`
    ///
    /// * An ARN of an IAM user, for example:
    /// `iam::123456789012user/username`
    ///
    /// * A service principal name, for example: `service-id.amazonaws.com`
    ///
    /// Not all resource types can be shared with IAM roles and users.
    /// For more information, see [Sharing with IAM roles and
    /// users](https://docs.aws.amazon.com/ram/latest/userguide/permissions.html#permissions-rbp-supported-resource-types) in the *Resource Access Manager User
    /// Guide*.
    principals: ?[]const []const u8 = null,

    /// Specifies a list of [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) for one or more resources that you want to remove from
    /// the resource share. After the operation runs, these resources are no longer
    /// shared with principals
    /// associated with the resource share.
    resource_arns: ?[]const []const u8 = null,

    /// Specifies [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share that you want to remove resources or principals
    /// from.
    resource_share_arn: []const u8,

    /// Specifies source constraints (accounts, ARNs, organization IDs, or
    /// organization paths) to remove from the resource share. This enables granular
    /// management of source constraints while maintaining service principal
    /// associations. At least one source must remain when service principals are
    /// present.
    sources: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .principals = "principals",
        .resource_arns = "resourceArns",
        .resource_share_arn = "resourceShareArn",
        .sources = "sources",
    };
};

pub const DisassociateResourceShareOutput = struct {
    /// The idempotency identifier associated with this request. If you
    /// want to repeat the same operation in an idempotent manner then you must
    /// include this
    /// value in the `clientToken` request parameter of that later call. All other
    /// parameters must also have the same values that you used in the first call.
    client_token: ?[]const u8 = null,

    /// An array of objects with information about the updated associations for this
    /// resource share.
    resource_share_associations: ?[]const ResourceShareAssociation = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .resource_share_associations = "resourceShareAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateResourceShareInput, options: CallOptions) !DisassociateResourceShareOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ram", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateResourceShareInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/disassociateresourceshare";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.principals) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"principals\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceShareArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_share_arn), input.resource_share_arn, allocator, &body_buf);
    has_prev = true;
    if (input.sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateResourceShareOutput {
    const result: DisassociateResourceShareOutput = try aws.json.parseJsonObject(
        DisassociateResourceShareOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
