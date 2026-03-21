const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Version = @import("version.zig").Version;

pub const CreateApplicationInput = struct {
    /// The name of the author publishing the app.
    ///
    /// Minimum length=1. Maximum length=127.
    ///
    /// Pattern "^[a-z0-9](([a-z0-9]|-(?!-))*[a-z0-9])?$";
    author: []const u8,

    /// The description of the application.
    ///
    /// Minimum length=1. Maximum length=256
    description: []const u8,

    /// A URL with more information about the application, for example the location
    /// of your GitHub repository for the application.
    home_page_url: ?[]const u8 = null,

    /// Labels to improve discovery of apps in search results.
    ///
    /// Minimum length=1. Maximum length=127. Maximum number of labels: 10
    ///
    /// Pattern: "^[a-zA-Z0-9+\\-_:\\/@]+$";
    labels: ?[]const []const u8 = null,

    /// A local text file that contains the license of the app that matches the
    /// spdxLicenseID value of your application.
    /// The file has the format file://<path>/<filename>.
    ///
    /// Maximum size 5 MB
    ///
    /// You can specify only one of licenseBody and licenseUrl; otherwise, an error
    /// results.
    license_body: ?[]const u8 = null,

    /// A link to the S3 object that contains the license of the app that matches
    /// the spdxLicenseID value of your application.
    ///
    /// Maximum size 5 MB
    ///
    /// You can specify only one of licenseBody and licenseUrl; otherwise, an error
    /// results.
    license_url: ?[]const u8 = null,

    /// The name of the application that you want to publish.
    ///
    /// Minimum length=1. Maximum length=140
    ///
    /// Pattern: "[a-zA-Z0-9\\-]+";
    name: []const u8,

    /// A local text readme file in Markdown language that contains a more detailed
    /// description of the application and how it works.
    /// The file has the format file://<path>/<filename>.
    ///
    /// Maximum size 5 MB
    ///
    /// You can specify only one of readmeBody and readmeUrl; otherwise, an error
    /// results.
    readme_body: ?[]const u8 = null,

    /// A link to the S3 object in Markdown language that contains a more detailed
    /// description of the application and how it works.
    ///
    /// Maximum size 5 MB
    ///
    /// You can specify only one of readmeBody and readmeUrl; otherwise, an error
    /// results.
    readme_url: ?[]const u8 = null,

    /// The semantic version of the application:
    ///
    /// [https://semver.org/](https://semver.org/)
    semantic_version: ?[]const u8 = null,

    /// A link to the S3 object that contains the ZIP archive of the source code for
    /// this version of your application.
    ///
    /// Maximum size 50 MB
    source_code_archive_url: ?[]const u8 = null,

    /// A link to a public repository for the source code of your application, for
    /// example the URL of a specific GitHub commit.
    source_code_url: ?[]const u8 = null,

    /// A valid identifier from
    /// [https://spdx.org/licenses/](https://spdx.org/licenses/).
    spdx_license_id: ?[]const u8 = null,

    /// The local raw packaged AWS SAM template file of your application.
    /// The file has the format file://<path>/<filename>.
    ///
    /// You can specify only one of templateBody and templateUrl; otherwise an error
    /// results.
    template_body: ?[]const u8 = null,

    /// A link to the S3 object containing the packaged AWS SAM template of your
    /// application.
    ///
    /// You can specify only one of templateBody and templateUrl; otherwise an error
    /// results.
    template_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .author = "Author",
        .description = "Description",
        .home_page_url = "HomePageUrl",
        .labels = "Labels",
        .license_body = "LicenseBody",
        .license_url = "LicenseUrl",
        .name = "Name",
        .readme_body = "ReadmeBody",
        .readme_url = "ReadmeUrl",
        .semantic_version = "SemanticVersion",
        .source_code_archive_url = "SourceCodeArchiveUrl",
        .source_code_url = "SourceCodeUrl",
        .spdx_license_id = "SpdxLicenseId",
        .template_body = "TemplateBody",
        .template_url = "TemplateUrl",
    };
};

pub const CreateApplicationOutput = struct {
    /// The application Amazon Resource Name (ARN).
    application_id: ?[]const u8 = null,

    /// The name of the author publishing the app.
    ///
    /// Minimum length=1. Maximum length=127.
    ///
    /// Pattern "^[a-z0-9](([a-z0-9]|-(?!-))*[a-z0-9])?$";
    author: ?[]const u8 = null,

    /// The date and time this resource was created.
    creation_time: ?[]const u8 = null,

    /// The description of the application.
    ///
    /// Minimum length=1. Maximum length=256
    description: ?[]const u8 = null,

    /// A URL with more information about the application, for example the location
    /// of your GitHub repository for the application.
    home_page_url: ?[]const u8 = null,

    /// Whether the author of this application has been verified. This means means
    /// that AWS has made a good faith review, as a reasonable and prudent service
    /// provider, of the information provided by the requester and has confirmed
    /// that the requester's identity is as claimed.
    is_verified_author: ?bool = null,

    /// Labels to improve discovery of apps in search results.
    ///
    /// Minimum length=1. Maximum length=127. Maximum number of labels: 10
    ///
    /// Pattern: "^[a-zA-Z0-9+\\-_:\\/@]+$";
    labels: ?[]const []const u8 = null,

    /// A link to a license file of the app that matches the spdxLicenseID value of
    /// your application.
    ///
    /// Maximum size 5 MB
    license_url: ?[]const u8 = null,

    /// The name of the application.
    ///
    /// Minimum length=1. Maximum length=140
    ///
    /// Pattern: "[a-zA-Z0-9\\-]+";
    name: ?[]const u8 = null,

    /// A link to the readme file in Markdown language that contains a more detailed
    /// description of the application and how it works.
    ///
    /// Maximum size 5 MB
    readme_url: ?[]const u8 = null,

    /// A valid identifier from https://spdx.org/licenses/.
    spdx_license_id: ?[]const u8 = null,

    /// The URL to the public profile of a verified author. This URL is submitted by
    /// the author.
    verified_author_url: ?[]const u8 = null,

    /// Version information about the application.
    version: ?Version = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .author = "Author",
        .creation_time = "CreationTime",
        .description = "Description",
        .home_page_url = "HomePageUrl",
        .is_verified_author = "IsVerifiedAuthor",
        .labels = "Labels",
        .license_url = "LicenseUrl",
        .name = "Name",
        .readme_url = "ReadmeUrl",
        .spdx_license_id = "SpdxLicenseId",
        .verified_author_url = "VerifiedAuthorUrl",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: CallOptions) !CreateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "serverlessrepo");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("serverlessrepo", "ServerlessApplicationRepository", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/applications";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Author\":");
    try aws.json.writeValue(@TypeOf(input.author), input.author, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (input.home_page_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HomePageUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.labels) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Labels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.license_body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LicenseBody\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.license_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LicenseUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.readme_body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReadmeBody\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.readme_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReadmeUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.semantic_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SemanticVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_code_archive_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceCodeArchiveUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_code_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceCodeUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.spdx_license_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SpdxLicenseId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.template_body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TemplateBody\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.template_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TemplateUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationOutput {
    var result: CreateApplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateApplicationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
