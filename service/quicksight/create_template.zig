const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplateVersionDefinition = @import("template_version_definition.zig").TemplateVersionDefinition;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;
const TemplateSourceEntity = @import("template_source_entity.zig").TemplateSourceEntity;
const Tag = @import("tag.zig").Tag;
const ValidationStrategy = @import("validation_strategy.zig").ValidationStrategy;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateTemplateInput = struct {
    /// The ID for the Amazon Web Services account that the group is in. You use the
    /// ID for the Amazon Web Services account that contains your Amazon Quick Sight
    /// account.
    aws_account_id: []const u8,

    /// The definition of a template.
    ///
    /// A definition is the data model of all features in a Dashboard, Template, or
    /// Analysis.
    ///
    /// Either a `SourceEntity` or a `Definition` must be provided in
    /// order for the request to be valid.
    definition: ?TemplateVersionDefinition = null,

    /// A display name for the template.
    name: ?[]const u8 = null,

    /// A list of resource permissions to be set on the template.
    permissions: ?[]const ResourcePermission = null,

    /// The entity that you are using as a source when you create the template. In
    /// `SourceEntity`, you specify the type of object you're using as source:
    /// `SourceTemplate` for a template or `SourceAnalysis` for an
    /// analysis. Both of these require an Amazon Resource Name (ARN). For
    /// `SourceTemplate`, specify the ARN of the source template. For
    /// `SourceAnalysis`, specify the ARN of the source analysis. The
    /// `SourceTemplate`
    /// ARN can contain any Amazon Web Services account and any Quick
    /// Sight-supported Amazon Web Services Region.
    ///
    /// Use the `DataSetReferences` entity within `SourceTemplate` or
    /// `SourceAnalysis` to list the replacement datasets for the placeholders
    /// listed
    /// in the original. The schema in each dataset must match its placeholder.
    ///
    /// Either a `SourceEntity` or a `Definition` must be provided in
    /// order for the request to be valid.
    source_entity: ?TemplateSourceEntity = null,

    /// Contains a map of the key-value pairs for the resource tag or tags assigned
    /// to the resource.
    tags: ?[]const Tag = null,

    /// An ID for the template that you want to create. This template is unique per
    /// Amazon Web Services Region; in
    /// each Amazon Web Services account.
    template_id: []const u8,

    /// TThe option to relax the validation needed to create a template with
    /// definition objects. This skips the validation step for specific errors.
    validation_strategy: ?ValidationStrategy = null,

    /// A description of the current template version being created. This API
    /// operation creates the
    /// first version of the template. Every time `UpdateTemplate` is called, a new
    /// version is created. Each version of the template maintains a description of
    /// the version
    /// in the `VersionDescription` field.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .definition = "Definition",
        .name = "Name",
        .permissions = "Permissions",
        .source_entity = "SourceEntity",
        .tags = "Tags",
        .template_id = "TemplateId",
        .validation_strategy = "ValidationStrategy",
        .version_description = "VersionDescription",
    };
};

pub const CreateTemplateOutput = struct {
    /// The ARN for the template.
    arn: ?[]const u8 = null,

    /// The template creation status.
    creation_status: ?ResourceStatus = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The ID of the template.
    template_id: ?[]const u8 = null,

    /// The ARN for the template, including the version information of
    /// the first version.
    version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_status = "CreationStatus",
        .request_id = "RequestId",
        .status = "Status",
        .template_id = "TemplateId",
        .version_arn = "VersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTemplateInput, options: CallOptions) !CreateTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/templates/");
    try path_buf.appendSlice(allocator, input.template_id);
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
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
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
    if (input.validation_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ValidationStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VersionDescription\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTemplateOutput {
    var result: CreateTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateTemplateOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
