const AclConfiguration = @import("acl_configuration.zig").AclConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

/// The information about the updates in the query results, such as output
/// location and
/// encryption configuration for the query results.
pub const ResultConfigurationUpdates = struct {
    /// The ACL configuration for the query results.
    acl_configuration: ?AclConfiguration,

    /// The encryption configuration for query and calculation results.
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
    /// If workgroup settings override client-side settings, then the query uses the
    /// `ExpectedBucketOwner` setting that is specified for the workgroup, and
    /// also uses the location for storing query results specified in the workgroup.
    /// See WorkGroupConfiguration$EnforceWorkGroupConfiguration and [Workgroup
    /// Settings Override Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    expected_bucket_owner: ?[]const u8,

    /// The location in Amazon S3 where your query and calculation results are
    /// stored,
    /// such as `s3://path/to/query/bucket/`. If workgroup settings override
    /// client-side settings, then the query uses the location for the query results
    /// and the
    /// encryption configuration that are specified for the workgroup. The
    /// "workgroup settings
    /// override" is specified in `EnforceWorkGroupConfiguration` (true/false) in
    /// the
    /// `WorkGroupConfiguration`. See
    /// WorkGroupConfiguration$EnforceWorkGroupConfiguration.
    output_location: ?[]const u8,

    /// If set to `true`, indicates that the previously-specified ACL configuration
    /// for queries in this workgroup should be ignored and set to null. If set to
    /// `false` or not set, and a value is present in the
    /// `AclConfiguration` of `ResultConfigurationUpdates`, the
    /// `AclConfiguration` in the workgroup's `ResultConfiguration` is
    /// updated with the new value. For more information, see [Workgroup Settings
    /// Override
    /// Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    remove_acl_configuration: ?bool,

    /// If set to "true", indicates that the previously-specified encryption
    /// configuration
    /// (also known as the client-side setting) for queries in this workgroup should
    /// be ignored
    /// and set to null. If set to "false" or not set, and a value is present in the
    /// `EncryptionConfiguration` in `ResultConfigurationUpdates` (the
    /// client-side setting), the `EncryptionConfiguration` in the workgroup's
    /// `ResultConfiguration` will be updated with the new value. For more
    /// information, see [Workgroup Settings Override
    /// Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    remove_encryption_configuration: ?bool,

    /// If set to "true", removes the Amazon Web Services account ID previously
    /// specified for
    /// ResultConfiguration$ExpectedBucketOwner. If set to "false" or not
    /// set, and a value is present in the `ExpectedBucketOwner` in
    /// `ResultConfigurationUpdates` (the client-side setting), the
    /// `ExpectedBucketOwner` in the workgroup's `ResultConfiguration`
    /// is updated with the new value. For more information, see [Workgroup Settings
    /// Override
    /// Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    remove_expected_bucket_owner: ?bool,

    /// If set to "true", indicates that the previously-specified query results
    /// location (also
    /// known as a client-side setting) for queries in this workgroup should be
    /// ignored and set
    /// to null. If set to "false" or not set, and a value is present in the
    /// `OutputLocation` in `ResultConfigurationUpdates` (the
    /// client-side setting), the `OutputLocation` in the workgroup's
    /// `ResultConfiguration` will be updated with the new value. For more
    /// information, see [Workgroup Settings Override
    /// Client-Side
    /// Settings](https://docs.aws.amazon.com/athena/latest/ug/workgroups-settings-override.html).
    remove_output_location: ?bool,

    pub const json_field_names = .{
        .acl_configuration = "AclConfiguration",
        .encryption_configuration = "EncryptionConfiguration",
        .expected_bucket_owner = "ExpectedBucketOwner",
        .output_location = "OutputLocation",
        .remove_acl_configuration = "RemoveAclConfiguration",
        .remove_encryption_configuration = "RemoveEncryptionConfiguration",
        .remove_expected_bucket_owner = "RemoveExpectedBucketOwner",
        .remove_output_location = "RemoveOutputLocation",
    };
};
