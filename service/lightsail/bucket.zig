const BucketAccessLogConfig = @import("bucket_access_log_config.zig").BucketAccessLogConfig;
const AccessRules = @import("access_rules.zig").AccessRules;
const BucketCorsConfig = @import("bucket_cors_config.zig").BucketCorsConfig;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceReceivingAccess = @import("resource_receiving_access.zig").ResourceReceivingAccess;
const BucketState = @import("bucket_state.zig").BucketState;
const Tag = @import("tag.zig").Tag;

/// Describes an Amazon Lightsail bucket.
pub const Bucket = struct {
    /// Indicates whether the bundle that is currently applied to a bucket can be
    /// changed to
    /// another bundle.
    ///
    /// You can update a bucket's bundle only one time within a monthly Amazon Web
    /// Services billing
    /// cycle.
    ///
    /// Use the
    /// [UpdateBucketBundle](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_UpdateBucketBundle.html) action to change a
    /// bucket's bundle.
    able_to_update_bundle: ?bool,

    /// An object that describes the access log configuration for the bucket.
    access_log_config: ?BucketAccessLogConfig,

    /// An object that describes the access rules of the bucket.
    access_rules: ?AccessRules,

    /// The Amazon Resource Name (ARN) of the bucket.
    arn: ?[]const u8,

    /// The ID of the bundle currently applied to the bucket.
    ///
    /// A bucket bundle specifies the monthly cost, storage space, and data transfer
    /// quota for a
    /// bucket.
    ///
    /// Use the
    /// [UpdateBucketBundle](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_UpdateBucketBundle.html) action to change the
    /// bundle of a bucket.
    bundle_id: ?[]const u8,

    /// An array of cross-origin resource sharing (CORS) rules that identify origins
    /// and the HTTP methods that can be executed on your bucket. This field is only
    /// included in the response when CORS configuration is requested or when
    /// updating CORS configuration. For more information, see [Configuring
    /// cross-origin resource sharing
    /// (CORS)](https://docs.aws.amazon.com/lightsail/latest/userguide/configure-cors.html).
    cors: ?BucketCorsConfig,

    /// The timestamp when the distribution was created.
    created_at: ?i64,

    /// An object that describes the location of the bucket, such as the Amazon Web
    /// Services Region
    /// and Availability Zone.
    location: ?ResourceLocation,

    /// The name of the bucket.
    name: ?[]const u8,

    /// Indicates whether object versioning is enabled for the bucket.
    ///
    /// The following options can be configured:
    ///
    /// * `Enabled` - Object versioning is enabled.
    ///
    /// * `Suspended` - Object versioning was previously enabled but is currently
    /// suspended. Existing object versions are retained.
    ///
    /// * `NeverEnabled` - Object versioning has never been enabled.
    object_versioning: ?[]const u8,

    /// An array of strings that specify the Amazon Web Services account IDs that
    /// have read-only
    /// access to the bucket.
    readonly_access_accounts: ?[]const []const u8,

    /// An array of objects that describe Lightsail instances that have access to
    /// the
    /// bucket.
    ///
    /// Use the
    /// [SetResourceAccessForBucket](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_SetResourceAccessForBucket.html)
    /// action to update the instances that have access to a bucket.
    resources_receiving_access: ?[]const ResourceReceivingAccess,

    /// The Lightsail resource type of the bucket.
    resource_type: ?[]const u8,

    /// An object that describes the state of the bucket.
    state: ?BucketState,

    /// The support code for a bucket. Include this code in your email to support
    /// when you have
    /// questions about a Lightsail bucket. This code enables our support team to
    /// look up your
    /// Lightsail information more easily.
    support_code: ?[]const u8,

    /// The tag keys and optional values for the bucket. For more information, see
    /// [Tags in
    /// Amazon
    /// Lightsail](https://lightsail.aws.amazon.com/ls/docs/en/articles/amazon-lightsail-tags) in the *Amazon Lightsail Developer Guide*.
    tags: ?[]const Tag,

    /// The URL of the bucket.
    url: ?[]const u8,

    pub const json_field_names = .{
        .able_to_update_bundle = "ableToUpdateBundle",
        .access_log_config = "accessLogConfig",
        .access_rules = "accessRules",
        .arn = "arn",
        .bundle_id = "bundleId",
        .cors = "cors",
        .created_at = "createdAt",
        .location = "location",
        .name = "name",
        .object_versioning = "objectVersioning",
        .readonly_access_accounts = "readonlyAccessAccounts",
        .resources_receiving_access = "resourcesReceivingAccess",
        .resource_type = "resourceType",
        .state = "state",
        .support_code = "supportCode",
        .tags = "tags",
        .url = "url",
    };
};
