/// The container element for object ownership for a bucket's ownership
/// controls.
///
/// `BucketOwnerPreferred` - Objects uploaded to the bucket change ownership to
/// the bucket
/// owner if the objects are uploaded with the `bucket-owner-full-control`
/// canned ACL.
///
/// `ObjectWriter` - The uploading account will own the object if the object is
/// uploaded with
/// the `bucket-owner-full-control` canned ACL.
///
/// `BucketOwnerEnforced` - Access control lists (ACLs) are disabled and no
/// longer affect
/// permissions. The bucket owner automatically owns and has full control over
/// every object in the bucket.
/// The bucket only accepts PUT requests that don't specify an ACL or specify
/// bucket owner full control ACLs
/// (such as the predefined `bucket-owner-full-control` canned ACL or a custom
/// ACL in XML format
/// that grants the same permissions).
///
/// By default, `ObjectOwnership` is set to `BucketOwnerEnforced` and ACLs are
/// disabled. We recommend keeping ACLs disabled, except in uncommon use cases
/// where you must control access
/// for each object individually. For more information about S3 Object
/// Ownership, see [Controlling
/// ownership of objects and disabling ACLs for your
/// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html) in the
/// *Amazon S3 User Guide*.
///
/// This functionality is not supported for directory buckets. Directory buckets
/// use the bucket owner enforced setting for S3 Object Ownership.
pub const ObjectOwnership = enum {
    bucket_owner_preferred,
    object_writer,
    bucket_owner_enforced,
};
