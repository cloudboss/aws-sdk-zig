/// Attributes for Kerberos configuration when Kerberos authentication is
/// enabled using a
/// security configuration. For more information see [Use Kerberos
/// Authentication](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-kerberos.html)
/// in the *Amazon EMR Management Guide*.
pub const KerberosAttributes = struct {
    /// The Active Directory password for `ADDomainJoinUser`.
    ad_domain_join_password: ?[]const u8 = null,

    /// Required only when establishing a cross-realm trust with an Active Directory
    /// domain. A
    /// user with sufficient privileges to join resources to the domain.
    ad_domain_join_user: ?[]const u8 = null,

    /// Required only when establishing a cross-realm trust with a KDC in a
    /// different realm. The
    /// cross-realm principal password, which must be identical across realms.
    cross_realm_trust_principal_password: ?[]const u8 = null,

    /// The password used within the cluster for the kadmin service on the
    /// cluster-dedicated
    /// KDC, which maintains Kerberos principals, password policies, and keytabs for
    /// the
    /// cluster.
    kdc_admin_password: []const u8,

    /// The name of the Kerberos realm to which all nodes in a cluster belong. For
    /// example,
    /// `EC2.INTERNAL`.
    realm: []const u8,

    pub const json_field_names = .{
        .ad_domain_join_password = "ADDomainJoinPassword",
        .ad_domain_join_user = "ADDomainJoinUser",
        .cross_realm_trust_principal_password = "CrossRealmTrustPrincipalPassword",
        .kdc_admin_password = "KdcAdminPassword",
        .realm = "Realm",
    };
};
