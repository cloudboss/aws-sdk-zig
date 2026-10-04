const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PointInTimeRecoverySpecification = @import("point_in_time_recovery_specification.zig").PointInTimeRecoverySpecification;
const ContinuousBackupsDescription = @import("continuous_backups_description.zig").ContinuousBackupsDescription;

pub const UpdateContinuousBackupsInput = struct {
    /// Represents the settings used to enable point in time recovery.
    point_in_time_recovery_specification: PointInTimeRecoverySpecification,

    /// The name of the table. You can also provide the Amazon Resource Name (ARN)
    /// of the table in this
    /// parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .point_in_time_recovery_specification = "PointInTimeRecoverySpecification",
        .table_name = "TableName",
    };
};

pub const UpdateContinuousBackupsOutput = struct {
    /// Represents the continuous backups and point in time recovery settings on the
    /// table.
    continuous_backups_description: ?ContinuousBackupsDescription = null,

    pub const json_field_names = .{
        .continuous_backups_description = "ContinuousBackupsDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContinuousBackupsInput, options: CallOptions) !UpdateContinuousBackupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContinuousBackupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.UpdateContinuousBackups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContinuousBackupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateContinuousBackupsOutput, body, allocator);
}
