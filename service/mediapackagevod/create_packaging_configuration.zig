const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CmafPackage = @import("cmaf_package.zig").CmafPackage;
const DashPackage = @import("dash_package.zig").DashPackage;
const HlsPackage = @import("hls_package.zig").HlsPackage;
const MssPackage = @import("mss_package.zig").MssPackage;

pub const CreatePackagingConfigurationInput = struct {
    cmaf_package: ?CmafPackage = null,

    dash_package: ?DashPackage = null,

    hls_package: ?HlsPackage = null,

    /// The ID of the PackagingConfiguration.
    id: []const u8,

    mss_package: ?MssPackage = null,

    /// The ID of a PackagingGroup.
    packaging_group_id: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cmaf_package = "CmafPackage",
        .dash_package = "DashPackage",
        .hls_package = "HlsPackage",
        .id = "Id",
        .mss_package = "MssPackage",
        .packaging_group_id = "PackagingGroupId",
        .tags = "Tags",
    };
};

pub const CreatePackagingConfigurationOutput = struct {
    /// The ARN of the PackagingConfiguration.
    arn: ?[]const u8 = null,

    cmaf_package: ?CmafPackage = null,

    /// The time the PackagingConfiguration was created.
    created_at: ?[]const u8 = null,

    dash_package: ?DashPackage = null,

    hls_package: ?HlsPackage = null,

    /// The ID of the PackagingConfiguration.
    id: ?[]const u8 = null,

    mss_package: ?MssPackage = null,

    /// The ID of a PackagingGroup.
    packaging_group_id: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .cmaf_package = "CmafPackage",
        .created_at = "CreatedAt",
        .dash_package = "DashPackage",
        .hls_package = "HlsPackage",
        .id = "Id",
        .mss_package = "MssPackage",
        .packaging_group_id = "PackagingGroupId",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePackagingConfigurationInput, options: CallOptions) !CreatePackagingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackage-vod", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePackagingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackage-vod", "MediaPackage Vod", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/packaging_configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cmaf_package) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CmafPackage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dash_package) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DashPackage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hls_package) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HlsPackage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Id\":");
    try aws.json.writeValue(@TypeOf(input.id), input.id, allocator, &body_buf);
    has_prev = true;
    if (input.mss_package) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MssPackage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PackagingGroupId\":");
    try aws.json.writeValue(@TypeOf(input.packaging_group_id), input.packaging_group_id, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePackagingConfigurationOutput {
    var result: CreatePackagingConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePackagingConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
