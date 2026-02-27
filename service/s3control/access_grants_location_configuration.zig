/// The configuration options of the S3 Access Grants location. It contains the
/// `S3SubPrefix` field. The grant scope, the data to which you are granting
/// access, is the result of appending the `Subprefix` field to the scope of the
/// registered location.
pub const AccessGrantsLocationConfiguration = struct {
    /// The `S3SubPrefix` is appended to the location scope creating the grant
    /// scope. Use this field to narrow the scope of the grant to a subset of the
    /// location scope. This field is required if the location scope is the default
    /// location `s3://` because you cannot create a grant for all of your S3 data
    /// in the Region and must narrow the scope. For example, if the location scope
    /// is the default location `s3://`, the `S3SubPrefx` can be a /*, so the full
    /// grant scope path would be `s3:///*`. Or the `S3SubPrefx` can be `/*`, so the
    /// full grant scope path would be or `s3:///*`.
    ///
    /// If the `S3SubPrefix` includes a prefix, append the wildcard character `*`
    /// after the prefix to indicate that you want to include all object key names
    /// in the bucket that start with that prefix.
    s3_sub_prefix: ?[]const u8,
};
