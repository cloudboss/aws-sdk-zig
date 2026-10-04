const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateProgramManagementAccountDetail = @import("update_program_management_account_detail.zig").UpdateProgramManagementAccountDetail;

pub const UpdateProgramManagementAccountInput = struct {
    /// The catalog identifier for the program management account.
    catalog: []const u8,

    /// The new display name for the program management account.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the program management account to update.
    identifier: []const u8,

    /// The current revision number of the program management account.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog = "catalog",
        .display_name = "displayName",
        .identifier = "identifier",
        .revision = "revision",
    };
};

pub const UpdateProgramManagementAccountOutput = struct {
    /// Details of the updated program management account.
    program_management_account_detail: ?UpdateProgramManagementAccountDetail = null,

    pub const json_field_names = .{
        .program_management_account_detail = "programManagementAccountDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProgramManagementAccountInput, options: CallOptions) !UpdateProgramManagementAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProgramManagementAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-channel", "PartnerCentral Channel", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralChannel.UpdateProgramManagementAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProgramManagementAccountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateProgramManagementAccountOutput, body, allocator);
}
