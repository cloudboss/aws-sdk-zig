const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateWebAppConfiguration = @import("create_web_app_configuration.zig").CreateWebAppConfiguration;
const EncryptionContext = @import("encryption_context.zig").EncryptionContext;
const DomainStatus = @import("domain_status.zig").DomainStatus;
const WebAppConfiguration = @import("web_app_configuration.zig").WebAppConfiguration;

pub const CreateDomainInput = struct {
    /// The ARN of the KMS key to use for encrypting data in this Domain.
    kms_key_arn: ?[]const u8 = null,

    /// The name for the new Domain.
    name: []const u8,

    /// Tags to associate with the Domain.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Configuration for the Domain web application. Optional, but if provided all
    /// fields are required.
    web_app_setup_configuration: ?CreateWebAppConfiguration = null,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .tags = "tags",
        .web_app_setup_configuration = "webAppSetupConfiguration",
    };
};

pub const CreateDomainOutput = struct {
    arn: []const u8,

    created_at: i64,

    domain_id: []const u8,

    encryption_context: ?EncryptionContext = null,

    kms_key_arn: ?[]const u8 = null,

    name: []const u8,

    status: DomainStatus,

    web_app_configuration: ?WebAppConfiguration = null,

    web_app_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .domain_id = "domainId",
        .encryption_context = "encryptionContext",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .status = "status",
        .web_app_configuration = "webAppConfiguration",
        .web_app_url = "webAppUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainInput, options: CallOptions) !CreateDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health-agent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health-agent", "ConnectHealth", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/domain";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.web_app_setup_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"webAppSetupConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainOutput {
    const result: CreateDomainOutput = try aws.json.parseJsonObject(
        CreateDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
