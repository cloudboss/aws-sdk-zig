const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisType = @import("analysis_type.zig").AnalysisType;
const ResourceId = @import("resource_id.zig").ResourceId;
const ScanType = @import("scan_type.zig").ScanType;
const ScanState = @import("scan_state.zig").ScanState;

pub const CreateScanInput = struct {
    /// The type of analysis you want CodeGuru Security to perform in the scan,
    /// either `Security` or `All`. The `Security` type only generates findings
    /// related to security. The `All` type generates both security findings and
    /// quality findings. Defaults to `Security` type if missing.
    analysis_type: ?AnalysisType = null,

    /// The idempotency token for the request. Amazon CodeGuru Security uses this
    /// value to prevent the accidental creation of duplicate scans if there are
    /// failures and retries.
    client_token: ?[]const u8 = null,

    /// The identifier for the resource object to be scanned.
    resource_id: ResourceId,

    /// The unique name that CodeGuru Security uses to track revisions across
    /// multiple scans of the same resource. Only allowed for a `STANDARD` scan
    /// type.
    scan_name: []const u8,

    /// The type of scan, either `Standard` or `Express`. Defaults to `Standard`
    /// type if missing.
    ///
    /// `Express` scans run on limited resources and use a limited set of detectors
    /// to analyze your code in near-real time. `Standard` scans have standard
    /// resource limits and use the full set of detectors to analyze your code.
    scan_type: ?ScanType = null,

    /// An array of key-value pairs used to tag a scan. A tag is a custom attribute
    /// label with two parts:
    ///
    /// * A tag key. For example, `CostCenter`, `Environment`, or `Secret`. Tag keys
    ///   are case sensitive.
    /// * An optional tag value field. For example, `111122223333`, `Production`, or
    ///   a team name. Omitting the tag value is the same as using an empty string.
    ///   Tag values are case sensitive.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .analysis_type = "analysisType",
        .client_token = "clientToken",
        .resource_id = "resourceId",
        .scan_name = "scanName",
        .scan_type = "scanType",
        .tags = "tags",
    };
};

pub const CreateScanOutput = struct {
    /// The identifier for the resource object that contains resources that were
    /// scanned.
    resource_id: ?ResourceId = null,

    /// UUID that identifies the individual scan run.
    run_id: []const u8,

    /// The name of the scan.
    scan_name: []const u8,

    /// The ARN for the scan name.
    scan_name_arn: ?[]const u8 = null,

    /// The current state of the scan. Returns either `InProgress`, `Successful`, or
    /// `Failed`.
    scan_state: ScanState,

    pub const json_field_names = .{
        .resource_id = "resourceId",
        .run_id = "runId",
        .scan_name = "scanName",
        .scan_name_arn = "scanNameArn",
        .scan_state = "scanState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScanInput, options: CallOptions) !CreateScanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-security", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-security", "CodeGuru Security", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/scans";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.analysis_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"analysisType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceId\":");
    try aws.json.writeValue(@TypeOf(input.resource_id), input.resource_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scanName\":");
    try aws.json.writeValue(@TypeOf(input.scan_name), input.scan_name, allocator, &body_buf);
    has_prev = true;
    if (input.scan_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scanType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScanOutput {
    var result: CreateScanOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateScanOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
