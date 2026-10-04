const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainNameConfig = @import("domain_name_config.zig").DomainNameConfig;

pub const CreateDomainNameInput = struct {
    /// The Amazon Resource Name (ARN) of the certificate. This can be an
    /// Certificate Manager
    /// (ACM) certificate or an Identity and Access Management (IAM)
    /// server certificate.
    certificate_arn: []const u8,

    /// A description of the `DomainName`.
    description: ?[]const u8 = null,

    /// The domain name.
    domain_name: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .description = "description",
        .domain_name = "domainName",
        .tags = "tags",
    };
};

pub const CreateDomainNameOutput = struct {
    /// The configuration for the `DomainName`.
    domain_name_config: ?DomainNameConfig = null,

    pub const json_field_names = .{
        .domain_name_config = "domainNameConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainNameInput, options: CallOptions) !CreateDomainNameOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appsync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainNameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/domainnames";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"certificateArn\":");
    try aws.json.writeValue(@TypeOf(input.certificate_arn), input.certificate_arn, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"domainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainNameOutput {
    var result: CreateDomainNameOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDomainNameOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
