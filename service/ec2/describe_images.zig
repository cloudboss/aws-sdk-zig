const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const Image = @import("image.zig").Image;
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeImagesInput, options: Options) !DescribeImagesOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeImagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeImages&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.executable_users) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExecutableBy.ExecutableBy.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.image_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ImageId.ImageId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.include_deprecated) |v| {
        try body_buf.appendSlice(allocator, "&IncludeDeprecated=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.include_disabled) |v| {
        try body_buf.appendSlice(allocator, "&IncludeDisabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.owners) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Owner.Owner.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeImagesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeImagesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "imagesSet")) {
                    result.images = try serde.deserializeImageList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
