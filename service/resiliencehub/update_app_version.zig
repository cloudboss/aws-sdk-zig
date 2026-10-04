const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateAppVersionInput = struct {
    /// Additional configuration parameters for an Resilience Hub application. If
    /// you want to implement `additionalInfo` through the Resilience Hub console
    /// rather than using an API call, see [Configure the application configuration
    /// parameters](https://docs.aws.amazon.com/resilience-hub/latest/userguide/app-config-param.html).
    ///
    /// Currently, this parameter accepts a key-value mapping (in a string format)
    /// of only one failover region and one associated account.
    ///
    /// Key: `"failover-regions"`
    ///
    /// Value: `"[{"region":"<REGION>", "accounts":[{"id":"<ACCOUNT_ID>"}]}]"`
    additional_info: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    pub const json_field_names = .{
        .additional_info = "additionalInfo",
        .app_arn = "appArn",
    };
};

pub const UpdateAppVersionOutput = struct {
    /// Additional configuration parameters for an Resilience Hub application. If
    /// you want to implement `additionalInfo` through the Resilience Hub console
    /// rather than using an API call, see [Configure the application configuration
    /// parameters](https://docs.aws.amazon.com/resilience-hub/latest/userguide/app-config-param.html).
    ///
    /// Currently, this parameter supports only failover region and account.
    additional_info: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// Resilience Hub application version.
    app_version: []const u8,

    pub const json_field_names = .{
        .additional_info = "additionalInfo",
        .app_arn = "appArn",
        .app_version = "appVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAppVersionInput, options: CallOptions) !UpdateAppVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAppVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-app-version";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appArn\":");
    try aws.json.writeValue(@TypeOf(input.app_arn), input.app_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAppVersionOutput {
    const result: UpdateAppVersionOutput = try aws.json.parseJsonObject(
        UpdateAppVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
