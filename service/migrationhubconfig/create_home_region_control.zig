const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Target = @import("target.zig").Target;
const HomeRegionControl = @import("home_region_control.zig").HomeRegionControl;

pub const CreateHomeRegionControlInput = struct {
    /// Optional Boolean flag to indicate whether any effect should take place. It
    /// tests whether
    /// the caller has permission to make the call.
    dry_run: ?bool = null,

    /// The name of the home region of the calling account.
    home_region: []const u8,

    /// The account for which this command sets up a home region control. The
    /// `Target`
    /// is always of type `ACCOUNT`.
    target: Target,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .home_region = "HomeRegion",
        .target = "Target",
    };
};

pub const CreateHomeRegionControlOutput = struct {
    /// This object is the `HomeRegionControl` object that's returned by a
    /// successful
    /// call to `CreateHomeRegionControl`.
    home_region_control: ?HomeRegionControl = null,

    pub const json_field_names = .{
        .home_region_control = "HomeRegionControl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHomeRegionControlInput, options: CallOptions) !CreateHomeRegionControlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHomeRegionControlInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHubMultiAccountService.CreateHomeRegionControl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHomeRegionControlOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateHomeRegionControlOutput, body, allocator);
}
