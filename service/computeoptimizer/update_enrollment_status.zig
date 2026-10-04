const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Status = @import("status.zig").Status;

pub const UpdateEnrollmentStatusInput = struct {
    /// Indicates whether to enroll member accounts of the organization if the
    /// account is the
    /// management account of an organization.
    include_member_accounts: ?bool = null,

    /// The new enrollment status of the account.
    ///
    /// The following status options are available:
    ///
    /// * `Active` - Opts in your account to the Compute Optimizer service.
    /// Compute Optimizer begins analyzing the configuration and utilization metrics
    /// of your Amazon Web Services resources after you opt in. For more
    /// information, see
    /// [Metrics analyzed by Compute
    /// Optimizer](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html) in the *Compute Optimizer User Guide*.
    ///
    /// * `Inactive` - Opts out your account from the Compute Optimizer
    /// service. Your account's recommendations and related metrics data will be
    /// deleted
    /// from Compute Optimizer after you opt out.
    ///
    /// The `Pending` and `Failed` options cannot be used to update
    /// the enrollment status of an account. They are returned in the response of a
    /// request
    /// to update the enrollment status of an account.
    status: Status,

    pub const json_field_names = .{
        .include_member_accounts = "includeMemberAccounts",
        .status = "status",
    };
};

pub const UpdateEnrollmentStatusOutput = struct {
    /// The enrollment status of the account.
    status: ?Status = null,

    /// The reason for the enrollment status of the account. For example, an account
    /// might
    /// show a status of `Pending` because member accounts of an organization
    /// require
    /// more time to be enrolled in the service.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnrollmentStatusInput, options: CallOptions) !UpdateEnrollmentStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnrollmentStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("compute-optimizer", "Compute Optimizer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.UpdateEnrollmentStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnrollmentStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEnrollmentStatusOutput, body, allocator);
}
