const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetEvidenceFileUploadUrlInput = struct {
    /// The file that you want to upload. For a list of supported file formats, see
    /// [Supported file types for manual
    /// evidence](https://docs.aws.amazon.com/audit-manager/latest/userguide/upload-evidence.html#supported-manual-evidence-files) in the *Audit Manager
    /// User Guide*.
    file_name: []const u8,

    pub const json_field_names = .{
        .file_name = "fileName",
    };
};

pub const GetEvidenceFileUploadUrlOutput = struct {
    /// The name of the uploaded manual evidence file that the presigned URL was
    /// generated
    /// for.
    evidence_file_name: ?[]const u8 = null,

    /// The presigned URL that was generated.
    upload_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .evidence_file_name = "evidenceFileName",
        .upload_url = "uploadUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEvidenceFileUploadUrlInput, options: CallOptions) !GetEvidenceFileUploadUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "auditmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEvidenceFileUploadUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/evidenceFileUploadUrl";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "fileName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.file_name);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEvidenceFileUploadUrlOutput {
    var result: GetEvidenceFileUploadUrlOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEvidenceFileUploadUrlOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
