const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TelemetryMetadata = @import("telemetry_metadata.zig").TelemetryMetadata;

pub const GetTelemetryMetadataInput = struct {
    /// The ARN that specifies the assessment run that has the telemetry data that
    /// you want
    /// to obtain.
    assessment_run_arn: []const u8,

    pub const json_field_names = .{
        .assessment_run_arn = "assessmentRunArn",
    };
};

pub const GetTelemetryMetadataOutput = struct {
    /// Telemetry details.
    telemetry_metadata: ?[]const TelemetryMetadata = null,

    pub const json_field_names = .{
        .telemetry_metadata = "telemetryMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTelemetryMetadataInput, options: CallOptions) !GetTelemetryMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTelemetryMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector", "Inspector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.GetTelemetryMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTelemetryMetadataOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetTelemetryMetadataOutput, body, allocator);
}
