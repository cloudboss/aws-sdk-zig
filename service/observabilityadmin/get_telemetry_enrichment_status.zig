const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TelemetryEnrichmentStatus = @import("telemetry_enrichment_status.zig").TelemetryEnrichmentStatus;

pub const GetTelemetryEnrichmentStatusInput = struct {};

pub const GetTelemetryEnrichmentStatusOutput = struct {
    /// The Amazon Resource Name (ARN) of the Resource Explorer managed view used
    /// for resource tags for telemetry, if the feature is enabled.
    aws_resource_explorer_managed_view_arn: ?[]const u8 = null,

    /// The current status of the resource tags for telemetry feature (`Running`,
    /// `Stopped`, or `Impaired`).
    status: ?TelemetryEnrichmentStatus = null,

    pub const json_field_names = .{
        .aws_resource_explorer_managed_view_arn = "AwsResourceExplorerManagedViewArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTelemetryEnrichmentStatusInput, options: CallOptions) !GetTelemetryEnrichmentStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTelemetryEnrichmentStatusInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetTelemetryEnrichmentStatus";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTelemetryEnrichmentStatusOutput {
    var result: GetTelemetryEnrichmentStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTelemetryEnrichmentStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
