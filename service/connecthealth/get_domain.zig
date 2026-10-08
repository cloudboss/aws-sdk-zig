const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionContext = @import("encryption_context.zig").EncryptionContext;
const DomainStatus = @import("domain_status.zig").DomainStatus;
const WebAppConfiguration = @import("web_app_configuration.zig").WebAppConfiguration;

pub const GetDomainInput = struct {
    /// The id of the Domain to get
    domain_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "domainId",
    };
};

pub const GetDomainOutput = struct {
    arn: []const u8,

    created_at: i64,

    domain_id: []const u8,

    encryption_context: ?EncryptionContext = null,

    kms_key_arn: ?[]const u8 = null,

    name: []const u8,

    status: DomainStatus,

    /// Tags associated with the Domain
    tags: ?[]const aws.map.StringMapEntry = null,

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
        .tags = "tags",
        .web_app_configuration = "webAppConfiguration",
        .web_app_url = "webAppUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainInput, options: CallOptions) !GetDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health-agent", "ConnectHealth", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domain/");
    try path_buf.appendSlice(allocator, input.domain_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainOutput {
    const result: GetDomainOutput = try aws.json.parseJsonObject(
        GetDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
