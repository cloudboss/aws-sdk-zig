const AclConfiguration = @import("acl_configuration.zig").AclConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

/// The location in Amazon S3 where query and calculation results are stored and
/// the encryption option, if any, used for query and calculation results. These
/// are known
/// as "client-side settings". If workgroup settings override client-side
/// settings, then the
/// query uses the workgroup settings.
pub const ResultConfiguration = struct {
    /// Indicates that an Amazon S3 canned ACL should be set to control ownership of
    /// stored query results. Currently the only supported canned ACL is
    /// `BUCKET_OWNER_FULL_CONTROL`. This is a client-side setting. If workgroup
    /// settings override client-side settings, then the query uses the ACL
    /// configuration that
    /// is specified for the workgroup, and also uses the location for storing query
    /// results
    /// specified in the workgroup. For more information, see
    /// WorkGroupConfiguration$EnforceWorkGroupConfiguration and [Workgroup Settings
    /// Override Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    acl_configuration: ?AclConfiguration,

    /// If query and calculation results are encrypted in Amazon S3, indicates the
    /// encryption option used (for example, `SSE_KMS` or `CSE_KMS`) and
    /// key information. This is a client-side setting. If workgroup settings
    /// override
    /// client-side settings, then the query uses the encryption configuration that
    /// is specified
    /// for the workgroup, and also uses the location for storing query results
    /// specified in the
    /// workgroup. See WorkGroupConfiguration$EnforceWorkGroupConfiguration
    /// and [Workgroup Settings Override Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    encryption_configuration: ?EncryptionConfiguration,

    /// The Amazon Web Services account ID that you expect to be the owner of the
    /// Amazon S3 bucket specified by ResultConfiguration$OutputLocation.
    /// If set, Athena uses the value for `ExpectedBucketOwner` when it
    /// makes Amazon S3 calls to your specified output location. If the
    /// `ExpectedBucketOwner`
    /// Amazon Web Services account ID does not match the actual owner of the Amazon
    /// S3
    /// bucket, the call fails with a permissions error.
    ///
    /// This is a client-side setting. If workgroup settings override client-side
    /// settings,
    /// then the query uses the `ExpectedBucketOwner` setting that is specified for
    /// the workgroup, and also uses the location for storing query results
    /// specified in the
    /// workgroup. See WorkGroupConfiguration$EnforceWorkGroupConfiguration
    /// and [Workgroup Settings Override Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    expected_bucket_owner: ?[]const u8,

    /// The location in Amazon S3 where your query and calculation results are
    /// stored,
    /// such as `s3://path/to/query/bucket/`. To run the query, you must specify the
    /// query results location using one of the ways: either for individual queries
    /// using either
    /// this setting (client-side), or in the workgroup, using
    /// WorkGroupConfiguration. If none of them is set, Athena
    /// issues an error that no output location is provided. If workgroup settings
    /// override
    /// client-side settings, then the query uses the settings specified for the
    /// workgroup. See
    /// WorkGroupConfiguration$EnforceWorkGroupConfiguration.
    output_location: ?[]const u8,

    pub const json_field_names = .{
        .acl_configuration = "AclConfiguration",
        .encryption_configuration = "EncryptionConfiguration",
        .expected_bucket_owner = "ExpectedBucketOwner",
        .output_location = "OutputLocation",
    };
};
