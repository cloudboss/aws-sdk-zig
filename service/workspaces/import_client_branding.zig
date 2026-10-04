const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DefaultImportClientBrandingAttributes = @import("default_import_client_branding_attributes.zig").DefaultImportClientBrandingAttributes;
const IosImportClientBrandingAttributes = @import("ios_import_client_branding_attributes.zig").IosImportClientBrandingAttributes;
const DefaultClientBrandingAttributes = @import("default_client_branding_attributes.zig").DefaultClientBrandingAttributes;
const IosClientBrandingAttributes = @import("ios_client_branding_attributes.zig").IosClientBrandingAttributes;

pub const ImportClientBrandingInput = struct {
    /// The branding information to import for Android devices.
    device_type_android: ?DefaultImportClientBrandingAttributes = null,

    /// The branding information to import for iOS devices.
    device_type_ios: ?IosImportClientBrandingAttributes = null,

    /// The branding information to import for Linux devices.
    device_type_linux: ?DefaultImportClientBrandingAttributes = null,

    /// The branding information to import for macOS devices.
    device_type_osx: ?DefaultImportClientBrandingAttributes = null,

    /// The branding information to import for web access.
    device_type_web: ?DefaultImportClientBrandingAttributes = null,

    /// The branding information to import for Windows devices.
    device_type_windows: ?DefaultImportClientBrandingAttributes = null,

    /// The directory identifier of the WorkSpace for which you want to import
    /// client
    /// branding.
    resource_id: []const u8,

    pub const json_field_names = .{
        .device_type_android = "DeviceTypeAndroid",
        .device_type_ios = "DeviceTypeIos",
        .device_type_linux = "DeviceTypeLinux",
        .device_type_osx = "DeviceTypeOsx",
        .device_type_web = "DeviceTypeWeb",
        .device_type_windows = "DeviceTypeWindows",
        .resource_id = "ResourceId",
    };
};

pub const ImportClientBrandingOutput = struct {
    /// The branding information configured for Android devices.
    device_type_android: ?DefaultClientBrandingAttributes = null,

    /// The branding information configured for iOS devices.
    device_type_ios: ?IosClientBrandingAttributes = null,

    /// The branding information configured for Linux devices.
    device_type_linux: ?DefaultClientBrandingAttributes = null,

    /// The branding information configured for macOS devices.
    device_type_osx: ?DefaultClientBrandingAttributes = null,

    /// The branding information configured for web access.
    device_type_web: ?DefaultClientBrandingAttributes = null,

    /// The branding information configured for Windows devices.
    device_type_windows: ?DefaultClientBrandingAttributes = null,

    pub const json_field_names = .{
        .device_type_android = "DeviceTypeAndroid",
        .device_type_ios = "DeviceTypeIos",
        .device_type_linux = "DeviceTypeLinux",
        .device_type_osx = "DeviceTypeOsx",
        .device_type_web = "DeviceTypeWeb",
        .device_type_windows = "DeviceTypeWindows",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportClientBrandingInput, options: CallOptions) !ImportClientBrandingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportClientBrandingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.ImportClientBranding");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportClientBrandingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportClientBrandingOutput, body, allocator);
}
