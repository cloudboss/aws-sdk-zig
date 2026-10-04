const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Sbom = @import("sbom.zig").Sbom;
const SbomValidationStatus = @import("sbom_validation_status.zig").SbomValidationStatus;

pub const AssociateSbomWithPackageVersionInput = struct {
    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The name of the new software package.
    package_name: []const u8,

    sbom: Sbom,

    /// The name of the new package version.
    version_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .package_name = "packageName",
        .sbom = "sbom",
        .version_name = "versionName",
    };
};

pub const AssociateSbomWithPackageVersionOutput = struct {
    /// The name of the new software package.
    package_name: ?[]const u8 = null,

    sbom: ?Sbom = null,

    /// The status of the initial validation for the software bill of materials
    /// against the Software Package Data Exchange (SPDX) and CycloneDX industry
    /// standard formats.
    sbom_validation_status: ?SbomValidationStatus = null,

    /// The name of the new package version.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .package_name = "packageName",
        .sbom = "sbom",
        .sbom_validation_status = "sbomValidationStatus",
        .version_name = "versionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateSbomWithPackageVersionInput, options: CallOptions) !AssociateSbomWithPackageVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateSbomWithPackageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/");
    try path_buf.appendSlice(allocator, input.package_name);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version_name);
    try path_buf.appendSlice(allocator, "/sbom");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sbom\":");
    try aws.json.writeValue(@TypeOf(input.sbom), input.sbom, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateSbomWithPackageVersionOutput {
    const result: AssociateSbomWithPackageVersionOutput = try aws.json.parseJsonObject(
        AssociateSbomWithPackageVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
