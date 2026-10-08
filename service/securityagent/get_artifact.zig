const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Artifact = @import("artifact.zig").Artifact;

pub const GetArtifactInput = struct {
    /// The unique identifier of the agent space that contains the artifact.
    agent_space_id: []const u8,

    /// The unique identifier of the artifact to retrieve.
    artifact_id: []const u8,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .artifact_id = "artifactId",
    };
};

pub const GetArtifactOutput = struct {
    /// The unique identifier of the agent space that contains the artifact.
    agent_space_id: []const u8,

    /// The artifact content and type.
    artifact: ?Artifact = null,

    /// The unique identifier of the artifact.
    artifact_id: []const u8,

    /// The file name of the artifact.
    file_name: []const u8,

    /// The date and time the artifact was last updated, in UTC format.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .artifact = "artifact",
        .artifact_id = "artifactId",
        .file_name = "fileName",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetArtifactInput, options: CallOptions) !GetArtifactOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetArtifactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetArtifact";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentSpaceId\":");
    try aws.json.writeValue(@TypeOf(input.agent_space_id), input.agent_space_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"artifactId\":");
    try aws.json.writeValue(@TypeOf(input.artifact_id), input.artifact_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetArtifactOutput {
    const result: GetArtifactOutput = try aws.json.parseJsonObject(
        GetArtifactOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
