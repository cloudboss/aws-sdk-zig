const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MitigationActionParams = @import("mitigation_action_params.zig").MitigationActionParams;
const MitigationActionType = @import("mitigation_action_type.zig").MitigationActionType;

pub const DescribeMitigationActionInput = struct {
    /// The friendly name that uniquely identifies the mitigation action.
    action_name: []const u8,

    pub const json_field_names = .{
        .action_name = "actionName",
    };
};

pub const DescribeMitigationActionOutput = struct {
    /// The ARN that identifies this migration action.
    action_arn: ?[]const u8 = null,

    /// A unique identifier for this action.
    action_id: ?[]const u8 = null,

    /// The friendly name that uniquely identifies the mitigation action.
    action_name: ?[]const u8 = null,

    /// Parameters that control how the mitigation action is applied, specific to
    /// the type of mitigation action.
    action_params: ?MitigationActionParams = null,

    /// The type of mitigation action.
    action_type: ?MitigationActionType = null,

    /// The date and time when the mitigation action was added to your Amazon Web
    /// Services accounts.
    creation_date: ?i64 = null,

    /// The date and time when the mitigation action was last changed.
    last_modified_date: ?i64 = null,

    /// The ARN of the IAM role used to apply this action.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_arn = "actionArn",
        .action_id = "actionId",
        .action_name = "actionName",
        .action_params = "actionParams",
        .action_type = "actionType",
        .creation_date = "creationDate",
        .last_modified_date = "lastModifiedDate",
        .role_arn = "roleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMitigationActionInput, options: CallOptions) !DescribeMitigationActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMitigationActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/mitigationactions/actions/");
    try path_buf.appendSlice(allocator, input.action_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMitigationActionOutput {
    const result: DescribeMitigationActionOutput = try aws.json.parseJsonObject(
        DescribeMitigationActionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
