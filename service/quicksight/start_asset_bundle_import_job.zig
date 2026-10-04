const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetBundleImportSource = @import("asset_bundle_import_source.zig").AssetBundleImportSource;
const AssetBundleImportFailureAction = @import("asset_bundle_import_failure_action.zig").AssetBundleImportFailureAction;
const AssetBundleImportJobOverrideParameters = @import("asset_bundle_import_job_override_parameters.zig").AssetBundleImportJobOverrideParameters;
const AssetBundleImportJobOverridePermissions = @import("asset_bundle_import_job_override_permissions.zig").AssetBundleImportJobOverridePermissions;
const AssetBundleImportJobOverrideTags = @import("asset_bundle_import_job_override_tags.zig").AssetBundleImportJobOverrideTags;
const AssetBundleImportJobOverrideValidationStrategy = @import("asset_bundle_import_job_override_validation_strategy.zig").AssetBundleImportJobOverrideValidationStrategy;

pub const StartAssetBundleImportJobInput = struct {
    /// The ID of the job. This ID is unique while the job is running. After the job
    /// is
    /// completed, you can reuse this ID for another job.
    asset_bundle_import_job_id: []const u8,

    /// The source of the asset bundle zip file that contains the data that you want
    /// to import.
    /// The file must be in `QUICKSIGHT_JSON` format.
    asset_bundle_import_source: AssetBundleImportSource,

    /// The ID of the Amazon Web Services account to import assets into.
    aws_account_id: []const u8,

    /// The failure action for the import job.
    ///
    /// If you choose `ROLLBACK`, failed import jobs will attempt to undo any asset
    /// changes caused by the failed job.
    ///
    /// If you choose `DO_NOTHING`, failed import jobs will not attempt to roll back
    /// any asset changes caused by the failed job, possibly keeping the Amazon
    /// Quick Sight account
    /// in an inconsistent state.
    failure_action: ?AssetBundleImportFailureAction = null,

    /// Optional overrides that are applied to the resource configuration before
    /// import.
    override_parameters: ?AssetBundleImportJobOverrideParameters = null,

    /// Optional permission overrides that are applied to the resource configuration
    /// before
    /// import.
    override_permissions: ?AssetBundleImportJobOverridePermissions = null,

    /// Optional tag overrides that are applied to the resource configuration before
    /// import.
    override_tags: ?AssetBundleImportJobOverrideTags = null,

    /// An optional validation strategy override for all analyses and dashboards
    /// that is applied
    /// to the resource configuration before import.
    override_validation_strategy: ?AssetBundleImportJobOverrideValidationStrategy = null,

    pub const json_field_names = .{
        .asset_bundle_import_job_id = "AssetBundleImportJobId",
        .asset_bundle_import_source = "AssetBundleImportSource",
        .aws_account_id = "AwsAccountId",
        .failure_action = "FailureAction",
        .override_parameters = "OverrideParameters",
        .override_permissions = "OverridePermissions",
        .override_tags = "OverrideTags",
        .override_validation_strategy = "OverrideValidationStrategy",
    };
};

pub const StartAssetBundleImportJobOutput = struct {
    /// The Amazon Resource Name (ARN) for the import job.
    arn: ?[]const u8 = null,

    /// The ID of the job. This ID is unique while the job is running. After the job
    /// is
    /// completed, you can reuse this ID for another job.
    asset_bundle_import_job_id: ?[]const u8 = null,

    /// The Amazon Web Services response ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the response.
    status: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_bundle_import_job_id = "AssetBundleImportJobId",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAssetBundleImportJobInput, options: CallOptions) !StartAssetBundleImportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAssetBundleImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/asset-bundle-import-jobs/import");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AssetBundleImportJobId\":");
    try aws.json.writeValue(@TypeOf(input.asset_bundle_import_job_id), input.asset_bundle_import_job_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AssetBundleImportSource\":");
    try aws.json.writeValue(@TypeOf(input.asset_bundle_import_source), input.asset_bundle_import_source, allocator, &body_buf);
    has_prev = true;
    if (input.failure_action) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FailureAction\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.override_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OverrideParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.override_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OverridePermissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.override_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OverrideTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.override_validation_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OverrideValidationStrategy\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAssetBundleImportJobOutput {
    var result: StartAssetBundleImportJobOutput = try aws.json.parseJsonObject(
        StartAssetBundleImportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
