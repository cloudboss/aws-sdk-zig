const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KmsKey = @import("kms_key.zig").KmsKey;

pub const GetMissionProfileInput = struct {
    /// UUID of a mission profile.
    mission_profile_id: []const u8,

    pub const json_field_names = .{
        .mission_profile_id = "missionProfileId",
    };
};

pub const GetMissionProfileOutput = struct {
    /// Amount of time after a contact ends that you'd like to receive a CloudWatch
    /// event indicating the pass has finished.
    contact_post_pass_duration_seconds: ?i32 = null,

    /// Amount of time prior to contact start you'd like to receive a CloudWatch
    /// event indicating an upcoming pass.
    contact_pre_pass_duration_seconds: ?i32 = null,

    /// A list of lists of ARNs. Each list of ARNs is an edge, with a *from* `
    /// Config` and a *to* `Config`.
    dataflow_edges: ?[]const []const []const u8 = null,

    /// Smallest amount of time in seconds that you'd like to see for an available
    /// contact. AWS Ground Station will not present you with contacts shorter than
    /// this duration.
    minimum_viable_contact_duration_seconds: ?i32 = null,

    /// ARN of a mission profile.
    mission_profile_arn: ?[]const u8 = null,

    /// UUID of a mission profile.
    mission_profile_id: ?[]const u8 = null,

    /// Name of a mission profile.
    name: ?[]const u8 = null,

    /// Region of a mission profile.
    region: ?[]const u8 = null,

    /// KMS key to use for encrypting streams.
    streams_kms_key: ?KmsKey = null,

    /// Role to use for encrypting streams with KMS key.
    streams_kms_role: ?[]const u8 = null,

    /// Tags assigned to a mission profile.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// ARN of a telemetry sink `Config`.
    telemetry_sink_config_arn: ?[]const u8 = null,

    /// ARN of a tracking `Config`.
    tracking_config_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_post_pass_duration_seconds = "contactPostPassDurationSeconds",
        .contact_pre_pass_duration_seconds = "contactPrePassDurationSeconds",
        .dataflow_edges = "dataflowEdges",
        .minimum_viable_contact_duration_seconds = "minimumViableContactDurationSeconds",
        .mission_profile_arn = "missionProfileArn",
        .mission_profile_id = "missionProfileId",
        .name = "name",
        .region = "region",
        .streams_kms_key = "streamsKmsKey",
        .streams_kms_role = "streamsKmsRole",
        .tags = "tags",
        .telemetry_sink_config_arn = "telemetrySinkConfigArn",
        .tracking_config_arn = "trackingConfigArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMissionProfileInput, options: CallOptions) !GetMissionProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMissionProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/missionprofile/");
    try path_buf.appendSlice(allocator, input.mission_profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMissionProfileOutput {
    const result: GetMissionProfileOutput = try aws.json.parseJsonObject(
        GetMissionProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
