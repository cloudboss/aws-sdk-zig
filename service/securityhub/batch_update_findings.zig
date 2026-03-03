const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AwsSecurityFindingIdentifier = @import("aws_security_finding_identifier.zig").AwsSecurityFindingIdentifier;
const NoteUpdate = @import("note_update.zig").NoteUpdate;
const RelatedFinding = @import("related_finding.zig").RelatedFinding;
const SeverityUpdate = @import("severity_update.zig").SeverityUpdate;
const VerificationState = @import("verification_state.zig").VerificationState;
const WorkflowUpdate = @import("workflow_update.zig").WorkflowUpdate;
const BatchUpdateFindingsUnprocessedFinding = @import("batch_update_findings_unprocessed_finding.zig").BatchUpdateFindingsUnprocessedFinding;

pub const BatchUpdateFindingsInput = struct {
    /// The updated value for the finding confidence. Confidence is defined as the
    /// likelihood
    /// that a finding accurately identifies the behavior or issue that it was
    /// intended to
    /// identify.
    ///
    /// Confidence is scored on a 0-100 basis using a ratio scale, where 0 means
    /// zero percent
    /// confidence and 100 means 100 percent confidence.
    confidence: ?i32 = null,

    /// The updated value for the level of importance assigned to the resources
    /// associated with
    /// the findings.
    ///
    /// A score of 0 means that the underlying resources have no criticality, and a
    /// score of 100
    /// is reserved for the most critical resources.
    criticality: ?i32 = null,

    /// The list of findings to update. `BatchUpdateFindings` can be used to update
    /// up to 100 findings at a time.
    ///
    /// For each finding, the list provides the finding identifier and the ARN of
    /// the finding
    /// provider.
    finding_identifiers: []const AwsSecurityFindingIdentifier,

    note: ?NoteUpdate = null,

    /// A list of findings that are related to the updated findings.
    related_findings: ?[]const RelatedFinding = null,

    /// Used to update the finding severity.
    severity: ?SeverityUpdate = null,

    /// One or more finding types in the format of namespace/category/classifier
    /// that classify a
    /// finding.
    ///
    /// Valid namespace values are as follows.
    ///
    /// * Software and Configuration Checks
    ///
    /// * TTPs
    ///
    /// * Effects
    ///
    /// * Unusual Behaviors
    ///
    /// * Sensitive Data Identifications
    types: ?[]const []const u8 = null,

    /// A list of name/value string pairs associated with the finding. These are
    /// custom,
    /// user-defined fields added to a finding.
    user_defined_fields: ?[]const aws.map.StringMapEntry = null,

    /// Indicates the veracity of a finding.
    ///
    /// The available values for `VerificationState` are as follows.
    ///
    /// * `UNKNOWN` – The default disposition of a security finding
    ///
    /// * `TRUE_POSITIVE` – The security finding is confirmed
    ///
    /// * `FALSE_POSITIVE` – The security finding was determined to be a false
    /// alarm
    ///
    /// * `BENIGN_POSITIVE` – A special case of `TRUE_POSITIVE` where
    /// the finding doesn't pose any threat, is expected, or both
    verification_state: ?VerificationState = null,

    /// Used to update the workflow status of a finding.
    ///
    /// The workflow status indicates the progress of the investigation into the
    /// finding.
    workflow: ?WorkflowUpdate = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .criticality = "Criticality",
        .finding_identifiers = "FindingIdentifiers",
        .note = "Note",
        .related_findings = "RelatedFindings",
        .severity = "Severity",
        .types = "Types",
        .user_defined_fields = "UserDefinedFields",
        .verification_state = "VerificationState",
        .workflow = "Workflow",
    };
};

pub const BatchUpdateFindingsOutput = struct {
    /// The list of findings that were updated successfully.
    processed_findings: ?[]const AwsSecurityFindingIdentifier = null,

    /// The list of findings that were not updated.
    unprocessed_findings: ?[]const BatchUpdateFindingsUnprocessedFinding = null,

    pub const json_field_names = .{
        .processed_findings = "ProcessedFindings",
        .unprocessed_findings = "UnprocessedFindings",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateFindingsInput, options: Options) !BatchUpdateFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "securityhub");

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/findings/batchupdate";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.confidence) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Confidence\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.criticality) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Criticality\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FindingIdentifiers\":");
    try aws.json.writeValue(@TypeOf(input.finding_identifiers), input.finding_identifiers, allocator, &body_buf);
    has_prev = true;
    if (input.note) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Note\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.related_findings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RelatedFindings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.severity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Severity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Types\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_defined_fields) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UserDefinedFields\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.verification_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VerificationState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workflow) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Workflow\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateFindingsOutput {
    var result: BatchUpdateFindingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchUpdateFindingsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidAccessException")) {
        return .{ .arena = arena, .kind = .{ .invalid_access_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
