const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ResourceSharePermissionSummary = @import("resource_share_permission_summary.zig").ResourceSharePermissionSummary;

pub const CreatePermissionInput = struct {
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

    /// Specifies the name of the customer managed permission. The name must be
    /// unique within the
    /// Amazon Web Services Region.
    name: []const u8,

    /// A string in JSON format string that contains the following elements of a
    /// resource-based policy:
    ///
    /// * **Effect**: must be set to
    /// `ALLOW`.
    ///
    /// * **Action**: specifies the actions that are
    /// allowed by this customer managed permission. The list must contain only
    /// actions that are supported by
    /// the specified resource type. For a list of all actions supported by each
    /// resource type, see [Actions, resources, and condition keys for Amazon Web
    /// Services
    /// services](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html) in the
    /// *Identity and Access Management User Guide*.
    ///
    /// * **Condition**: (optional) specifies conditional
    /// parameters that must evaluate to true when a user attempts an action for
    /// that
    /// action to be allowed. For more information about the Condition element, see
    /// [IAM
    /// policies: Condition
    /// element](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition.html) in the *Identity and Access Management User
    /// Guide*.
    ///
    /// This template can't include either the `Resource` or
    /// `Principal` elements. Those are both filled in by RAM when it instantiates
    /// the resource-based policy on each resource shared using this managed
    /// permission. The
    /// `Resource` comes from the ARN of the specific resource that you are sharing.
    /// The `Principal` comes from the list of identities added to the resource
    /// share.
    policy_template: []const u8,

    /// Specifies the name of the resource type that this customer managed
    /// permission applies to.
    ///
    /// The format is
    /// `
    /// **:**
    /// `
    /// and is case sensitive. For example, to specify an Amazon EC2 Subnet, you can
    /// use the
    /// string `ec2:Subnet`. To see the list of valid values for this parameter,
    /// query the ListResourceTypes operation. This value must match the display
    /// name of the resource
    /// (available in `ListResourceTypes`).
    resource_type: []const u8,

    /// Specifies a list of one or more tag key and value pairs to attach to the
    /// permission.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .name = "name",
        .policy_template = "policyTemplate",
        .resource_type = "resourceType",
        .tags = "tags",
    };
};

pub const CreatePermissionOutput = struct {
    /// The idempotency identifier associated with this request. If you
    /// want to repeat the same operation in an idempotent manner then you must
    /// include this
    /// value in the `clientToken` request parameter of that later call. All other
    /// parameters must also have the same values that you used in the first call.
    client_token: ?[]const u8 = null,

    /// A structure with information about this customer managed permission.
    permission: ?ResourceSharePermissionSummary = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .permission = "permission",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePermissionInput, options: CallOptions) !CreatePermissionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ram", "RAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/createpermission";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyTemplate\":");
    try aws.json.writeValue(@TypeOf(input.policy_template), input.policy_template, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceType\":");
    try aws.json.writeValue(@TypeOf(input.resource_type), input.resource_type, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePermissionOutput {
    const result: CreatePermissionOutput = try aws.json.parseJsonObject(
        CreatePermissionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
