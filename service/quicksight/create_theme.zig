const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThemeConfiguration = @import("theme_configuration.zig").ThemeConfiguration;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;
const Tag = @import("tag.zig").Tag;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateThemeInput = struct {
    /// The ID of the Amazon Web Services account where you want to store the new
    /// theme.
    aws_account_id: []const u8,

    /// The ID of the theme that a custom theme will inherit from. All themes
    /// inherit from one of
    /// the starting themes defined by Amazon Quick Sight. For a list of the
    /// starting themes, use
    /// `ListThemes` or choose **Themes** from
    /// within an analysis.
    base_theme_id: []const u8,

    /// The theme configuration, which contains the theme display properties.
    configuration: ThemeConfiguration,

    /// A display name for the theme.
    name: []const u8,

    /// A valid grouping of resource permissions to apply to the new theme.
    permissions: ?[]const ResourcePermission = null,

    /// A map of the key-value pairs for the resource tag or tags that you want to
    /// add to the
    /// resource.
    tags: ?[]const Tag = null,

    /// An ID for the theme that you want to create. The theme ID is unique per
    /// Amazon Web Services Region in
    /// each Amazon Web Services account.
    theme_id: []const u8,

    /// A description of the first version of the theme that you're creating. Every
    /// time
    /// `UpdateTheme` is called, a new version is created. Each version of the
    /// theme has a description of the version in the `VersionDescription`
    /// field.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .base_theme_id = "BaseThemeId",
        .configuration = "Configuration",
        .name = "Name",
        .permissions = "Permissions",
        .tags = "Tags",
        .theme_id = "ThemeId",
        .version_description = "VersionDescription",
    };
};

pub const CreateThemeOutput = struct {
    /// The Amazon Resource Name (ARN) for the theme.
    arn: ?[]const u8 = null,

    /// The theme creation status.
    creation_status: ?ResourceStatus = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The ID of the theme.
    theme_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the new theme.
    version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_status = "CreationStatus",
        .request_id = "RequestId",
        .status = "Status",
        .theme_id = "ThemeId",
        .version_arn = "VersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateThemeInput, options: CallOptions) !CreateThemeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateThemeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/themes/");
    try path_buf.appendSlice(allocator, input.theme_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BaseThemeId\":");
    try aws.json.writeValue(@TypeOf(input.base_theme_id), input.base_theme_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Permissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VersionDescription\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateThemeOutput {
    var result: CreateThemeOutput = try aws.json.parseJsonObject(
        CreateThemeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
