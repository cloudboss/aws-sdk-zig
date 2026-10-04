const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const PackageGroupDescription = @import("package_group_description.zig").PackageGroupDescription;

pub const CreatePackageGroupInput = struct {
    /// The contact information for the created package group.
    contact_info: ?[]const u8 = null,

    /// A description of the package group.
    description: ?[]const u8 = null,

    /// The name of the domain in which you want to create a package group.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The pattern of the package group to create. The pattern is also the
    /// identifier of the package group.
    package_group: []const u8,

    /// One or more tag key-value pairs for the package group.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .contact_info = "contactInfo",
        .description = "description",
        .domain = "domain",
        .domain_owner = "domainOwner",
        .package_group = "packageGroup",
        .tags = "tags",
    };
};

pub const CreatePackageGroupOutput = struct {
    /// Information about the created package group after processing the request.
    package_group: ?PackageGroupDescription = null,

    pub const json_field_names = .{
        .package_group = "packageGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePackageGroupInput, options: CallOptions) !CreatePackageGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeartifact", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePackageGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/package-group";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "domain=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.domain);
    query_has_prev = true;
    if (input.domain_owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domain-owner=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.contact_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contactInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"packageGroup\":");
    try aws.json.writeValue(@TypeOf(input.package_group), input.package_group, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePackageGroupOutput {
    var result: CreatePackageGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePackageGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
