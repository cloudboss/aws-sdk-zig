const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteAnalysisInput = struct {
    /// The ID of the analysis that you're deleting.
    analysis_id: []const u8,

    /// The ID of the Amazon Web Services account where you want to delete an
    /// analysis.
    aws_account_id: []const u8,

    /// This option defaults to the value `NoForceDeleteWithoutRecovery`. To
    /// immediately delete the analysis, add the `ForceDeleteWithoutRecovery`
    /// option.
    /// You can't restore an analysis after it's deleted.
    force_delete_without_recovery: ?bool = null,

    /// A value that specifies the number of days that Amazon Quick Sight waits
    /// before it deletes the
    /// analysis. You can't use this parameter with the `ForceDeleteWithoutRecovery`
    /// option in the same API call. The default value is 30.
    recovery_window_in_days: ?i64 = null,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .aws_account_id = "AwsAccountId",
        .force_delete_without_recovery = "ForceDeleteWithoutRecovery",
        .recovery_window_in_days = "RecoveryWindowInDays",
    };
};

pub const DeleteAnalysisOutput = struct {
    /// The ID of the deleted analysis.
    analysis_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the deleted analysis.
    arn: ?[]const u8 = null,

    /// The date and time that the analysis is scheduled to be deleted.
    deletion_time: ?i64 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .arn = "Arn",
        .deletion_time = "DeletionTime",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAnalysisInput, options: CallOptions) !DeleteAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAnalysisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/analyses/");
    try path_buf.appendSlice(allocator, input.analysis_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.force_delete_without_recovery) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "force-delete-without-recovery=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.recovery_window_in_days) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "recovery-window-in-days=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAnalysisOutput {
    var result: DeleteAnalysisOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteAnalysisOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
