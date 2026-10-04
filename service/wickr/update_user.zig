const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateUserDetails = @import("update_user_details.zig").UpdateUserDetails;

pub const UpdateUserInput = struct {
    /// The ID of the Wickr network containing the user to update.
    network_id: []const u8,

    /// An object containing the user details to be updated, such as name, password,
    /// security groups, and invite code settings.
    user_details: ?UpdateUserDetails = null,

    /// The unique identifier of the user to update.
    user_id: []const u8,

    pub const json_field_names = .{
        .network_id = "networkId",
        .user_details = "userDetails",
        .user_id = "userId",
    };
};

pub const UpdateUserOutput = struct {
    /// Indicates whether the user can be verified through a custom invite code.
    code_validation: ?bool = null,

    /// The updated first name of the user.
    first_name: ?[]const u8 = null,

    /// The updated invite code for the user, if applicable.
    invite_code: ?[]const u8 = null,

    /// The expiration time of the user's invite code, specified in epoch seconds.
    invite_expiration: ?i32 = null,

    /// The updated last name of the user.
    last_name: ?[]const u8 = null,

    /// The middle name of the user (currently not used).
    middle_name: ?[]const u8 = null,

    /// The timestamp when the user was last modified, specified in epoch seconds.
    modified: ?i32 = null,

    /// The ID of the network where the user was updated.
    network_id: []const u8,

    /// The list of security group IDs to which the user now belongs after the
    /// update.
    security_group_ids: ?[]const []const u8 = null,

    /// The user's status after the update.
    status: ?i32 = null,

    /// Indicates whether the user is suspended after the update.
    suspended: bool,

    /// The unique identifier of the updated user.
    user_id: []const u8,

    pub const json_field_names = .{
        .code_validation = "codeValidation",
        .first_name = "firstName",
        .invite_code = "inviteCode",
        .invite_expiration = "inviteExpiration",
        .last_name = "lastName",
        .middle_name = "middleName",
        .modified = "modified",
        .network_id = "networkId",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .suspended = "suspended",
        .user_id = "userId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserInput, options: CallOptions) !UpdateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wickr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/users");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.user_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userDetails\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"userId\":");
    try aws.json.writeValue(@TypeOf(input.user_id), input.user_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserOutput {
    var result: UpdateUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateUserOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
