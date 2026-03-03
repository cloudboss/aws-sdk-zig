const aws = @import("aws");
const std = @import("std");

const create_certificate_authority = @import("create_certificate_authority.zig");
const create_certificate_authority_audit_report = @import("create_certificate_authority_audit_report.zig");
const create_permission = @import("create_permission.zig");
const delete_certificate_authority = @import("delete_certificate_authority.zig");
const delete_permission = @import("delete_permission.zig");
const delete_policy = @import("delete_policy.zig");
const describe_certificate_authority = @import("describe_certificate_authority.zig");
const describe_certificate_authority_audit_report = @import("describe_certificate_authority_audit_report.zig");
const get_certificate = @import("get_certificate.zig");
const get_certificate_authority_certificate = @import("get_certificate_authority_certificate.zig");
const get_certificate_authority_csr = @import("get_certificate_authority_csr.zig");
const get_policy = @import("get_policy.zig");
const import_certificate_authority_certificate = @import("import_certificate_authority_certificate.zig");
const issue_certificate = @import("issue_certificate.zig");
const list_certificate_authorities = @import("list_certificate_authorities.zig");
const list_permissions = @import("list_permissions.zig");
const list_tags = @import("list_tags.zig");
const put_policy = @import("put_policy.zig");
const restore_certificate_authority = @import("restore_certificate_authority.zig");
const revoke_certificate = @import("revoke_certificate.zig");
const tag_certificate_authority = @import("tag_certificate_authority.zig");
const untag_certificate_authority = @import("untag_certificate_authority.zig");
const update_certificate_authority = @import("update_certificate_authority.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ACM PCA";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a root or subordinate private certificate authority (CA). You must
    /// specify the CA configuration, an optional configuration for Online
    /// Certificate Status Protocol (OCSP) and/or a certificate revocation list
    /// (CRL), the CA type, and an optional idempotency token to avoid accidental
    /// creation of multiple CAs. The CA configuration specifies the name of the
    /// algorithm and key size to be used to create the CA private key, the type of
    /// signing algorithm that the CA uses, and X.500 subject information. The OCSP
    /// configuration can optionally specify a custom URL for the OCSP responder.
    /// The CRL configuration specifies the CRL expiration period in days (the
    /// validity period of the CRL), the Amazon S3 bucket that will contain the CRL,
    /// and a CNAME alias for the S3 bucket that is included in certificates issued
    /// by the CA. If successful, this action returns the Amazon Resource Name (ARN)
    /// of the CA.
    ///
    /// Both Amazon Web Services Private CA and the IAM principal must have
    /// permission to write to the S3 bucket that you specify. If the IAM principal
    /// making the call does not have permission to write to the bucket, then an
    /// exception is thrown. For more information, see [Access policies for CRLs in
    /// Amazon
    /// S3](https://docs.aws.amazon.com/privateca/latest/userguide/crl-planning.html#s3-policies).
    ///
    /// Amazon Web Services Private CA assets that are stored in Amazon S3 can be
    /// protected with encryption. For more information, see [Encrypting Your
    /// CRLs](https://docs.aws.amazon.com/privateca/latest/userguide/crl-planning.html#crl-encryption).
    pub fn createCertificateAuthority(self: *Self, allocator: std.mem.Allocator, input: create_certificate_authority.CreateCertificateAuthorityInput, options: CallOptions) !create_certificate_authority.CreateCertificateAuthorityOutput {
        return create_certificate_authority.execute(self, allocator, input, options);
    }

    /// Creates an audit report that lists every time that your CA private key is
    /// used to issue a certificate. The
    /// [IssueCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_IssueCertificate.html) and [RevokeCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_RevokeCertificate.html) actions use the private key.
    ///
    /// To save the audit report to your designated Amazon S3 bucket, you must
    /// create a bucket policy that grants Amazon Web Services Private CA permission
    /// to access and write to it. For an example policy, see [Prepare an Amazon S3
    /// bucket for audit
    /// reports](https://docs.aws.amazon.com/privateca/latest/userguide/PcaAuditReport.html#s3-access).
    ///
    /// Amazon Web Services Private CA assets that are stored in Amazon S3 can be
    /// protected with encryption. For more information, see [Encrypting Your Audit
    /// Reports](https://docs.aws.amazon.com/privateca/latest/userguide/PcaAuditReport.html#audit-report-encryption).
    ///
    /// You can generate a maximum of one report every 30 minutes.
    pub fn createCertificateAuthorityAuditReport(self: *Self, allocator: std.mem.Allocator, input: create_certificate_authority_audit_report.CreateCertificateAuthorityAuditReportInput, options: CallOptions) !create_certificate_authority_audit_report.CreateCertificateAuthorityAuditReportOutput {
        return create_certificate_authority_audit_report.execute(self, allocator, input, options);
    }

    /// Grants one or more permissions on a private CA to the Certificate Manager
    /// (ACM) service principal (`acm.amazonaws.com`). These permissions allow ACM
    /// to issue and renew ACM certificates that reside in the same Amazon Web
    /// Services account as the CA.
    ///
    /// You can list current permissions with the
    /// [ListPermissions](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListPermissions.html) action and revoke them with the [DeletePermission](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DeletePermission.html) action. **About Permissions**
    ///
    /// * If the private CA and the certificates it issues reside in the same
    ///   account, you can use `CreatePermission` to grant permissions for ACM to
    ///   carry out automatic certificate renewals.
    /// * For automatic certificate renewal to succeed, the ACM service principal
    ///   needs permissions to create, retrieve, and list certificates.
    /// * If the private CA and the ACM certificates reside in different accounts,
    ///   then permissions cannot be used to enable automatic renewals. Instead, the
    ///   ACM certificate owner must set up a resource-based policy to enable
    ///   cross-account issuance and renewals. For more information, see [Using a
    ///   Resource Based Policy with Amazon Web Services Private
    ///   CA](https://docs.aws.amazon.com/privateca/latest/userguide/pca-rbp.html).
    pub fn createPermission(self: *Self, allocator: std.mem.Allocator, input: create_permission.CreatePermissionInput, options: CallOptions) !create_permission.CreatePermissionOutput {
        return create_permission.execute(self, allocator, input, options);
    }

    /// Deletes a private certificate authority (CA). You must provide the Amazon
    /// Resource Name (ARN) of the private CA that you want to delete. You can find
    /// the ARN by calling the
    /// [ListCertificateAuthorities](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListCertificateAuthorities.html) action.
    ///
    /// Deleting a CA will invalidate other CAs and certificates below it in your CA
    /// hierarchy.
    ///
    /// Before you can delete a CA that you have created and activated, you must
    /// disable it. To do this, call the
    /// [UpdateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_UpdateCertificateAuthority.html) action and set the **CertificateAuthorityStatus** parameter to `DISABLED`.
    ///
    /// Additionally, you can delete a CA if you are waiting for it to be created
    /// (that is, the status of the CA is `CREATING`). You can also delete it if the
    /// CA has been created but you haven't yet imported the signed certificate into
    /// Amazon Web Services Private CA (that is, the status of the CA is
    /// `PENDING_CERTIFICATE`).
    ///
    /// When you successfully call
    /// [DeleteCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DeleteCertificateAuthority.html), the CA's status changes to `DELETED`. However, the CA won't be permanently deleted until the restoration period has passed. By default, if you do not set the `PermanentDeletionTimeInDays` parameter, the CA remains restorable for 30 days. You can set the parameter from 7 to 30 days. The [DescribeCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DescribeCertificateAuthority.html) action returns the time remaining in the restoration window of a private CA in the `DELETED` state. To restore an eligible CA, call the [RestoreCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_RestoreCertificateAuthority.html) action.
    ///
    /// A private CA can be deleted if it is in the `PENDING_CERTIFICATE`,
    /// `CREATING`, `EXPIRED`, `DISABLED`, or `FAILED` state. To delete a CA in the
    /// `ACTIVE` state, you must first disable it, or else the delete request
    /// results in an exception. If you are deleting a private CA in the
    /// `PENDING_CERTIFICATE` or `DISABLED` state, you can set the length of its
    /// restoration period to 7-30 days. The default is 30. During this time, the
    /// status is set to `DELETED` and the CA can be restored. A private CA deleted
    /// in the `CREATING` or `FAILED` state has no assigned restoration period and
    /// cannot be restored.
    pub fn deleteCertificateAuthority(self: *Self, allocator: std.mem.Allocator, input: delete_certificate_authority.DeleteCertificateAuthorityInput, options: CallOptions) !delete_certificate_authority.DeleteCertificateAuthorityOutput {
        return delete_certificate_authority.execute(self, allocator, input, options);
    }

    /// Revokes permissions on a private CA granted to the Certificate Manager (ACM)
    /// service principal (acm.amazonaws.com).
    ///
    /// These permissions allow ACM to issue and renew ACM certificates that reside
    /// in the same Amazon Web Services account as the CA. If you revoke these
    /// permissions, ACM will no longer renew the affected certificates
    /// automatically.
    ///
    /// Permissions can be granted with the
    /// [CreatePermission](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreatePermission.html) action and listed with the [ListPermissions](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListPermissions.html) action. **About Permissions**
    ///
    /// * If the private CA and the certificates it issues reside in the same
    ///   account, you can use `CreatePermission` to grant permissions for ACM to
    ///   carry out automatic certificate renewals.
    /// * For automatic certificate renewal to succeed, the ACM service principal
    ///   needs permissions to create, retrieve, and list certificates.
    /// * If the private CA and the ACM certificates reside in different accounts,
    ///   then permissions cannot be used to enable automatic renewals. Instead, the
    ///   ACM certificate owner must set up a resource-based policy to enable
    ///   cross-account issuance and renewals. For more information, see [Using a
    ///   Resource Based Policy with Amazon Web Services Private
    ///   CA](https://docs.aws.amazon.com/privateca/latest/userguide/pca-rbp.html).
    pub fn deletePermission(self: *Self, allocator: std.mem.Allocator, input: delete_permission.DeletePermissionInput, options: CallOptions) !delete_permission.DeletePermissionOutput {
        return delete_permission.execute(self, allocator, input, options);
    }

    /// Deletes the resource-based policy attached to a private CA. Deletion will
    /// remove any access that the policy has granted. If there is no policy
    /// attached to the private CA, this action will return successful.
    ///
    /// If you delete a policy that was applied through Amazon Web Services Resource
    /// Access Manager (RAM), the CA will be removed from all shares in which it was
    /// included.
    ///
    /// The Certificate Manager Service Linked Role that the policy supports is not
    /// affected when you delete the policy.
    ///
    /// The current policy can be shown with
    /// [GetPolicy](https://docs.aws.amazon.com/privateca/latest/APIReference/API_GetPolicy.html) and updated with [PutPolicy](https://docs.aws.amazon.com/privateca/latest/APIReference/API_PutPolicy.html). **About Policies**
    ///
    /// * A policy grants access on a private CA to an Amazon Web Services customer
    ///   account, to Amazon Web Services Organizations, or to an Amazon Web
    ///   Services Organizations unit. Policies are under the control of a CA
    ///   administrator. For more information, see [Using a Resource Based Policy
    ///   with Amazon Web Services Private
    ///   CA](https://docs.aws.amazon.com/privateca/latest/userguide/pca-rbp.html).
    /// * A policy permits a user of Certificate Manager (ACM) to issue ACM
    ///   certificates signed by a CA in another account.
    /// * For ACM to manage automatic renewal of these certificates, the ACM user
    ///   must configure a Service Linked Role (SLR). The SLR allows the ACM service
    ///   to assume the identity of the user, subject to confirmation against the
    ///   Amazon Web Services Private CA policy. For more information, see [Using a
    ///   Service Linked Role with
    ///   ACM](https://docs.aws.amazon.com/acm/latest/userguide/acm-slr.html).
    /// * Updates made in Amazon Web Services Resource Manager (RAM) are reflected
    ///   in policies. For more information, see [Attach a Policy for Cross-Account
    ///   Access](https://docs.aws.amazon.com/privateca/latest/userguide/pca-ram.html).
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: CallOptions) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Lists information about your private certificate authority (CA) or one that
    /// has been shared with you. You specify the private CA on input by its ARN
    /// (Amazon Resource Name). The output contains the status of your CA. This can
    /// be any of the following:
    ///
    /// * `CREATING` - Amazon Web Services Private CA is creating your private
    ///   certificate authority.
    /// * `PENDING_CERTIFICATE` - The certificate is pending. You must use your
    ///   Amazon Web Services Private CA-hosted or on-premises root or subordinate
    ///   CA to sign your private CA CSR and then import it into Amazon Web Services
    ///   Private CA.
    /// * `ACTIVE` - Your private CA is active.
    /// * `DISABLED` - Your private CA has been disabled.
    /// * `EXPIRED` - Your private CA certificate has expired.
    /// * `FAILED` - Your private CA has failed. Your CA can fail because of
    ///   problems such a network outage or back-end Amazon Web Services failure or
    ///   other errors. A failed CA can never return to the pending state. You must
    ///   create a new CA.
    /// * `DELETED` - Your private CA is within the restoration period, after which
    ///   it is permanently deleted. The length of time remaining in the CA's
    ///   restoration period is also included in this action's output.
    pub fn describeCertificateAuthority(self: *Self, allocator: std.mem.Allocator, input: describe_certificate_authority.DescribeCertificateAuthorityInput, options: CallOptions) !describe_certificate_authority.DescribeCertificateAuthorityOutput {
        return describe_certificate_authority.execute(self, allocator, input, options);
    }

    /// Lists information about a specific audit report created by calling the
    /// [CreateCertificateAuthorityAuditReport](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthorityAuditReport.html) action. Audit information is created every time the certificate authority (CA) private key is used. The private key is used when you call the [IssueCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_IssueCertificate.html) action or the [RevokeCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_RevokeCertificate.html) action.
    pub fn describeCertificateAuthorityAuditReport(self: *Self, allocator: std.mem.Allocator, input: describe_certificate_authority_audit_report.DescribeCertificateAuthorityAuditReportInput, options: CallOptions) !describe_certificate_authority_audit_report.DescribeCertificateAuthorityAuditReportOutput {
        return describe_certificate_authority_audit_report.execute(self, allocator, input, options);
    }

    /// Retrieves a certificate from your private CA or one that has been shared
    /// with you. The ARN of the certificate is returned when you call the
    /// [IssueCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_IssueCertificate.html) action. You must specify both the ARN of your private CA and the ARN of the issued certificate when calling the **GetCertificate** action. You can retrieve the certificate if it is in the **ISSUED**, **EXPIRED**, or **REVOKED** state. You can call the [CreateCertificateAuthorityAuditReport](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthorityAuditReport.html) action to create a report that contains information about all of the certificates issued and revoked by your private CA.
    pub fn getCertificate(self: *Self, allocator: std.mem.Allocator, input: get_certificate.GetCertificateInput, options: CallOptions) !get_certificate.GetCertificateOutput {
        return get_certificate.execute(self, allocator, input, options);
    }

    /// Retrieves the certificate and certificate chain for your private certificate
    /// authority (CA) or one that has been shared with you. Both the certificate
    /// and the chain are base64 PEM-encoded. The chain does not include the CA
    /// certificate. Each certificate in the chain signs the one before it.
    pub fn getCertificateAuthorityCertificate(self: *Self, allocator: std.mem.Allocator, input: get_certificate_authority_certificate.GetCertificateAuthorityCertificateInput, options: CallOptions) !get_certificate_authority_certificate.GetCertificateAuthorityCertificateOutput {
        return get_certificate_authority_certificate.execute(self, allocator, input, options);
    }

    /// Retrieves the certificate signing request (CSR) for your private certificate
    /// authority (CA). The CSR is created when you call the
    /// [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html) action. Sign the CSR with your Amazon Web Services Private CA-hosted or on-premises root or subordinate CA. Then import the signed certificate back into Amazon Web Services Private CA by calling the [ImportCertificateAuthorityCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ImportCertificateAuthorityCertificate.html) action. The CSR is returned as a base64 PEM-encoded string.
    pub fn getCertificateAuthorityCsr(self: *Self, allocator: std.mem.Allocator, input: get_certificate_authority_csr.GetCertificateAuthorityCsrInput, options: CallOptions) !get_certificate_authority_csr.GetCertificateAuthorityCsrOutput {
        return get_certificate_authority_csr.execute(self, allocator, input, options);
    }

    /// Retrieves the resource-based policy attached to a private CA. If either the
    /// private CA resource or the policy cannot be found, this action returns a
    /// `ResourceNotFoundException`.
    ///
    /// The policy can be attached or updated with
    /// [PutPolicy](https://docs.aws.amazon.com/privateca/latest/APIReference/API_PutPolicy.html) and removed with [DeletePolicy](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DeletePolicy.html). **About Policies**
    ///
    /// * A policy grants access on a private CA to an Amazon Web Services customer
    ///   account, to Amazon Web Services Organizations, or to an Amazon Web
    ///   Services Organizations unit. Policies are under the control of a CA
    ///   administrator. For more information, see [Using a Resource Based Policy
    ///   with Amazon Web Services Private
    ///   CA](https://docs.aws.amazon.com/privateca/latest/userguide/pca-rbp.html).
    /// * A policy permits a user of Certificate Manager (ACM) to issue ACM
    ///   certificates signed by a CA in another account.
    /// * For ACM to manage automatic renewal of these certificates, the ACM user
    ///   must configure a Service Linked Role (SLR). The SLR allows the ACM service
    ///   to assume the identity of the user, subject to confirmation against the
    ///   Amazon Web Services Private CA policy. For more information, see [Using a
    ///   Service Linked Role with
    ///   ACM](https://docs.aws.amazon.com/acm/latest/userguide/acm-slr.html).
    /// * Updates made in Amazon Web Services Resource Manager (RAM) are reflected
    ///   in policies. For more information, see [Attach a Policy for Cross-Account
    ///   Access](https://docs.aws.amazon.com/privateca/latest/userguide/pca-ram.html).
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: CallOptions) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Imports a signed private CA certificate into Amazon Web Services Private CA.
    /// This action is used when you are using a chain of trust whose root is
    /// located outside Amazon Web Services Private CA. Before you can call this
    /// action, the following preparations must in place:
    ///
    /// * In Amazon Web Services Private CA, call the
    ///   [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html) action to create the private CA that you plan to back with the imported certificate.
    /// * Call the
    ///   [GetCertificateAuthorityCsr](https://docs.aws.amazon.com/privateca/latest/APIReference/API_GetCertificateAuthorityCsr.html) action to generate a certificate signing request (CSR).
    /// * Sign the CSR using a root or intermediate CA hosted by either an
    ///   on-premises PKI hierarchy or by a commercial CA.
    /// * Create a certificate chain and copy the signed certificate and the
    ///   certificate chain to your working directory.
    ///
    /// Amazon Web Services Private CA supports three scenarios for installing a CA
    /// certificate:
    ///
    /// * Installing a certificate for a root CA hosted by Amazon Web Services
    ///   Private CA.
    /// * Installing a subordinate CA certificate whose parent authority is hosted
    ///   by Amazon Web Services Private CA.
    /// * Installing a subordinate CA certificate whose parent authority is
    ///   externally hosted.
    ///
    /// The following additional requirements apply when you import a CA
    /// certificate.
    ///
    /// * Only a self-signed certificate can be imported as a root CA.
    /// * A self-signed certificate cannot be imported as a subordinate CA.
    /// * Your certificate chain must not include the private CA certificate that
    ///   you are importing.
    /// * Your root CA must be the last certificate in your chain. The subordinate
    ///   certificate, if any, that your root CA signed must be next to last. The
    ///   subordinate certificate signed by the preceding subordinate CA must come
    ///   next, and so on until your chain is built.
    /// * The chain must be PEM-encoded.
    /// * The maximum allowed size of a certificate is 32 KB.
    /// * The maximum allowed size of a certificate chain is 2 MB.
    ///
    /// *Enforcement of Critical Constraints*
    ///
    /// Amazon Web Services Private CA allows the following extensions to be marked
    /// critical in the imported CA certificate or chain.
    ///
    /// * Authority key identifier
    /// * Basic constraints (*must* be marked critical)
    /// * Certificate policies
    /// * Extended key usage
    /// * Inhibit anyPolicy
    /// * Issuer alternative name
    /// * Key usage
    /// * Name constraints
    /// * Policy mappings
    /// * Subject alternative name
    /// * Subject directory attributes
    /// * Subject key identifier
    /// * Subject information access
    ///
    /// Amazon Web Services Private CA rejects the following extensions when they
    /// are marked critical in an imported CA certificate or chain.
    ///
    /// * Authority information access
    /// * CRL distribution points
    /// * Freshest CRL
    /// * Policy constraints
    ///
    /// Amazon Web Services Private Certificate Authority will also reject any other
    /// extension marked as critical not contained on the preceding list of allowed
    /// extensions.
    pub fn importCertificateAuthorityCertificate(self: *Self, allocator: std.mem.Allocator, input: import_certificate_authority_certificate.ImportCertificateAuthorityCertificateInput, options: CallOptions) !import_certificate_authority_certificate.ImportCertificateAuthorityCertificateOutput {
        return import_certificate_authority_certificate.execute(self, allocator, input, options);
    }

    /// Uses your private certificate authority (CA), or one that has been shared
    /// with you, to issue a client certificate. This action returns the Amazon
    /// Resource Name (ARN) of the certificate. You can retrieve the certificate by
    /// calling the
    /// [GetCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_GetCertificate.html) action and specifying the ARN.
    ///
    /// You cannot use the ACM **ListCertificateAuthorities** action to retrieve the
    /// ARNs of the certificates that you issue by using Amazon Web Services Private
    /// CA.
    pub fn issueCertificate(self: *Self, allocator: std.mem.Allocator, input: issue_certificate.IssueCertificateInput, options: CallOptions) !issue_certificate.IssueCertificateOutput {
        return issue_certificate.execute(self, allocator, input, options);
    }

    /// Lists the private certificate authorities that you created by using the
    /// [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html) action.
    pub fn listCertificateAuthorities(self: *Self, allocator: std.mem.Allocator, input: list_certificate_authorities.ListCertificateAuthoritiesInput, options: CallOptions) !list_certificate_authorities.ListCertificateAuthoritiesOutput {
        return list_certificate_authorities.execute(self, allocator, input, options);
    }

    /// List all permissions on a private CA, if any, granted to the Certificate
    /// Manager (ACM) service principal (acm.amazonaws.com).
    ///
    /// These permissions allow ACM to issue and renew ACM certificates that reside
    /// in the same Amazon Web Services account as the CA.
    ///
    /// Permissions can be granted with the
    /// [CreatePermission](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreatePermission.html) action and revoked with the [DeletePermission](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DeletePermission.html) action. **About Permissions**
    ///
    /// * If the private CA and the certificates it issues reside in the same
    ///   account, you can use `CreatePermission` to grant permissions for ACM to
    ///   carry out automatic certificate renewals.
    /// * For automatic certificate renewal to succeed, the ACM service principal
    ///   needs permissions to create, retrieve, and list certificates.
    /// * If the private CA and the ACM certificates reside in different accounts,
    ///   then permissions cannot be used to enable automatic renewals. Instead, the
    ///   ACM certificate owner must set up a resource-based policy to enable
    ///   cross-account issuance and renewals. For more information, see [Using a
    ///   Resource Based Policy with Amazon Web Services Private
    ///   CA](https://docs.aws.amazon.com/privateca/latest/userguide/pca-rbp.html).
    pub fn listPermissions(self: *Self, allocator: std.mem.Allocator, input: list_permissions.ListPermissionsInput, options: CallOptions) !list_permissions.ListPermissionsOutput {
        return list_permissions.execute(self, allocator, input, options);
    }

    /// Lists the tags, if any, that are associated with your private CA or one that
    /// has been shared with you. Tags are labels that you can use to identify and
    /// organize your CAs. Each tag consists of a key and an optional value. Call
    /// the
    /// [TagCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_TagCertificateAuthority.html) action to add one or more tags to your CA. Call the [UntagCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_UntagCertificateAuthority.html) action to remove tags.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: CallOptions) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Attaches a resource-based policy to a private CA.
    ///
    /// A policy can also be applied by sharing a private CA through Amazon Web
    /// Services Resource Access Manager (RAM). For more information, see [Attach a
    /// Policy for Cross-Account
    /// Access](https://docs.aws.amazon.com/privateca/latest/userguide/pca-ram.html).
    ///
    /// The policy can be displayed with
    /// [GetPolicy](https://docs.aws.amazon.com/privateca/latest/APIReference/API_GetPolicy.html) and removed with [DeletePolicy](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DeletePolicy.html). **About Policies**
    ///
    /// * A policy grants access on a private CA to an Amazon Web Services customer
    ///   account, to Amazon Web Services Organizations, or to an Amazon Web
    ///   Services Organizations unit. Policies are under the control of a CA
    ///   administrator. For more information, see [Using a Resource Based Policy
    ///   with Amazon Web Services Private
    ///   CA](https://docs.aws.amazon.com/privateca/latest/userguide/pca-rbp.html).
    /// * A policy permits a user of Certificate Manager (ACM) to issue ACM
    ///   certificates signed by a CA in another account.
    /// * For ACM to manage automatic renewal of these certificates, the ACM user
    ///   must configure a Service Linked Role (SLR). The SLR allows the ACM service
    ///   to assume the identity of the user, subject to confirmation against the
    ///   Amazon Web Services Private CA policy. For more information, see [Using a
    ///   Service Linked Role with
    ///   ACM](https://docs.aws.amazon.com/acm/latest/userguide/acm-slr.html).
    /// * Updates made in Amazon Web Services Resource Manager (RAM) are reflected
    ///   in policies. For more information, see [Attach a Policy for Cross-Account
    ///   Access](https://docs.aws.amazon.com/privateca/latest/userguide/pca-ram.html).
    pub fn putPolicy(self: *Self, allocator: std.mem.Allocator, input: put_policy.PutPolicyInput, options: CallOptions) !put_policy.PutPolicyOutput {
        return put_policy.execute(self, allocator, input, options);
    }

    /// Restores a certificate authority (CA) that is in the `DELETED` state. You
    /// can restore a CA during the period that you defined in the
    /// **PermanentDeletionTimeInDays** parameter of the
    /// [DeleteCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DeleteCertificateAuthority.html) action. Currently, you can specify 7 to 30 days. If you did not specify a **PermanentDeletionTimeInDays** value, by default you can restore the CA at any time in a 30 day period. You can check the time remaining in the restoration period of a private CA in the `DELETED` state by calling the [DescribeCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_DescribeCertificateAuthority.html) or [ListCertificateAuthorities](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListCertificateAuthorities.html) actions. The status of a restored CA is set to its pre-deletion status when the **RestoreCertificateAuthority** action returns. To change its status to `ACTIVE`, call the [UpdateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_UpdateCertificateAuthority.html) action. If the private CA was in the `PENDING_CERTIFICATE` state at deletion, you must use the [ImportCertificateAuthorityCertificate](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ImportCertificateAuthorityCertificate.html) action to import a certificate authority into the private CA before it can be activated. You cannot restore a CA after the restoration period has ended.
    pub fn restoreCertificateAuthority(self: *Self, allocator: std.mem.Allocator, input: restore_certificate_authority.RestoreCertificateAuthorityInput, options: CallOptions) !restore_certificate_authority.RestoreCertificateAuthorityOutput {
        return restore_certificate_authority.execute(self, allocator, input, options);
    }

    /// Revokes a certificate that was issued inside Amazon Web Services Private CA.
    /// If you enable a certificate revocation list (CRL) when you create or update
    /// your private CA, information about the revoked certificates will be included
    /// in the CRL. Amazon Web Services Private CA writes the CRL to an S3 bucket
    /// that you specify. A CRL is typically updated approximately 30 minutes after
    /// a certificate is revoked. If for any reason the CRL update fails, Amazon Web
    /// Services Private CA attempts makes further attempts every 15 minutes. With
    /// Amazon CloudWatch, you can create alarms for the metrics `CRLGenerated` and
    /// `MisconfiguredCRLBucket`. For more information, see [Supported CloudWatch
    /// Metrics](https://docs.aws.amazon.com/privateca/latest/userguide/PcaCloudWatch.html).
    ///
    /// Both Amazon Web Services Private CA and the IAM principal must have
    /// permission to write to the S3 bucket that you specify. If the IAM principal
    /// making the call does not have permission to write to the bucket, then an
    /// exception is thrown. For more information, see [Access policies for CRLs in
    /// Amazon
    /// S3](https://docs.aws.amazon.com/privateca/latest/userguide/crl-planning.html#s3-policies).
    ///
    /// Amazon Web Services Private CA also writes revocation information to the
    /// audit report. For more information, see
    /// [CreateCertificateAuthorityAuditReport](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthorityAuditReport.html).
    ///
    /// You cannot revoke a root CA self-signed certificate.
    pub fn revokeCertificate(self: *Self, allocator: std.mem.Allocator, input: revoke_certificate.RevokeCertificateInput, options: CallOptions) !revoke_certificate.RevokeCertificateOutput {
        return revoke_certificate.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to your private CA. Tags are labels that you can use
    /// to identify and organize your Amazon Web Services resources. Each tag
    /// consists of a key and an optional value. You specify the private CA on input
    /// by its Amazon Resource Name (ARN). You specify the tag by using a key-value
    /// pair. You can apply a tag to just one private CA if you want to identify a
    /// specific characteristic of that CA, or you can apply the same tag to
    /// multiple private CAs if you want to filter for a common relationship among
    /// those CAs. To remove one or more tags, use the
    /// [UntagCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_UntagCertificateAuthority.html) action. Call the [ListTags](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListTags.html) action to see what tags are associated with your CA.
    ///
    /// To attach tags to a private CA during the creation procedure, a CA
    /// administrator must first associate an inline IAM policy with the
    /// `CreateCertificateAuthority` action and explicitly allow tagging. For more
    /// information, see [Attaching tags to a CA at the time of
    /// creation](https://docs.aws.amazon.com/privateca/latest/userguide/auth-InlinePolicies.html#policy-tag-ca).
    pub fn tagCertificateAuthority(self: *Self, allocator: std.mem.Allocator, input: tag_certificate_authority.TagCertificateAuthorityInput, options: CallOptions) !tag_certificate_authority.TagCertificateAuthorityOutput {
        return tag_certificate_authority.execute(self, allocator, input, options);
    }

    /// Remove one or more tags from your private CA. A tag consists of a key-value
    /// pair. If you do not specify the value portion of the tag when calling this
    /// action, the tag will be removed regardless of value. If you specify a value,
    /// the tag is removed only if it is associated with the specified value. To add
    /// tags to a private CA, use the
    /// [TagCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_TagCertificateAuthority.html). Call the [ListTags](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListTags.html) action to see what tags are associated with your CA.
    pub fn untagCertificateAuthority(self: *Self, allocator: std.mem.Allocator, input: untag_certificate_authority.UntagCertificateAuthorityInput, options: CallOptions) !untag_certificate_authority.UntagCertificateAuthorityOutput {
        return untag_certificate_authority.execute(self, allocator, input, options);
    }

    /// Updates the status or configuration of a private certificate authority (CA).
    /// Your private CA must be in the `ACTIVE` or `DISABLED` state before you can
    /// update it. You can disable a private CA that is in the `ACTIVE` state or
    /// make a CA that is in the `DISABLED` state active again.
    ///
    /// Both Amazon Web Services Private CA and the IAM principal must have
    /// permission to write to the S3 bucket that you specify. If the IAM principal
    /// making the call does not have permission to write to the bucket, then an
    /// exception is thrown. For more information, see [Access policies for CRLs in
    /// Amazon
    /// S3](https://docs.aws.amazon.com/privateca/latest/userguide/crl-planning.html#s3-policies).
    pub fn updateCertificateAuthority(self: *Self, allocator: std.mem.Allocator, input: update_certificate_authority.UpdateCertificateAuthorityInput, options: CallOptions) !update_certificate_authority.UpdateCertificateAuthorityOutput {
        return update_certificate_authority.execute(self, allocator, input, options);
    }

    pub fn listCertificateAuthoritiesPaginator(self: *Self, params: list_certificate_authorities.ListCertificateAuthoritiesInput) paginator.ListCertificateAuthoritiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPermissionsPaginator(self: *Self, params: list_permissions.ListPermissionsInput) paginator.ListPermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsPaginator(self: *Self, params: list_tags.ListTagsInput) paginator.ListTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilAuditReportCreated(self: *Self, params: describe_certificate_authority_audit_report.DescribeCertificateAuthorityAuditReportInput) aws.waiter.WaiterError!void {
        var w = waiters.AuditReportCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilCertificateAuthorityCSRCreated(self: *Self, params: get_certificate_authority_csr.GetCertificateAuthorityCsrInput) aws.waiter.WaiterError!void {
        var w = waiters.CertificateAuthorityCSRCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilCertificateIssued(self: *Self, params: get_certificate.GetCertificateInput) aws.waiter.WaiterError!void {
        var w = waiters.CertificateIssuedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
