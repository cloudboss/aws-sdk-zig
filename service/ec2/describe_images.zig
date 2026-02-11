const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const Image = @import("image.zig").Image;

/// Describes the specified images (AMIs, AKIs, and ARIs) available to you or
/// all of the
/// images available to you.
///
/// The images available to you include public images, private images that you
/// own, and
/// private images owned by other Amazon Web Services accounts for which you
/// have explicit launch
/// permissions.
///
/// Recently deregistered images appear in the returned results for a short
/// interval and then
/// return empty results. After all instances that reference a deregistered AMI
/// are terminated,
/// specifying the ID of the image will eventually return an error indicating
/// that the AMI ID
/// cannot be found.
///
/// When Allowed AMIs is set to `enabled`, only allowed images are returned in
/// the
/// results, with the `imageAllowed` field set to `true` for each image. In
/// `audit-mode`, the `imageAllowed` field is set to `true` for
/// images that meet the account's Allowed AMIs criteria, and `false` for images
/// that
/// don't meet the criteria. For more information, see [Allowed
/// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html).
///
/// The Amazon EC2 API follows an eventual consistency model. This means that
/// the result of an API
/// command you run that creates or modifies resources might not be immediately
/// available to all
/// subsequent commands you run. For guidance on how to manage eventual
/// consistency, see [Eventual
/// consistency in the Amazon EC2
/// API](https://docs.aws.amazon.com/ec2/latest/devguide/eventual-consistency.html) in the *Amazon EC2 Developer
/// Guide*.
///
/// **Important:**
///
/// We strongly recommend using only paginated requests. Unpaginated requests
/// are
/// susceptible to throttling and timeouts.
///
/// **Note:**
///
/// The order of the elements in the response, including those within nested
/// structures,
/// might vary. Applications should not assume the elements appear in a
/// particular order.
pub const DescribeImagesInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Scopes the images by users with explicit launch permissions. Specify an
    /// Amazon Web Services account ID, `self` (the sender of the request), or `all`
    /// (public AMIs).
    ///
    /// * If you specify an Amazon Web Services account ID that is not your own,
    ///   only AMIs shared
    /// with that specific Amazon Web Services account ID are returned. However,
    /// AMIs that are
    /// shared with the account’s organization or organizational unit (OU) are not
    /// returned.
    ///
    /// * If you specify `self` or your own Amazon Web Services account ID, AMIs
    /// shared with your account are returned. In addition, AMIs that are shared
    /// with the
    /// organization or OU of which you are member are also returned.
    ///
    /// * If you specify `all`, all public AMIs are returned.
    executable_users: ?[]const []const u8 = null,

    /// The filters.
    ///
    /// * `architecture` - The image architecture (`i386` |
    /// `x86_64` | `arm64` | `x86_64_mac` |
    /// `arm64_mac`).
    ///
    /// * `block-device-mapping.delete-on-termination` - A Boolean value that
    ///   indicates
    /// whether the Amazon EBS volume is deleted on instance termination.
    ///
    /// * `block-device-mapping.device-name` - The device name specified in the
    ///   block
    /// device mapping (for example, `/dev/sdh` or `xvdh`).
    ///
    /// * `block-device-mapping.snapshot-id` - The ID of the snapshot used for the
    ///   Amazon EBS
    /// volume.
    ///
    /// * `block-device-mapping.volume-size` - The volume size of the Amazon EBS
    ///   volume, in
    /// GiB.
    ///
    /// * `block-device-mapping.volume-type` - The volume type of the Amazon EBS
    ///   volume
    /// (`io1` | `io2` | `gp2` | `gp3` | `sc1
    /// `| `st1` | `standard`).
    ///
    /// * `block-device-mapping.encrypted` - A Boolean that indicates whether the
    ///   Amazon EBS
    /// volume is encrypted.
    ///
    /// * `creation-date` - The time when the image was created, in the ISO 8601
    /// format in the UTC time zone (YYYY-MM-DDThh:mm:ss.sssZ), for example,
    /// `2021-09-29T11:04:43.305Z`. You can use a wildcard (`*`), for
    /// example, `2021-09-29T*`, which matches an entire day.
    ///
    /// * `description` - The description of the image (provided during image
    /// creation).
    ///
    /// * `ena-support` - A Boolean that indicates whether enhanced networking with
    /// ENA is enabled.
    ///
    /// * `free-tier-eligible` - A Boolean that indicates whether this image can be
    /// used under the Amazon Web Services Free Tier (`true` | `false`).
    ///
    /// * `hypervisor` - The hypervisor type (`ovm` |
    /// `xen`).
    ///
    /// * `image-allowed` - A Boolean that indicates whether the image meets the
    /// criteria specified for Allowed AMIs.
    ///
    /// * `image-id` - The ID of the image.
    ///
    /// * `image-type` - The image type (`machine` | `kernel` |
    /// `ramdisk`).
    ///
    /// * `is-public` - A Boolean that indicates whether the image is public.
    ///
    /// * `kernel-id` - The kernel ID.
    ///
    /// * `manifest-location` - The location of the image manifest.
    ///
    /// * `name` - The name of the AMI (provided during image creation).
    ///
    /// * `owner-alias` - The owner alias (`amazon` |
    /// `aws-backup-vault` | `aws-marketplace`). The valid aliases are
    /// defined in an Amazon-maintained list. This is not the Amazon Web Services
    /// account alias
    /// that can be set using the IAM console. We recommend that you use the
    /// **Owner** request parameter instead of this filter.
    ///
    /// * `owner-id` - The Amazon Web Services account ID of the owner. We recommend
    /// that you use the **Owner** request parameter instead of this
    /// filter.
    ///
    /// * `platform` - The platform. The only supported value is
    /// `windows`.
    ///
    /// * `product-code` - The product code.
    ///
    /// * `product-code.type` - The type of the product code
    /// (`marketplace`).
    ///
    /// * `ramdisk-id` - The RAM disk ID.
    ///
    /// * `root-device-name` - The device name of the root device volume (for
    ///   example,
    /// `/dev/sda1`).
    ///
    /// * `root-device-type` - The type of the root device volume (`ebs` |
    /// `instance-store`).
    ///
    /// * `source-image-id` - The ID of the source AMI from which the AMI was
    /// created.
    ///
    /// * `source-image-region` - The Region of the source AMI.
    ///
    /// * `source-instance-id` - The ID of the instance that the AMI was created
    ///   from
    /// if the AMI was created using CreateImage. This filter is applicable only if
    /// the AMI was
    /// created using
    /// [CreateImage](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateImage.html).
    ///
    /// * `state` - The state of the image (`available` | `pending`
    /// | `failed`).
    ///
    /// * `state-reason-code` - The reason code for the state change.
    ///
    /// * `state-reason-message` - The message for the state change.
    ///
    /// * `sriov-net-support` - A value of `simple` indicates that
    /// enhanced networking with the Intel 82599 VF interface is enabled.
    ///
    /// * `tag:` - The key/value combination of a tag assigned to the resource. Use
    ///   the tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    ///
    /// * `tag-key` - The key of a tag assigned to the resource. Use this filter to
    ///   find all resources assigned a tag with a specific key, regardless of the
    ///   tag value.
    ///
    /// * `virtualization-type` - The virtualization type (`paravirtual` |
    /// `hvm`).
    filters: ?[]const Filter = null,

    /// The image IDs.
    ///
    /// Default: Describes all images available to you.
    image_ids: ?[]const []const u8 = null,

    /// Specifies whether to include deprecated AMIs.
    ///
    /// Default: No deprecated AMIs are included in the response.
    ///
    /// **Note:**
    ///
    /// If you are the AMI owner, all deprecated AMIs appear in the response
    /// regardless of what
    /// you specify for this parameter.
    include_deprecated: ?bool = null,

    /// Specifies whether to include disabled AMIs.
    ///
    /// Default: No disabled AMIs are included in the response.
    include_disabled: ?bool = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,

    /// Scopes the results to images with the specified owners. You can specify a
    /// combination of
    /// Amazon Web Services account IDs, `self`, `amazon`,
    /// `aws-backup-vault`, and `aws-marketplace`. If you omit this parameter,
    /// the results include all images for which you have launch permissions,
    /// regardless of
    /// ownership.
    owners: ?[]const []const u8 = null,
};

pub const DescribeImagesOutput = struct {
    /// Information about the images.
    images: ?[]const Image = null,

    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there
    /// are no more items to return.
    next_token: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const DescribeImagesOutput) void {
        if (self.next_token) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeImagesInput, options: Options) !DescribeImagesOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeImagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeImages&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.executable_users) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExecutableUsers.ExecutableBy.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.image_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ImageIds.ImageId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.include_deprecated) |v| {
        try body_buf.appendSlice(alloc, "&IncludeDeprecated=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.include_disabled) |v| {
        try body_buf.appendSlice(alloc, "&IncludeDisabled=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.owners) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Owners.Owner.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeImagesOutput {
    _ = status;
    _ = headers;
    var result: DescribeImagesOutput = .{ .allocator = alloc };
    if (findElement(body, "nextToken")) |content| {
        result.next_token = try alloc.dupe(u8, content);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
