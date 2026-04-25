const aws = @import("aws");
const std = @import("std");

const batch_create_billing_adjustment_request = @import("batch_create_billing_adjustment_request.zig");
const cancel_agreement_cancellation_request = @import("cancel_agreement_cancellation_request.zig");
const cancel_agreement_payment_request = @import("cancel_agreement_payment_request.zig");
const describe_agreement = @import("describe_agreement.zig");
const get_agreement_cancellation_request = @import("get_agreement_cancellation_request.zig");
const get_agreement_payment_request = @import("get_agreement_payment_request.zig");
const get_agreement_terms = @import("get_agreement_terms.zig");
const get_billing_adjustment_request = @import("get_billing_adjustment_request.zig");
const list_agreement_cancellation_requests = @import("list_agreement_cancellation_requests.zig");
const list_agreement_invoice_line_items = @import("list_agreement_invoice_line_items.zig");
const list_agreement_payment_requests = @import("list_agreement_payment_requests.zig");
const list_billing_adjustment_requests = @import("list_billing_adjustment_requests.zig");
const search_agreements = @import("search_agreements.zig");
const send_agreement_cancellation_request = @import("send_agreement_cancellation_request.zig");
const send_agreement_payment_request = @import("send_agreement_payment_request.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Marketplace Agreement";

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

    /// Allows sellers (proposers) to submit billing adjustment requests for one or
    /// more invoices within an agreement. Each entry in the batch specifies an
    /// invoice and the adjustment amount. The operation returns successfully
    /// created adjustment request IDs and any errors for entries that failed
    /// validation.
    ///
    /// Each entry requires a unique `clientToken` for idempotency. A
    /// `ValidationException` is returned if the adjustment amount exceeds the
    /// maximum refundable amount for the invoice.
    pub fn batchCreateBillingAdjustmentRequest(self: *Self, allocator: std.mem.Allocator, input: batch_create_billing_adjustment_request.BatchCreateBillingAdjustmentRequestInput, options: CallOptions) !batch_create_billing_adjustment_request.BatchCreateBillingAdjustmentRequestOutput {
        return batch_create_billing_adjustment_request.execute(self, allocator, input, options);
    }

    /// Allows sellers (proposers) to withdraw an existing agreement cancellation
    /// request that is in a pending state. Once cancelled, the cancellation request
    /// transitions to `CANCELLED` status and can no longer be approved or rejected
    /// by the buyer.
    ///
    /// Only cancellation requests in `PENDING_APPROVAL` status can be cancelled. A
    /// `ConflictException` is thrown if the cancellation request is in any other
    /// status.
    pub fn cancelAgreementCancellationRequest(self: *Self, allocator: std.mem.Allocator, input: cancel_agreement_cancellation_request.CancelAgreementCancellationRequestInput, options: CallOptions) !cancel_agreement_cancellation_request.CancelAgreementCancellationRequestOutput {
        return cancel_agreement_cancellation_request.execute(self, allocator, input, options);
    }

    /// Allows sellers (proposers) to cancel a payment request that is in
    /// `PENDING_APPROVAL` status. Once cancelled, the payment request transitions
    /// to `CANCELLED` status and can no longer be accepted or rejected by the
    /// buyer.
    ///
    /// Only payment requests in `PENDING_APPROVAL` status can be cancelled. A
    /// `ConflictException` is thrown if the payment request is in any other status.
    pub fn cancelAgreementPaymentRequest(self: *Self, allocator: std.mem.Allocator, input: cancel_agreement_payment_request.CancelAgreementPaymentRequestInput, options: CallOptions) !cancel_agreement_payment_request.CancelAgreementPaymentRequestOutput {
        return cancel_agreement_payment_request.execute(self, allocator, input, options);
    }

    /// Provides details about an agreement, such as the proposer, acceptor, start
    /// date, and end date.
    pub fn describeAgreement(self: *Self, allocator: std.mem.Allocator, input: describe_agreement.DescribeAgreementInput, options: CallOptions) !describe_agreement.DescribeAgreementOutput {
        return describe_agreement.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific agreement cancellation
    /// request. Both sellers (proposers) and buyers (acceptors) can use this
    /// operation to view cancellation requests associated with their agreements.
    ///
    /// The calling identity must be either the acceptor or proposer of the
    /// agreement. A `ResourceNotFoundException` is returned if the cancellation
    /// request does not exist.
    pub fn getAgreementCancellationRequest(self: *Self, allocator: std.mem.Allocator, input: get_agreement_cancellation_request.GetAgreementCancellationRequestInput, options: CallOptions) !get_agreement_cancellation_request.GetAgreementCancellationRequestOutput {
        return get_agreement_cancellation_request.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific payment request. Both
    /// sellers (proposers) and buyers (acceptors) can use this operation to view
    /// payment requests associated with their agreements. The response includes the
    /// current status, charge details, timestamps, and the charge ID if the request
    /// has been approved.
    ///
    /// The calling identity must be either the acceptor or proposer of the payment
    /// request. A `ResourceNotFoundException` is returned if the payment request
    /// does not exist.
    pub fn getAgreementPaymentRequest(self: *Self, allocator: std.mem.Allocator, input: get_agreement_payment_request.GetAgreementPaymentRequestInput, options: CallOptions) !get_agreement_payment_request.GetAgreementPaymentRequestOutput {
        return get_agreement_payment_request.execute(self, allocator, input, options);
    }

    /// Obtains details about the terms in an agreement that you participated in as
    /// proposer or acceptor.
    ///
    /// The details include:
    ///
    /// * `TermType` – The type of term, such as `LegalTerm`, `RenewalTerm`, or
    ///   `ConfigurableUpfrontPricingTerm`.
    /// * `TermID` – The ID of the particular term, which is common between offer
    ///   and agreement.
    /// * `TermPayload` – The key information contained in the term, such as the
    ///   EULA for `LegalTerm` or pricing and dimensions for various pricing terms,
    ///   such as `ConfigurableUpfrontPricingTerm` or `UsageBasedPricingTerm`.
    ///
    /// * `Configuration` – The buyer/acceptor's selection at the time of agreement
    ///   creation, such as the number of units purchased for a dimension or setting
    ///   the `EnableAutoRenew` flag.
    pub fn getAgreementTerms(self: *Self, allocator: std.mem.Allocator, input: get_agreement_terms.GetAgreementTermsInput, options: CallOptions) !get_agreement_terms.GetAgreementTermsOutput {
        return get_agreement_terms.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific billing adjustment request.
    /// Sellers (proposers) can use this operation to view the status and details of
    /// a billing adjustment request they submitted.
    ///
    /// A `ResourceNotFoundException` is returned if the billing adjustment request
    /// does not exist or the caller does not have permission to access it.
    pub fn getBillingAdjustmentRequest(self: *Self, allocator: std.mem.Allocator, input: get_billing_adjustment_request.GetBillingAdjustmentRequestInput, options: CallOptions) !get_billing_adjustment_request.GetBillingAdjustmentRequestOutput {
        return get_billing_adjustment_request.execute(self, allocator, input, options);
    }

    /// Lists agreement cancellation requests available to you as a seller or buyer.
    /// Both sellers (proposers) and buyers (acceptors) can use this operation to
    /// find cancellation requests by specifying their party type and applying
    /// optional filters.
    ///
    /// `PartyType` is a required parameter. A `ValidationException` is returned if
    /// `PartyType` is not provided. Pagination is supported through `maxResults`
    /// (1-50, default 20) and `nextToken` parameters.
    pub fn listAgreementCancellationRequests(self: *Self, allocator: std.mem.Allocator, input: list_agreement_cancellation_requests.ListAgreementCancellationRequestsInput, options: CallOptions) !list_agreement_cancellation_requests.ListAgreementCancellationRequestsOutput {
        return list_agreement_cancellation_requests.execute(self, allocator, input, options);
    }

    /// Allows sellers (proposers) to retrieve aggregated billing data from AWS
    /// Marketplace agreements using flexible grouping. Supports invoice-level
    /// aggregation with filtering by billing period, invoice type, and issued date.
    ///
    /// The `groupBy` parameter is required and currently supports only `INVOICE_ID`
    /// as a value. The `agreementId` parameter is required.
    pub fn listAgreementInvoiceLineItems(self: *Self, allocator: std.mem.Allocator, input: list_agreement_invoice_line_items.ListAgreementInvoiceLineItemsInput, options: CallOptions) !list_agreement_invoice_line_items.ListAgreementInvoiceLineItemsOutput {
        return list_agreement_invoice_line_items.execute(self, allocator, input, options);
    }

    /// Lists payment requests available to you as a seller or buyer. Both sellers
    /// (proposers) and buyers (acceptors) can use this operation to find payment
    /// requests by specifying their party type and applying optional parameters.
    ///
    /// `PartyType` is a required parameter. A `ValidationException` is returned if
    /// `PartyType` is not provided. Pagination is supported through `maxResults`
    /// (1-50, default 50) and `nextToken` parameters.
    pub fn listAgreementPaymentRequests(self: *Self, allocator: std.mem.Allocator, input: list_agreement_payment_requests.ListAgreementPaymentRequestsInput, options: CallOptions) !list_agreement_payment_requests.ListAgreementPaymentRequestsOutput {
        return list_agreement_payment_requests.execute(self, allocator, input, options);
    }

    /// Lists billing adjustment requests for a specific agreement. Sellers
    /// (proposers) can use this operation to view all billing adjustment requests
    /// associated with an agreement.
    ///
    /// Pagination is supported through `maxResults` and `nextToken` parameters.
    pub fn listBillingAdjustmentRequests(self: *Self, allocator: std.mem.Allocator, input: list_billing_adjustment_requests.ListBillingAdjustmentRequestsInput, options: CallOptions) !list_billing_adjustment_requests.ListBillingAdjustmentRequestsOutput {
        return list_billing_adjustment_requests.execute(self, allocator, input, options);
    }

    /// Searches across all agreements that a proposer has in AWS Marketplace. The
    /// search returns a list of agreements with basic agreement information.
    ///
    /// The following filter combinations are supported when the `PartyType` is
    /// `Proposer`:
    ///
    /// * `AgreementType`
    /// * `AgreementType` + `EndTime`
    /// * `AgreementType` + `ResourceType`
    /// * `AgreementType` + `ResourceType` + `EndTime`
    /// * `AgreementType` + `ResourceType` + `Status`
    /// * `AgreementType` + `ResourceType` + `Status` + `EndTime`
    /// * `AgreementType` + `ResourceId`
    /// * `AgreementType` + `ResourceId` + `EndTime`
    /// * `AgreementType` + `ResourceId` + `Status`
    /// * `AgreementType` + `ResourceId` + `Status` + `EndTime`
    /// * `AgreementType` + `AcceptorAccountId`
    /// * `AgreementType` + `AcceptorAccountId` + `EndTime`
    /// * `AgreementType` + `AcceptorAccountId` + `Status`
    /// * `AgreementType` + `AcceptorAccountId` + `Status` + `EndTime`
    /// * `AgreementType` + `AcceptorAccountId` + `OfferId`
    /// * `AgreementType` + `AcceptorAccountId` + `OfferId` + `Status`
    /// * `AgreementType` + `AcceptorAccountId` + `OfferId` + `EndTime`
    /// * `AgreementType` + `AcceptorAccountId` + `OfferId` + `Status` + `EndTime`
    /// * `AgreementType` + `AcceptorAccountId` + `ResourceId`
    /// * `AgreementType` + `AcceptorAccountId` + `ResourceId` + `Status`
    /// * `AgreementType` + `AcceptorAccountId` + `ResourceId` + `EndTime`
    /// * `AgreementType` + `AcceptorAccountId` + `ResourceId` + `Status` +
    ///   `EndTime`
    /// * `AgreementType` + `AcceptorAccountId` + `ResourceType`
    /// * `AgreementType` + `AcceptorAccountId` + `ResourceType` + `EndTime`
    /// * `AgreementType` + `AcceptorAccountId` + `ResourceType` + `Status`
    /// * `AgreementType` + `AcceptorAccountId` + `ResourceType` + `Status` +
    ///   `EndTime`
    /// * `AgreementType` + `Status`
    /// * `AgreementType` + `Status` + `EndTime`
    /// * `AgreementType` + `OfferId`
    /// * `AgreementType` + `OfferId` + `EndTime`
    /// * `AgreementType` + `OfferId` + `Status`
    /// * `AgreementType` + `OfferId` + `Status` + `EndTime`
    /// * `AgreementType` + `OfferSetId`
    /// * `AgreementType` + `OfferSetId` + `EndTime`
    /// * `AgreementType` + `OfferSetId` + `Status`
    /// * `AgreementType` + `OfferSetId` + `Status` + `EndTime`
    ///
    /// To filter by `EndTime`, you can use either `BeforeEndTime` or
    /// `AfterEndTime`. Only `EndTime` is supported for sorting.
    pub fn searchAgreements(self: *Self, allocator: std.mem.Allocator, input: search_agreements.SearchAgreementsInput, options: CallOptions) !search_agreements.SearchAgreementsOutput {
        return search_agreements.execute(self, allocator, input, options);
    }

    /// Allows sellers (proposers) to submit a cancellation request for an active
    /// agreement. The cancellation request is created in `PENDING_APPROVAL` status,
    /// at which point the buyer can review it.
    pub fn sendAgreementCancellationRequest(self: *Self, allocator: std.mem.Allocator, input: send_agreement_cancellation_request.SendAgreementCancellationRequestInput, options: CallOptions) !send_agreement_cancellation_request.SendAgreementCancellationRequestOutput {
        return send_agreement_cancellation_request.execute(self, allocator, input, options);
    }

    /// Allows sellers (proposers) to submit a payment request to buyers (acceptors)
    /// for a specific charge amount for an agreement that includes a
    /// `VariablePaymentTerm`. The payment request is created in `PENDING_APPROVAL`
    /// status, at which point the buyer can accept or reject it.
    ///
    /// The agreement must be active and have a `VariablePaymentTerm` to support
    /// payment requests. The `chargeAmount` must not exceed the remaining available
    /// balance under the `VariablePaymentTerm` `maxTotalChargeAmount`.
    pub fn sendAgreementPaymentRequest(self: *Self, allocator: std.mem.Allocator, input: send_agreement_payment_request.SendAgreementPaymentRequestInput, options: CallOptions) !send_agreement_payment_request.SendAgreementPaymentRequestOutput {
        return send_agreement_payment_request.execute(self, allocator, input, options);
    }

    pub fn getAgreementTermsPaginator(self: *Self, params: get_agreement_terms.GetAgreementTermsInput) paginator.GetAgreementTermsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAgreementCancellationRequestsPaginator(self: *Self, params: list_agreement_cancellation_requests.ListAgreementCancellationRequestsInput) paginator.ListAgreementCancellationRequestsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAgreementInvoiceLineItemsPaginator(self: *Self, params: list_agreement_invoice_line_items.ListAgreementInvoiceLineItemsInput) paginator.ListAgreementInvoiceLineItemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAgreementPaymentRequestsPaginator(self: *Self, params: list_agreement_payment_requests.ListAgreementPaymentRequestsInput) paginator.ListAgreementPaymentRequestsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBillingAdjustmentRequestsPaginator(self: *Self, params: list_billing_adjustment_requests.ListBillingAdjustmentRequestsInput) paginator.ListBillingAdjustmentRequestsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchAgreementsPaginator(self: *Self, params: search_agreements.SearchAgreementsInput) paginator.SearchAgreementsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
