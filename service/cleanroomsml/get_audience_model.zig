const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AudienceModelStatus = @import("audience_model_status.zig").AudienceModelStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;

pub const GetAudienceModelInput = struct {
    /// The Amazon Resource Name (ARN) of the audience model that you are interested
    /// in.
    audience_model_arn: []const u8,

    pub const json_field_names = .{
        .audience_model_arn = "audienceModelArn",
    };
};

pub const GetAudienceModelOutput = struct {
    /// The Amazon Resource Name (ARN) of the audience model.
    audience_model_arn: []const u8,

    /// The time at which the audience model was created.
    create_time: i64,

    /// The description of the audience model.
    description: ?[]const u8 = null,

    /// The KMS key ARN used for the audience model.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the audience model.
    name: []const u8,

    /// The status of the audience model.
    status: AudienceModelStatus,

    /// Details about the status of the audience model.
    status_details: ?StatusDetails = null,

    /// The tags that are assigned to the audience model.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The end date specified for the training window.
    training_data_end_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the training dataset that was used for
    /// this audience model.
    training_dataset_arn: []const u8,

    /// The start date specified for the training window.
    training_data_start_time: ?i64 = null,

    /// The most recent time at which the audience model was updated.
    update_time: i64,

    pub const json_field_names = .{
        .audience_model_arn = "audienceModelArn",
        .create_time = "createTime",
        .description = "description",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .status = "status",
        .status_details = "statusDetails",
        .tags = "tags",
        .training_data_end_time = "trainingDataEndTime",
        .training_dataset_arn = "trainingDatasetArn",
        .training_data_start_time = "trainingDataStartTime",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAudienceModelInput, options: CallOptions) !GetAudienceModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms-ml", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAudienceModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/audience-model/");
    try path_buf.appendSlice(allocator, input.audience_model_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAudienceModelOutput {
    var result: GetAudienceModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAudienceModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
