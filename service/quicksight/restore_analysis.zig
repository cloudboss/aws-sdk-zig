const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RestoreAnalysisInput = struct {
    /// The ID of the analysis that you're restoring.
    analysis_id: []const u8,

    /// The ID of the Amazon Web Services account that contains the analysis.
    aws_account_id: []const u8,

    /// A boolean value that determines if the analysis will be restored to folders
    /// that it previously resided in. A `True` value restores analysis back to all
    /// folders that it previously resided in. A `False` value restores the analysis
    /// but does not restore the analysis back to all previously resided folders.
    /// Restoring a restricted analysis requires this parameter to be set to `True`.
    restore_to_folders: ?bool = null,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .aws_account_id = "AwsAccountId",
        .restore_to_folders = "RestoreToFolders",
    };
};

pub const RestoreAnalysisOutput = struct {
    /// The ID of the analysis that you're restoring.
    analysis_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the analysis that you're restoring.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// A list of folder arns thatthe analysis failed to be restored to.
    restoration_failed_folder_arns: ?[]const []const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .arn = "Arn",
        .request_id = "RequestId",
        .restoration_failed_folder_arns = "RestorationFailedFolderArns",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreAnalysisInput, options: CallOptions) !RestoreAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreAnalysisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/restore/analyses/");
    try path_buf.appendSlice(allocator, input.analysis_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.restore_to_folders) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "restore-to-folders=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreAnalysisOutput {
    var result: RestoreAnalysisOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RestoreAnalysisOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
