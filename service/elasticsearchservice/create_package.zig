const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageSource = @import("package_source.zig").PackageSource;
const PackageType = @import("package_type.zig").PackageType;
const PackageDetails = @import("package_details.zig").PackageDetails;

pub const CreatePackageInput = struct {
    /// Description of the package.
    package_description: ?[]const u8 = null,

    /// Unique identifier for the package.
    package_name: []const u8,

    /// The customer S3 location `PackageSource` for importing the package.
    package_source: PackageSource,

    /// Type of package. Currently supports only TXT-DICTIONARY.
    package_type: PackageType,

    pub const json_field_names = .{
        .package_description = "PackageDescription",
        .package_name = "PackageName",
        .package_source = "PackageSource",
        .package_type = "PackageType",
    };
};

pub const CreatePackageOutput = struct {
    /// Information about the package `PackageDetails`.
    package_details: ?PackageDetails = null,

    pub const json_field_names = .{
        .package_details = "PackageDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePackageInput, options: CallOptions) !CreatePackageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/packages";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.package_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PackageDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PackageName\":");
    try aws.json.writeValue(@TypeOf(input.package_name), input.package_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PackageSource\":");
    try aws.json.writeValue(@TypeOf(input.package_source), input.package_source, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PackageType\":");
    try aws.json.writeValue(@TypeOf(input.package_type), input.package_type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePackageOutput {
    var result: CreatePackageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePackageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
