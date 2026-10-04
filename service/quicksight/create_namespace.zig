const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityStore = @import("identity_store.zig").IdentityStore;
const Tag = @import("tag.zig").Tag;
const NamespaceStatus = @import("namespace_status.zig").NamespaceStatus;

pub const CreateNamespaceInput = struct {
    /// The ID for the Amazon Web Services account that you want to create the Quick
    /// Sight namespace in.
    aws_account_id: []const u8,

    /// Specifies the type of your user identity directory. Currently, this supports
    /// users
    /// with an identity type of `QUICKSIGHT`.
    identity_store: IdentityStore,

    /// The name that you want to use to describe the new namespace.
    namespace: []const u8,

    /// The tags that you want to associate with the namespace that you're creating.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .identity_store = "IdentityStore",
        .namespace = "Namespace",
        .tags = "Tags",
    };
};

pub const CreateNamespaceOutput = struct {
    /// The ARN of the Quick Sight namespace you created.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services Region; that you want to use for the free SPICE
    /// capacity for the new namespace.
    /// This is set to the region that you run CreateNamespace in.
    capacity_region: ?[]const u8 = null,

    /// The status of the creation of the namespace. This is an asynchronous
    /// process. A status
    /// of `CREATED` means that your namespace is ready to use. If an error occurs,
    /// it indicates if the process is `retryable` or `non-retryable`. In
    /// the case of a non-retryable error, refer to the error message for follow-up
    /// tasks.
    creation_status: ?NamespaceStatus = null,

    /// Specifies the type of your user identity directory. Currently, this supports
    /// users
    /// with an identity type of `QUICKSIGHT`.
    identity_store: ?IdentityStore = null,

    /// The name of the new namespace that you created.
    name: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .capacity_region = "CapacityRegion",
        .creation_status = "CreationStatus",
        .identity_store = "IdentityStore",
        .name = "Name",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNamespaceInput, options: CallOptions) !CreateNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IdentityStore\":");
    try aws.json.writeValue(@TypeOf(input.identity_store), input.identity_store, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Namespace\":");
    try aws.json.writeValue(@TypeOf(input.namespace), input.namespace, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNamespaceOutput {
    var result: CreateNamespaceOutput = try aws.json.parseJsonObject(
        CreateNamespaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
