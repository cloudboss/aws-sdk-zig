const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartTelemetryEvaluationForOrganizationInput = struct {
    /// If set to `true`, telemetry evaluation for the organization starts in all
    /// Amazon Web Services Regions where Amazon CloudWatch Observability Admin is
    /// available in the current partition. The current region becomes the home
    /// region for managing multi-region evaluation for the organization. When new
    /// regions become available, evaluation automatically expands to include them.
    /// Mutually exclusive with `Regions`.
    all_regions: ?bool = null,

    /// An optional list of Amazon Web Services Regions to include in multi-region
    /// telemetry evaluation for the organization. The current region is always
    /// implicitly included and must not be specified in this list. When provided,
    /// telemetry evaluation starts in the current region and propagates to all
    /// specified regions for the organization. Mutually exclusive with
    /// `AllRegions`. If neither `Regions` nor `AllRegions` is provided, the
    /// operation applies only to the current region.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .all_regions = "AllRegions",
        .regions = "Regions",
    };
};

pub const StartTelemetryEvaluationForOrganizationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTelemetryEvaluationForOrganizationInput, options: CallOptions) !StartTelemetryEvaluationForOrganizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTelemetryEvaluationForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartTelemetryEvaluationForOrganization";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.all_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Regions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTelemetryEvaluationForOrganizationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: StartTelemetryEvaluationForOrganizationOutput = .{};

    return result;
}
