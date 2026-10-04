const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Program = @import("program.zig").Program;
const Tag = @import("tag.zig").Tag;
const CreateProgramManagementAccountDetail = @import("create_program_management_account_detail.zig").CreateProgramManagementAccountDetail;

pub const CreateProgramManagementAccountInput = struct {
    /// The AWS account ID to associate with the program management account.
    account_id: []const u8,

    /// The catalog identifier for the program management account.
    catalog: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// A human-readable name for the program management account.
    display_name: []const u8,

    /// The program type for the management account.
    program: Program,

    /// Key-value pairs to associate with the program management account.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .catalog = "catalog",
        .client_token = "clientToken",
        .display_name = "displayName",
        .program = "program",
        .tags = "tags",
    };
};

pub const CreateProgramManagementAccountOutput = struct {
    /// Details of the created program management account.
    program_management_account_detail: ?CreateProgramManagementAccountDetail = null,

    pub const json_field_names = .{
        .program_management_account_detail = "programManagementAccountDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProgramManagementAccountInput, options: CallOptions) !CreateProgramManagementAccountOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProgramManagementAccountInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralChannel.CreateProgramManagementAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProgramManagementAccountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProgramManagementAccountOutput, body, allocator);
}
