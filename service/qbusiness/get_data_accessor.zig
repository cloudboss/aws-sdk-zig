const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionConfiguration = @import("action_configuration.zig").ActionConfiguration;
const DataAccessorAuthenticationDetail = @import("data_accessor_authentication_detail.zig").DataAccessorAuthenticationDetail;

pub const GetDataAccessorInput = struct {
    /// The unique identifier of the Amazon Q Business application.
    application_id: []const u8,

    /// The unique identifier of the data accessor to retrieve.
    data_accessor_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_accessor_id = "dataAccessorId",
    };
};

pub const GetDataAccessorOutput = struct {
    /// The list of action configurations specifying the allowed actions and any
    /// associated filters.
    action_configurations: ?[]const ActionConfiguration = null,

    /// The unique identifier of the Amazon Q Business application associated with
    /// this data accessor.
    application_id: ?[]const u8 = null,

    /// The authentication configuration details for the data accessor. This
    /// specifies how the ISV authenticates when accessing data through this data
    /// accessor.
    authentication_detail: ?DataAccessorAuthenticationDetail = null,

    /// The timestamp when the data accessor was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the data accessor.
    data_accessor_arn: ?[]const u8 = null,

    /// The unique identifier of the data accessor.
    data_accessor_id: ?[]const u8 = null,

    /// The friendly name of the data accessor.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center application
    /// associated with this data accessor.
    idc_application_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role for the ISV associated with
    /// this data accessor.
    principal: ?[]const u8 = null,

    /// The timestamp when the data accessor was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .action_configurations = "actionConfigurations",
        .application_id = "applicationId",
        .authentication_detail = "authenticationDetail",
        .created_at = "createdAt",
        .data_accessor_arn = "dataAccessorArn",
        .data_accessor_id = "dataAccessorId",
        .display_name = "displayName",
        .idc_application_arn = "idcApplicationArn",
        .principal = "principal",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataAccessorInput, options: CallOptions) !GetDataAccessorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataAccessorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/dataaccessors/");
    try path_buf.appendSlice(allocator, input.data_accessor_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataAccessorOutput {
    const result: GetDataAccessorOutput = try aws.json.parseJsonObject(
        GetDataAccessorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
