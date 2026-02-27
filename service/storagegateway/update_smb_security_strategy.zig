const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SMBSecurityStrategy = @import("smb_security_strategy.zig").SMBSecurityStrategy;

pub const UpdateSMBSecurityStrategyInput = struct {
    gateway_arn: []const u8,

    /// Specifies the type of security strategy.
    ///
    /// `ClientSpecified`: If you choose this option, requests are established based
    /// on what is negotiated by the client. This option is recommended when you
    /// want to maximize
    /// compatibility across different clients in your environment. Supported only
    /// for S3 File
    /// Gateway.
    ///
    /// `MandatorySigning`: If you choose this option, File Gateway only allows
    /// connections from SMBv2 or SMBv3 clients that have signing enabled. This
    /// option works with
    /// SMB clients on Microsoft Windows Vista, Windows Server 2008 or newer.
    ///
    /// `MandatoryEncryption`: If you choose this option, File Gateway only allows
    /// connections from SMBv3 clients that have encryption enabled. This option is
    /// recommended for
    /// environments that handle sensitive data. This option works with SMB clients
    /// on Microsoft
    /// Windows 8, Windows Server 2012 or newer.
    ///
    /// `MandatoryEncryptionNoAes128`: If you choose this option, File Gateway only
    /// allows connections from SMBv3 clients that use 256-bit AES encryption
    /// algorithms. 128-bit
    /// algorithms are not allowed. This option is recommended for environments that
    /// handle
    /// sensitive data. It works with SMB clients on Microsoft Windows 8, Windows
    /// Server 2012, or
    /// later.
    smb_security_strategy: SMBSecurityStrategy,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .smb_security_strategy = "SMBSecurityStrategy",
    };
};

pub const UpdateSMBSecurityStrategyOutput = struct {
    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSMBSecurityStrategyInput, options: Options) !UpdateSMBSecurityStrategyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateSMBSecurityStrategyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "StorageGateway_20130630.UpdateSMBSecurityStrategy");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateSMBSecurityStrategyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSMBSecurityStrategyOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
