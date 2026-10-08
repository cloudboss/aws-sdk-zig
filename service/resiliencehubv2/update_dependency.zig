const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DependencyCriticality = @import("dependency_criticality.zig").DependencyCriticality;

pub const UpdateDependencyInput = struct {
    /// A comment about the dependency.
    comment: ?[]const u8 = null,

    /// The updated criticality level of the dependency.
    criticality: ?DependencyCriticality = null,

    /// The identifier of the dependency to update.
    dependency_id: []const u8,

    service_arn: []const u8,

    pub const json_field_names = .{
        .comment = "comment",
        .criticality = "criticality",
        .dependency_id = "dependencyId",
        .service_arn = "serviceArn",
    };
};

pub const UpdateDependencyOutput = struct {
    /// The comment about the dependency.
    comment: ?[]const u8 = null,

    /// The criticality level of the dependency.
    criticality: DependencyCriticality,

    /// The identifier of the updated dependency.
    dependency_id: []const u8,

    /// The name of the updated dependency.
    dependency_name: []const u8,

    /// The location of the dependency.
    location: []const u8,

    /// The provider of the dependency.
    provider: ?[]const u8 = null,

    /// The timestamp when the dependency was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .comment = "comment",
        .criticality = "criticality",
        .dependency_id = "dependencyId",
        .dependency_name = "dependencyName",
        .location = "location",
        .provider = "provider",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDependencyInput, options: CallOptions) !UpdateDependencyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDependencyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/update-dependency";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.comment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"comment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.criticality) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"criticality\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dependencyId\":");
    try aws.json.writeValue(@TypeOf(input.dependency_id), input.dependency_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceArn\":");
    try aws.json.writeValue(@TypeOf(input.service_arn), input.service_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDependencyOutput {
    const result: UpdateDependencyOutput = try aws.json.parseJsonObject(
        UpdateDependencyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
