const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ImageCriterion = @import("image_criterion.zig").ImageCriterion;
const ManagedBy = @import("managed_by.zig").ManagedBy;
const serde = @import("serde.zig");

/// Gets the current state of the Allowed AMIs setting and the list of Allowed
/// AMIs criteria
/// at the account level in the specified Region.
///
/// **Note:**
///
/// The Allowed AMIs feature does not restrict the AMIs owned by your account.
/// Regardless of
/// the criteria you set, the AMIs created by your account will always be
/// discoverable and
/// usable by users in your account.
///
/// For more information, see [Control the discovery and use of AMIs in
/// Amazon EC2 with Allowed
/// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html) in
/// *Amazon EC2 User Guide*.
pub const GetAllowedImagesSettingsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,
};

pub const GetAllowedImagesSettingsOutput = struct {
    /// The list of criteria for images that are discoverable and usable in the
    /// account in the
    /// specified Amazon Web Services Region.
    image_criteria: ?[]const ImageCriterion = null,

    /// The entity that manages the Allowed AMIs settings. Possible values include:
    ///
    /// * `account` - The Allowed AMIs settings is managed by the account.
    ///
    /// * `declarative-policy` - The Allowed AMIs settings is managed by a
    /// declarative policy and can't be modified by the account.
    managed_by: ?ManagedBy = null,

    /// The current state of the Allowed AMIs setting at the account level in the
    /// specified Amazon Web Services
    /// Region.
    ///
    /// Possible values:
    ///
    /// * `disabled`: All AMIs are allowed.
    ///
    /// * `audit-mode`: All AMIs are allowed, but the `ImageAllowed` field
    /// is set to `true` if the AMI would be allowed with the current list of
    /// criteria
    /// if allowed AMIs was enabled.
    ///
    /// * `enabled`: Only AMIs matching the image criteria are discoverable and
    /// available for use.
    state: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetAllowedImagesSettingsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetAllowedImagesSettingsInput, options: Options) !GetAllowedImagesSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetAllowedImagesSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetAllowedImagesSettings&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetAllowedImagesSettingsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetAllowedImagesSettingsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "imageCriterionSet")) {
                    result.image_criteria = try serde.deserializeImageCriterionList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "managedBy")) {
                    result.managed_by = std.meta.stringToEnum(ManagedBy, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "state")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
