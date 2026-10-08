const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Ec2DeepInspectionStatus = @import("ec_2_deep_inspection_status.zig").Ec2DeepInspectionStatus;

pub const GetEc2DeepInspectionConfigurationInput = struct {};

pub const GetEc2DeepInspectionConfigurationOutput = struct {
    /// An error message explaining why Amazon Inspector deep inspection
    /// configurations could not be
    /// retrieved for your account.
    error_message: ?[]const u8 = null,

    /// The Amazon Inspector deep inspection custom paths for your organization.
    org_package_paths: ?[]const []const u8 = null,

    /// The Amazon Inspector deep inspection custom paths for your account.
    package_paths: ?[]const []const u8 = null,

    /// The activation status of Amazon Inspector deep inspection in your account.
    status: ?Ec2DeepInspectionStatus = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .org_package_paths = "orgPackagePaths",
        .package_paths = "packagePaths",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEc2DeepInspectionConfigurationInput, options: CallOptions) !GetEc2DeepInspectionConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEc2DeepInspectionConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ec2deepinspectionconfiguration/get";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEc2DeepInspectionConfigurationOutput {
    const result: GetEc2DeepInspectionConfigurationOutput = try aws.json.parseJsonObject(
        GetEc2DeepInspectionConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
