const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainObjectTypeField = @import("domain_object_type_field.zig").DomainObjectTypeField;

pub const GetDomainObjectTypeInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The unique name of the domain object type.
    object_type_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .object_type_name = "ObjectTypeName",
    };
};

pub const GetDomainObjectTypeOutput = struct {
    /// The timestamp of when the domain object type was created.
    created_at: ?i64 = null,

    /// The description of the domain object type.
    description: ?[]const u8 = null,

    /// The customer provided KMS key used to encrypt this type of domain object.
    encryption_key: ?[]const u8 = null,

    /// A map of field names to their corresponding domain object type field
    /// definitions.
    fields: ?[]const aws.map.MapEntry(DomainObjectTypeField) = null,

    /// The timestamp of when the domain object type was most recently edited.
    last_updated_at: ?i64 = null,

    /// The unique name of the domain object type.
    object_type_name: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .encryption_key = "EncryptionKey",
        .fields = "Fields",
        .last_updated_at = "LastUpdatedAt",
        .object_type_name = "ObjectTypeName",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainObjectTypeInput, options: CallOptions) !GetDomainObjectTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainObjectTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/domain-object-types/");
    try path_buf.appendSlice(allocator, input.object_type_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainObjectTypeOutput {
    var result: GetDomainObjectTypeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDomainObjectTypeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
