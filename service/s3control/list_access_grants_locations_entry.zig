/// A container for information about the registered location.
pub const ListAccessGrantsLocationsEntry = struct {
    /// The Amazon Resource Name (ARN) of the registered location.
    access_grants_location_arn: ?[]const u8 = null,

    /// The ID of the registered location to which you are granting access. S3
    /// Access Grants assigns this ID when you register the location. S3 Access
    /// Grants assigns the ID `default` to the default location `s3://` and assigns
    /// an auto-generated ID to other locations that you register.
    access_grants_location_id: ?[]const u8 = null,

    /// The date and time when you registered the location.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the IAM role for the registered location.
    /// S3 Access Grants assumes this role to manage access to the registered
    /// location.
    iam_role_arn: ?[]const u8 = null,

    /// The S3 path to the location that you are registering. The location scope can
    /// be the default S3 location `s3://`, the S3 path to a bucket `s3://`, or the
    /// S3 path to a bucket and prefix `s3:///`. A prefix in S3 is a string of
    /// characters at the beginning of an object key name used to organize the
    /// objects that you store in your S3 buckets. For example, object key names
    /// that start with the `engineering/` prefix or object key names that start
    /// with the `marketing/campaigns/` prefix.
    location_scope: ?[]const u8 = null,
};
