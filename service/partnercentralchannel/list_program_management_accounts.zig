const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Program = @import("program.zig").Program;
const ListProgramManagementAccountsSortBase = @import("list_program_management_accounts_sort_base.zig").ListProgramManagementAccountsSortBase;
const ProgramManagementAccountStatus = @import("program_management_account_status.zig").ProgramManagementAccountStatus;
const ProgramManagementAccountSummary = @import("program_management_account_summary.zig").ProgramManagementAccountSummary;

pub const ListProgramManagementAccountsInput = struct {
    /// Filter by AWS account IDs.
    account_ids: ?[]const []const u8 = null,

    /// The catalog identifier to filter accounts.
    catalog: []const u8,

    /// Filter by display names.
    display_names: ?[]const []const u8 = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// Token for retrieving the next page of results.
    next_token: ?[]const u8 = null,

    /// Filter by program types.
    programs: ?[]const Program = null,

    /// Sorting options for the results.
    sort: ?ListProgramManagementAccountsSortBase = null,

    /// Filter by program management account statuses.
    statuses: ?[]const ProgramManagementAccountStatus = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .catalog = "catalog",
        .display_names = "displayNames",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .programs = "programs",
        .sort = "sort",
        .statuses = "statuses",
    };
};

pub const ListProgramManagementAccountsOutput = struct {
    /// List of program management accounts matching the criteria.
    items: ?[]const ProgramManagementAccountSummary = null,

    /// Token for retrieving the next page of results, if available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProgramManagementAccountsInput, options: CallOptions) !ListProgramManagementAccountsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProgramManagementAccountsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralChannel.ListProgramManagementAccounts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProgramManagementAccountsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListProgramManagementAccountsOutput, body, allocator);
}
