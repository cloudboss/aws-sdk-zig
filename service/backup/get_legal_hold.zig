const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecoveryPointSelection = @import("recovery_point_selection.zig").RecoveryPointSelection;
const LegalHoldStatus = @import("legal_hold_status.zig").LegalHoldStatus;

pub const GetLegalHoldInput = struct {
    /// The ID of the legal hold.
    legal_hold_id: []const u8,

    pub const json_field_names = .{
        .legal_hold_id = "LegalHoldId",
    };
};

pub const GetLegalHoldOutput = struct {
    /// The reason for removing the legal hold.
    cancel_description: ?[]const u8 = null,

    /// The time when the legal hold was cancelled.
    cancellation_date: ?i64 = null,

    /// The time when the legal hold was created.
    creation_date: ?i64 = null,

    /// The description of the legal hold.
    description: ?[]const u8 = null,

    /// The framework ARN for the specified legal hold. The format
    /// of the ARN depends on the resource type.
    legal_hold_arn: ?[]const u8 = null,

    /// The ID of the legal hold.
    legal_hold_id: ?[]const u8 = null,

    /// The criteria to assign a set of resources, such as resource types or backup
    /// vaults.
    recovery_point_selection: ?RecoveryPointSelection = null,

    /// The date and time until which the legal hold record is retained.
    retain_record_until: ?i64 = null,

    /// The status of the legal hold.
    status: ?LegalHoldStatus = null,

    /// The title of the legal hold.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .cancel_description = "CancelDescription",
        .cancellation_date = "CancellationDate",
        .creation_date = "CreationDate",
        .description = "Description",
        .legal_hold_arn = "LegalHoldArn",
        .legal_hold_id = "LegalHoldId",
        .recovery_point_selection = "RecoveryPointSelection",
        .retain_record_until = "RetainRecordUntil",
        .status = "Status",
        .title = "Title",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLegalHoldInput, options: CallOptions) !GetLegalHoldOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLegalHoldInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/legal-holds/");
    try path_buf.appendSlice(allocator, input.legal_hold_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLegalHoldOutput {
    const result: GetLegalHoldOutput = try aws.json.parseJsonObject(
        GetLegalHoldOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
