const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Status = @import("status.zig").Status;

pub const GetEnrollmentStatusInput = struct {};

pub const GetEnrollmentStatusOutput = struct {
    /// The Unix epoch timestamp, in seconds, of when the account enrollment status
    /// was last
    /// updated.
    last_updated_timestamp: ?i64 = null,

    /// Confirms the enrollment status of member accounts of the organization, if
    /// the account
    /// is a management account of an organization.
    member_accounts_enrolled: ?bool = null,

    /// The count of organization member accounts that are opted in to the service,
    /// if your
    /// account is an organization management account.
    number_of_member_accounts_opted_in: ?i32 = null,

    /// The enrollment status of the account.
    status: ?Status = null,

    /// The reason for the enrollment status of the account.
    ///
    /// For example, an account might show a status of `Pending` because member
    /// accounts of an organization require more time to be enrolled in the service.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .member_accounts_enrolled = "memberAccountsEnrolled",
        .number_of_member_accounts_opted_in = "numberOfMemberAccountsOptedIn",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnrollmentStatusInput, options: CallOptions) !GetEnrollmentStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnrollmentStatusInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("compute-optimizer", "Compute Optimizer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.GetEnrollmentStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnrollmentStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetEnrollmentStatusOutput, body, allocator);
}
