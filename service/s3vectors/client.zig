const aws = @import("aws");
const std = @import("std");

const create_index = @import("create_index.zig");
const create_vector_bucket = @import("create_vector_bucket.zig");
const delete_index = @import("delete_index.zig");
const delete_vector_bucket = @import("delete_vector_bucket.zig");
const delete_vector_bucket_policy = @import("delete_vector_bucket_policy.zig");
const delete_vectors = @import("delete_vectors.zig");
const get_index = @import("get_index.zig");
const get_vector_bucket = @import("get_vector_bucket.zig");
const get_vector_bucket_policy = @import("get_vector_bucket_policy.zig");
const get_vectors = @import("get_vectors.zig");
const list_indexes = @import("list_indexes.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_vector_buckets = @import("list_vector_buckets.zig");
const list_vectors = @import("list_vectors.zig");
const put_vector_bucket_policy = @import("put_vector_bucket_policy.zig");
const put_vectors = @import("put_vectors.zig");
const query_vectors = @import("query_vectors.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "S3Vectors";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a vector index within a vector bucket. To specify the vector bucket,
    /// you must use either the vector bucket name or the vector bucket Amazon
    /// Resource Name (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:CreateIndex` permission to use this operation.
    ///
    /// You must have the `s3vectors:TagResource` permission in addition to
    /// `s3vectors:CreateIndex` permission to create a vector index with tags.
    pub fn createIndex(self: *Self, allocator: std.mem.Allocator, input: create_index.CreateIndexInput, options: CallOptions) !create_index.CreateIndexOutput {
        return create_index.execute(self, allocator, input, options);
    }

    /// Creates a vector bucket in the Amazon Web Services Region that you want your
    /// bucket to be in.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:CreateVectorBucket` permission to use this
    /// operation.
    ///
    /// You must have the `s3vectors:TagResource` permission in addition to
    /// `s3vectors:CreateVectorBucket` permission to create a vector bucket with
    /// tags.
    pub fn createVectorBucket(self: *Self, allocator: std.mem.Allocator, input: create_vector_bucket.CreateVectorBucketInput, options: CallOptions) !create_vector_bucket.CreateVectorBucketOutput {
        return create_vector_bucket.execute(self, allocator, input, options);
    }

    /// Deletes a vector index. To specify the vector index, you can either use both
    /// the vector bucket name and vector index name, or use the vector index Amazon
    /// Resource Name (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:DeleteIndex` permission to use this operation.
    pub fn deleteIndex(self: *Self, allocator: std.mem.Allocator, input: delete_index.DeleteIndexInput, options: CallOptions) !delete_index.DeleteIndexOutput {
        return delete_index.execute(self, allocator, input, options);
    }

    /// Deletes a vector bucket. All vector indexes in the vector bucket must be
    /// deleted before the vector bucket can be deleted. To perform this operation,
    /// you must use either the vector bucket name or the vector bucket Amazon
    /// Resource Name (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:DeleteVectorBucket` permission to use this
    /// operation.
    pub fn deleteVectorBucket(self: *Self, allocator: std.mem.Allocator, input: delete_vector_bucket.DeleteVectorBucketInput, options: CallOptions) !delete_vector_bucket.DeleteVectorBucketOutput {
        return delete_vector_bucket.execute(self, allocator, input, options);
    }

    /// Deletes a vector bucket policy. To specify the bucket, you must use either
    /// the vector bucket name or the vector bucket Amazon Resource Name (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:DeleteVectorBucketPolicy` permission to use
    /// this operation.
    pub fn deleteVectorBucketPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_vector_bucket_policy.DeleteVectorBucketPolicyInput, options: CallOptions) !delete_vector_bucket_policy.DeleteVectorBucketPolicyOutput {
        return delete_vector_bucket_policy.execute(self, allocator, input, options);
    }

    /// Deletes one or more vectors in a vector index. To specify the vector index,
    /// you can either use both the vector bucket name and vector index name, or use
    /// the vector index Amazon Resource Name (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:DeleteVectors` permission to use this
    /// operation.
    pub fn deleteVectors(self: *Self, allocator: std.mem.Allocator, input: delete_vectors.DeleteVectorsInput, options: CallOptions) !delete_vectors.DeleteVectorsOutput {
        return delete_vectors.execute(self, allocator, input, options);
    }

    /// Returns vector index attributes. To specify the vector index, you can either
    /// use both the vector bucket name and the vector index name, or use the vector
    /// index Amazon Resource Name (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:GetIndex` permission to use this operation.
    pub fn getIndex(self: *Self, allocator: std.mem.Allocator, input: get_index.GetIndexInput, options: CallOptions) !get_index.GetIndexOutput {
        return get_index.execute(self, allocator, input, options);
    }

    /// Returns vector bucket attributes. To specify the bucket, you must use either
    /// the vector bucket name or the vector bucket Amazon Resource Name (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:GetVectorBucket` permission to use this
    /// operation.
    pub fn getVectorBucket(self: *Self, allocator: std.mem.Allocator, input: get_vector_bucket.GetVectorBucketInput, options: CallOptions) !get_vector_bucket.GetVectorBucketOutput {
        return get_vector_bucket.execute(self, allocator, input, options);
    }

    /// Gets details about a vector bucket policy. To specify the bucket, you must
    /// use either the vector bucket name or the vector bucket Amazon Resource Name
    /// (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:GetVectorBucketPolicy` permission to use this
    /// operation.
    pub fn getVectorBucketPolicy(self: *Self, allocator: std.mem.Allocator, input: get_vector_bucket_policy.GetVectorBucketPolicyInput, options: CallOptions) !get_vector_bucket_policy.GetVectorBucketPolicyOutput {
        return get_vector_bucket_policy.execute(self, allocator, input, options);
    }

    /// Returns vector attributes. To specify the vector index, you can either use
    /// both the vector bucket name and the vector index name, or use the vector
    /// index Amazon Resource Name (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:GetVectors` permission to use this operation.
    pub fn getVectors(self: *Self, allocator: std.mem.Allocator, input: get_vectors.GetVectorsInput, options: CallOptions) !get_vectors.GetVectorsOutput {
        return get_vectors.execute(self, allocator, input, options);
    }

    /// Returns a list of all the vector indexes within the specified vector bucket.
    /// To specify the bucket, you must use either the vector bucket name or the
    /// vector bucket Amazon Resource Name (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:ListIndexes` permission to use this operation.
    pub fn listIndexes(self: *Self, allocator: std.mem.Allocator, input: list_indexes.ListIndexesInput, options: CallOptions) !list_indexes.ListIndexesOutput {
        return list_indexes.execute(self, allocator, input, options);
    }

    /// Lists all of the tags applied to a specified Amazon S3 Vectors resource.
    /// Each tag is a label consisting of a key and value pair. Tags can help you
    /// organize, track costs for, and control access to resources.
    ///
    /// For a list of S3 resources that support tagging, see [Managing tags for
    /// Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html#manage-tags).
    ///
    /// **Permissions**
    ///
    /// For vector buckets and vector indexes, you must have the
    /// `s3vectors:ListTagsForResource` permission to use this operation.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of all the vector buckets that are owned by the authenticated
    /// sender of the request.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:ListVectorBuckets` permission to use this
    /// operation.
    pub fn listVectorBuckets(self: *Self, allocator: std.mem.Allocator, input: list_vector_buckets.ListVectorBucketsInput, options: CallOptions) !list_vector_buckets.ListVectorBucketsOutput {
        return list_vector_buckets.execute(self, allocator, input, options);
    }

    /// List vectors in the specified vector index. To specify the vector index, you
    /// can either use both the vector bucket name and the vector index name, or use
    /// the vector index Amazon Resource Name (ARN).
    ///
    /// `ListVectors` operations proceed sequentially; however, for faster
    /// performance on a large number of vectors in a vector index, applications can
    /// request a parallel `ListVectors` operation by providing the `segmentCount`
    /// and `segmentIndex` parameters.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:ListVectors` permission to use this operation.
    /// Additional permissions are required based on the request parameters you
    /// specify:
    ///
    /// * With only `s3vectors:ListVectors` permission, you can list vector keys
    ///   when `returnData` and `returnMetadata` are both set to false or not
    ///   specified..
    /// * If you set `returnData` or `returnMetadata` to true, you must have both
    ///   `s3vectors:ListVectors` and `s3vectors:GetVectors` permissions. The
    ///   request fails with a `403 Forbidden` error if you request vector data or
    ///   metadata without the `s3vectors:GetVectors` permission.
    pub fn listVectors(self: *Self, allocator: std.mem.Allocator, input: list_vectors.ListVectorsInput, options: CallOptions) !list_vectors.ListVectorsOutput {
        return list_vectors.execute(self, allocator, input, options);
    }

    /// Creates a bucket policy for a vector bucket. To specify the bucket, you must
    /// use either the vector bucket name or the vector bucket Amazon Resource Name
    /// (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:PutVectorBucketPolicy` permission to use this
    /// operation.
    pub fn putVectorBucketPolicy(self: *Self, allocator: std.mem.Allocator, input: put_vector_bucket_policy.PutVectorBucketPolicyInput, options: CallOptions) !put_vector_bucket_policy.PutVectorBucketPolicyOutput {
        return put_vector_bucket_policy.execute(self, allocator, input, options);
    }

    /// Adds one or more vectors to a vector index. To specify the vector index, you
    /// can either use both the vector bucket name and the vector index name, or use
    /// the vector index Amazon Resource Name (ARN).
    ///
    /// For more information about limits, see [Limitations and
    /// restrictions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-vectors-limitations.html) in the *Amazon S3 User Guide*.
    ///
    /// When inserting vector data into your vector index, you must provide the
    /// vector data as `float32` (32-bit floating point) values. If you pass
    /// higher-precision values to an Amazon Web Services SDK, S3 Vectors converts
    /// the values to 32-bit floating point before storing them, and `GetVectors`,
    /// `ListVectors`, and `QueryVectors` operations return the float32 values.
    /// Different Amazon Web Services SDKs may have different default numeric types,
    /// so ensure your vectors are properly formatted as `float32` values regardless
    /// of which SDK you're using. For example, in Python, use `numpy.float32` or
    /// explicitly cast your values.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:PutVectors` permission to use this operation.
    pub fn putVectors(self: *Self, allocator: std.mem.Allocator, input: put_vectors.PutVectorsInput, options: CallOptions) !put_vectors.PutVectorsOutput {
        return put_vectors.execute(self, allocator, input, options);
    }

    /// Performs an approximate nearest neighbor search query in a vector index
    /// using a query vector. By default, it returns the keys of approximate nearest
    /// neighbors. You can optionally include the computed distance (between the
    /// query vector and each vector in the response), the vector data, and metadata
    /// of each vector in the response.
    ///
    /// To specify the vector index, you can either use both the vector bucket name
    /// and the vector index name, or use the vector index Amazon Resource Name
    /// (ARN).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3vectors:QueryVectors` permission to use this operation.
    /// Additional permissions are required based on the request parameters you
    /// specify:
    ///
    /// * With only `s3vectors:QueryVectors` permission, you can retrieve vector
    ///   keys of approximate nearest neighbors and computed distances between these
    ///   vectors. This permission is sufficient only when you don't set any
    ///   metadata filters and don't request vector data or metadata (by keeping the
    ///   `returnMetadata` parameter set to `false` or not specified).
    /// * If you specify a metadata filter or set `returnMetadata` to true, you must
    ///   have both `s3vectors:QueryVectors` and `s3vectors:GetVectors` permissions.
    ///   The request fails with a `403 Forbidden error` if you request metadata
    ///   filtering, vector data, or metadata without the `s3vectors:GetVectors`
    ///   permission.
    pub fn queryVectors(self: *Self, allocator: std.mem.Allocator, input: query_vectors.QueryVectorsInput, options: CallOptions) !query_vectors.QueryVectorsOutput {
        return query_vectors.execute(self, allocator, input, options);
    }

    /// Applies one or more user-defined tags to an Amazon S3 Vectors resource or
    /// updates existing tags. Each tag is a label consisting of a key and value
    /// pair. Tags can help you organize, track costs for, and control access to
    /// your resources. You can add up to 50 tags for each resource.
    ///
    /// For a list of S3 resources that support tagging, see [Managing tags for
    /// Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html#manage-tags).
    ///
    /// **Permissions**
    ///
    /// For vector buckets and vector indexes, you must have the
    /// `s3vectors:TagResource` permission to use this operation.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified user-defined tags from an Amazon S3 Vectors resource.
    /// You can pass one or more tag keys.
    ///
    /// For a list of S3 resources that support tagging, see [Managing tags for
    /// Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html#manage-tags).
    ///
    /// **Permissions**
    ///
    /// For vector buckets and vector indexes, you must have the
    /// `s3vectors:UntagResource` permission to use this operation.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listIndexesPaginator(self: *Self, params: list_indexes.ListIndexesInput) paginator.ListIndexesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVectorBucketsPaginator(self: *Self, params: list_vector_buckets.ListVectorBucketsInput) paginator.ListVectorBucketsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVectorsPaginator(self: *Self, params: list_vectors.ListVectorsInput) paginator.ListVectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
