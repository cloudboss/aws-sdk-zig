const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CACertificateDescription = @import("ca_certificate_description.zig").CACertificateDescription;
const RegistrationConfig = @import("registration_config.zig").RegistrationConfig;

pub const DescribeCACertificateInput = struct {
    /// The CA certificate identifier.
    certificate_id: []const u8,

    pub const json_field_names = .{
        .certificate_id = "certificateId",
    };
};

pub const DescribeCACertificateOutput = struct {
    /// The CA certificate description.
    certificate_description: ?CACertificateDescription = null,

    /// Information about the registration configuration.
    registration_config: ?RegistrationConfig = null,

    pub const json_field_names = .{
        .certificate_description = "certificateDescription",
        .registration_config = "registrationConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCACertificateInput, options: CallOptions) !DescribeCACertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCACertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/cacertificate/");
    try path_buf.appendSlice(allocator, input.certificate_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCACertificateOutput {
    const result: DescribeCACertificateOutput = try aws.json.parseJsonObject(
        DescribeCACertificateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
