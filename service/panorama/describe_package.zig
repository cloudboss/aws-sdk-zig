const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StorageLocation = @import("storage_location.zig").StorageLocation;

pub const DescribePackageInput = struct {
    /// The package's ID.
    package_id: []const u8,

    pub const json_field_names = .{
        .package_id = "PackageId",
    };
};

pub const DescribePackageOutput = struct {
    /// The package's ARN.
    arn: []const u8,

    /// When the package was created.
    created_time: i64,

    /// The package's ID.
    package_id: []const u8,

    /// The package's name.
    package_name: []const u8,

    /// ARNs of accounts that have read access to the package.
    read_access_principal_arns: ?[]const []const u8 = null,

    /// The package's storage location.
    storage_location: ?StorageLocation = null,

    /// The package's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// ARNs of accounts that have write access to the package.
    write_access_principal_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .package_id = "PackageId",
        .package_name = "PackageName",
        .read_access_principal_arns = "ReadAccessPrincipalArns",
        .storage_location = "StorageLocation",
        .tags = "Tags",
        .write_access_principal_arns = "WriteAccessPrincipalArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePackageInput, options: CallOptions) !DescribePackageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/metadata/");
    try path_buf.appendSlice(allocator, input.package_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePackageOutput {
    var result: DescribePackageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribePackageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
