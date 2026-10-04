const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegionStatus = @import("region_status.zig").RegionStatus;
const Status = @import("status.zig").Status;

pub const GetTelemetryEvaluationStatusForOrganizationInput = struct {};

pub const GetTelemetryEvaluationStatusForOrganizationOutput = struct {
    /// This field describes the reason for the failure status. The field will only
    /// be populated if `Status` is `FAILED_START` or `FAILED_STOP`.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Web Services Region that is designated as the home region for
    /// multi-region telemetry evaluation for the organization. The home region is
    /// the single management point for all multi-region operations on this
    /// organization. This field is only present when multi-region telemetry
    /// evaluation is active.
    home_region: ?[]const u8 = null,

    /// A list of per-region telemetry evaluation statuses for the organization.
    /// Each entry indicates the evaluation status for a specific spoke region
    /// included in the multi-region configuration. This field is only present when
    /// multi-region telemetry evaluation is active.
    region_statuses: ?[]const RegionStatus = null,

    /// The onboarding status of the telemetry config feature for the organization.
    status: ?Status = null,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .home_region = "HomeRegion",
        .region_statuses = "RegionStatuses",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTelemetryEvaluationStatusForOrganizationInput, options: CallOptions) !GetTelemetryEvaluationStatusForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "observabilityadmin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTelemetryEvaluationStatusForOrganizationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetTelemetryEvaluationStatusForOrganization";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTelemetryEvaluationStatusForOrganizationOutput {
    var result: GetTelemetryEvaluationStatusForOrganizationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTelemetryEvaluationStatusForOrganizationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
