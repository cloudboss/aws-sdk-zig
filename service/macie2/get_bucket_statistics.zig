const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BucketCountByEffectivePermission = @import("bucket_count_by_effective_permission.zig").BucketCountByEffectivePermission;
const BucketCountByEncryptionType = @import("bucket_count_by_encryption_type.zig").BucketCountByEncryptionType;
const BucketCountPolicyAllowsUnencryptedObjectUploads = @import("bucket_count_policy_allows_unencrypted_object_uploads.zig").BucketCountPolicyAllowsUnencryptedObjectUploads;
const BucketCountBySharedAccessType = @import("bucket_count_by_shared_access_type.zig").BucketCountBySharedAccessType;
const BucketStatisticsBySensitivity = @import("bucket_statistics_by_sensitivity.zig").BucketStatisticsBySensitivity;
const ObjectLevelStatistics = @import("object_level_statistics.zig").ObjectLevelStatistics;

pub const GetBucketStatisticsInput = struct {
    /// The unique identifier for the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};

pub const GetBucketStatisticsOutput = struct {
    /// The total number of buckets.
    bucket_count: ?i64 = null,

    /// The total number of buckets that are publicly accessible due to a
    /// combination of permissions settings for each bucket.
    bucket_count_by_effective_permission: ?BucketCountByEffectivePermission = null,

    /// The total number of buckets whose settings do or don't specify default
    /// server-side encryption behavior for objects that are added to the buckets.
    bucket_count_by_encryption_type: ?BucketCountByEncryptionType = null,

    /// The total number of buckets whose bucket policies do or don't require
    /// server-side encryption of objects when objects are added to the buckets.
    bucket_count_by_object_encryption_requirement: ?BucketCountPolicyAllowsUnencryptedObjectUploads = null,

    /// The total number of buckets that are or aren't shared with other Amazon Web
    /// Services accounts, Amazon CloudFront origin access identities (OAIs), or
    /// CloudFront origin access controls (OACs).
    bucket_count_by_shared_access_type: ?BucketCountBySharedAccessType = null,

    /// The aggregated sensitive data discovery statistics for the buckets. If
    /// automated sensitive data discovery is currently disabled for your account,
    /// the value for most statistics is 0.
    bucket_statistics_by_sensitivity: ?BucketStatisticsBySensitivity = null,

    /// The total number of objects that Amazon Macie can analyze in the buckets.
    /// These objects use a supported storage class and have a file name extension
    /// for a supported file or storage format.
    classifiable_object_count: ?i64 = null,

    /// The total storage size, in bytes, of all the objects that Amazon Macie can
    /// analyze in the buckets. These objects use a supported storage class and have
    /// a file name extension for a supported file or storage format.
    ///
    /// If versioning is enabled for any of the buckets, this value is based on the
    /// size of the latest version of each applicable object in the buckets. This
    /// value doesn't reflect the storage size of all versions of all applicable
    /// objects in the buckets.
    classifiable_size_in_bytes: ?i64 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when Amazon Macie
    /// most recently retrieved bucket or object metadata from Amazon S3 for the
    /// buckets.
    last_updated: ?i64 = null,

    /// The total number of objects in the buckets.
    object_count: ?i64 = null,

    /// The total storage size, in bytes, of the buckets.
    ///
    /// If versioning is enabled for any of the buckets, this value is based on the
    /// size of the latest version of each object in the buckets. This value doesn't
    /// reflect the storage size of all versions of the objects in the buckets.
    size_in_bytes: ?i64 = null,

    /// The total storage size, in bytes, of the objects that are compressed (.gz,
    /// .gzip, .zip) files in the buckets.
    ///
    /// If versioning is enabled for any of the buckets, this value is based on the
    /// size of the latest version of each applicable object in the buckets. This
    /// value doesn't reflect the storage size of all versions of the applicable
    /// objects in the buckets.
    size_in_bytes_compressed: ?i64 = null,

    /// The total number of objects that Amazon Macie can't analyze in the buckets.
    /// These objects don't use a supported storage class or don't have a file name
    /// extension for a supported file or storage format.
    unclassifiable_object_count: ?ObjectLevelStatistics = null,

    /// The total storage size, in bytes, of the objects that Amazon Macie can't
    /// analyze in the buckets. These objects don't use a supported storage class or
    /// don't have a file name extension for a supported file or storage format.
    unclassifiable_object_size_in_bytes: ?ObjectLevelStatistics = null,

    pub const json_field_names = .{
        .bucket_count = "bucketCount",
        .bucket_count_by_effective_permission = "bucketCountByEffectivePermission",
        .bucket_count_by_encryption_type = "bucketCountByEncryptionType",
        .bucket_count_by_object_encryption_requirement = "bucketCountByObjectEncryptionRequirement",
        .bucket_count_by_shared_access_type = "bucketCountBySharedAccessType",
        .bucket_statistics_by_sensitivity = "bucketStatisticsBySensitivity",
        .classifiable_object_count = "classifiableObjectCount",
        .classifiable_size_in_bytes = "classifiableSizeInBytes",
        .last_updated = "lastUpdated",
        .object_count = "objectCount",
        .size_in_bytes = "sizeInBytes",
        .size_in_bytes_compressed = "sizeInBytesCompressed",
        .unclassifiable_object_count = "unclassifiableObjectCount",
        .unclassifiable_object_size_in_bytes = "unclassifiableObjectSizeInBytes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBucketStatisticsInput, options: CallOptions) !GetBucketStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBucketStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/datasources/s3/statistics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBucketStatisticsOutput {
    var result: GetBucketStatisticsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBucketStatisticsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
