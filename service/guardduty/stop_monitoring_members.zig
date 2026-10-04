const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UnprocessedAccount = @import("unprocessed_account.zig").UnprocessedAccount;

pub const StopMonitoringMembersInput = struct {
    /// A list of account IDs for the member accounts to stop monitoring.
    account_ids: []const []const u8,

    /// The unique ID of the detector associated with the GuardDuty administrator
    /// account that is monitoring member accounts.
    ///
    /// To find the `detectorId` in the current Region, see the Settings page in the
    /// GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .detector_id = "DetectorId",
    };
};

pub const StopMonitoringMembersOutput = struct {
    /// A list of objects that contain an accountId for each account that could not
    /// be processed, and a result string that indicates why the account was not
    /// processed.
    unprocessed_accounts: ?[]const UnprocessedAccount = null,

    pub const json_field_names = .{
        .unprocessed_accounts = "UnprocessedAccounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopMonitoringMembersInput, options: CallOptions) !StopMonitoringMembersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopMonitoringMembersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/member/stop");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AccountIds\":");
    try aws.json.writeValue(@TypeOf(input.account_ids), input.account_ids, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopMonitoringMembersOutput {
    var result: StopMonitoringMembersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StopMonitoringMembersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
