const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FormInput = @import("form_input.zig").FormInput;
const PredictionConfiguration = @import("prediction_configuration.zig").PredictionConfiguration;
const FormOutput = @import("form_output.zig").FormOutput;
const TimeSeriesDataPointSummaryFormOutput = @import("time_series_data_point_summary_form_output.zig").TimeSeriesDataPointSummaryFormOutput;
const AssetListingDetails = @import("asset_listing_details.zig").AssetListingDetails;

pub const CreateAssetInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// Asset description.
    description: ?[]const u8 = null,

    /// Amazon DataZone domain where the asset is created.
    domain_identifier: []const u8,

    /// The external identifier of the asset.
    ///
    /// If the value for the `externalIdentifier` parameter is specified, it must be
    /// a unique value.
    external_identifier: ?[]const u8 = null,

    /// Metadata forms attached to the asset.
    forms_input: ?[]const FormInput = null,

    /// Glossary terms attached to the asset.
    glossary_terms: ?[]const []const u8 = null,

    /// Asset name.
    name: []const u8,

    /// The unique identifier of the project that owns this asset.
    owning_project_identifier: []const u8,

    /// The configuration of the automatically generated business-friendly metadata
    /// for the asset.
    prediction_configuration: ?PredictionConfiguration = null,

    /// The unique identifier of this asset's type.
    type_identifier: []const u8,

    /// The revision of this asset's type.
    type_revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .external_identifier = "externalIdentifier",
        .forms_input = "formsInput",
        .glossary_terms = "glossaryTerms",
        .name = "name",
        .owning_project_identifier = "owningProjectIdentifier",
        .prediction_configuration = "predictionConfiguration",
        .type_identifier = "typeIdentifier",
        .type_revision = "typeRevision",
    };
};

pub const CreateAssetOutput = struct {
    /// The timestamp of when the asset was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user that created this asset in the catalog.
    created_by: ?[]const u8 = null,

    /// The description of the created asset.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the asset was created.
    domain_id: []const u8,

    /// The external identifier of the asset.
    external_identifier: ?[]const u8 = null,

    /// The timestamp of when the first revision of the asset took place.
    first_revision_created_at: ?i64 = null,

    /// The Amazon DataZone user that made the first revision of the asset.
    first_revision_created_by: ?[]const u8 = null,

    /// The metadata forms that are attached to the created asset.
    forms_output: ?[]const FormOutput = null,

    /// The glossary terms that are attached to the created asset.
    glossary_terms: ?[]const []const u8 = null,

    /// The glossary terms in a restricted glossary.
    governed_glossary_terms: ?[]const []const u8 = null,

    /// The unique identifier of the created asset.
    id: []const u8,

    /// The latest data point that was imported into the time series form for the
    /// asset.
    latest_time_series_data_point_forms_output: ?[]const TimeSeriesDataPointSummaryFormOutput = null,

    /// The details of an asset published in an Amazon DataZone catalog.
    listing: ?AssetListingDetails = null,

    /// The name of the created asset.
    name: []const u8,

    /// The ID of the Amazon DataZone project that owns the created asset.
    owning_project_id: []const u8,

    /// The configuration of the automatically generated business-friendly metadata
    /// for the asset.
    prediction_configuration: ?PredictionConfiguration = null,

    /// The read-only metadata forms that are attached to the created asset.
    read_only_forms_output: ?[]const FormOutput = null,

    /// The revision of the asset.
    revision: []const u8,

    /// The identifier of the created asset type.
    type_identifier: []const u8,

    /// The revision type of the asset.
    type_revision: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .external_identifier = "externalIdentifier",
        .first_revision_created_at = "firstRevisionCreatedAt",
        .first_revision_created_by = "firstRevisionCreatedBy",
        .forms_output = "formsOutput",
        .glossary_terms = "glossaryTerms",
        .governed_glossary_terms = "governedGlossaryTerms",
        .id = "id",
        .latest_time_series_data_point_forms_output = "latestTimeSeriesDataPointFormsOutput",
        .listing = "listing",
        .name = "name",
        .owning_project_id = "owningProjectId",
        .prediction_configuration = "predictionConfiguration",
        .read_only_forms_output = "readOnlyFormsOutput",
        .revision = "revision",
        .type_identifier = "typeIdentifier",
        .type_revision = "typeRevision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssetInput, options: CallOptions) !CreateAssetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datazone");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/assets");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.external_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"externalIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.forms_input) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"formsInput\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.glossary_terms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"glossaryTerms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"owningProjectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.owning_project_identifier), input.owning_project_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.prediction_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"predictionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"typeIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.type_identifier), input.type_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.type_revision) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"typeRevision\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssetOutput {
    var result: CreateAssetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAssetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
