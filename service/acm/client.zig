const aws = @import("aws");
const std = @import("std");

const add_tags_to_certificate = @import("add_tags_to_certificate.zig");
const delete_certificate = @import("delete_certificate.zig");
const describe_certificate = @import("describe_certificate.zig");
const export_certificate = @import("export_certificate.zig");
const get_account_configuration = @import("get_account_configuration.zig");
const get_certificate = @import("get_certificate.zig");
const import_certificate = @import("import_certificate.zig");
const list_certificates = @import("list_certificates.zig");
const list_tags_for_certificate = @import("list_tags_for_certificate.zig");
const put_account_configuration = @import("put_account_configuration.zig");
const remove_tags_from_certificate = @import("remove_tags_from_certificate.zig");
const renew_certificate = @import("renew_certificate.zig");
const request_certificate = @import("request_certificate.zig");
const resend_validation_email = @import("resend_validation_email.zig");
const revoke_certificate = @import("revoke_certificate.zig");
const update_certificate_options = @import("update_certificate_options.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ACM";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Adds one or more tags to an ACM certificate. Tags are labels that you can
    /// use to identify and organize your Amazon Web Services resources. Each tag
    /// consists of a `key` and an optional `value`. You specify the certificate on
    /// input by its Amazon Resource Name (ARN). You specify the tag by using a
    /// key-value pair.
    ///
    /// You can apply a tag to just one certificate if you want to identify a
    /// specific characteristic of that certificate, or you can apply the same tag
    /// to multiple certificates if you want to filter for a common relationship
    /// among those certificates. Similarly, you can apply the same tag to multiple
    /// resources if you want to specify a relationship among those resources. For
    /// example, you can add the same tag to an ACM certificate and an Elastic Load
    /// Balancing load balancer to indicate that they are both used by the same
    /// website. For more information, see [Tagging ACM
    /// certificates](https://docs.aws.amazon.com/acm/latest/userguide/tags.html).
    ///
    /// To remove one or more tags, use the RemoveTagsFromCertificate action. To
    /// view all of the tags that have been applied to the certificate, use the
    /// ListTagsForCertificate action.
    pub fn addTagsToCertificate(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_certificate.AddTagsToCertificateInput, options: add_tags_to_certificate.Options) !add_tags_to_certificate.AddTagsToCertificateOutput {
        return add_tags_to_certificate.execute(self, allocator, input, options);
    }

    /// Deletes a certificate and its associated private key. If this action
    /// succeeds, the certificate no longer appears in the list that can be
    /// displayed by calling the ListCertificates action or be retrieved by calling
    /// the GetCertificate action. The certificate will not be available for use by
    /// Amazon Web Services services integrated with ACM.
    ///
    /// You cannot delete an ACM certificate that is being used by another Amazon
    /// Web Services service. To delete a certificate that is in use, the
    /// certificate association must first be removed.
    pub fn deleteCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_certificate.DeleteCertificateInput, options: delete_certificate.Options) !delete_certificate.DeleteCertificateOutput {
        return delete_certificate.execute(self, allocator, input, options);
    }

    /// Returns detailed metadata about the specified ACM certificate.
    ///
    /// If you have just created a certificate using the `RequestCertificate`
    /// action, there is a delay of several seconds before you can retrieve
    /// information about it.
    pub fn describeCertificate(self: *Self, allocator: std.mem.Allocator, input: describe_certificate.DescribeCertificateInput, options: describe_certificate.Options) !describe_certificate.DescribeCertificateOutput {
        return describe_certificate.execute(self, allocator, input, options);
    }

    /// Exports a private certificate issued by a private certificate authority (CA)
    /// or public certificate for use anywhere. The exported file contains the
    /// certificate, the certificate chain, and the encrypted private key associated
    /// with the public key that is embedded in the certificate. For security, you
    /// must assign a passphrase for the private key when exporting it.
    ///
    /// For information about exporting and formatting a certificate using the ACM
    /// console or CLI, see [Export a private
    /// certificate](https://docs.aws.amazon.com/acm/latest/userguide/export-private.html) and [Export a public certificate](https://docs.aws.amazon.com/acm/latest/userguide/export-public-certificate).
    pub fn exportCertificate(self: *Self, allocator: std.mem.Allocator, input: export_certificate.ExportCertificateInput, options: export_certificate.Options) !export_certificate.ExportCertificateOutput {
        return export_certificate.execute(self, allocator, input, options);
    }

    /// Returns the account configuration options associated with an Amazon Web
    /// Services account.
    pub fn getAccountConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_account_configuration.GetAccountConfigurationInput, options: get_account_configuration.Options) !get_account_configuration.GetAccountConfigurationOutput {
        return get_account_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves a certificate and its certificate chain. The certificate may be
    /// either a public or private certificate issued using the ACM
    /// `RequestCertificate` action, or a certificate imported into ACM using the
    /// `ImportCertificate` action. The chain consists of the certificate of the
    /// issuing CA and the intermediate certificates of any other subordinate CAs.
    /// All of the certificates are base64 encoded. You can use
    /// [OpenSSL](https://wiki.openssl.org/index.php/Command_Line_Utilities) to
    /// decode the certificates and inspect individual fields.
    pub fn getCertificate(self: *Self, allocator: std.mem.Allocator, input: get_certificate.GetCertificateInput, options: get_certificate.Options) !get_certificate.GetCertificateOutput {
        return get_certificate.execute(self, allocator, input, options);
    }

    /// Imports a certificate into Certificate Manager (ACM) to use with services
    /// that are integrated with ACM. Note that [integrated
    /// services](https://docs.aws.amazon.com/acm/latest/userguide/acm-services.html) allow only certificate types and keys they support to be associated with their resources. Further, their support differs depending on whether the certificate is imported into IAM or into ACM. For more information, see the documentation for each service. For more information about importing certificates into ACM, see [Importing Certificates](https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the *Certificate Manager User Guide*.
    ///
    /// ACM does not provide [managed
    /// renewal](https://docs.aws.amazon.com/acm/latest/userguide/acm-renewal.html)
    /// for certificates that you import.
    ///
    /// Note the following guidelines when importing third party certificates:
    ///
    /// * You must enter the private key that matches the certificate you are
    ///   importing.
    /// * The private key must be unencrypted. You cannot import a private key that
    ///   is protected by a password or a passphrase.
    /// * The private key must be no larger than 5 KB (5,120 bytes).
    /// * The certificate, private key, and certificate chain must be PEM-encoded.
    /// * The current time must be between the `Not Before` and `Not After`
    ///   certificate fields.
    /// * The `Issuer` field must not be empty.
    /// * The OCSP authority URL, if present, must not exceed 1000 characters.
    /// * To import a new certificate, omit the `CertificateArn` argument. Include
    ///   this argument only when you want to replace a previously imported
    ///   certificate.
    /// * When you import a certificate by using the CLI, you must specify the
    ///   certificate, the certificate chain, and the private key by their file
    ///   names preceded by `fileb://`. For example, you can specify a certificate
    ///   saved in the `C:\temp` folder as
    ///   `fileb://C:\temp\certificate_to_import.pem`. If you are making an HTTP or
    ///   HTTPS Query request, include these arguments as BLOBs.
    /// * When you import a certificate by using an SDK, you must specify the
    ///   certificate, the certificate chain, and the private key files in the
    ///   manner required by the programming language you're using.
    /// * The cryptographic algorithm of an imported certificate must match the
    ///   algorithm of the signing CA. For example, if the signing CA key type is
    ///   RSA, then the certificate key type must also be RSA.
    ///
    /// This operation returns the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the imported certificate.
    pub fn importCertificate(self: *Self, allocator: std.mem.Allocator, input: import_certificate.ImportCertificateInput, options: import_certificate.Options) !import_certificate.ImportCertificateOutput {
        return import_certificate.execute(self, allocator, input, options);
    }

    /// Retrieves a list of certificate ARNs and domain names. You can request that
    /// only certificates that match a specific status be listed. You can also
    /// filter by specific attributes of the certificate. Default filtering returns
    /// only `RSA_2048` certificates. For more information, see Filters.
    pub fn listCertificates(self: *Self, allocator: std.mem.Allocator, input: list_certificates.ListCertificatesInput, options: list_certificates.Options) !list_certificates.ListCertificatesOutput {
        return list_certificates.execute(self, allocator, input, options);
    }

    /// Lists the tags that have been applied to the ACM certificate. Use the
    /// certificate's Amazon Resource Name (ARN) to specify the certificate. To add
    /// a tag to an ACM certificate, use the AddTagsToCertificate action. To delete
    /// a tag, use the RemoveTagsFromCertificate action.
    pub fn listTagsForCertificate(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_certificate.ListTagsForCertificateInput, options: list_tags_for_certificate.Options) !list_tags_for_certificate.ListTagsForCertificateOutput {
        return list_tags_for_certificate.execute(self, allocator, input, options);
    }

    /// Adds or modifies account-level configurations in ACM.
    ///
    /// The supported configuration option is `DaysBeforeExpiry`. This option
    /// specifies the number of days prior to certificate expiration when ACM starts
    /// generating `EventBridge` events. ACM sends one event per day per certificate
    /// until the certificate expires. By default, accounts receive events starting
    /// 45 days before certificate expiration.
    pub fn putAccountConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_account_configuration.PutAccountConfigurationInput, options: put_account_configuration.Options) !put_account_configuration.PutAccountConfigurationOutput {
        return put_account_configuration.execute(self, allocator, input, options);
    }

    /// Remove one or more tags from an ACM certificate. A tag consists of a
    /// key-value pair. If you do not specify the value portion of the tag when
    /// calling this function, the tag will be removed regardless of value. If you
    /// specify a value, the tag is removed only if it is associated with the
    /// specified value.
    ///
    /// To add tags to a certificate, use the AddTagsToCertificate action. To view
    /// all of the tags that have been applied to a specific ACM certificate, use
    /// the ListTagsForCertificate action.
    pub fn removeTagsFromCertificate(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_certificate.RemoveTagsFromCertificateInput, options: remove_tags_from_certificate.Options) !remove_tags_from_certificate.RemoveTagsFromCertificateOutput {
        return remove_tags_from_certificate.execute(self, allocator, input, options);
    }

    /// Renews an [eligible ACM
    /// certificate](https://docs.aws.amazon.com/acm/latest/userguide/managed-renewal.html). In order to renew your Amazon Web Services Private CA certificates with ACM, you must first [grant the ACM service principal permission to do so](https://docs.aws.amazon.com/privateca/latest/userguide/PcaPermissions.html). For more information, see [Testing Managed Renewal](https://docs.aws.amazon.com/acm/latest/userguide/manual-renewal.html) in the ACM User Guide.
    pub fn renewCertificate(self: *Self, allocator: std.mem.Allocator, input: renew_certificate.RenewCertificateInput, options: renew_certificate.Options) !renew_certificate.RenewCertificateOutput {
        return renew_certificate.execute(self, allocator, input, options);
    }

    /// Requests an ACM certificate for use with other Amazon Web Services services.
    /// To request an ACM certificate, you must specify a fully qualified domain
    /// name (FQDN) in the `DomainName` parameter. You can also specify additional
    /// FQDNs in the `SubjectAlternativeNames` parameter.
    ///
    /// If you are requesting a private certificate, domain validation is not
    /// required. If you are requesting a public certificate, each domain name that
    /// you specify must be validated to verify that you own or control the domain.
    /// You can use [DNS
    /// validation](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate-dns.html) or [email validation](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate-email.html). We recommend that you use DNS validation.
    ///
    /// ACM behavior differs from the [RFC
    /// 6125](https://datatracker.ietf.org/doc/html/rfc6125#appendix-B.2)
    /// specification of the certificate validation process. ACM first checks for a
    /// Subject Alternative Name, and, if it finds one, ignores the common name
    /// (CN).
    ///
    /// After successful completion of the `RequestCertificate` action, there is a
    /// delay of several seconds before you can retrieve information about the new
    /// certificate.
    pub fn requestCertificate(self: *Self, allocator: std.mem.Allocator, input: request_certificate.RequestCertificateInput, options: request_certificate.Options) !request_certificate.RequestCertificateOutput {
        return request_certificate.execute(self, allocator, input, options);
    }

    /// Resends the email that requests domain ownership validation. The domain
    /// owner or an authorized representative must approve the ACM certificate
    /// before it can be issued. The certificate can be approved by clicking a link
    /// in the mail to navigate to the Amazon certificate approval website and then
    /// clicking **I Approve**. However, the validation email can be blocked by spam
    /// filters. Therefore, if you do not receive the original mail, you can request
    /// that the mail be resent within 72 hours of requesting the ACM certificate.
    /// If more than 72 hours have elapsed since your original request or since your
    /// last attempt to resend validation mail, you must request a new certificate.
    /// For more information about setting up your contact email addresses, see
    /// [Configure Email for your
    /// Domain](https://docs.aws.amazon.com/acm/latest/userguide/setup-email.html).
    pub fn resendValidationEmail(self: *Self, allocator: std.mem.Allocator, input: resend_validation_email.ResendValidationEmailInput, options: resend_validation_email.Options) !resend_validation_email.ResendValidationEmailOutput {
        return resend_validation_email.execute(self, allocator, input, options);
    }

    /// Revokes a public ACM certificate. You can only revoke certificates that have
    /// been previously exported.
    pub fn revokeCertificate(self: *Self, allocator: std.mem.Allocator, input: revoke_certificate.RevokeCertificateInput, options: revoke_certificate.Options) !revoke_certificate.RevokeCertificateOutput {
        return revoke_certificate.execute(self, allocator, input, options);
    }

    /// Updates a certificate. You can use this function to specify whether to opt
    /// in to or out of recording your certificate in a certificate transparency log
    /// and exporting. For more information, see [ Opting Out of Certificate
    /// Transparency
    /// Logging](https://docs.aws.amazon.com/acm/latest/userguide/acm-bestpractices.html#best-practices-transparency) and [Certificate Manager Exportable Managed Certificates](https://docs.aws.amazon.com/acm/latest/userguide/acm-exportable-certificates.html).
    pub fn updateCertificateOptions(self: *Self, allocator: std.mem.Allocator, input: update_certificate_options.UpdateCertificateOptionsInput, options: update_certificate_options.Options) !update_certificate_options.UpdateCertificateOptionsOutput {
        return update_certificate_options.execute(self, allocator, input, options);
    }

    pub fn listCertificatesPaginator(self: *Self, params: list_certificates.ListCertificatesInput) paginator.ListCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilCertificateValidated(self: *Self, params: describe_certificate.DescribeCertificateInput) aws.waiter.WaiterError!void {
        var w = waiters.CertificateValidatedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
