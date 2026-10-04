const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Target = @import("target.zig").Target;
const HomeRegionControl = @import("home_region_control.zig").HomeRegionControl;

pub const DescribeHomeRegionControlsInput = struct {
    /// The `ControlID` is a unique identifier string of your
    /// `HomeRegionControl` object.
    control_id: ?[]const u8 = null,

    /// The name of the home region you'd like to view.
    home_region: ?[]const u8 = null,

    /// The maximum number of filtering results to display per page.
    max_results: ?i32 = null,

    /// If a `NextToken` was returned by a previous call, more results are
    /// available.
    /// To retrieve the next page of results, make the call again using the returned
    /// token in
    /// `NextToken`.
    next_token: ?[]const u8 = null,

    /// The target parameter specifies the identifier to which the home region is
    /// applied, which
    /// is always of type `ACCOUNT`. It applies the home region to the current
    /// `ACCOUNT`.
    target: ?Target = null,

    pub const json_field_names = .{
        .control_id = "ControlId",
        .home_region = "HomeRegion",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .target = "Target",
    };
};

pub const DescribeHomeRegionControlsOutput = struct {
    /// An array that contains your `HomeRegionControl` objects.
    home_region_controls: ?[]const HomeRegionControl = null,

    /// If a `NextToken` was returned by a previous call, more results are
    /// available.
    /// To retrieve the next page of results, make the call again using the returned
    /// token in
    /// `NextToken`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .home_region_controls = "HomeRegionControls",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHomeRegionControlsInput, options: CallOptions) !DescribeHomeRegionControlsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgh", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeHomeRegionControlsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-config", "MigrationHub Config", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHubMultiAccountService.DescribeHomeRegionControls");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeHomeRegionControlsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeHomeRegionControlsOutput, body, allocator);
}
