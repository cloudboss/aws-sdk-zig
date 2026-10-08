const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Architecture = @import("architecture.zig").Architecture;
const BuildState = @import("build_state.zig").BuildState;
const Chipset = @import("chipset.zig").Chipset;
const SnapshotBuild = @import("snapshot_build.zig").SnapshotBuild;

pub const GetMicrovmImageBuildInput = struct {
    /// The unique identifier of the build to retrieve.
    build_id: []const u8,

    /// The unique identifier (ARN or ID) of the MicroVM image.
    image_identifier: []const u8,

    /// The version of the MicroVM image.
    image_version: []const u8,

    pub const json_field_names = .{
        .build_id = "buildId",
        .image_identifier = "imageIdentifier",
        .image_version = "imageVersion",
    };
};

pub const GetMicrovmImageBuildOutput = struct {
    /// The target CPU architecture for the build. Supported value: ARM_64.
    architecture: Architecture,

    /// The build request ID.
    build_id: []const u8,

    /// The current state of the build.
    build_state: BuildState,

    /// The target chipset for the build.
    chipset: Chipset,

    /// The target chipset generation for the build.
    chipset_generation: []const u8,

    /// The timestamp when the build was created.
    created_at: i64,

    /// The ARN of the MicroVM image.
    image_arn: []const u8,

    /// The version of the MicroVM image.
    image_version: []const u8,

    /// The snapshot build details, including memory and disk snapshot sizes.
    snapshot_build: ?SnapshotBuild = null,

    /// The reason for the build state, if applicable.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .architecture = "architecture",
        .build_id = "buildId",
        .build_state = "buildState",
        .chipset = "chipset",
        .chipset_generation = "chipsetGeneration",
        .created_at = "createdAt",
        .image_arn = "imageArn",
        .image_version = "imageVersion",
        .snapshot_build = "snapshotBuild",
        .state_reason = "stateReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMicrovmImageBuildInput, options: CallOptions) !GetMicrovmImageBuildOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMicrovmImageBuildInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Microvms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-09-09/microvm-images/");
    try path_buf.appendSlice(allocator, input.image_identifier);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.image_version);
    try path_buf.appendSlice(allocator, "/builds/");
    try path_buf.appendSlice(allocator, input.build_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMicrovmImageBuildOutput {
    const result: GetMicrovmImageBuildOutput = try aws.json.parseJsonObject(
        GetMicrovmImageBuildOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
