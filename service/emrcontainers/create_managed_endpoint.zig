const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationOverrides = @import("configuration_overrides.zig").ConfigurationOverrides;

pub const CreateManagedEndpointInput = struct {
    /// The certificate ARN provided by users for the managed endpoint. This field
    /// is under
    /// deprecation and will be removed in future releases.
    certificate_arn: ?[]const u8 = null,

    /// The client idempotency token for this create call.
    client_token: []const u8,

    /// The configuration settings that will be used to override existing
    /// configurations.
    configuration_overrides: ?ConfigurationOverrides = null,

    /// The ARN of the execution role.
    execution_role_arn: []const u8,

    /// The name of the managed endpoint.
    name: []const u8,

    /// The Amazon EMR release version.
    release_label: []const u8,

    /// The tags of the managed endpoint.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the managed endpoint.
    @"type": []const u8,

    /// The ID of the virtual cluster for which a managed endpoint is created.
    virtual_cluster_id: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .client_token = "clientToken",
        .configuration_overrides = "configurationOverrides",
        .execution_role_arn = "executionRoleArn",
        .name = "name",
        .release_label = "releaseLabel",
        .tags = "tags",
        .@"type" = "type",
        .virtual_cluster_id = "virtualClusterId",
    };
};

pub const CreateManagedEndpointOutput = struct {
    /// The output contains the ARN of the managed endpoint.
    arn: ?[]const u8 = null,

    /// The output contains the ID of the managed endpoint.
    id: ?[]const u8 = null,

    /// The output contains the name of the managed endpoint.
    name: ?[]const u8 = null,

    /// The output contains the ID of the virtual cluster.
    virtual_cluster_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .name = "name",
        .virtual_cluster_id = "virtualClusterId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateManagedEndpointInput, options: CallOptions) !CreateManagedEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-containers", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateManagedEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr-containers", "EMR containers", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/virtualclusters/");
    try path_buf.appendSlice(allocator, input.virtual_cluster_id);
    try path_buf.appendSlice(allocator, "/endpoints");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.certificate_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificateArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.configuration_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configurationOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.execution_role_arn), input.execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"releaseLabel\":");
    try aws.json.writeValue(@TypeOf(input.release_label), input.release_label, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateManagedEndpointOutput {
    var result: CreateManagedEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateManagedEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
