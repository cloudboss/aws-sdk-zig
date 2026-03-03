/// The mutual TLS authentication configuration for a custom domain name. If
/// specified, API Gateway
/// performs two-way authentication between the client and the server. Clients
/// must present a
/// trusted certificate to access your API.
pub const MutualTlsAuthentication = struct {
    /// An Amazon S3 URL that specifies the truststore for mutual TLS
    /// authentication, for example
    /// `s3://bucket-name/key-name`. The truststore can contain certificates from
    /// public or private
    /// certificate authorities. To update the truststore, upload a new version to
    /// S3, and then update
    /// your custom domain name to use the new version. To update the truststore,
    /// you must have
    /// permissions to access the S3 object.
    truststore_uri: ?[]const u8 = null,

    /// The version of the S3 object that contains your truststore. To specify a
    /// version, you must have versioning enabled for the S3 bucket.
    truststore_version: ?[]const u8 = null,

    /// A list of warnings that API Gateway returns while processing your
    /// truststore. Invalid
    /// certificates produce warnings. Mutual TLS is still enabled, but some clients
    /// might not be able
    /// to access your API. To resolve warnings, upload a new truststore to S3, and
    /// then update you
    /// domain name to use the new version.
    truststore_warnings: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .truststore_uri = "truststoreUri",
        .truststore_version = "truststoreVersion",
        .truststore_warnings = "truststoreWarnings",
    };
};
