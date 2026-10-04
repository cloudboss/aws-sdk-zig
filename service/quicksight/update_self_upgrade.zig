const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SelfUpgradeAdminAction = @import("self_upgrade_admin_action.zig").SelfUpgradeAdminAction;
const SelfUpgradeRequestDetail = @import("self_upgrade_request_detail.zig").SelfUpgradeRequestDetail;

pub const UpdateSelfUpgradeInput = struct {
    /// The action to perform on the self-upgrade request. Valid values are
    /// `APPROVE`, `DENY`, or `VERIFY`.
    action: SelfUpgradeAdminAction,

    /// The ID of the Amazon Web Services account that contains the self-upgrade
    /// request.
    aws_account_id: []const u8,

    /// The Quick namespace for the self-upgrade request.
    namespace: []const u8,

    /// The ID of the self-upgrade request to update.
    upgrade_request_id: []const u8,

    pub const json_field_names = .{
        .action = "Action",
        .aws_account_id = "AwsAccountId",
        .namespace = "Namespace",
        .upgrade_request_id = "UpgradeRequestId",
    };
};

pub const UpdateSelfUpgradeOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// Details of the updated self-upgrade request.
    self_upgrade_request_detail: ?SelfUpgradeRequestDetail = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .self_upgrade_request_detail = "SelfUpgradeRequestDetail",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSelfUpgradeInput, options: CallOptions) !UpdateSelfUpgradeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSelfUpgradeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/namespaces/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/update-self-upgrade-request");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UpgradeRequestId\":");
    try aws.json.writeValue(@TypeOf(input.upgrade_request_id), input.upgrade_request_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSelfUpgradeOutput {
    var result: UpdateSelfUpgradeOutput = try aws.json.parseJsonObject(
        UpdateSelfUpgradeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
