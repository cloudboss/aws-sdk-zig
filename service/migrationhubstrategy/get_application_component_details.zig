const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationComponentDetail = @import("application_component_detail.zig").ApplicationComponentDetail;
const AssociatedApplication = @import("associated_application.zig").AssociatedApplication;

pub const GetApplicationComponentDetailsInput = struct {
    /// The ID of the application component. The ID is unique within an AWS account.
    application_component_id: []const u8,

    pub const json_field_names = .{
        .application_component_id = "applicationComponentId",
    };
};

pub const GetApplicationComponentDetailsOutput = struct {
    /// Detailed information about an application component.
    application_component_detail: ?ApplicationComponentDetail = null,

    /// The associated application group as defined in AWS Application Discovery
    /// Service.
    associated_applications: ?[]const AssociatedApplication = null,

    /// A list of the IDs of the servers on which the application component is
    /// running.
    associated_server_ids: ?[]const []const u8 = null,

    /// Set to true if the application component belongs to more than one
    /// application group.
    more_application_resource: ?bool = null,

    pub const json_field_names = .{
        .application_component_detail = "applicationComponentDetail",
        .associated_applications = "associatedApplications",
        .associated_server_ids = "associatedServerIds",
        .more_application_resource = "moreApplicationResource",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationComponentDetailsInput, options: CallOptions) !GetApplicationComponentDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationComponentDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/get-applicationcomponent-details/");
    try path_buf.appendSlice(allocator, input.application_component_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationComponentDetailsOutput {
    var result: GetApplicationComponentDetailsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetApplicationComponentDetailsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
