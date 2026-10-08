const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Version = @import("version.zig").Version;

pub const GetApplicationInput = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_id: []const u8,

    /// The semantic version of the application to get.
    semantic_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .semantic_version = "SemanticVersion",
    };
};

pub const GetApplicationOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationInput, options: CallOptions) !GetApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "serverlessrepo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("serverlessrepo", "ServerlessApplicationRepository", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.semantic_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "semanticVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationOutput {
    const result: GetApplicationOutput = try aws.json.parseJsonObject(
        GetApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
