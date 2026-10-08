const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountColor = @import("account_color.zig").AccountColor;

pub const UpdateAccountCustomizationsInput = struct {
    /// The account color preference to set. Set to `none` to reset to the default
    /// (no color).
    account_color: ?AccountColor = null,

    /// The list of Amazon Web Services Region codes to make visible in the Amazon
    /// Web Services Management Console. Set to `null` to reset to the default,
    /// which makes all Regions visible. For a list of valid Region codes, see
    /// [Amazon Web Services
    /// Regions](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html).
    visible_regions: ?[]const []const u8 = null,

    /// The list of Amazon Web Services service identifiers to make visible in the
    /// Amazon Web Services Management Console. Set to `null` to reset to the
    /// default, which makes all services visible. For valid service identifiers,
    /// call
    /// [ListServices](https://docs.aws.amazon.com/awsconsolehelpdocs/latest/APIReference/API_ListServices.html).
    visible_services: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_color = "accountColor",
        .visible_regions = "visibleRegions",
        .visible_services = "visibleServices",
    };
};

pub const UpdateAccountCustomizationsOutput = struct {
    /// The current account color preference after the update.
    account_color: ?AccountColor = null,

    /// The current list of visible Region codes after the update.
    visible_regions: ?[]const []const u8 = null,

    /// The current list of visible service identifiers after the update.
    visible_services: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_color = "accountColor",
        .visible_regions = "visibleRegions",
        .visible_services = "visibleServices",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountCustomizationsInput, options: CallOptions) !UpdateAccountCustomizationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "uxc", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountCustomizationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("uxc", "uxc", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/account-customizations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_color) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountColor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.visible_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"visibleRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.visible_services) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"visibleServices\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountCustomizationsOutput {
    const result: UpdateAccountCustomizationsOutput = try aws.json.parseJsonObject(
        UpdateAccountCustomizationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
