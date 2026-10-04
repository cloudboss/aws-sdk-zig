const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ControlFindingGenerator = @import("control_finding_generator.zig").ControlFindingGenerator;

pub const DescribeHubInput = struct {
    /// The ARN of the Hub resource to retrieve.
    hub_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .hub_arn = "HubArn",
    };
};

pub const DescribeHubOutput = struct {
    /// Whether to automatically enable new controls when they are added to
    /// standards that are
    /// enabled.
    ///
    /// If set to `true`, then new controls for enabled standards are enabled
    /// automatically. If set to `false`, then new controls are not enabled.
    ///
    /// When you automatically enable new controls, you can interact with the
    /// controls in
    /// the console and programmatically immediately after release. However,
    /// automatically enabled controls have a temporary default status of
    /// `DISABLED`. It can take up to several days for Security Hub CSPM to process
    /// the control release and designate the
    /// control as `ENABLED` in your account. During the processing period, you can
    /// manually enable or disable a
    /// control, and Security Hub CSPM will maintain that designation regardless of
    /// whether you have `AutoEnableControls` set to
    /// `true`.
    auto_enable_controls: ?bool = null,

    /// Specifies whether the calling account has consolidated control findings
    /// turned on. If the value for this field is set to
    /// `SECURITY_CONTROL`, Security Hub CSPM generates a single finding for a
    /// control check even when the check
    /// applies to multiple enabled standards.
    ///
    /// If the value for this field is set to `STANDARD_CONTROL`, Security Hub CSPM
    /// generates separate findings
    /// for a control check when the check applies to multiple enabled standards.
    ///
    /// The value for this field in a member account matches the value in the
    /// administrator
    /// account. For accounts that aren't part of an organization, the default value
    /// of this field
    /// is `SECURITY_CONTROL` if you enabled Security Hub CSPM on or after February
    /// 23,
    /// 2023.
    control_finding_generator: ?ControlFindingGenerator = null,

    /// The ARN of the Hub resource that was retrieved.
    hub_arn: ?[]const u8 = null,

    /// The date and time when Security Hub CSPM was enabled in the account.
    subscribed_at: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_enable_controls = "AutoEnableControls",
        .control_finding_generator = "ControlFindingGenerator",
        .hub_arn = "HubArn",
        .subscribed_at = "SubscribedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHubInput, options: CallOptions) !DescribeHubOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeHubInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/accounts";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.hub_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "HubArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeHubOutput {
    const result: DescribeHubOutput = try aws.json.parseJsonObject(
        DescribeHubOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
