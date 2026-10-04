const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisDefinition = @import("analysis_definition.zig").AnalysisDefinition;
const Parameters = @import("parameters.zig").Parameters;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;
const AnalysisSourceEntity = @import("analysis_source_entity.zig").AnalysisSourceEntity;
const Tag = @import("tag.zig").Tag;
const ValidationStrategy = @import("validation_strategy.zig").ValidationStrategy;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateAnalysisInput = struct {
    /// The ID for the analysis that you're creating. This ID displays in the URL of
    /// the
    /// analysis.
    analysis_id: []const u8,

    /// The ID of the Amazon Web Services account where you are creating an
    /// analysis.
    aws_account_id: []const u8,

    /// The definition of an analysis.
    ///
    /// A definition is the data model of all features in a Dashboard, Template, or
    /// Analysis.
    ///
    /// Either a `SourceEntity` or a `Definition` must be provided in
    /// order for the request to be valid.
    definition: ?AnalysisDefinition = null,

    /// When you create the analysis, Amazon Quick Sight adds the analysis to these
    /// folders.
    folder_arns: ?[]const []const u8 = null,

    /// A descriptive name for the analysis that you're creating. This name displays
    /// for the
    /// analysis in the Amazon Quick Sight console.
    name: []const u8,

    /// The parameter names and override values that you want to use. An analysis
    /// can have
    /// any parameter type, and some parameters might accept multiple values.
    parameters: ?Parameters = null,

    /// A structure that describes the principals and the resource-level permissions
    /// on an
    /// analysis. You can use the `Permissions` structure to grant permissions by
    /// providing a list of Identity and Access Management (IAM) action information
    /// for each
    /// principal listed by Amazon Resource Name (ARN).
    ///
    /// To specify no permissions, omit `Permissions`.
    permissions: ?[]const ResourcePermission = null,

    /// A source entity to use for the analysis that you're creating. This metadata
    /// structure
    /// contains details that describe a source template and one or more datasets.
    ///
    /// Either a `SourceEntity` or a `Definition` must be provided in
    /// order for the request to be valid.
    source_entity: ?AnalysisSourceEntity = null,

    /// Contains a map of the key-value pairs for the resource tag or tags assigned
    /// to the
    /// analysis.
    tags: ?[]const Tag = null,

    /// The ARN for the theme to apply to the analysis that you're creating. To see
    /// the theme
    /// in the Amazon Quick Sight console, make sure that you have access to it.
    theme_arn: ?[]const u8 = null,

    /// The option to relax the validation needed to create an analysis with
    /// definition objects. This skips the validation step for specific errors.
    validation_strategy: ?ValidationStrategy = null,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .aws_account_id = "AwsAccountId",
        .definition = "Definition",
        .folder_arns = "FolderArns",
        .name = "Name",
        .parameters = "Parameters",
        .permissions = "Permissions",
        .source_entity = "SourceEntity",
        .tags = "Tags",
        .theme_arn = "ThemeArn",
        .validation_strategy = "ValidationStrategy",
    };
};

pub const CreateAnalysisOutput = struct {
    /// The ID of the analysis.
    analysis_id: ?[]const u8 = null,

    /// The ARN for the analysis.
    arn: ?[]const u8 = null,

    /// The status of the creation of the analysis.
    creation_status: ?ResourceStatus = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .arn = "Arn",
        .creation_status = "CreationStatus",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAnalysisInput, options: CallOptions) !CreateAnalysisOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAnalysisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/analyses/");
    try path_buf.appendSlice(allocator, input.analysis_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.definition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Definition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.folder_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FolderArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Permissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_entity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceEntity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.theme_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ThemeArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.validation_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ValidationStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAnalysisOutput {
    var result: CreateAnalysisOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAnalysisOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
