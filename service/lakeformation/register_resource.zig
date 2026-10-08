const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RegisterResourceInput = struct {
    /// The Amazon Web Services account that owns the Glue tables associated with
    /// specific Amazon S3 locations.
    expected_resource_owner_account: ?[]const u8 = null,

    /// Specifies whether the data access of tables pointing to the location can be
    /// managed by both Lake Formation permissions as well as Amazon S3 bucket
    /// policies.
    hybrid_access_enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the resource that you want to register.
    resource_arn: []const u8,

    /// The identifier for the role that registers the resource.
    role_arn: ?[]const u8 = null,

    /// Designates an Identity and Access Management (IAM) service-linked role by
    /// registering this role with the Data Catalog. A service-linked role is a
    /// unique type of IAM role that is linked directly to Lake Formation.
    ///
    /// For more information, see [Using Service-Linked Roles for Lake
    /// Formation](https://docs.aws.amazon.com/lake-formation/latest/dg/service-linked-roles.html).
    use_service_linked_role: ?bool = null,

    /// Whether or not the resource is a federated resource.
    with_federation: ?bool = null,

    /// Grants the calling principal the permissions to perform all supported Lake
    /// Formation operations on the registered data location.
    with_privileged_access: ?bool = null,

    pub const json_field_names = .{
        .expected_resource_owner_account = "ExpectedResourceOwnerAccount",
        .hybrid_access_enabled = "HybridAccessEnabled",
        .resource_arn = "ResourceArn",
        .role_arn = "RoleArn",
        .use_service_linked_role = "UseServiceLinkedRole",
        .with_federation = "WithFederation",
        .with_privileged_access = "WithPrivilegedAccess",
    };
};

pub const RegisterResourceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterResourceInput, options: CallOptions) !RegisterResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/RegisterResource";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.expected_resource_owner_account) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExpectedResourceOwnerAccount\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hybrid_access_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HybridAccessEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.use_service_linked_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UseServiceLinkedRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.with_federation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WithFederation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.with_privileged_access) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WithPrivilegedAccess\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterResourceOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RegisterResourceOutput = .{};

    return result;
}
