const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderConfig = @import("provider_config.zig").ProviderConfig;
const DlpAction = @import("dlp_action.zig").DlpAction;
const DlpProviderType = @import("dlp_provider_type.zig").DlpProviderType;

pub const UpdateDlpSettingInput = struct {
    /// The ID of the Amazon Web Services account that contains the DLP setting that
    /// you want to update.
    aws_account_id: []const u8,

    /// The ID of the DLP setting that you want to update.
    dlp_setting_id: []const u8,

    /// Specifies whether DLP enforcement is active for this setting. Set to `true`
    /// to enable enforcement, or `false` to disable it.
    enabled: ?bool = null,

    /// An updated display name for the DLP setting.
    name: ?[]const u8 = null,

    /// An updated provider-specific configuration for the DLP integration. This is
    /// a union type structure. For this structure to be valid, only one of the
    /// attributes can be defined.
    provider_config: ?ProviderConfig = null,

    /// An updated behavior to apply when the DLP provider is unreachable. Valid
    /// values are `ALLOW`, `WARN`, and `BLOCK`.
    provider_outage_action: ?DlpAction = null,

    /// An updated DLP provider type. Currently, the only supported value is
    /// `MICROSOFT_PURVIEW`.
    provider_type: ?DlpProviderType = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dlp_setting_id = "DlpSettingId",
        .enabled = "Enabled",
        .name = "Name",
        .provider_config = "ProviderConfig",
        .provider_outage_action = "ProviderOutageAction",
        .provider_type = "ProviderType",
    };
};

pub const UpdateDlpSettingOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated DLP setting.
    arn: []const u8,

    /// The ID of the updated DLP setting.
    dlp_setting_id: []const u8,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .dlp_setting_id = "DlpSettingId",
        .request_id = "RequestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDlpSettingInput, options: CallOptions) !UpdateDlpSettingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDlpSettingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/data-loss-prevention/settings/");
    try path_buf.appendSlice(allocator, input.dlp_setting_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Enabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provider_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProviderConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provider_outage_action) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProviderOutageAction\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provider_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProviderType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDlpSettingOutput {
    const result: UpdateDlpSettingOutput = try aws.json.parseJsonObject(
        UpdateDlpSettingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
