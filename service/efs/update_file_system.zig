const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThroughputMode = @import("throughput_mode.zig").ThroughputMode;
const FileSystemProtectionDescription = @import("file_system_protection_description.zig").FileSystemProtectionDescription;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;
const PerformanceMode = @import("performance_mode.zig").PerformanceMode;
const FileSystemSize = @import("file_system_size.zig").FileSystemSize;
const Tag = @import("tag.zig").Tag;

pub const UpdateFileSystemInput = struct {
    /// The ID of the file system that you want to update.
    file_system_id: []const u8,

    /// (Optional) The throughput, measured in mebibytes per second (MiBps), that
    /// you want to
    /// provision for a file system that you're creating. Required if
    /// `ThroughputMode`
    /// is set to `provisioned`. Valid values are 1-3414 MiBps, with the upper limit
    /// depending on Region. To increase this limit, contact Amazon Web Services
    /// Support. For more information,
    /// see [Amazon EFS
    /// quotas that you can
    /// increase](https://docs.aws.amazon.com/efs/latest/ug/limits.html#soft-limits)
    /// in the *Amazon EFS User
    /// Guide*.
    provisioned_throughput_in_mibps: ?f64 = null,

    /// (Optional) Updates the file system's throughput mode. If you're not
    /// updating your throughput mode, you don't need to provide this value in your
    /// request. If you are changing the `ThroughputMode` to `provisioned`,
    /// you must also set a value for `ProvisionedThroughputInMibps`.
    throughput_mode: ?ThroughputMode = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .provisioned_throughput_in_mibps = "ProvisionedThroughputInMibps",
        .throughput_mode = "ThroughputMode",
    };
};

pub const UpdateFileSystemOutput = @import("file_system_description.zig").FileSystemDescription;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFileSystemInput, options: CallOptions) !UpdateFileSystemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFileSystemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-02-01/file-systems/");
    try path_buf.appendSlice(allocator, input.file_system_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.provisioned_throughput_in_mibps) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProvisionedThroughputInMibps\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.throughput_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ThroughputMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFileSystemOutput {
    const result: UpdateFileSystemOutput = try aws.json.parseJsonObject(
        UpdateFileSystemOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
