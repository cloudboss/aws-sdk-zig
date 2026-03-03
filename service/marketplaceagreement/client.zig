const aws = @import("aws");
const std = @import("std");

const describe_agreement = @import("describe_agreement.zig");
const get_agreement_terms = @import("get_agreement_terms.zig");
const search_agreements = @import("search_agreements.zig");
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

    /// Provides details about an agreement, such as the proposer, acceptor, start
    /// date, and end date.
    pub fn describeAgreement(self: *Self, allocator: std.mem.Allocator, input: describe_agreement.DescribeAgreementInput, options: CallOptions) !describe_agreement.DescribeAgreementOutput {
        return describe_agreement.execute(self, allocator, input, options);
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

    pub fn getAgreementTermsPaginator(self: *Self, params: get_agreement_terms.GetAgreementTermsInput) paginator.GetAgreementTermsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchAgreementsPaginator(self: *Self, params: search_agreements.SearchAgreementsInput) paginator.SearchAgreementsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
