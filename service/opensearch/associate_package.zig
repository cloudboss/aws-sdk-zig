const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageAssociationConfiguration = @import("package_association_configuration.zig").PackageAssociationConfiguration;
const DomainPackageDetails = @import("domain_package_details.zig").DomainPackageDetails;

pub const AssociatePackageInput = struct {
    /// The configuration for associating a package with an Amazon OpenSearch
    /// Service
    /// domain.
    association_configuration: ?PackageAssociationConfiguration = null,

    /// Name of the domain to associate the package with.
    domain_name: []const u8,

    /// Internal ID of the package to associate with a domain. Use
    /// `DescribePackages` to find this value.
    package_id: []const u8,

    /// A list of package IDs that must be associated with the domain before the
    /// package
    /// specified in the request can be associated.
    prerequisite_package_id_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .association_configuration = "AssociationConfiguration",
        .domain_name = "DomainName",
        .package_id = "PackageID",
        .prerequisite_package_id_list = "PrerequisitePackageIDList",
    };
};

pub const AssociatePackageOutput = struct {
    /// Information about a package that is associated with a domain.
    domain_package_details: ?DomainPackageDetails = null,

    pub const json_field_names = .{
        .domain_package_details = "DomainPackageDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociatePackageInput, options: CallOptions) !AssociatePackageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociatePackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/packages/associate/");
    try path_buf.appendSlice(allocator, input.package_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.domain_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.association_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AssociationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prerequisite_package_id_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PrerequisitePackageIDList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociatePackageOutput {
    const result: AssociatePackageOutput = try aws.json.parseJsonObject(
        AssociatePackageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
