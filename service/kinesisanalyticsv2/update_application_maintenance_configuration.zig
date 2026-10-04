const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationMaintenanceConfigurationUpdate = @import("application_maintenance_configuration_update.zig").ApplicationMaintenanceConfigurationUpdate;
const ApplicationMaintenanceConfigurationDescription = @import("application_maintenance_configuration_description.zig").ApplicationMaintenanceConfigurationDescription;

pub const UpdateApplicationMaintenanceConfigurationInput = struct {
    /// Describes the application maintenance configuration update.
    application_maintenance_configuration_update: ApplicationMaintenanceConfigurationUpdate,

    /// The name of the application for which you want to update the maintenance
    /// configuration.
    application_name: []const u8,

    pub const json_field_names = .{
        .application_maintenance_configuration_update = "ApplicationMaintenanceConfigurationUpdate",
        .application_name = "ApplicationName",
    };
};

pub const UpdateApplicationMaintenanceConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_arn: ?[]const u8 = null,

    /// The application maintenance configuration description after the update.
    application_maintenance_configuration_description: ?ApplicationMaintenanceConfigurationDescription = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_maintenance_configuration_description = "ApplicationMaintenanceConfigurationDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationMaintenanceConfigurationInput, options: CallOptions) !UpdateApplicationMaintenanceConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisanalytics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationMaintenanceConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.UpdateApplicationMaintenanceConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationMaintenanceConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateApplicationMaintenanceConfigurationOutput, body, allocator);
}
