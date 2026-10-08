const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdCConfiguration = @import("id_c_configuration.zig").IdCConfiguration;

pub const GetApplicationInput = struct {
    /// The unique identifier of the application to retrieve.
    application_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
    };
};

pub const GetApplicationOutput = struct {
    /// The unique identifier of the application.
    application_id: []const u8,

    /// The name of the application.
    application_name: ?[]const u8 = null,

    /// The identifier of the default AWS KMS key used to encrypt data for the
    /// application.
    default_kms_key_id: ?[]const u8 = null,

    /// The domain associated with the application.
    domain: []const u8,

    /// The IAM Identity Center configuration for the application.
    idc_configuration: ?IdCConfiguration = null,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the
    /// application.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .application_name = "applicationName",
        .default_kms_key_id = "defaultKmsKeyId",
        .domain = "domain",
        .idc_configuration = "idcConfiguration",
        .role_arn = "roleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationInput, options: CallOptions) !GetApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetApplication";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"applicationId\":");
    try aws.json.writeValue(@TypeOf(input.application_id), input.application_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationOutput {
    const result: GetApplicationOutput = try aws.json.parseJsonObject(
        GetApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
