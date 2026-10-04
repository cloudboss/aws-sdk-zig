const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelVersionSourceType = @import("model_version_source_type.zig").ModelVersionSourceType;
const ModelVersionStatus = @import("model_version_status.zig").ModelVersionStatus;
const ModelVersionSummary = @import("model_version_summary.zig").ModelVersionSummary;

pub const ListModelVersionsInput = struct {
    /// Filter results to return all the model versions created before this time.
    created_at_end_time: ?i64 = null,

    /// Filter results to return all the model versions created after this time.
    created_at_start_time: ?i64 = null,

    /// Specifies the highest version of the model to return in the list.
    max_model_version: ?i64 = null,

    /// Specifies the maximum number of machine learning model versions to list.
    max_results: ?i32 = null,

    /// Specifies the lowest version of the model to return in the list.
    min_model_version: ?i64 = null,

    /// Then name of the machine learning model for which the model versions are to
    /// be
    /// listed.
    model_name: []const u8,

    /// If the total number of results exceeds the limit that the response can
    /// display, the
    /// response returns an opaque pagination token indicating where to continue the
    /// listing of
    /// machine learning model versions. Use this token in the `NextToken` field in
    /// the
    /// request to list the next page of results.
    next_token: ?[]const u8 = null,

    /// Filter the results based on the way the model version was generated.
    source_type: ?ModelVersionSourceType = null,

    /// Filter the results based on the current status of the model version.
    status: ?ModelVersionStatus = null,

    pub const json_field_names = .{
        .created_at_end_time = "CreatedAtEndTime",
        .created_at_start_time = "CreatedAtStartTime",
        .max_model_version = "MaxModelVersion",
        .max_results = "MaxResults",
        .min_model_version = "MinModelVersion",
        .model_name = "ModelName",
        .next_token = "NextToken",
        .source_type = "SourceType",
        .status = "Status",
    };
};

pub const ListModelVersionsOutput = struct {
    /// Provides information on the specified model version, including the created
    /// time, model
    /// and dataset ARNs, and status.
    ///
    /// If you don't supply the `ModelName` request parameter, or if you supply the
    /// name
    /// of a model that doesn't exist, `ListModelVersions` returns an empty array in
    /// `ModelVersionSummaries`.
    model_version_summaries: ?[]const ModelVersionSummary = null,

    /// If the total number of results exceeds the limit that the response can
    /// display, the
    /// response returns an opaque pagination token indicating where to continue the
    /// listing of
    /// machine learning model versions. Use this token in the `NextToken` field in
    /// the
    /// request to list the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_version_summaries = "ModelVersionSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelVersionsInput, options: CallOptions) !ListModelVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListModelVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListModelVersionsOutput, body, allocator);
}
