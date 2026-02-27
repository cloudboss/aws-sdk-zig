/// You specify each grantee as a type-value pair using one of these types. You
/// can specify only one type of grantee. For more information, see
/// [PutBucketAcl](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketAcl.html).
pub const AclGrantee = union(enum) {
    /// The value specified is the canonical user ID of an Amazon Web Services
    /// account.
    id: ?[]const u8,
    /// Used for granting permissions to a predefined group.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .uri = "uri",
    };
};
