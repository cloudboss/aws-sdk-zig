const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncludedData = @import("included_data.zig").IncludedData;
const UserContext = @import("user_context.zig").UserContext;
const ModelCardProcessingStatus = @import("model_card_processing_status.zig").ModelCardProcessingStatus;
const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;
const ModelCardSecurityConfig = @import("model_card_security_config.zig").ModelCardSecurityConfig;

pub const DescribeModelCardInput = struct {
    /// Specifies the level of model card data to include in the response. Use this
    /// parameter to call `DescribeModelCard` without requiring `kms:Decrypt`
    /// permission on the customer-managed Amazon Web Services KMS key.
    ///
    /// * `AllData`: Returns the full model card `Content`. This option requires
    ///   `kms:Decrypt` permission on the customer-managed key, if one is associated
    ///   with the model card. This is the default.
    /// * `MetadataOnly`: Returns the model card with sanitized `Content` that
    ///   includes only a small set of unencrypted metadata fields. This option does
    ///   not require `kms:Decrypt` permission. For the list of fields preserved in
    ///   the response, see `Content`.
    ///
    /// If you don't specify a value, SageMaker returns `AllData`.
    included_data: ?IncludedData = null,

    /// The name or Amazon Resource Name (ARN) of the model card to describe.
    model_card_name: []const u8,

    /// The version of the model card to describe. If a version is not provided,
    /// then the latest version of the model card is described.
    model_card_version: ?i32 = null,

    pub const json_field_names = .{
        .included_data = "IncludedData",
        .model_card_name = "ModelCardName",
        .model_card_version = "ModelCardVersion",
    };
};

pub const DescribeModelCardOutput = struct {
    /// The content of the model card. Content is provided as a string in the [model
    /// card JSON
    /// schema](https://docs.aws.amazon.com/sagemaker/latest/dg/model-cards.html#model-cards-json-schema).
    ///
    /// When you set `IncludedData` to `MetadataOnly` in the request, SageMaker
    /// returns a sanitized version of `Content` that includes only the following
    /// JSON paths, when present in the model card:
    ///
    /// * `model_overview.model_id`
    /// * `model_overview.model_name`
    /// * `intended_uses.risk_rating`
    /// * `model_package_details.model_package_group_name`
    /// * `model_package_details.model_package_arn`
    ///
    /// All other fields are removed from `Content` when `IncludedData` is
    /// `MetadataOnly`, including model description, training details, evaluation
    /// details, business details, and additional information. To retrieve the
    /// complete `Content`, set `IncludedData` to `AllData` or omit the parameter.
    content: []const u8,

    created_by: ?UserContext = null,

    /// The date and time the model card was created.
    creation_time: i64,

    last_modified_by: ?UserContext = null,

    /// The date and time the model card was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the model card.
    model_card_arn: []const u8,

    /// The name of the model card.
    model_card_name: []const u8,

    /// The processing status of model card deletion. The
    /// `ModelCardProcessingStatus` updates throughout the different deletion steps.
    ///
    /// * `DeletePending`: Model card deletion request received.
    /// * `DeleteInProgress`: Model card deletion is in progress.
    /// * `ContentDeleted`: Deleted model card content.
    /// * `ExportJobsDeleted`: Deleted all export jobs associated with the model
    ///   card.
    /// * `DeleteCompleted`: Successfully deleted the model card.
    /// * `DeleteFailed`: The model card failed to delete.
    model_card_processing_status: ?ModelCardProcessingStatus = null,

    /// The approval status of the model card within your organization. Different
    /// organizations might have different criteria for model card review and
    /// approval.
    ///
    /// * `Draft`: The model card is a work in progress.
    /// * `PendingReview`: The model card is pending review.
    /// * `Approved`: The model card is approved.
    /// * `Archived`: The model card is archived. No more updates should be made to
    ///   the model card, but it can still be exported.
    model_card_status: ModelCardStatus,

    /// The version of the model card.
    model_card_version: i32,

    /// The security configuration used to protect model card content.
    security_config: ?ModelCardSecurityConfig = null,

    pub const json_field_names = .{
        .content = "Content",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .model_card_arn = "ModelCardArn",
        .model_card_name = "ModelCardName",
        .model_card_processing_status = "ModelCardProcessingStatus",
        .model_card_status = "ModelCardStatus",
        .model_card_version = "ModelCardVersion",
        .security_config = "SecurityConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeModelCardInput, options: CallOptions) !DescribeModelCardOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeModelCardInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeModelCard");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeModelCardOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeModelCardOutput, body, allocator);
}
