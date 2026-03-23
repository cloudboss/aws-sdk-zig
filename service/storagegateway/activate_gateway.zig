const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;

pub const ActivateGatewayInput = struct {
    /// Your gateway activation key. You can obtain the activation key by sending an
    /// HTTP GET
    /// request with redirects enabled to the gateway IP address (port 80). The
    /// redirect URL
    /// returned in the response provides you the activation key for your gateway in
    /// the query
    /// string parameter `activationKey`. It may also include other
    /// activation-related
    /// parameters, however, these are merely defaults -- the arguments you pass to
    /// the
    /// `ActivateGateway` API call determine the actual configuration of your
    /// gateway.
    ///
    /// For more information, see [Getting activation
    /// key](https://docs.aws.amazon.com/storagegateway/latest/userguide/get-activation-key.html) in the *Storage Gateway User Guide*.
    activation_key: []const u8,

    /// The name you configured for your gateway.
    gateway_name: []const u8,

    /// A value that indicates the Amazon Web Services Region where you want to
    /// store your data.
    /// The gateway Amazon Web Services Region specified must be the same Amazon Web
    /// Services Region
    /// as the Amazon Web Services Region in your `Host` header in the request. For
    /// more
    /// information about available Amazon Web Services Regions and endpoints for
    /// Storage Gateway, see [
    /// Storage Gateway endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/sg.html) in the
    /// *Amazon Web Services
    /// General Reference*.
    ///
    /// Valid Values: See [
    /// Storage Gateway endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/sg.html) in the
    /// *Amazon Web Services
    /// General Reference*.
    gateway_region: []const u8,

    /// A value that indicates the time zone you want to set for the gateway. The
    /// time zone is
    /// of the format "GMT", "GMT-hr:mm", or "GMT+hr:mm". For example, GMT indicates
    /// Greenwich Mean
    /// Time without any offset. GMT-4:00 indicates the time is 4 hours behind GMT.
    /// GMT+2:00
    /// indicates the time is 2 hours ahead of GMT. The time zone is used, for
    /// example, for
    /// scheduling snapshots and your gateway's maintenance schedule.
    gateway_timezone: []const u8,

    /// A value that defines the type of gateway to activate. The type specified is
    /// critical to
    /// all later functions of the gateway and cannot be changed after activation.
    /// The default
    /// value is `CACHED`.
    ///
    /// Amazon FSx File Gateway is no longer available to new customers. Existing
    /// customers of FSx File Gateway can continue to use the service normally. For
    /// capabilities similar to FSx File Gateway, visit [this blog
    /// post](https://aws.amazon.com/blogs/storage/switch-your-file-share-access-from-amazon-fsx-file-gateway-to-amazon-fsx-for-windows-file-server/).
    ///
    /// Valid Values: `STORED` | `CACHED` | `VTL`
    /// | `FILE_S3` |
    /// `FILE_FSX_SMB`
    gateway_type: ?[]const u8 = null,

    /// The value that indicates the type of medium changer to use for tape gateway.
    /// This field
    /// is optional.
    ///
    /// Valid Values: `STK-L700` | `AWS-Gateway-VTL` |
    /// `IBM-03584L32-0402`
    medium_changer_type: ?[]const u8 = null,

    /// A list of up to 50 tags that you can assign to the gateway. Each tag is a
    /// key-value
    /// pair.
    ///
    /// Valid characters for key and value are letters, spaces, and numbers that can
    /// be
    /// represented in UTF-8 format, and the following special characters: + - = . _
    /// : / @. The
    /// maximum length of a tag's key is 128 characters, and the maximum length for
    /// a
    /// tag's value is 256 characters.
    tags: ?[]const Tag = null,

    /// The value that indicates the type of tape drive to use for tape gateway.
    /// This field is
    /// optional.
    ///
    /// Valid Values: `IBM-ULT3580-TD5`
    tape_drive_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .activation_key = "ActivationKey",
        .gateway_name = "GatewayName",
        .gateway_region = "GatewayRegion",
        .gateway_timezone = "GatewayTimezone",
        .gateway_type = "GatewayType",
        .medium_changer_type = "MediumChangerType",
        .tags = "Tags",
        .tape_drive_type = "TapeDriveType",
    };
};

pub const ActivateGatewayOutput = struct {
    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ActivateGatewayInput, options: CallOptions) !ActivateGatewayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ActivateGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.ActivateGateway");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ActivateGatewayOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ActivateGatewayOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
