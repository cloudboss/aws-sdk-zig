const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateDatasetIntegrationInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset integration to update.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role to associate with the dataset
    /// integration.
    role_arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .role_arn = "RoleArn",
    };
};

pub const UpdateDatasetIntegrationOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated dataset integration.
    arn: []const u8,

    /// The timestamp when the dataset integration was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the updated
    /// dataset integration.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDatasetIntegrationInput, options: CallOptions) !UpdateDatasetIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDatasetIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateDatasetIntegration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDatasetIntegrationOutput {
    const result: UpdateDatasetIntegrationOutput = try aws.json.parseJsonObject(
        UpdateDatasetIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
