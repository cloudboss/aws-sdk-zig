const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageDetailsForAssociation = @import("package_details_for_association.zig").PackageDetailsForAssociation;
const DomainPackageDetails = @import("domain_package_details.zig").DomainPackageDetails;

pub const AssociatePackagesInput = struct {
    domain_name: []const u8,

    /// A list of packages and their prerequisites to be associated with a domain.
    package_list: []const PackageDetailsForAssociation,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .package_list = "PackageList",
    };
};

pub const AssociatePackagesOutput = struct {
    /// List of information about packages that are associated with a domain.
    domain_package_details_list: ?[]const DomainPackageDetails = null,

    pub const json_field_names = .{
        .domain_package_details_list = "DomainPackageDetailsList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociatePackagesInput, options: CallOptions) !AssociatePackagesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociatePackagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/packages/associateMultiple";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DomainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PackageList\":");
    try aws.json.writeValue(@TypeOf(input.package_list), input.package_list, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociatePackagesOutput {
    var result: AssociatePackagesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociatePackagesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
