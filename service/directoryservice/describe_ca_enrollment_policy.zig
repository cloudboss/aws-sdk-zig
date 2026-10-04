const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CaEnrollmentPolicyStatus = @import("ca_enrollment_policy_status.zig").CaEnrollmentPolicyStatus;

pub const DescribeCAEnrollmentPolicyInput = struct {
    /// The identifier of the directory for which to retrieve the CA enrollment
    /// policy
    /// information.
    directory_id: []const u8,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
    };
};

pub const DescribeCAEnrollmentPolicyOutput = struct {
    /// The current status of the CA enrollment policy. This indicates if automatic
    /// certificate
    /// enrollment is currently active, inactive, or in a transitional state.
    ///
    /// Valid values:
    ///
    /// * `IN_PROGRESS` - The policy is being activated T
    ///
    /// * `SUCCESS` - The policy is active and automatic certificate enrollment is
    /// operational
    ///
    /// * `FAILED` - The policy activation or deactivation failed
    ///
    /// * `DISABLING` - The policy is being deactivated
    ///
    /// * `DISABLED` - The policy is inactive and automatic certificate enrollment
    ///   is
    /// not available
    ///
    /// * `IMPAIRED` - Network connectivity is impaired.
    ca_enrollment_policy_status: ?CaEnrollmentPolicyStatus = null,

    /// Additional information explaining the current status of the CA enrollment
    /// policy,
    /// particularly useful when the policy is in an error or transitional state.
    ca_enrollment_policy_status_reason: ?[]const u8 = null,

    /// The identifier of the directory associated with this CA enrollment policy.
    directory_id: ?[]const u8 = null,

    /// The date and time when the CA enrollment policy was last modified or
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Private
    /// Certificate Authority (PCA) connector
    /// that is configured for automatic certificate enrollment in this directory.
    pca_connector_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .ca_enrollment_policy_status = "CaEnrollmentPolicyStatus",
        .ca_enrollment_policy_status_reason = "CaEnrollmentPolicyStatusReason",
        .directory_id = "DirectoryId",
        .last_updated_date_time = "LastUpdatedDateTime",
        .pca_connector_arn = "PcaConnectorArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCAEnrollmentPolicyInput, options: CallOptions) !DescribeCAEnrollmentPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCAEnrollmentPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeCAEnrollmentPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCAEnrollmentPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCAEnrollmentPolicyOutput, body, allocator);
}
