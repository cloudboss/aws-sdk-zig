const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ArtifactType = @import("artifact_type.zig").ArtifactType;

pub const AddArtifactInput = struct {
    /// The unique identifier of the agent space to add the artifact to.
    agent_space_id: []const u8,

    /// The binary content of the artifact to upload.
    artifact_content: []const u8,

    /// The file type of the artifact. Valid values include TXT, PNG, JPEG, MD, PDF,
    /// DOCX, DOC, JSON, and YAML.
    artifact_type: ArtifactType,

    /// The file name of the artifact.
    file_name: []const u8,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .artifact_content = "artifactContent",
        .artifact_type = "artifactType",
        .file_name = "fileName",
    };
};

pub const AddArtifactOutput = struct {
    /// The unique identifier assigned to the uploaded artifact.
    artifact_id: []const u8,

    pub const json_field_names = .{
        .artifact_id = "artifactId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddArtifactInput, options: CallOptions) !AddArtifactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddArtifactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/AddArtifact";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentSpaceId\":");
    try aws.json.writeValue(@TypeOf(input.agent_space_id), input.agent_space_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"artifactContent\":");
    try aws.json.writeValue(@TypeOf(input.artifact_content), input.artifact_content, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"artifactType\":");
    try aws.json.writeValue(@TypeOf(input.artifact_type), input.artifact_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fileName\":");
    try aws.json.writeValue(@TypeOf(input.file_name), input.file_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddArtifactOutput {
    const result: AddArtifactOutput = try aws.json.parseJsonObject(
        AddArtifactOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
