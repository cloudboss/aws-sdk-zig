const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FormOutput = @import("form_output.zig").FormOutput;
const TimeSeriesDataPointSummaryFormOutput = @import("time_series_data_point_summary_form_output.zig").TimeSeriesDataPointSummaryFormOutput;
const AssetListingDetails = @import("asset_listing_details.zig").AssetListingDetails;

pub const GetAssetInput = struct {
    /// The ID of the Amazon DataZone domain to which the asset belongs.
    domain_identifier: []const u8,

    /// The ID of the Amazon DataZone asset.
    ///
    /// This parameter supports either the value of `assetId` or
    /// `externalIdentifier` as input. If you are passing the value of
    /// `externalIdentifier`, you must prefix this value with
    /// `externalIdentifer%2F`.
    identifier: []const u8,

    /// The revision of the Amazon DataZone asset.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .revision = "revision",
    };
};

pub const GetAssetOutput = struct {
    /// The timestamp of when the asset was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the asset.
    created_by: ?[]const u8 = null,

    /// The description of the Amazon DataZone asset.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain to which the asset belongs.
    domain_id: []const u8,

    /// The external ID of the asset.
    external_identifier: ?[]const u8 = null,

    /// The timestamp of when the first revision of the asset was created.
    first_revision_created_at: ?i64 = null,

    /// The Amazon DataZone user who created the first revision of the asset.
    first_revision_created_by: ?[]const u8 = null,

    /// The metadata forms attached to the asset.
    forms_output: ?[]const FormOutput = null,

    /// The business glossary terms attached to the asset.
    glossary_terms: ?[]const []const u8 = null,

    /// The restricted glossary terms attached to an asset.
    governed_glossary_terms: ?[]const []const u8 = null,

    /// The ID of the asset.
    id: []const u8,

    /// The latest data point that was imported into the time series form for the
    /// asset.
    latest_time_series_data_point_forms_output: ?[]const TimeSeriesDataPointSummaryFormOutput = null,

    /// The listing of the asset.
    listing: ?AssetListingDetails = null,

    /// The name of the asset.
    name: []const u8,

    /// The ID of the project that owns the asset.
    owning_project_id: []const u8,

    /// The read-only metadata forms attached to the asset.
    read_only_forms_output: ?[]const FormOutput = null,

    /// The revision of the asset.
    revision: []const u8,

    /// The ID of the asset type.
    type_identifier: []const u8,

    /// The revision of the asset type.
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
        .read_only_forms_output = "readOnlyFormsOutput",
        .revision = "revision",
        .type_identifier = "typeIdentifier",
        .type_revision = "typeRevision",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssetInput, options: Options) !GetAssetOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/domains/");
    try path_buf.appendSlice(alloc, input.domain_identifier);
    try path_buf.appendSlice(alloc, "/assets/");
    try path_buf.appendSlice(alloc, input.identifier);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.revision) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "revision=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetAssetOutput {
    var result: GetAssetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAssetOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
