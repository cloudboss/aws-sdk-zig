const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThemeAttribute = @import("theme_attribute.zig").ThemeAttribute;
const S3Location = @import("s3_location.zig").S3Location;
const ThemeFooterLink = @import("theme_footer_link.zig").ThemeFooterLink;
const ThemeState = @import("theme_state.zig").ThemeState;
const ThemeStyling = @import("theme_styling.zig").ThemeStyling;
const Theme = @import("theme.zig").Theme;

pub const UpdateThemeForStackInput = struct {
    /// The attributes to delete.
    attributes_to_delete: ?[]const ThemeAttribute = null,

    /// The S3 location of the favicon. The favicon enables users to recognize their
    /// application streaming site in a browser full of tabs or bookmarks. It is
    /// displayed at the top of the browser tab for the application streaming site
    /// during users' streaming sessions.
    favicon_s3_location: ?S3Location = null,

    /// The links that are displayed in the footer of the streaming application
    /// catalog page. These links are helpful resources for users, such as the
    /// organization's IT support and product marketing sites.
    footer_links: ?[]const ThemeFooterLink = null,

    /// The organization logo that appears on the streaming application catalog
    /// page.
    organization_logo_s3_location: ?S3Location = null,

    /// The name of the stack for the theme.
    stack_name: []const u8,

    /// Specifies whether custom branding should be applied to catalog page or not.
    state: ?ThemeState = null,

    /// The color theme that is applied to website links, text, and buttons. These
    /// colors are also applied as accents in the background for the streaming
    /// application catalog page.
    theme_styling: ?ThemeStyling = null,

    /// The title that is displayed at the top of the browser tab during users'
    /// application streaming sessions.
    title_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes_to_delete = "AttributesToDelete",
        .favicon_s3_location = "FaviconS3Location",
        .footer_links = "FooterLinks",
        .organization_logo_s3_location = "OrganizationLogoS3Location",
        .stack_name = "StackName",
        .state = "State",
        .theme_styling = "ThemeStyling",
        .title_text = "TitleText",
    };
};

pub const UpdateThemeForStackOutput = struct {
    /// The theme object that contains the metadata of the custom branding.
    theme: ?Theme = null,

    pub const json_field_names = .{
        .theme = "Theme",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateThemeForStackInput, options: CallOptions) !UpdateThemeForStackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateThemeForStackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.UpdateThemeForStack");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateThemeForStackOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateThemeForStackOutput, body, allocator);
}
