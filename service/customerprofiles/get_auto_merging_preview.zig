const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConflictResolution = @import("conflict_resolution.zig").ConflictResolution;
const Consolidation = @import("consolidation.zig").Consolidation;

pub const GetAutoMergingPreviewInput = struct {
    /// How the auto-merging process should resolve conflicts between different
    /// profiles.
    conflict_resolution: ConflictResolution,

    /// A list of matching attributes that represent matching criteria.
    consolidation: Consolidation,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// Minimum confidence score required for profiles within a matching group to be
    /// merged
    /// during the auto-merge process.
    min_allowed_confidence_score_for_merging: ?f64 = null,

    pub const json_field_names = .{
        .conflict_resolution = "ConflictResolution",
        .consolidation = "Consolidation",
        .domain_name = "DomainName",
        .min_allowed_confidence_score_for_merging = "MinAllowedConfidenceScoreForMerging",
    };
};

pub const GetAutoMergingPreviewOutput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The number of match groups in the domain that have been reviewed in this
    /// preview dry
    /// run.
    number_of_matches_in_sample: ?i64 = null,

    /// The number of profiles found in this preview dry run.
    number_of_profiles_in_sample: ?i64 = null,

    /// The number of profiles that would be merged if this wasn't a preview dry
    /// run.
    number_of_profiles_will_be_merged: ?i64 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .number_of_matches_in_sample = "NumberOfMatchesInSample",
        .number_of_profiles_in_sample = "NumberOfProfilesInSample",
        .number_of_profiles_will_be_merged = "NumberOfProfilesWillBeMerged",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutoMergingPreviewInput, options: CallOptions) !GetAutoMergingPreviewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutoMergingPreviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/identity-resolution-jobs/auto-merging-preview");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConflictResolution\":");
    try aws.json.writeValue(@TypeOf(input.conflict_resolution), input.conflict_resolution, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Consolidation\":");
    try aws.json.writeValue(@TypeOf(input.consolidation), input.consolidation, allocator, &body_buf);
    has_prev = true;
    if (input.min_allowed_confidence_score_for_merging) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MinAllowedConfidenceScoreForMerging\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutoMergingPreviewOutput {
    const result: GetAutoMergingPreviewOutput = try aws.json.parseJsonObject(
        GetAutoMergingPreviewOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
