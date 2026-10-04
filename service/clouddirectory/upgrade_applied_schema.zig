const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpgradeAppliedSchemaInput = struct {
    /// The ARN for the directory to which the upgraded schema will be applied.
    directory_arn: []const u8,

    /// Used for testing whether the major version schemas are backward compatible
    /// or not. If schema compatibility fails, an exception would be thrown else the
    /// call would succeed but no changes will be saved. This parameter is optional.
    dry_run: ?bool = null,

    /// The revision of the published schema to upgrade the directory to.
    published_schema_arn: []const u8,

    pub const json_field_names = .{
        .directory_arn = "DirectoryArn",
        .dry_run = "DryRun",
        .published_schema_arn = "PublishedSchemaArn",
    };
};

pub const UpgradeAppliedSchemaOutput = struct {
    /// The ARN of the directory that is returned as part of the response.
    directory_arn: ?[]const u8 = null,

    /// The ARN of the upgraded schema that is returned as part of the response.
    upgraded_schema_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_arn = "DirectoryArn",
        .upgraded_schema_arn = "UpgradedSchemaArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpgradeAppliedSchemaInput, options: CallOptions) !UpgradeAppliedSchemaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "clouddirectory", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpgradeAppliedSchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/schema/upgradeapplied";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DirectoryArn\":");
    try aws.json.writeValue(@TypeOf(input.directory_arn), input.directory_arn, allocator, &body_buf);
    has_prev = true;
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PublishedSchemaArn\":");
    try aws.json.writeValue(@TypeOf(input.published_schema_arn), input.published_schema_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpgradeAppliedSchemaOutput {
    var result: UpgradeAppliedSchemaOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpgradeAppliedSchemaOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
