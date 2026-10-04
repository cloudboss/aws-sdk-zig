const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnrollmentStatus = @import("enrollment_status.zig").EnrollmentStatus;

pub const UpdateEnrollmentConfigurationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. Must be 1-64 characters long and contain only
    /// alphanumeric characters, underscores, and hyphens.
    client_token: ?[]const u8 = null,

    /// The desired enrollment status.
    ///
    /// * Active - Enables the Automation feature for your account.
    /// * Inactive - Disables the Automation feature for your account and stops all
    ///   of your automation rules. If you opt in again later, all rules will be
    ///   inactive, and you must enable the rules you want to run. You must wait at
    ///   least 24 hours after opting out to opt in again.
    ///
    /// The `Pending` and `Failed` options cannot be used to update the enrollment
    /// status of an account. They are returned in the response of a request to
    /// update the enrollment status of an account.
    ///
    /// If you are a member account, your account must be disassociated from your
    /// organization’s management account before you can disable Automation. Contact
    /// your administrator to make this change.
    status: EnrollmentStatus,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .status = "status",
    };
};

pub const UpdateEnrollmentConfigurationOutput = struct {
    /// The timestamp when the enrollment configuration was last updated.
    last_updated_timestamp: i64,

    /// The updated enrollment status.
    status: EnrollmentStatus,

    /// The reason for the updated enrollment status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnrollmentConfigurationInput, options: CallOptions) !UpdateEnrollmentConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnrollmentConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aco-automation", "Compute Optimizer Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerAutomationService.UpdateEnrollmentConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnrollmentConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateEnrollmentConfigurationOutput, body, allocator);
}
