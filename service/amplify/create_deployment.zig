const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateDeploymentInput = struct {
    /// The unique ID for an Amplify app.
    app_id: []const u8,

    /// The name of the branch to use for the job.
    branch_name: []const u8,

    /// An optional file map that contains the file name as the key and the file
    /// content md5
    /// hash as the value. If this argument is provided, the service will generate a
    /// unique
    /// upload URL per file. Otherwise, the service will only generate a single
    /// upload URL for
    /// the zipped files.
    file_map: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .branch_name = "branchName",
        .file_map = "fileMap",
    };
};

pub const CreateDeploymentOutput = struct {
    /// When the `fileMap` argument is provided in the request,
    /// `fileUploadUrls` will contain a map of file names to upload URLs.
    file_upload_urls: ?[]const aws.map.StringMapEntry = null,

    /// The job ID for this deployment. will supply to start deployment api.
    job_id: ?[]const u8 = null,

    /// When the `fileMap` argument is not provided in the request, this
    /// `zipUploadUrl` is returned.
    zip_upload_url: []const u8,

    pub const json_field_names = .{
        .file_upload_urls = "fileUploadUrls",
        .job_id = "jobId",
        .zip_upload_url = "zipUploadUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeploymentInput, options: CallOptions) !CreateDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplify", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplify", "Amplify", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/apps/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/branches/");
    try path_buf.appendSlice(allocator, input.branch_name);
    try path_buf.appendSlice(allocator, "/deployments");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.file_map) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fileMap\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeploymentOutput {
    const result: CreateDeploymentOutput = try aws.json.parseJsonObject(
        CreateDeploymentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
