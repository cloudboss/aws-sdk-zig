const TlsCertificateData = @import("tls_certificate_data.zig").TlsCertificateData;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const Tag = @import("tag.zig").Tag;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// The high-level properties of a TLS inspection configuration. This, along
/// with the `TLSInspectionConfiguration`, define the TLS inspection
/// configuration. You can retrieve all objects for a TLS inspection
/// configuration by calling `DescribeTLSInspectionConfiguration`.
pub const TLSInspectionConfigurationResponse = struct {
    certificate_authority: ?TlsCertificateData = null,

    /// A list of the certificates associated with the TLS inspection configuration.
    certificates: ?[]const TlsCertificateData = null,

    /// A description of the TLS inspection configuration.
    description: ?[]const u8 = null,

    /// A complex type that contains the Amazon Web Services KMS encryption
    /// configuration settings for your TLS inspection configuration.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The last time that the TLS inspection configuration was changed.
    last_modified_time: ?i64 = null,

    /// The number of firewall policies that use this TLS inspection configuration.
    number_of_associations: ?i32 = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the TLS inspection configuration.
    tls_inspection_configuration_arn: []const u8,

    /// A unique identifier for the TLS inspection configuration. This ID is
    /// returned in the responses to create and list commands. You provide it to
    /// operations such as update and delete.
    tls_inspection_configuration_id: []const u8,

    /// The descriptive name of the TLS inspection configuration. You can't change
    /// the name of a TLS inspection configuration after you create it.
    tls_inspection_configuration_name: []const u8,

    /// Detailed information about the current status of a
    /// TLSInspectionConfiguration. You can retrieve this for a TLS inspection
    /// configuration by calling DescribeTLSInspectionConfiguration and providing
    /// the TLS inspection configuration name and ARN.
    tls_inspection_configuration_status: ?ResourceStatus = null,

    pub const json_field_names = .{
        .certificate_authority = "CertificateAuthority",
        .certificates = "Certificates",
        .description = "Description",
        .encryption_configuration = "EncryptionConfiguration",
        .last_modified_time = "LastModifiedTime",
        .number_of_associations = "NumberOfAssociations",
        .tags = "Tags",
        .tls_inspection_configuration_arn = "TLSInspectionConfigurationArn",
        .tls_inspection_configuration_id = "TLSInspectionConfigurationId",
        .tls_inspection_configuration_name = "TLSInspectionConfigurationName",
        .tls_inspection_configuration_status = "TLSInspectionConfigurationStatus",
    };
};
