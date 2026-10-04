const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Category = @import("category.zig").Category;
const SigningConfiguration = @import("signing_configuration.zig").SigningConfiguration;
const SigningImageFormat = @import("signing_image_format.zig").SigningImageFormat;

pub const GetSigningPlatformInput = struct {
    /// The ID of the target signing platform.
    platform_id: []const u8,

    pub const json_field_names = .{
        .platform_id = "platformId",
    };
};

pub const GetSigningPlatformOutput = struct {
    /// The category type of the target signing platform.
    category: ?Category = null,

    /// The display name of the target signing platform.
    display_name: ?[]const u8 = null,

    /// The maximum size (in MB) of the payload that can be signed by the target
    /// platform.
    max_size_in_mb: ?i32 = null,

    /// A list of partner entities that use the target signing platform.
    partner: ?[]const u8 = null,

    /// The ID of the target signing platform.
    platform_id: ?[]const u8 = null,

    /// A flag indicating whether signatures generated for the signing platform can
    /// be
    /// revoked.
    revocation_supported: ?bool = null,

    /// A list of configurations applied to the target platform at signing.
    signing_configuration: ?SigningConfiguration = null,

    /// The format of the target platform's signing image.
    signing_image_format: ?SigningImageFormat = null,

    /// The validation template that is used by the target signing platform.
    target: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "category",
        .display_name = "displayName",
        .max_size_in_mb = "maxSizeInMB",
        .partner = "partner",
        .platform_id = "platformId",
        .revocation_supported = "revocationSupported",
        .signing_configuration = "signingConfiguration",
        .signing_image_format = "signingImageFormat",
        .target = "target",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSigningPlatformInput, options: CallOptions) !GetSigningPlatformOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "signer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSigningPlatformInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/signing-platforms/");
    try path_buf.appendSlice(allocator, input.platform_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSigningPlatformOutput {
    const result: GetSigningPlatformOutput = try aws.json.parseJsonObject(
        GetSigningPlatformOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
