const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberAccountEc2DeepInspectionStatusState = @import("member_account_ec_2_deep_inspection_status_state.zig").MemberAccountEc2DeepInspectionStatusState;
const FailedMemberAccountEc2DeepInspectionStatusState = @import("failed_member_account_ec_2_deep_inspection_status_state.zig").FailedMemberAccountEc2DeepInspectionStatusState;

pub const BatchGetMemberEc2DeepInspectionStatusInput = struct {
    /// The unique identifiers for the Amazon Web Services accounts to retrieve
    /// Amazon Inspector deep inspection
    /// activation status for.
    account_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
    };
};

pub const BatchGetMemberEc2DeepInspectionStatusOutput = struct {
    /// An array of objects that provide details on the activation status of Amazon
    /// Inspector deep
    /// inspection for each of the requested accounts.
    account_ids: ?[]const MemberAccountEc2DeepInspectionStatusState = null,

    /// An array of objects that provide details on any accounts that failed to
    /// activate Amazon Inspector
    /// deep inspection and why.
    failed_account_ids: ?[]const FailedMemberAccountEc2DeepInspectionStatusState = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .failed_account_ids = "failedAccountIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetMemberEc2DeepInspectionStatusInput, options: CallOptions) !BatchGetMemberEc2DeepInspectionStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetMemberEc2DeepInspectionStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ec2deepinspectionstatus/member/batch/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountIds\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetMemberEc2DeepInspectionStatusOutput {
    const result: BatchGetMemberEc2DeepInspectionStatusOutput = try aws.json.parseJsonObject(
        BatchGetMemberEc2DeepInspectionStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
