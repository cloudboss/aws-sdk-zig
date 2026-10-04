const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationRuleMode = @import("organization_rule_mode.zig").OrganizationRuleMode;
const EnrollmentStatus = @import("enrollment_status.zig").EnrollmentStatus;

pub const GetEnrollmentConfigurationInput = struct {
};

pub const GetEnrollmentConfigurationOutput = struct {
    /// The timestamp of the last update to the enrollment configuration.
    last_updated_timestamp: ?i64 = null,

    /// Specifies whether the management account can create Automation rules that
    /// implement optimization actions for this account.
    organization_rule_mode: ?OrganizationRuleMode = null,

    /// The current enrollment status.
    status: EnrollmentStatus,

    /// The reason for the current enrollment status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .organization_rule_mode = "organizationRuleMode",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnrollmentConfigurationInput, options: CallOptions) !GetEnrollmentConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnrollmentConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("aco-automation", "Compute Optimizer Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerAutomationService.GetEnrollmentConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnrollmentConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetEnrollmentConfigurationOutput, body, allocator);
}
