const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OcsfFindingIdentifier = @import("ocsf_finding_identifier.zig").OcsfFindingIdentifier;
const BatchUpdateFindingsV2ProcessedFinding = @import("batch_update_findings_v2_processed_finding.zig").BatchUpdateFindingsV2ProcessedFinding;
const BatchUpdateFindingsV2UnprocessedFinding = @import("batch_update_findings_v2_unprocessed_finding.zig").BatchUpdateFindingsV2UnprocessedFinding;

pub const BatchUpdateFindingsV2Input = struct {
    /// The updated value for a user provided comment about the finding.
    /// Minimum character length 1.
    /// Maximum character length 512.
    comment: ?[]const u8 = null,

    /// Provides information to identify a specific V2 finding.
    finding_identifiers: ?[]const OcsfFindingIdentifier = null,

    /// The list of finding `metadata.uid` to indicate findings to update.
    /// Finding `metadata.uid` is a globally unique identifier associated with the
    /// finding.
    /// Customers cannot use `MetadataUids` together with `FindingIdentifiers`.
    metadata_uids: ?[]const []const u8 = null,

    /// The updated value for the normalized severity identifier.
    /// The severity ID is an integer with the allowed enum values [0, 1, 2, 3, 4,
    /// 5, 6, 99].
    /// When customer provides the updated severity ID, the string sibling severity
    /// will automatically be updated in the finding.
    severity_id: ?i32 = null,

    /// The updated value for the normalized status identifier.
    /// The status ID is an integer with the allowed enum values [0, 1, 2, 3, 4, 5,
    /// 99].
    /// When customer provides the updated status ID, the string sibling status will
    /// automatically be updated in the finding.
    status_id: ?i32 = null,

    pub const json_field_names = .{
        .comment = "Comment",
        .finding_identifiers = "FindingIdentifiers",
        .metadata_uids = "MetadataUids",
        .severity_id = "SeverityId",
        .status_id = "StatusId",
    };
};

pub const BatchUpdateFindingsV2Output = struct {
    /// The list of findings that were updated successfully.
    processed_findings: ?[]const BatchUpdateFindingsV2ProcessedFinding = null,

    /// The list of V2 findings that were not updated.
    unprocessed_findings: ?[]const BatchUpdateFindingsV2UnprocessedFinding = null,

    pub const json_field_names = .{
        .processed_findings = "ProcessedFindings",
        .unprocessed_findings = "UnprocessedFindings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateFindingsV2Input, options: CallOptions) !BatchUpdateFindingsV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateFindingsV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/findingsv2/batchupdatev2";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.comment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Comment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.finding_identifiers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FindingIdentifiers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata_uids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MetadataUids\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.severity_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SeverityId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StatusId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateFindingsV2Output {
    const result: BatchUpdateFindingsV2Output = try aws.json.parseJsonObject(
        BatchUpdateFindingsV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
