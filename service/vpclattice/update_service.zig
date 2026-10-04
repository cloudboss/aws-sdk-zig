const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthType = @import("auth_type.zig").AuthType;

pub const UpdateServiceInput = struct {
    /// The type of IAM policy.
    ///
    /// * `NONE`: The resource does not use an IAM policy. This is the default.
    /// * `AWS_IAM`: The resource uses an IAM policy. When this type is used, auth
    ///   is enabled and an auth policy is required.
    auth_type: ?AuthType = null,

    /// The Amazon Resource Name (ARN) of the certificate.
    certificate_arn: ?[]const u8 = null,

    /// The amount of time, in seconds, that a connection can remain idle (no data
    /// sent) before VPC Lattice closes it. The valid range is 60 to 600 seconds. If
    /// you don't specify a value, the default is 60 seconds. This setting does not
    /// change the maximum connection duration of 10 minutes; connections are still
    /// closed when they reach that limit.
    idle_timeout_seconds: ?i32 = null,

    /// The ID or ARN of the service.
    service_identifier: []const u8,

    pub const json_field_names = .{
        .auth_type = "authType",
        .certificate_arn = "certificateArn",
        .idle_timeout_seconds = "idleTimeoutSeconds",
        .service_identifier = "serviceIdentifier",
    };
};

pub const UpdateServiceOutput = struct {
    /// The Amazon Resource Name (ARN) of the service.
    arn: ?[]const u8 = null,

    /// The type of IAM policy.
    auth_type: ?AuthType = null,

    /// The Amazon Resource Name (ARN) of the certificate.
    certificate_arn: ?[]const u8 = null,

    /// The custom domain name of the service.
    custom_domain_name: ?[]const u8 = null,

    /// The ID of the service.
    id: ?[]const u8 = null,

    /// The amount of time, in seconds, that a connection can remain idle before VPC
    /// Lattice closes it.
    idle_timeout_seconds: ?i32 = null,

    /// The name of the service.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .auth_type = "authType",
        .certificate_arn = "certificateArn",
        .custom_domain_name = "customDomainName",
        .id = "id",
        .idle_timeout_seconds = "idleTimeoutSeconds",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceInput, options: CallOptions) !UpdateServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/services/");
    try path_buf.appendSlice(allocator, input.service_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auth_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.certificate_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificateArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.idle_timeout_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idleTimeoutSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceOutput {
    const result: UpdateServiceOutput = try aws.json.parseJsonObject(
        UpdateServiceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
