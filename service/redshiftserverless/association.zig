/// An object that represents the custom domain name association.
pub const Association = struct {
    /// The custom domain name’s certificate Amazon resource name (ARN).
    custom_domain_certificate_arn: ?[]const u8,

    /// The expiration time for the certificate.
    custom_domain_certificate_expiry_time: ?i64,

    /// The custom domain name associated with the workgroup.
    custom_domain_name: ?[]const u8,

    /// The name of the workgroup associated with the database.
    workgroup_name: ?[]const u8,

    pub const json_field_names = .{
        .custom_domain_certificate_arn = "customDomainCertificateArn",
        .custom_domain_certificate_expiry_time = "customDomainCertificateExpiryTime",
        .custom_domain_name = "customDomainName",
        .workgroup_name = "workgroupName",
    };
};
