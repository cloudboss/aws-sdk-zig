/// Information about a certificate authority for a group.
pub const GroupCertificateAuthorityProperties = struct {
    /// The ARN of the certificate authority for the group.
    group_certificate_authority_arn: ?[]const u8,

    /// The ID of the certificate authority for the group.
    group_certificate_authority_id: ?[]const u8,

    pub const json_field_names = .{
        .group_certificate_authority_arn = "GroupCertificateAuthorityArn",
        .group_certificate_authority_id = "GroupCertificateAuthorityId",
    };
};
