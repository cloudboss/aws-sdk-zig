const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LocationType = @import("location_type.zig").LocationType;

pub const HeadBucketInput = struct {
    /// The bucket name.
    ///
    /// **Directory buckets** - When you use this operation with a directory bucket,
    /// you must use virtual-hosted-style requests in the format `
    /// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`. Path-style
    /// requests are not supported. Directory bucket names must be unique in the
    /// chosen Zone (Availability Zone or Local Zone). Bucket names must follow the
    /// format `
    /// *bucket-base-name*--*zone-id*--x-s3` (for example, `
    /// *amzn-s3-demo-bucket*--*usw2-az1*--x-s3`). For information about bucket
    /// naming
    /// restrictions, see [Directory bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-bucket-naming-rules.html) in the *Amazon S3 User Guide*.
    ///
    /// **Access points** - When you use this action with an access point for
    /// general purpose buckets, you must provide the alias of the access point in
    /// place of the bucket name or specify the access point ARN. When you use this
    /// action with an access point for directory buckets, you must provide the
    /// access point name in place of the bucket name. When using the access point
    /// ARN, you must direct requests to the access point hostname. The access point
    /// hostname takes the form
    /// *AccessPointName*-*AccountId*.s3-accesspoint.*Region*.amazonaws.com. When
    /// using this action with an access point through the Amazon Web Services SDKs,
    /// you provide the access point ARN in place of the bucket name. For more
    /// information about access point ARNs, see [Using access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-access-points.html) in the *Amazon S3 User Guide*.
    ///
    /// **Object Lambda access points** - When you use this API operation with an
    /// Object Lambda access point, provide the alias of the Object Lambda access
    /// point in place of the bucket name.
    /// If the Object Lambda access point alias in a request is not valid, the error
    /// code `InvalidAccessPointAliasError` is returned.
    /// For more information about `InvalidAccessPointAliasError`, see [List of
    /// Error
    /// Codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#ErrorCodeList).
    ///
    /// Object Lambda access points are not supported by directory buckets.
    ///
    /// **S3 on Outposts** - When you use this action with S3 on Outposts, you must
    /// direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname
    /// takes the
    /// form `
    /// *AccessPointName*-*AccountId*.*outpostID*.s3-outposts.*Region*.amazonaws.com`. When you use this action with S3 on Outposts, the destination bucket must be the Outposts access point ARN or the access point alias. For more information about S3 on Outposts, see [What is S3 on Outposts?](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    bucket: []const u8,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,
};

pub const HeadBucketOutput = struct {
    /// Indicates whether the bucket name used in the request is an access point
    /// alias.
    ///
    /// For directory buckets, the value of this field is `false`.
    access_point_alias: ?bool = null,

    /// The Amazon Resource Name (ARN) of the S3 bucket. ARNs uniquely identify
    /// Amazon Web Services resources across all
    /// of Amazon Web Services.
    ///
    /// This parameter is only supported for S3 directory buckets. For more
    /// information, see [Using tags with
    /// directory
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-tagging.html).
    bucket_arn: ?[]const u8 = null,

    /// The name of the location where the bucket will be created.
    ///
    /// For directory buckets, the Zone ID of the Availability Zone or the Local
    /// Zone where the bucket is created. An example
    /// Zone ID value for an Availability Zone is `usw2-az1`.
    ///
    /// This functionality is only supported by directory buckets.
    bucket_location_name: ?[]const u8 = null,

    /// The type of location where the bucket is created.
    ///
    /// This functionality is only supported by directory buckets.
    bucket_location_type: ?LocationType = null,

    /// The Region that the bucket is located.
    bucket_region: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: HeadBucketInput, options: CallOptions) !HeadBucketOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

pub const PresignOptions = struct {
    expires_seconds: u64 = 3600,
};

pub fn presign(client: *Client, allocator: std.mem.Allocator, input: HeadBucketInput, options: PresignOptions) ![]const u8 {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);

    return aws.signing.presignRequest(
        allocator,
        client.config.io,
        &request,
        creds,
        client.config.region,
        "s3",
        .{ .expires_seconds = options.expires_seconds },
        client.config.http_client.clock_skew_offset,
    );
}

fn serializeRequest(allocator: std.mem.Allocator, input: HeadBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .HEAD;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !HeadBucketOutput {
    var result: HeadBucketOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("x-amz-access-point-alias")) |value| {
        result.access_point_alias = std.mem.eql(u8, value, "true");
    }
    if (headers.get("x-amz-bucket-arn")) |value| {
        result.bucket_arn = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-bucket-location-name")) |value| {
        result.bucket_location_name = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-bucket-location-type")) |value| {
        result.bucket_location_type = LocationType.fromWireName(value);
    }
    if (headers.get("x-amz-bucket-region")) |value| {
        result.bucket_region = try allocator.dupe(u8, value);
    }

    return result;
}
