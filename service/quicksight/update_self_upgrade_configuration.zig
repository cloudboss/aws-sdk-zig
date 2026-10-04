const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SelfUpgradeStatus = @import("self_upgrade_status.zig").SelfUpgradeStatus;

pub const UpdateSelfUpgradeConfigurationInput = struct {
    /// The ID of the Amazon Web Services account that contains the Quick
    /// self-upgrade configuration that you want to update.
    aws_account_id: []const u8,

    /// The Quick namespace that you want to update the Quick self-upgrade
    /// configuration for.
    namespace: []const u8,

    /// The self-upgrade status that you want to set for the Quick account.
    self_upgrade_status: SelfUpgradeStatus,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .namespace = "Namespace",
        .self_upgrade_status = "SelfUpgradeStatus",
    };
};

pub const UpdateSelfUpgradeConfigurationOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSelfUpgradeConfigurationInput, options: CallOptions) !UpdateSelfUpgradeConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSelfUpgradeConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/namespaces/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/self-upgrade-configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SelfUpgradeStatus\":");
    try aws.json.writeValue(@TypeOf(input.self_upgrade_status), input.self_upgrade_status, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSelfUpgradeConfigurationOutput {
    var result: UpdateSelfUpgradeConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSelfUpgradeConfigurationOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
