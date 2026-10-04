const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TieringConfigurationInputForUpdate = @import("tiering_configuration_input_for_update.zig").TieringConfigurationInputForUpdate;

pub const UpdateTieringConfigurationInput = struct {
    /// Specifies the body of a tiering configuration.
    tiering_configuration: TieringConfigurationInputForUpdate,

    /// The name of a tiering configuration to update.
    tiering_configuration_name: []const u8,

    pub const json_field_names = .{
        .tiering_configuration = "TieringConfiguration",
        .tiering_configuration_name = "TieringConfigurationName",
    };
};

pub const UpdateTieringConfigurationOutput = struct {
    /// The date and time a tiering configuration was created, in Unix format
    /// and Coordinated Universal Time (UTC). The value of `CreationTime`
    /// is accurate to milliseconds. For example, the value 1516925490.087
    /// represents
    /// Friday, January 26, 2018 12:11:30.087AM.
    creation_time: ?i64 = null,

    /// The date and time a tiering configuration was updated, in Unix format
    /// and Coordinated Universal Time (UTC). The value of `LastUpdatedTime`
    /// is accurate to milliseconds. For example, the value 1516925490.087
    /// represents
    /// Friday, January 26, 2018 12:11:30.087AM.
    last_updated_time: ?i64 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies the updated
    /// tiering configuration.
    tiering_configuration_arn: ?[]const u8 = null,

    /// This unique string is the name of the tiering configuration.
    tiering_configuration_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_updated_time = "LastUpdatedTime",
        .tiering_configuration_arn = "TieringConfigurationArn",
        .tiering_configuration_name = "TieringConfigurationName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTieringConfigurationInput, options: CallOptions) !UpdateTieringConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTieringConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tiering-configurations/");
    try path_buf.appendSlice(allocator, input.tiering_configuration_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TieringConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.tiering_configuration), input.tiering_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTieringConfigurationOutput {
    var result: UpdateTieringConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateTieringConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
