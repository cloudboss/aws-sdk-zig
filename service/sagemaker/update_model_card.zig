const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;

pub const UpdateModelCardInput = struct {
    /// The updated model card content. Content must be in [model card JSON
    /// schema](https://docs.aws.amazon.com/sagemaker/latest/dg/model-cards.html#model-cards-json-schema) and provided as a string.
    ///
    /// When updating model card content, be sure to include the full content and
    /// not just updated content.
    content: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) of the model card to update.
    model_card_name: []const u8,

    /// The approval status of the model card within your organization. Different
    /// organizations might have different criteria for model card review and
    /// approval.
    ///
    /// * `Draft`: The model card is a work in progress.
    /// * `PendingReview`: The model card is pending review.
    /// * `Approved`: The model card is approved.
    /// * `Archived`: The model card is archived. No more updates should be made to
    ///   the model card, but it can still be exported.
    model_card_status: ?ModelCardStatus = null,

    pub const json_field_names = .{
        .content = "Content",
        .model_card_name = "ModelCardName",
        .model_card_status = "ModelCardStatus",
    };
};

pub const UpdateModelCardOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated model card.
    model_card_arn: []const u8,

    pub const json_field_names = .{
        .model_card_arn = "ModelCardArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateModelCardInput, options: CallOptions) !UpdateModelCardOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateModelCardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateModelCard");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateModelCardOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateModelCardOutput, body, allocator);
}
