const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistryScanningRule = @import("registry_scanning_rule.zig").RegistryScanningRule;
const ScanType = @import("scan_type.zig").ScanType;
const RegistryScanningConfiguration = @import("registry_scanning_configuration.zig").RegistryScanningConfiguration;

pub const PutRegistryScanningConfigurationInput = struct {
    /// The scanning rules to use for the registry. A scanning rule is used to
    /// determine which
    /// repository filters are used and at what frequency scanning will occur.
    rules: ?[]const RegistryScanningRule = null,

    /// The scanning type to set for the registry.
    ///
    /// When a registry scanning configuration is not defined, by default the
    /// `BASIC` scan type is used. When basic scanning is used, you may specify
    /// filters to determine which individual repositories, or all repositories, are
    /// scanned
    /// when new images are pushed to those repositories. Alternatively, you can do
    /// manual scans
    /// of images with basic scanning.
    ///
    /// When the `ENHANCED` scan type is set, Amazon Inspector provides automated
    /// vulnerability scanning. You may choose between continuous scanning or scan
    /// on push and
    /// you may specify filters to determine which individual repositories, or all
    /// repositories,
    /// are scanned.
    scan_type: ?ScanType = null,

    pub const json_field_names = .{
        .rules = "rules",
        .scan_type = "scanType",
    };
};

pub const PutRegistryScanningConfigurationOutput = struct {
    /// The scanning configuration for your registry.
    registry_scanning_configuration: ?RegistryScanningConfiguration = null,

    pub const json_field_names = .{
        .registry_scanning_configuration = "registryScanningConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRegistryScanningConfigurationInput, options: CallOptions) !PutRegistryScanningConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRegistryScanningConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.PutRegistryScanningConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRegistryScanningConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutRegistryScanningConfigurationOutput, body, allocator);
}
