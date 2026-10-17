const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportDestination = @import("export_destination.zig").ExportDestination;
const ExportOutput = @import("export_output.zig").ExportOutput;
const ExportScopes = @import("export_scopes.zig").ExportScopes;

pub const StartExportJobV2Input = struct {
    /// A unique identifier used to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The destination that Security Hub writes the export to. You must specify
    /// exactly one destination type. Currently, the only supported type is Amazon
    /// S3.
    destination: ExportDestination,

    /// An optional, user-provided name for the export job that helps you identify
    /// it in `ListExportJobsV2` results. The value can be 1–256 characters.
    /// Alphanumeric characters, spaces, and the following ASCII characters are
    /// permitted: `. _ , : ( ) / + -`.
    name: ?[]const u8 = null,

    /// Specifies what data to export and how to format it. You must specify exactly
    /// one output type. Currently, the only supported type is `Findings`.
    output_configuration: ExportOutput,

    /// Limits the export to findings from specific organizational units (OUs) or
    /// from the delegated administrator's organization. Only the delegated
    /// administrator account can use this parameter; other accounts that specify it
    /// receive an `AccessDeniedException`.
    ///
    /// This parameter is optional. If you omit it, the delegated administrator
    /// exports findings from all accounts across the entire organization, and other
    /// accounts export only their own findings.
    ///
    /// You can specify up to 10 entries in `Scopes.AwsOrganizations`. If you
    /// specify multiple entries, Security Hub combines them using OR logic.
    scopes: ?ExportScopes = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .destination = "Destination",
        .name = "Name",
        .output_configuration = "OutputConfiguration",
        .scopes = "Scopes",
    };
};

pub const StartExportJobV2Output = struct {
    /// The unique identifier of the export job that Security Hub started. Use this
    /// value with `GetExportJobV2` or `CancelExportJobV2`.
    export_job_id: []const u8,

    pub const json_field_names = .{
        .export_job_id = "ExportJobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartExportJobV2Input, options: CallOptions) !StartExportJobV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartExportJobV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/exportjobsv2";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, allocator, &body_buf);
    has_prev = true;
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.output_configuration), input.output_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.scopes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Scopes\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartExportJobV2Output {
    const result: StartExportJobV2Output = try aws.json.parseJsonObject(
        StartExportJobV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
