const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetPackageInput = struct {
    /// The name of the target software package.
    package_name: []const u8,

    pub const json_field_names = .{
        .package_name = "packageName",
    };
};

pub const GetPackageOutput = struct {
    /// The date the package was created.
    creation_date: ?i64 = null,

    /// The name of the default package version.
    default_version_name: ?[]const u8 = null,

    /// The package description.
    description: ?[]const u8 = null,

    /// The date when the package was last updated.
    last_modified_date: ?i64 = null,

    /// The ARN for the package.
    package_arn: ?[]const u8 = null,

    /// The name of the software package.
    package_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .default_version_name = "defaultVersionName",
        .description = "description",
        .last_modified_date = "lastModifiedDate",
        .package_arn = "packageArn",
        .package_name = "packageName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPackageInput, options: CallOptions) !GetPackageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/");
    try path_buf.appendSlice(allocator, input.package_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPackageOutput {
    var result: GetPackageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPackageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
