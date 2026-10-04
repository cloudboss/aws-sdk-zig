const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningType = @import("provisioning_type.zig").ProvisioningType;
const ProvisioningProfileStatus = @import("provisioning_profile_status.zig").ProvisioningProfileStatus;

pub const GetProvisioningProfileInput = struct {
    /// The id of a provisioning profile.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetProvisioningProfileOutput = struct {
    /// The Amazon Resource Name (ARN) of the provisioning profile.
    arn: ?[]const u8 = null,

    /// The body of the PEM-encoded claim certificate.
    claim_certificate: ?[]const u8 = null,

    /// The provisioning profile id.
    id: ?[]const u8 = null,

    /// The name of the provisioning profile.
    name: ?[]const u8 = null,

    /// The type of provisioning workflow the device uses for onboarding to IoT
    /// managed integrations.
    provisioning_type: ?ProvisioningType = null,

    /// The status of a provisioning profile.
    status: ?ProvisioningProfileStatus = null,

    /// A set of key/value pairs that are used to manage the provisioning profile.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .claim_certificate = "ClaimCertificate",
        .id = "Id",
        .name = "Name",
        .provisioning_type = "ProvisioningType",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProvisioningProfileInput, options: CallOptions) !GetProvisioningProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProvisioningProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/provisioning-profiles/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProvisioningProfileOutput {
    const result: GetProvisioningProfileOutput = try aws.json.parseJsonObject(
        GetProvisioningProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
