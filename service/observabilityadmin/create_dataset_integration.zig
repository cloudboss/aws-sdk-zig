const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateDatasetIntegrationInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that grants Amazon CloudWatch
    /// permission to access the resources needed for the dataset integration.
    role_arn: []const u8,

    /// The key-value pairs to associate with the dataset integration resource for
    /// categorization and management purposes.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateDatasetIntegrationOutput = struct {
    /// The Amazon Resource Name (ARN) of the created dataset integration.
    arn: []const u8,

    /// The timestamp when the dataset integration was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the dataset
    /// integration.
    role_arn: []const u8,

    /// The timestamp when the dataset integration was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .role_arn = "RoleArn",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetIntegrationInput, options: CallOptions) !CreateDatasetIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatasetIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateDatasetIntegration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetIntegrationOutput {
    const result: CreateDatasetIntegrationOutput = try aws.json.parseJsonObject(
        CreateDatasetIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
