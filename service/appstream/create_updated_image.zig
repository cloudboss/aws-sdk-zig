const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Image = @import("image.zig").Image;

pub const CreateUpdatedImageInput = struct {
    /// Indicates whether to display the status of image update availability before
    /// WorkSpaces Applications initiates the process of creating a new updated
    /// image. If this value is set to `true`, WorkSpaces Applications displays
    /// whether image updates are available. If this value is set to `false`,
    /// WorkSpaces Applications initiates the process of creating a new updated
    /// image without displaying whether image updates are available.
    dry_run: ?bool = null,

    /// The name of the image to update.
    existing_image_name: []const u8,

    /// The description to display for the new image.
    new_image_description: ?[]const u8 = null,

    /// The name to display for the new image.
    new_image_display_name: ?[]const u8 = null,

    /// The name of the new image. The name must be unique within the AWS account
    /// and Region.
    new_image_name: []const u8,

    /// The tags to associate with the new image. A tag is a key-value pair, and the
    /// value is optional. For example, Environment=Test. If you do not specify a
    /// value, Environment=.
    ///
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in UTF-8, and the following special characters:
    ///
    /// _ . : / = + \ - @
    ///
    /// If you do not specify a value, the value is set to an empty string.
    ///
    /// For more information about tags, see [Tagging Your
    /// Resources](https://docs.aws.amazon.com/appstream2/latest/developerguide/tagging-basic.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    new_image_tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .dry_run = "dryRun",
        .existing_image_name = "existingImageName",
        .new_image_description = "newImageDescription",
        .new_image_display_name = "newImageDisplayName",
        .new_image_name = "newImageName",
        .new_image_tags = "newImageTags",
    };
};

pub const CreateUpdatedImageOutput = struct {
    /// Indicates whether a new image can be created.
    can_update_image: ?bool = null,

    image: ?Image = null,

    pub const json_field_names = .{
        .can_update_image = "canUpdateImage",
        .image = "image",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUpdatedImageInput, options: CallOptions) !CreateUpdatedImageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUpdatedImageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateUpdatedImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUpdatedImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUpdatedImageOutput, body, allocator);
}
