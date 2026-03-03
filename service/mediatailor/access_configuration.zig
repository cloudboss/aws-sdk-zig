const AccessType = @import("access_type.zig").AccessType;
const SecretsManagerAccessTokenConfiguration = @import("secrets_manager_access_token_configuration.zig").SecretsManagerAccessTokenConfiguration;

/// Access configuration parameters.
pub const AccessConfiguration = struct {
    /// The type of authentication used to access content from
    /// `HttpConfiguration::BaseUrl` on your source location.
    ///
    /// `S3_SIGV4` - AWS Signature Version 4 authentication for Amazon S3 hosted
    /// virtual-style access. If your source location base URL is an Amazon S3
    /// bucket, MediaTailor can use AWS Signature Version 4 (SigV4) authentication
    /// to access the bucket where your source content is stored. Your MediaTailor
    /// source location baseURL must follow the S3 virtual hosted-style request URL
    /// format. For example, https://bucket-name.s3.Region.amazonaws.com/key-name.
    ///
    /// Before you can use `S3_SIGV4`, you must meet these requirements:
    ///
    /// • You must allow MediaTailor to access your S3 bucket by granting
    /// mediatailor.amazonaws.com principal access in IAM. For information about
    /// configuring access in IAM, see Access management in the IAM User Guide.
    ///
    /// • The mediatailor.amazonaws.com service principal must have permissions to
    /// read all top level manifests referenced by the VodSource packaging
    /// configurations.
    ///
    /// • The caller of the API must have s3:GetObject IAM permissions to read all
    /// top level manifests referenced by your MediaTailor VodSource packaging
    /// configurations.
    ///
    /// `AUTODETECT_SIGV4` - AWS Signature Version 4 authentication for a set of
    /// supported services: MediaPackage Version 2 and Amazon S3 hosted
    /// virtual-style access. If your source location base URL is a MediaPackage
    /// Version 2 endpoint or an Amazon S3 bucket, MediaTailor can use AWS Signature
    /// Version 4 (SigV4) authentication to access the resource where your source
    /// content is stored.
    ///
    /// Before you can use `AUTODETECT_SIGV4` with a MediaPackage Version 2
    /// endpoint, you must meet these requirements:
    ///
    /// • You must grant MediaTailor access to your MediaPackage endpoint by
    /// granting `mediatailor.amazonaws.com` principal access in an Origin Access
    /// policy on the endpoint.
    ///
    /// • Your MediaTailor source location base URL must be a MediaPackage V2
    /// endpoint.
    ///
    /// • The caller of the API must have `mediapackagev2:GetObject` IAM permissions
    /// to read all top level manifests referenced by the MediaTailor source
    /// packaging configurations.
    ///
    /// Before you can use `AUTODETECT_SIGV4` with an Amazon S3 bucket, you must
    /// meet these requirements:
    ///
    /// • You must grant MediaTailor access to your S3 bucket by granting
    /// `mediatailor.amazonaws.com` principal access in IAM. For more information
    /// about configuring access in IAM, see [Access
    /// management](https://docs.aws.amazon.com/IAM/latest/UserGuide/access.html) in
    /// the *IAM User Guide.*.
    ///
    /// • The `mediatailor.amazonaws.com` service principal must have permissions to
    /// read all top-level manifests referenced by the `VodSource` packaging
    /// configurations.
    ///
    /// • The caller of the API must have `s3:GetObject` IAM permissions to read all
    /// top level manifests referenced by your MediaTailor `VodSource` packaging
    /// configurations.
    access_type: ?AccessType = null,

    /// AWS Secrets Manager access token configuration parameters.
    secrets_manager_access_token_configuration: ?SecretsManagerAccessTokenConfiguration = null,

    pub const json_field_names = .{
        .access_type = "AccessType",
        .secrets_manager_access_token_configuration = "SecretsManagerAccessTokenConfiguration",
    };
};
