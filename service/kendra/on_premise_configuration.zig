const S3Path = @import("s3_path.zig").S3Path;

/// Provides the configuration information to connect to GitHub Enterprise
/// Server (on
/// premises).
pub const OnPremiseConfiguration = struct {
    /// The GitHub host URL or API endpoint URL. For example,
    /// *https://on-prem-host-url/api/v3/*
    host_url: []const u8,

    /// The name of the organization of the GitHub Enterprise Server (on-premises)
    /// account you
    /// want to connect to. You can find your organization name by logging into
    /// GitHub desktop
    /// and selecting **Your organizations** under your profile
    /// picture dropdown.
    organization_name: []const u8,

    /// The path to the SSL certificate stored in an Amazon S3 bucket. You use this
    /// to
    /// connect to GitHub if you require a secure SSL connection.
    ///
    /// You can simply generate a self-signed X509 certificate on any computer using
    /// OpenSSL.
    /// For an example of using OpenSSL to create an X509 certificate, see [Create
    /// and sign an X509
    /// certificate](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/configuring-https-ssl.html).
    ssl_certificate_s3_path: S3Path,

    pub const json_field_names = .{
        .host_url = "HostUrl",
        .organization_name = "OrganizationName",
        .ssl_certificate_s3_path = "SslCertificateS3Path",
    };
};
