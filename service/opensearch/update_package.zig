const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageConfiguration = @import("package_configuration.zig").PackageConfiguration;
const PackageEncryptionOptions = @import("package_encryption_options.zig").PackageEncryptionOptions;
const PackageSource = @import("package_source.zig").PackageSource;
const PackageDetails = @import("package_details.zig").PackageDetails;

pub const UpdatePackageInput = struct {
    /// Commit message for the updated file, which is shown as part of
    /// `GetPackageVersionHistoryResponse`.
    commit_message: ?[]const u8 = null,

    /// The updated configuration details for a package.
    package_configuration: ?PackageConfiguration = null,

    /// A new description of the package.
    package_description: ?[]const u8 = null,

    /// Encryption options for a package.
    package_encryption_options: ?PackageEncryptionOptions = null,

    /// The unique identifier for the package.
    package_id: []const u8,

    /// Amazon S3 bucket and key for the package.
    package_source: PackageSource,

    pub const json_field_names = .{
        .commit_message = "CommitMessage",
        .package_configuration = "PackageConfiguration",
        .package_description = "PackageDescription",
        .package_encryption_options = "PackageEncryptionOptions",
        .package_id = "PackageID",
        .package_source = "PackageSource",
    };
};

pub const UpdatePackageOutput = struct {
    /// Information about a package.
    package_details: ?PackageDetails = null,

    pub const json_field_names = .{
        .package_details = "PackageDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePackageInput, options: CallOptions) !UpdatePackageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/packages/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.commit_message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CommitMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.package_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PackageConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.package_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PackageDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.package_encryption_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PackageEncryptionOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PackageID\":");
    try aws.json.writeValue(@TypeOf(input.package_id), input.package_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PackageSource\":");
    try aws.json.writeValue(@TypeOf(input.package_source), input.package_source, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePackageOutput {
    const result: UpdatePackageOutput = try aws.json.parseJsonObject(
        UpdatePackageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
