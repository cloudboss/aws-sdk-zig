const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Target = @import("target.zig").Target;

pub const UpdateMaintenanceWindowTargetInput = struct {
    /// An optional description for the update.
    description: ?[]const u8 = null,

    /// A name for the update.
    name: ?[]const u8 = null,

    /// User-provided value that will be included in any Amazon CloudWatch Events
    /// events raised while
    /// running tasks for these targets in this maintenance window.
    owner_information: ?[]const u8 = null,

    /// If `True`, then all fields that are required by the
    /// RegisterTargetWithMaintenanceWindow operation are also required for this API
    /// request. Optional fields that aren't specified are set to null.
    replace: ?bool = null,

    /// The targets to add or replace.
    targets: ?[]const Target = null,

    /// The maintenance window ID with which to modify the target.
    window_id: []const u8,

    /// The target ID to modify.
    window_target_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .owner_information = "OwnerInformation",
        .replace = "Replace",
        .targets = "Targets",
        .window_id = "WindowId",
        .window_target_id = "WindowTargetId",
    };
};

pub const UpdateMaintenanceWindowTargetOutput = struct {
    /// The updated description.
    description: ?[]const u8 = null,

    /// The updated name.
    name: ?[]const u8 = null,

    /// The updated owner.
    owner_information: ?[]const u8 = null,

    /// The updated targets.
    targets: ?[]const Target = null,

    /// The maintenance window ID specified in the update request.
    window_id: ?[]const u8 = null,

    /// The target ID specified in the update request.
    window_target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .owner_information = "OwnerInformation",
        .targets = "Targets",
        .window_id = "WindowId",
        .window_target_id = "WindowTargetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMaintenanceWindowTargetInput, options: CallOptions) !UpdateMaintenanceWindowTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMaintenanceWindowTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateMaintenanceWindowTarget");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMaintenanceWindowTargetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMaintenanceWindowTargetOutput, body, allocator);
}
