const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountColor = @import("account_color.zig").AccountColor;

pub const GetAccountCustomizationsInput = struct {};

pub const GetAccountCustomizationsOutput = struct {
    /// The account color preference. A value of `none` indicates that you have not
    /// set a color.
    account_color: ?AccountColor = null,

    /// The list of Amazon Web Services Region codes that are visible to the account
    /// in the Amazon Web Services Management Console. A value of `null` indicates
    /// that you have not configured this feature and all Regions are visible. For a
    /// list of valid Region codes, see [Amazon Web Services
    /// Regions](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html).
    visible_regions: ?[]const []const u8 = null,

    /// The list of Amazon Web Services service identifiers that are visible to the
    /// account in the Amazon Web Services Management Console. A value of `null`
    /// indicates that you have not configured this feature and all services are
    /// visible. For valid service identifiers, call
    /// [ListServices](https://docs.aws.amazon.com/awsconsolehelpdocs/latest/APIReference/API_ListServices.html).
    visible_services: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_color = "accountColor",
        .visible_regions = "visibleRegions",
        .visible_services = "visibleServices",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountCustomizationsInput, options: CallOptions) !GetAccountCustomizationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountCustomizationsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("uxc", "uxc", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/account-customizations";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountCustomizationsOutput {
    const result: GetAccountCustomizationsOutput = try aws.json.parseJsonObject(
        GetAccountCustomizationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
