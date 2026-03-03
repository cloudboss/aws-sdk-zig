const AccessType = @import("access_type.zig").AccessType;

/// Describes the anonymous access permissions for an Amazon Lightsail bucket
/// and its
/// objects.
///
/// For more information about bucket access permissions, see [Understanding
/// bucket permissions in Amazon
/// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-understanding-bucket-permissions) in the
///
/// *Amazon Lightsail Developer Guide*.
pub const AccessRules = struct {
    /// A Boolean value that indicates whether the access control list (ACL)
    /// permissions that are
    /// applied to individual objects override the `getObject` option that is
    /// currently
    /// specified.
    ///
    /// When this is true, you can use the
    /// [PutObjectAcl](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObjectAcl.html) Amazon S3 API action to set
    /// individual objects to public (read-only) using the `public-read` ACL, or to
    /// private
    /// using the `private` ACL.
    allow_public_overrides: ?bool = null,

    /// Specifies the anonymous access to all objects in a bucket.
    ///
    /// The following options can be specified:
    ///
    /// * `public` - Sets all objects in the bucket to public (read-only), making
    /// them readable by anyone in the world.
    ///
    /// If the `getObject` value is set to `public`, then all objects in
    /// the bucket default to public regardless of the `allowPublicOverrides`
    /// value.
    ///
    /// * `private` - Sets all objects in the bucket to private, making them
    ///   readable
    /// only by you or anyone you give access to.
    ///
    /// If the `getObject` value is set to `private`, and the
    /// `allowPublicOverrides` value is set to `true`, then all objects in
    /// the bucket default to private unless they are configured with a
    /// `public-read`
    /// ACL. Individual objects with a `public-read` ACL are readable by anyone in
    /// the
    /// world.
    get_object: ?AccessType = null,

    pub const json_field_names = .{
        .allow_public_overrides = "allowPublicOverrides",
        .get_object = "getObject",
    };
};
