const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpgradePublishedSchemaInput = struct {
    /// The ARN of the development schema with the changes used for the upgrade.
    development_schema_arn: []const u8,

    /// Used for testing whether the Development schema provided is backwards
    /// compatible, or not, with the publish schema provided by the user to be
    /// upgraded. If schema compatibility fails, an exception would be thrown else
    /// the call would succeed. This parameter is optional and defaults to false.
    dry_run: ?bool = null,

    /// Identifies the minor version of the published schema that will be created.
    /// This parameter is NOT optional.
    minor_version: []const u8,

    /// The ARN of the published schema to be upgraded.
    published_schema_arn: []const u8,

    pub const json_field_names = .{
        .development_schema_arn = "DevelopmentSchemaArn",
        .dry_run = "DryRun",
        .minor_version = "MinorVersion",
        .published_schema_arn = "PublishedSchemaArn",
    };
};

pub const UpgradePublishedSchemaOutput = struct {
    /// The ARN of the upgraded schema that is returned as part of the response.
    upgraded_schema_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .upgraded_schema_arn = "UpgradedSchemaArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpgradePublishedSchemaInput, options: CallOptions) !UpgradePublishedSchemaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpgradePublishedSchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("clouddirectory", "CloudDirectory", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/amazonclouddirectory/2017-01-11/schema/upgradepublished";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DevelopmentSchemaArn\":");
    try aws.json.writeValue(@TypeOf(input.development_schema_arn), input.development_schema_arn, allocator, &body_buf);
    has_prev = true;
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MinorVersion\":");
    try aws.json.writeValue(@TypeOf(input.minor_version), input.minor_version, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpgradePublishedSchemaOutput {
    const result: UpgradePublishedSchemaOutput = try aws.json.parseJsonObject(
        UpgradePublishedSchemaOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
