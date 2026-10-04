const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluationFormAutoEvaluationConfiguration = @import("evaluation_form_auto_evaluation_configuration.zig").EvaluationFormAutoEvaluationConfiguration;
const EvaluationFormItem = @import("evaluation_form_item.zig").EvaluationFormItem;
const EvaluationFormLanguageConfiguration = @import("evaluation_form_language_configuration.zig").EvaluationFormLanguageConfiguration;
const EvaluationReviewConfiguration = @import("evaluation_review_configuration.zig").EvaluationReviewConfiguration;
const EvaluationFormScoringStrategy = @import("evaluation_form_scoring_strategy.zig").EvaluationFormScoringStrategy;
const EvaluationFormTargetConfiguration = @import("evaluation_form_target_configuration.zig").EvaluationFormTargetConfiguration;

pub const UpdateEvaluationFormInput = struct {
    /// A boolean flag indicating whether to update evaluation form to draft state.
    as_draft: ?bool = null,

    /// Whether automated evaluations are enabled.
    auto_evaluation_configuration: ?EvaluationFormAutoEvaluationConfiguration = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// A flag indicating whether the operation must create a new version.
    create_new_version: ?bool = null,

    /// The description of the evaluation form.
    description: ?[]const u8 = null,

    /// The unique identifier for the evaluation form.
    evaluation_form_id: []const u8,

    /// A version of the evaluation form to update.
    evaluation_form_version: ?i32 = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// Items that are part of the evaluation form. The total number of sections and
    /// questions must not exceed 100 each. Questions must be contained in a
    /// section.
    items: []const EvaluationFormItem,

    /// Configuration for language settings of the evaluation form.
    language_configuration: ?EvaluationFormLanguageConfiguration = null,

    /// Configuration for evaluation review settings of the evaluation form.
    review_configuration: ?EvaluationReviewConfiguration = null,

    /// A scoring strategy of the evaluation form.
    scoring_strategy: ?EvaluationFormScoringStrategy = null,

    /// Configuration that specifies the target for the evaluation form.
    target_configuration: ?EvaluationFormTargetConfiguration = null,

    /// A title of the evaluation form.
    title: []const u8,

    pub const json_field_names = .{
        .as_draft = "AsDraft",
        .auto_evaluation_configuration = "AutoEvaluationConfiguration",
        .client_token = "ClientToken",
        .create_new_version = "CreateNewVersion",
        .description = "Description",
        .evaluation_form_id = "EvaluationFormId",
        .evaluation_form_version = "EvaluationFormVersion",
        .instance_id = "InstanceId",
        .items = "Items",
        .language_configuration = "LanguageConfiguration",
        .review_configuration = "ReviewConfiguration",
        .scoring_strategy = "ScoringStrategy",
        .target_configuration = "TargetConfiguration",
        .title = "Title",
    };
};

pub const UpdateEvaluationFormOutput = struct {
    /// The Amazon Resource Name (ARN) for the contact evaluation resource.
    evaluation_form_arn: []const u8,

    /// The unique identifier for the evaluation form.
    evaluation_form_id: []const u8,

    /// The version of the updated evaluation form resource.
    evaluation_form_version: ?i32 = null,

    pub const json_field_names = .{
        .evaluation_form_arn = "EvaluationFormArn",
        .evaluation_form_id = "EvaluationFormId",
        .evaluation_form_version = "EvaluationFormVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEvaluationFormInput, options: CallOptions) !UpdateEvaluationFormOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEvaluationFormInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/evaluation-forms/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.evaluation_form_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.as_draft) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AsDraft\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_evaluation_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoEvaluationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.create_new_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CreateNewVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EvaluationFormVersion\":");
    try aws.json.writeValue(@TypeOf(input.evaluation_form_version), input.evaluation_form_version, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Items\":");
    try aws.json.writeValue(@TypeOf(input.items), input.items, allocator, &body_buf);
    has_prev = true;
    if (input.language_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LanguageConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.review_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReviewConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scoring_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ScoringStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Title\":");
    try aws.json.writeValue(@TypeOf(input.title), input.title, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEvaluationFormOutput {
    var result: UpdateEvaluationFormOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateEvaluationFormOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
