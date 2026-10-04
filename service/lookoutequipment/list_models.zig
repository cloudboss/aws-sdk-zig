const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelStatus = @import("model_status.zig").ModelStatus;
const ModelSummary = @import("model_summary.zig").ModelSummary;

pub const ListModelsInput = struct {
    /// The beginning of the name of the dataset of the machine learning models to
    /// be listed.
    dataset_name_begins_with: ?[]const u8 = null,

    /// Specifies the maximum number of machine learning models to list.
    max_results: ?i32 = null,

    /// The beginning of the name of the machine learning models being listed.
    model_name_begins_with: ?[]const u8 = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// machine learning
    /// models.
    next_token: ?[]const u8 = null,

    /// The status of the machine learning model.
    status: ?ModelStatus = null,

    pub const json_field_names = .{
        .dataset_name_begins_with = "DatasetNameBeginsWith",
        .max_results = "MaxResults",
        .model_name_begins_with = "ModelNameBeginsWith",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListModelsOutput = struct {
    /// Provides information on the specified model, including created time, model
    /// and dataset
    /// ARNs, and status.
    model_summaries: ?[]const ModelSummary = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// machine learning
    /// models.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_summaries = "ModelSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelsInput, options: CallOptions) !ListModelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListModels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListModelsOutput, body, allocator);
}
