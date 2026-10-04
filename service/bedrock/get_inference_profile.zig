const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceProfileModel = @import("inference_profile_model.zig").InferenceProfileModel;
const InferenceProfileStatus = @import("inference_profile_status.zig").InferenceProfileStatus;
const InferenceProfileType = @import("inference_profile_type.zig").InferenceProfileType;

pub const GetInferenceProfileInput = struct {
    /// The ID or Amazon Resource Name (ARN) of the inference profile.
    inference_profile_identifier: []const u8,

    pub const json_field_names = .{
        .inference_profile_identifier = "inferenceProfileIdentifier",
    };
};

pub const GetInferenceProfileOutput = struct {
    /// The time at which the inference profile was created.
    created_at: ?i64 = null,

    /// The description of the inference profile.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the inference profile.
    inference_profile_arn: []const u8,

    /// The unique identifier of the inference profile.
    inference_profile_id: []const u8,

    /// The name of the inference profile.
    inference_profile_name: []const u8,

    /// A list of information about each model in the inference profile.
    models: ?[]const InferenceProfileModel = null,

    /// The status of the inference profile. `ACTIVE` means that the inference
    /// profile is ready to be used.
    status: InferenceProfileStatus,

    /// The type of the inference profile. The following types are possible:
    ///
    /// * `SYSTEM_DEFINED` – The inference profile is defined by Amazon Bedrock. You
    ///   can route inference requests across regions with these inference profiles.
    /// * `APPLICATION` – The inference profile was created by a user. This type of
    ///   inference profile can track metrics and costs when invoking the model in
    ///   it. The inference profile may route requests to one or multiple regions.
    @"type": InferenceProfileType,

    /// The time at which the inference profile was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .inference_profile_arn = "inferenceProfileArn",
        .inference_profile_id = "inferenceProfileId",
        .inference_profile_name = "inferenceProfileName",
        .models = "models",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInferenceProfileInput, options: CallOptions) !GetInferenceProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInferenceProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/inference-profiles/");
    try path_buf.appendSlice(allocator, input.inference_profile_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInferenceProfileOutput {
    var result: GetInferenceProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetInferenceProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
