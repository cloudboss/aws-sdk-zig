const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssetInput, options: CallOptions) !GetAssetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.revision) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "revision=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssetOutput {
    const result: GetAssetOutput = try aws.json.parseJsonObject(
        GetAssetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
