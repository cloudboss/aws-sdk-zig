const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainPackageDetails = @import("domain_package_details.zig").DomainPackageDetails;

pub const DissociatePackageInput = struct {
    /// Name of the domain to dissociate the package from.
    domain_name: []const u8,

    /// Internal ID of the package to dissociate from the domain. Use
    /// `ListPackagesForDomain` to find this value.
    package_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .package_id = "PackageID",
    };
};

pub const DissociatePackageOutput = struct {
    /// Information about a package that has been dissociated from the domain.
    domain_package_details: ?DomainPackageDetails = null,

    pub const json_field_names = .{
        .domain_package_details = "DomainPackageDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DissociatePackageInput, options: CallOptions) !DissociatePackageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DissociatePackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/packages/dissociate/");
    try path_buf.appendSlice(allocator, input.package_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.domain_name);
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DissociatePackageOutput {
    var result: DissociatePackageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DissociatePackageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
