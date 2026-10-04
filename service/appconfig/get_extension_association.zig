const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetExtensionAssociationInput = struct {
    /// The extension association ID to get.
    extension_association_id: []const u8,

    pub const json_field_names = .{
        .extension_association_id = "ExtensionAssociationId",
    };
};

pub const GetExtensionAssociationOutput = struct {
    /// The system-generated Amazon Resource Name (ARN) for the extension.
    arn: ?[]const u8 = null,

    /// The ARN of the extension defined in the association.
    extension_arn: ?[]const u8 = null,

    /// The version number for the extension defined in the association.
    extension_version_number: ?i32 = null,

    /// The system-generated ID for the association.
    id: ?[]const u8 = null,

    /// The parameter names and values defined in the association.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The ARNs of applications, configuration profiles, or environments defined in
    /// the
    /// association.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .extension_arn = "ExtensionArn",
        .extension_version_number = "ExtensionVersionNumber",
        .id = "Id",
        .parameters = "Parameters",
        .resource_arn = "ResourceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExtensionAssociationInput, options: CallOptions) !GetExtensionAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExtensionAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/extensionassociations/");
    try path_buf.appendSlice(allocator, input.extension_association_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExtensionAssociationOutput {
    var result: GetExtensionAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetExtensionAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
