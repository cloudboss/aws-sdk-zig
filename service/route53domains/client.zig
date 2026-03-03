const aws = @import("aws");
const std = @import("std");

const accept_domain_transfer_from_another_aws_account = @import("accept_domain_transfer_from_another_aws_account.zig");
const associate_delegation_signer_to_domain = @import("associate_delegation_signer_to_domain.zig");
const cancel_domain_transfer_to_another_aws_account = @import("cancel_domain_transfer_to_another_aws_account.zig");
const check_domain_availability = @import("check_domain_availability.zig");
const check_domain_transferability = @import("check_domain_transferability.zig");
const delete_domain = @import("delete_domain.zig");
const delete_tags_for_domain = @import("delete_tags_for_domain.zig");
const disable_domain_auto_renew = @import("disable_domain_auto_renew.zig");
const disable_domain_transfer_lock = @import("disable_domain_transfer_lock.zig");
const disassociate_delegation_signer_from_domain = @import("disassociate_delegation_signer_from_domain.zig");
const enable_domain_auto_renew = @import("enable_domain_auto_renew.zig");
const enable_domain_transfer_lock = @import("enable_domain_transfer_lock.zig");
const get_contact_reachability_status = @import("get_contact_reachability_status.zig");
const get_domain_detail = @import("get_domain_detail.zig");
const get_domain_suggestions = @import("get_domain_suggestions.zig");
const get_operation_detail = @import("get_operation_detail.zig");
const list_domains = @import("list_domains.zig");
const list_operations = @import("list_operations.zig");
const list_prices = @import("list_prices.zig");
const list_tags_for_domain = @import("list_tags_for_domain.zig");
const push_domain = @import("push_domain.zig");
const register_domain = @import("register_domain.zig");
const reject_domain_transfer_from_another_aws_account = @import("reject_domain_transfer_from_another_aws_account.zig");
const renew_domain = @import("renew_domain.zig");
const resend_contact_reachability_email = @import("resend_contact_reachability_email.zig");
const resend_operation_authorization = @import("resend_operation_authorization.zig");
const retrieve_domain_auth_code = @import("retrieve_domain_auth_code.zig");
const transfer_domain = @import("transfer_domain.zig");
const transfer_domain_to_another_aws_account = @import("transfer_domain_to_another_aws_account.zig");
const update_domain_contact = @import("update_domain_contact.zig");
const update_domain_contact_privacy = @import("update_domain_contact_privacy.zig");
const update_domain_nameservers = @import("update_domain_nameservers.zig");
const update_tags_for_domain = @import("update_tags_for_domain.zig");
const view_billing = @import("view_billing.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Route 53 Domains";

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

    /// Accepts the transfer of a domain from another Amazon Web Services account to
    /// the
    /// currentAmazon Web Services account. You initiate a transfer between Amazon
    /// Web Services accounts using
    /// [TransferDomainToAnotherAwsAccount](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_TransferDomainToAnotherAwsAccount.html).
    ///
    /// If you use the CLI command at
    /// [accept-domain-transfer-from-another-aws-account](https://docs.aws.amazon.com/cli/latest/reference/route53domains/accept-domain-transfer-from-another-aws-account.html), use JSON format as input
    /// instead of text because otherwise CLI will throw an error from domain
    /// transfer input that includes single quotes.
    ///
    /// Use either
    /// [ListOperations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ListOperations.html) or [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html) to determine whether the operation succeeded. [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html) provides additional information, for example,
    /// `Domain Transfer from Aws Account 111122223333 has been cancelled`.
    pub fn acceptDomainTransferFromAnotherAwsAccount(self: *Self, allocator: std.mem.Allocator, input: accept_domain_transfer_from_another_aws_account.AcceptDomainTransferFromAnotherAwsAccountInput, options: CallOptions) !accept_domain_transfer_from_another_aws_account.AcceptDomainTransferFromAnotherAwsAccountOutput {
        return accept_domain_transfer_from_another_aws_account.execute(self, allocator, input, options);
    }

    /// Creates a delegation signer (DS) record in the registry zone for this domain
    /// name.
    ///
    /// Note that creating DS record at the registry impacts DNSSEC validation of
    /// your DNS
    /// records. This action may render your domain name unavailable on the internet
    /// if the
    /// steps are completed in the wrong order, or with incorrect timing. For more
    /// information
    /// about DNSSEC signing, see [Configuring DNSSEC
    /// signing](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-configuring-dnssec.html) in the *Route 53 developer
    /// guide*.
    pub fn associateDelegationSignerToDomain(self: *Self, allocator: std.mem.Allocator, input: associate_delegation_signer_to_domain.AssociateDelegationSignerToDomainInput, options: CallOptions) !associate_delegation_signer_to_domain.AssociateDelegationSignerToDomainOutput {
        return associate_delegation_signer_to_domain.execute(self, allocator, input, options);
    }

    /// Cancels the transfer of a domain from the current Amazon Web Services
    /// account to
    /// another Amazon Web Services account. You initiate a transfer betweenAmazon
    /// Web Services accounts using
    /// [TransferDomainToAnotherAwsAccount](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_TransferDomainToAnotherAwsAccount.html).
    ///
    /// You must cancel the transfer before the other Amazon Web Services account
    /// accepts
    /// the transfer using
    /// [AcceptDomainTransferFromAnotherAwsAccount](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_AcceptDomainTransferFromAnotherAwsAccount.html).
    ///
    /// Use either
    /// [ListOperations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ListOperations.html) or [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html) to determine whether the operation succeeded. [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html) provides additional information, for example,
    /// `Domain Transfer from Aws Account 111122223333 has been cancelled`.
    pub fn cancelDomainTransferToAnotherAwsAccount(self: *Self, allocator: std.mem.Allocator, input: cancel_domain_transfer_to_another_aws_account.CancelDomainTransferToAnotherAwsAccountInput, options: CallOptions) !cancel_domain_transfer_to_another_aws_account.CancelDomainTransferToAnotherAwsAccountOutput {
        return cancel_domain_transfer_to_another_aws_account.execute(self, allocator, input, options);
    }

    /// This operation checks the availability of one domain name. Note that if the
    /// availability status of a domain is pending, you must submit another request
    /// to determine
    /// the availability of the domain name.
    pub fn checkDomainAvailability(self: *Self, allocator: std.mem.Allocator, input: check_domain_availability.CheckDomainAvailabilityInput, options: CallOptions) !check_domain_availability.CheckDomainAvailabilityOutput {
        return check_domain_availability.execute(self, allocator, input, options);
    }

    /// Checks whether a domain name can be transferred to Amazon Route 53.
    pub fn checkDomainTransferability(self: *Self, allocator: std.mem.Allocator, input: check_domain_transferability.CheckDomainTransferabilityInput, options: CallOptions) !check_domain_transferability.CheckDomainTransferabilityOutput {
        return check_domain_transferability.execute(self, allocator, input, options);
    }

    /// This operation deletes the specified domain. This action is permanent. For
    /// more
    /// information, see [Deleting a domain name
    /// registration](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-delete.html).
    ///
    /// To transfer the domain registration to another registrar, use the transfer
    /// process
    /// that’s provided by the registrar to which you want to transfer the
    /// registration.
    /// Otherwise, the following apply:
    ///
    /// * You can’t get a refund for the cost of a deleted domain registration.
    ///
    /// * The registry for the top-level domain might hold the domain name for a
    ///   brief
    /// time before releasing it for other users to register (varies by registry).
    ///
    /// * When the registration has been deleted, we'll send you a confirmation to
    ///   the
    /// registrant contact. The email will come from
    /// `noreply@domainnameverification.net` or
    /// `noreply@registrar.amazon.com`.
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: CallOptions) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// This operation deletes the specified tags for a domain.
    ///
    /// All tag operations are eventually consistent; subsequent operations might
    /// not
    /// immediately represent all issued operations.
    pub fn deleteTagsForDomain(self: *Self, allocator: std.mem.Allocator, input: delete_tags_for_domain.DeleteTagsForDomainInput, options: CallOptions) !delete_tags_for_domain.DeleteTagsForDomainOutput {
        return delete_tags_for_domain.execute(self, allocator, input, options);
    }

    /// This operation disables automatic renewal of domain registration for the
    /// specified
    /// domain.
    pub fn disableDomainAutoRenew(self: *Self, allocator: std.mem.Allocator, input: disable_domain_auto_renew.DisableDomainAutoRenewInput, options: CallOptions) !disable_domain_auto_renew.DisableDomainAutoRenewOutput {
        return disable_domain_auto_renew.execute(self, allocator, input, options);
    }

    /// This operation removes the transfer lock on the domain (specifically the
    /// `clientTransferProhibited` status) to allow domain transfers. We
    /// recommend you refrain from performing this action unless you intend to
    /// transfer the
    /// domain to a different registrar. Successful submission returns an operation
    /// ID that you
    /// can use to track the progress and completion of the action. If the request
    /// is not
    /// completed successfully, the domain registrant will be notified by email.
    pub fn disableDomainTransferLock(self: *Self, allocator: std.mem.Allocator, input: disable_domain_transfer_lock.DisableDomainTransferLockInput, options: CallOptions) !disable_domain_transfer_lock.DisableDomainTransferLockOutput {
        return disable_domain_transfer_lock.execute(self, allocator, input, options);
    }

    /// Deletes a delegation signer (DS) record in the registry zone for this domain
    /// name.
    pub fn disassociateDelegationSignerFromDomain(self: *Self, allocator: std.mem.Allocator, input: disassociate_delegation_signer_from_domain.DisassociateDelegationSignerFromDomainInput, options: CallOptions) !disassociate_delegation_signer_from_domain.DisassociateDelegationSignerFromDomainOutput {
        return disassociate_delegation_signer_from_domain.execute(self, allocator, input, options);
    }

    /// This operation configures Amazon Route 53 to automatically renew the
    /// specified domain
    /// before the domain registration expires. The cost of renewing your domain
    /// registration is
    /// billed to your Amazon Web Services account.
    ///
    /// The period during which you can renew a domain name varies by TLD. For a
    /// list of TLDs
    /// and their renewal policies, see [Domains That You Can
    /// Register with Amazon Route
    /// 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/registrar-tld-list.html) in the *Amazon Route 53 Developer
    /// Guide*. Route 53 requires that you renew before the end of the renewal
    /// period so we can complete processing before the deadline.
    pub fn enableDomainAutoRenew(self: *Self, allocator: std.mem.Allocator, input: enable_domain_auto_renew.EnableDomainAutoRenewInput, options: CallOptions) !enable_domain_auto_renew.EnableDomainAutoRenewOutput {
        return enable_domain_auto_renew.execute(self, allocator, input, options);
    }

    /// This operation sets the transfer lock on the domain (specifically the
    /// `clientTransferProhibited` status) to prevent domain transfers.
    /// Successful submission returns an operation ID that you can use to track the
    /// progress and
    /// completion of the action. If the request is not completed successfully, the
    /// domain
    /// registrant will be notified by email.
    pub fn enableDomainTransferLock(self: *Self, allocator: std.mem.Allocator, input: enable_domain_transfer_lock.EnableDomainTransferLockInput, options: CallOptions) !enable_domain_transfer_lock.EnableDomainTransferLockOutput {
        return enable_domain_transfer_lock.execute(self, allocator, input, options);
    }

    /// For operations that require confirmation that the email address for the
    /// registrant
    /// contact is valid, such as registering a new domain, this operation returns
    /// information
    /// about whether the registrant contact has responded.
    ///
    /// If you want us to resend the email, use the
    /// `ResendContactReachabilityEmail` operation.
    pub fn getContactReachabilityStatus(self: *Self, allocator: std.mem.Allocator, input: get_contact_reachability_status.GetContactReachabilityStatusInput, options: CallOptions) !get_contact_reachability_status.GetContactReachabilityStatusOutput {
        return get_contact_reachability_status.execute(self, allocator, input, options);
    }

    /// This operation returns detailed information about a specified domain that is
    /// associated with the current Amazon Web Services account. Contact information
    /// for the
    /// domain is also returned as part of the output.
    pub fn getDomainDetail(self: *Self, allocator: std.mem.Allocator, input: get_domain_detail.GetDomainDetailInput, options: CallOptions) !get_domain_detail.GetDomainDetailOutput {
        return get_domain_detail.execute(self, allocator, input, options);
    }

    /// The GetDomainSuggestions operation returns a list of suggested domain names.
    pub fn getDomainSuggestions(self: *Self, allocator: std.mem.Allocator, input: get_domain_suggestions.GetDomainSuggestionsInput, options: CallOptions) !get_domain_suggestions.GetDomainSuggestionsOutput {
        return get_domain_suggestions.execute(self, allocator, input, options);
    }

    /// This operation returns the current status of an operation that is not
    /// completed.
    pub fn getOperationDetail(self: *Self, allocator: std.mem.Allocator, input: get_operation_detail.GetOperationDetailInput, options: CallOptions) !get_operation_detail.GetOperationDetailOutput {
        return get_operation_detail.execute(self, allocator, input, options);
    }

    /// This operation returns all the domain names registered with Amazon Route 53
    /// for the
    /// current Amazon Web Services account if no filtering conditions are used.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: CallOptions) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Returns information about all of the operations that return an operation ID
    /// and that
    /// have ever been performed on domains that were registered by the current
    /// account.
    ///
    /// This command runs only in the us-east-1 Region.
    pub fn listOperations(self: *Self, allocator: std.mem.Allocator, input: list_operations.ListOperationsInput, options: CallOptions) !list_operations.ListOperationsOutput {
        return list_operations.execute(self, allocator, input, options);
    }

    /// Lists the following prices for either all the TLDs supported by Route 53, or
    /// the specified TLD:
    ///
    /// * Registration
    ///
    /// * Transfer
    ///
    /// * Owner change
    ///
    /// * Domain renewal
    ///
    /// * Domain restoration
    pub fn listPrices(self: *Self, allocator: std.mem.Allocator, input: list_prices.ListPricesInput, options: CallOptions) !list_prices.ListPricesOutput {
        return list_prices.execute(self, allocator, input, options);
    }

    /// This operation returns all of the tags that are associated with the
    /// specified
    /// domain.
    ///
    /// All tag operations are eventually consistent; subsequent operations might
    /// not
    /// immediately represent all issued operations.
    pub fn listTagsForDomain(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_domain.ListTagsForDomainInput, options: CallOptions) !list_tags_for_domain.ListTagsForDomainOutput {
        return list_tags_for_domain.execute(self, allocator, input, options);
    }

    /// Moves a domain from Amazon Web Services to another registrar.
    ///
    /// Supported actions:
    ///
    /// * Changes the IPS tags of a .uk domain, and pushes it to transit. Transit
    ///   means
    /// that the domain is ready to be transferred to another registrar.
    pub fn pushDomain(self: *Self, allocator: std.mem.Allocator, input: push_domain.PushDomainInput, options: CallOptions) !push_domain.PushDomainOutput {
        return push_domain.execute(self, allocator, input, options);
    }

    /// This operation registers a domain. For some top-level domains (TLDs), this
    /// operation
    /// requires extra parameters.
    ///
    /// When you register a domain, Amazon Route 53 does the following:
    ///
    /// * Creates a Route 53 hosted zone that has the same name as the domain. Route
    ///   53
    /// assigns four name servers to your hosted zone and automatically updates your
    /// domain registration with the names of these name servers.
    ///
    /// * Enables auto renew, so your domain registration will renew automatically
    ///   each
    /// year. We'll notify you in advance of the renewal date so you can choose
    /// whether
    /// to renew the registration.
    ///
    /// * Optionally enables privacy protection, so WHOIS queries return contact for
    ///   the registrar
    /// or the phrase "REDACTED FOR PRIVACY", or "On behalf of owner."
    /// If you don't enable privacy protection, WHOIS queries return the information
    /// that you entered for the administrative, registrant, and technical
    /// contacts.
    ///
    /// While some domains may allow different privacy settings per contact, we
    /// recommend
    /// specifying the same privacy setting for all contacts.
    ///
    /// * If registration is successful, returns an operation ID that you can use to
    /// track the progress and completion of the action. If the request is not
    /// completed
    /// successfully, the domain registrant is notified by email.
    ///
    /// * Charges your Amazon Web Services account an amount based on the top-level
    /// domain. For more information, see [Amazon Route 53
    /// Pricing](http://aws.amazon.com/route53/pricing/).
    pub fn registerDomain(self: *Self, allocator: std.mem.Allocator, input: register_domain.RegisterDomainInput, options: CallOptions) !register_domain.RegisterDomainOutput {
        return register_domain.execute(self, allocator, input, options);
    }

    /// Rejects the transfer of a domain from another Amazon Web Services account to
    /// the
    /// current Amazon Web Services account. You initiate a transfer betweenAmazon
    /// Web Services accounts using
    /// [TransferDomainToAnotherAwsAccount](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_TransferDomainToAnotherAwsAccount.html).
    ///
    /// Use either
    /// [ListOperations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ListOperations.html) or [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html) to determine whether the operation succeeded. [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html) provides additional information, for example,
    /// `Domain Transfer from Aws Account 111122223333 has been cancelled`.
    pub fn rejectDomainTransferFromAnotherAwsAccount(self: *Self, allocator: std.mem.Allocator, input: reject_domain_transfer_from_another_aws_account.RejectDomainTransferFromAnotherAwsAccountInput, options: CallOptions) !reject_domain_transfer_from_another_aws_account.RejectDomainTransferFromAnotherAwsAccountOutput {
        return reject_domain_transfer_from_another_aws_account.execute(self, allocator, input, options);
    }

    /// This operation renews a domain for the specified number of years. The cost
    /// of renewing
    /// your domain is billed to your Amazon Web Services account.
    ///
    /// We recommend that you renew your domain several weeks before the expiration
    /// date. Some
    /// TLD registries delete domains before the expiration date if you haven't
    /// renewed far
    /// enough in advance. For more information about renewing domain registration,
    /// see [Renewing
    /// Registration for a
    /// Domain](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-renew.html) in the *Amazon Route 53 Developer
    /// Guide*.
    pub fn renewDomain(self: *Self, allocator: std.mem.Allocator, input: renew_domain.RenewDomainInput, options: CallOptions) !renew_domain.RenewDomainOutput {
        return renew_domain.execute(self, allocator, input, options);
    }

    /// For operations that require confirmation that the email address for the
    /// registrant
    /// contact is valid, such as registering a new domain, this operation resends
    /// the
    /// confirmation email to the current email address for the registrant contact.
    pub fn resendContactReachabilityEmail(self: *Self, allocator: std.mem.Allocator, input: resend_contact_reachability_email.ResendContactReachabilityEmailInput, options: CallOptions) !resend_contact_reachability_email.ResendContactReachabilityEmailOutput {
        return resend_contact_reachability_email.execute(self, allocator, input, options);
    }

    /// Resend the form of authorization email for this operation.
    pub fn resendOperationAuthorization(self: *Self, allocator: std.mem.Allocator, input: resend_operation_authorization.ResendOperationAuthorizationInput, options: CallOptions) !resend_operation_authorization.ResendOperationAuthorizationOutput {
        return resend_operation_authorization.execute(self, allocator, input, options);
    }

    /// This operation returns the authorization code for the domain. To transfer a
    /// domain to
    /// another registrar, you provide this value to the new registrar.
    pub fn retrieveDomainAuthCode(self: *Self, allocator: std.mem.Allocator, input: retrieve_domain_auth_code.RetrieveDomainAuthCodeInput, options: CallOptions) !retrieve_domain_auth_code.RetrieveDomainAuthCodeOutput {
        return retrieve_domain_auth_code.execute(self, allocator, input, options);
    }

    /// Transfers a domain from another registrar to Amazon Route 53.
    ///
    /// For more information about transferring domains, see the following topics:
    ///
    /// * For transfer requirements, a detailed procedure, and information about
    ///   viewing
    /// the status of a domain that you're transferring to Route 53, see
    /// [Transferring Registration for a Domain to Amazon Route
    /// 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-transfer-to-route-53.html) in the
    /// *Amazon Route 53 Developer Guide*.
    ///
    /// * For information about how to transfer a domain from one Amazon Web
    ///   Services account to another, see
    ///   [TransferDomainToAnotherAwsAccount](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_TransferDomainToAnotherAwsAccount.html).
    ///
    /// * For information about how to transfer a domain to another domain
    ///   registrar,
    /// see [Transferring a Domain from Amazon Route 53 to Another
    /// Registrar](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-transfer-from-route-53.html) in
    /// the *Amazon Route 53 Developer Guide*.
    ///
    /// During the transfer of any country code top-level domains (ccTLDs) to Route
    /// 53, except for .cc and .tv,
    /// updates to the owner contact are ignored and the owner contact data from the
    /// registry is used.
    /// You can
    /// update the owner contact after the transfer is complete. For more
    /// information, see
    /// [UpdateDomainContact](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_UpdateDomainContact.html).
    ///
    /// If the registrar for your domain is also the DNS service provider for the
    /// domain, we
    /// highly recommend that you transfer your DNS service to Route 53 or to
    /// another DNS
    /// service provider before you transfer your registration. Some registrars
    /// provide free DNS
    /// service when you purchase a domain registration. When you transfer the
    /// registration, the
    /// previous registrar will not renew your domain registration and could end
    /// your DNS
    /// service at any time.
    ///
    /// If the registrar for your domain is also the DNS service provider for the
    /// domain
    /// and you don't transfer DNS service to another provider, your website, email,
    /// and the
    /// web applications associated with the domain might become unavailable.
    ///
    /// If the transfer is successful, this method returns an operation ID that you
    /// can use to
    /// track the progress and completion of the action. If the transfer doesn't
    /// complete
    /// successfully, the domain registrant will be notified by email.
    pub fn transferDomain(self: *Self, allocator: std.mem.Allocator, input: transfer_domain.TransferDomainInput, options: CallOptions) !transfer_domain.TransferDomainOutput {
        return transfer_domain.execute(self, allocator, input, options);
    }

    /// Transfers a domain from the current Amazon Web Services account to another
    /// Amazon Web Services account. Note the following:
    ///
    /// * The Amazon Web Services account that you're transferring the domain to
    ///   must
    /// accept the transfer. If the other account doesn't accept the transfer within
    /// 3
    /// days, we cancel the transfer. See
    /// [AcceptDomainTransferFromAnotherAwsAccount](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_AcceptDomainTransferFromAnotherAwsAccount.html).
    ///
    /// * You can cancel the transfer before the other account accepts it. See
    ///   [CancelDomainTransferToAnotherAwsAccount](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_CancelDomainTransferToAnotherAwsAccount.html).
    ///
    /// * The other account can reject the transfer. See
    ///   [RejectDomainTransferFromAnotherAwsAccount](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_RejectDomainTransferFromAnotherAwsAccount.html).
    ///
    /// When you transfer a domain from one Amazon Web Services account to another,
    /// Route
    /// 53 doesn't transfer the hosted zone that is associated with the domain. DNS
    /// resolution isn't affected if the domain and the hosted zone are owned by
    /// separate
    /// accounts, so transferring the hosted zone is optional. For information about
    /// transferring the hosted zone to another Amazon Web Services account, see
    /// [Migrating a
    /// Hosted Zone to a Different Amazon Web Services
    /// Account](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/hosted-zones-migrating.html) in the
    /// *Amazon Route 53 Developer Guide*.
    ///
    /// Use either
    /// [ListOperations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ListOperations.html) or [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html) to determine whether the operation succeeded. [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html) provides additional information, for example,
    /// `Domain Transfer from Aws Account 111122223333 has been cancelled`.
    pub fn transferDomainToAnotherAwsAccount(self: *Self, allocator: std.mem.Allocator, input: transfer_domain_to_another_aws_account.TransferDomainToAnotherAwsAccountInput, options: CallOptions) !transfer_domain_to_another_aws_account.TransferDomainToAnotherAwsAccountOutput {
        return transfer_domain_to_another_aws_account.execute(self, allocator, input, options);
    }

    /// This operation updates the contact information for a particular domain. You
    /// must
    /// specify information for at least one contact: registrant, administrator, or
    /// technical.
    ///
    /// If the update is successful, this method returns an operation ID that you
    /// can use to
    /// track the progress and completion of the operation. If the request is not
    /// completed
    /// successfully, the domain registrant will be notified by email.
    pub fn updateDomainContact(self: *Self, allocator: std.mem.Allocator, input: update_domain_contact.UpdateDomainContactInput, options: CallOptions) !update_domain_contact.UpdateDomainContactOutput {
        return update_domain_contact.execute(self, allocator, input, options);
    }

    /// This operation updates the specified domain contact's privacy setting. When
    /// privacy
    /// protection is enabled, your contact information is replaced with contact
    /// information for
    /// the registrar or with the phrase "REDACTED FOR PRIVACY", or "On behalf of
    /// owner."
    ///
    /// While some domains may allow different privacy settings per contact, we
    /// recommend
    /// specifying the same privacy setting for all contacts.
    ///
    /// This operation affects only the contact information for the specified
    /// contact type
    /// (administrative, registrant, or technical). If the request succeeds, Amazon
    /// Route 53
    /// returns an operation ID that you can use with
    /// [GetOperationDetail](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_GetOperationDetail.html) to track the progress and completion of the action. If
    /// the request doesn't complete successfully, the domain registrant will be
    /// notified by
    /// email.
    ///
    /// By disabling the privacy service via API, you consent to the publication of
    /// the
    /// contact information provided for this domain via the public WHOIS database.
    /// You
    /// certify that you are the registrant of this domain name and have the
    /// authority to
    /// make this decision. You may withdraw your consent at any time by enabling
    /// privacy
    /// protection using either `UpdateDomainContactPrivacy` or the Route 53
    /// console. Enabling privacy protection removes the contact information
    /// provided for
    /// this domain from the WHOIS database. For more information on our privacy
    /// practices,
    /// see [https://aws.amazon.com/privacy/](https://aws.amazon.com/privacy/).
    pub fn updateDomainContactPrivacy(self: *Self, allocator: std.mem.Allocator, input: update_domain_contact_privacy.UpdateDomainContactPrivacyInput, options: CallOptions) !update_domain_contact_privacy.UpdateDomainContactPrivacyOutput {
        return update_domain_contact_privacy.execute(self, allocator, input, options);
    }

    /// This operation replaces the current set of name servers for the domain with
    /// the
    /// specified set of name servers. If you use Amazon Route 53 as your DNS
    /// service, specify
    /// the four name servers in the delegation set for the hosted zone for the
    /// domain.
    ///
    /// If successful, this operation returns an operation ID that you can use to
    /// track the
    /// progress and completion of the action. If the request is not completed
    /// successfully, the
    /// domain registrant will be notified by email.
    pub fn updateDomainNameservers(self: *Self, allocator: std.mem.Allocator, input: update_domain_nameservers.UpdateDomainNameserversInput, options: CallOptions) !update_domain_nameservers.UpdateDomainNameserversOutput {
        return update_domain_nameservers.execute(self, allocator, input, options);
    }

    /// This operation adds or updates tags for a specified domain.
    ///
    /// All tag operations are eventually consistent; subsequent operations might
    /// not
    /// immediately represent all issued operations.
    pub fn updateTagsForDomain(self: *Self, allocator: std.mem.Allocator, input: update_tags_for_domain.UpdateTagsForDomainInput, options: CallOptions) !update_tags_for_domain.UpdateTagsForDomainOutput {
        return update_tags_for_domain.execute(self, allocator, input, options);
    }

    /// Returns all the domain-related billing records for the current Amazon Web
    /// Services account for a specified period
    pub fn viewBilling(self: *Self, allocator: std.mem.Allocator, input: view_billing.ViewBillingInput, options: CallOptions) !view_billing.ViewBillingOutput {
        return view_billing.execute(self, allocator, input, options);
    }

    pub fn listDomainsPaginator(self: *Self, params: list_domains.ListDomainsInput) paginator.ListDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOperationsPaginator(self: *Self, params: list_operations.ListOperationsInput) paginator.ListOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPricesPaginator(self: *Self, params: list_prices.ListPricesInput) paginator.ListPricesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn viewBillingPaginator(self: *Self, params: view_billing.ViewBillingInput) paginator.ViewBillingPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
