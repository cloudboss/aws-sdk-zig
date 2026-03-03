const aws = @import("aws");
const std = @import("std");

const add_attachments_to_set = @import("add_attachments_to_set.zig");
const add_communication_to_case = @import("add_communication_to_case.zig");
const create_case = @import("create_case.zig");
const describe_attachment = @import("describe_attachment.zig");
const describe_cases = @import("describe_cases.zig");
const describe_communications = @import("describe_communications.zig");
const describe_create_case_options = @import("describe_create_case_options.zig");
const describe_services = @import("describe_services.zig");
const describe_severity_levels = @import("describe_severity_levels.zig");
const describe_supported_languages = @import("describe_supported_languages.zig");
const describe_trusted_advisor_check_refresh_statuses = @import("describe_trusted_advisor_check_refresh_statuses.zig");
const describe_trusted_advisor_check_result = @import("describe_trusted_advisor_check_result.zig");
const describe_trusted_advisor_check_summaries = @import("describe_trusted_advisor_check_summaries.zig");
const describe_trusted_advisor_checks = @import("describe_trusted_advisor_checks.zig");
const refresh_trusted_advisor_check = @import("refresh_trusted_advisor_check.zig");
const resolve_case = @import("resolve_case.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Support";

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

    /// Adds one or more attachments to an attachment set.
    ///
    /// An attachment set is a temporary container for attachments that you add to a
    /// case or
    /// case communication. The set is available for 1 hour after it's created. The
    /// `expiryTime` returned in the response is when the set expires.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn addAttachmentsToSet(self: *Self, allocator: std.mem.Allocator, input: add_attachments_to_set.AddAttachmentsToSetInput, options: add_attachments_to_set.Options) !add_attachments_to_set.AddAttachmentsToSetOutput {
        return add_attachments_to_set.execute(self, allocator, input, options);
    }

    /// Adds additional customer communication to an Amazon Web Services Support
    /// case. Use the `caseId`
    /// parameter to identify the case to which to add communication. You can list a
    /// set of
    /// email addresses to copy on the communication by using the `ccEmailAddresses`
    /// parameter. The `communicationBody` value contains the text of the
    /// communication.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn addCommunicationToCase(self: *Self, allocator: std.mem.Allocator, input: add_communication_to_case.AddCommunicationToCaseInput, options: add_communication_to_case.Options) !add_communication_to_case.AddCommunicationToCaseOutput {
        return add_communication_to_case.execute(self, allocator, input, options);
    }

    /// Creates a case in the Amazon Web Services Support Center. This operation is
    /// similar to how you create a case
    /// in the Amazon Web Services Support Center [Create
    /// Case](https://console.aws.amazon.com/support/home#/case/create) page.
    ///
    /// The Amazon Web Services Support API doesn't support requesting service limit
    /// increases. You can submit a
    /// service limit increase in the following ways:
    ///
    /// * Submit a request from the Amazon Web Services Support Center [Create
    ///   Case](https://console.aws.amazon.com/support/home#/case/create) page.
    ///
    /// * Use the Service Quotas
    ///   [RequestServiceQuotaIncrease](https://docs.aws.amazon.com/servicequotas/2019-06-24/apireference/API_RequestServiceQuotaIncrease.html) operation.
    ///
    /// A successful `CreateCase` request returns an Amazon Web Services Support
    /// case number. You can use
    /// the DescribeCases operation and specify the case number to get
    /// existing Amazon Web Services Support cases. After you create a case, use the
    /// AddCommunicationToCase operation to add additional communication or
    /// attachments to an existing case.
    ///
    /// The `caseId` is separate from the `displayId` that appears in
    /// the [Amazon Web Services Support
    /// Center](https://console.aws.amazon.com/support). Use the DescribeCases
    /// operation to get the `displayId`.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn createCase(self: *Self, allocator: std.mem.Allocator, input: create_case.CreateCaseInput, options: create_case.Options) !create_case.CreateCaseOutput {
        return create_case.execute(self, allocator, input, options);
    }

    /// Returns the attachment that has the specified ID. Attachments can include
    /// screenshots,
    /// error logs, or other files that describe your issue. Attachment IDs are
    /// generated by the
    /// case management system when you add an attachment to a case or case
    /// communication.
    /// Attachment IDs are returned in the AttachmentDetails objects that are
    /// returned by the DescribeCommunications operation.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeAttachment(self: *Self, allocator: std.mem.Allocator, input: describe_attachment.DescribeAttachmentInput, options: describe_attachment.Options) !describe_attachment.DescribeAttachmentOutput {
        return describe_attachment.execute(self, allocator, input, options);
    }

    /// Returns a list of cases that you specify by passing one or more case IDs.
    /// You can use
    /// the `afterTime` and `beforeTime` parameters to filter the cases by
    /// date. You can set values for the `includeResolvedCases` and
    /// `includeCommunications` parameters to specify how much information to
    /// return.
    ///
    /// The response returns the following in JSON format:
    ///
    /// * One or more
    ///   [CaseDetails](https://docs.aws.amazon.com/awssupport/latest/APIReference/API_CaseDetails.html) data types.
    ///
    /// * One or more `nextToken` values, which specify where to paginate the
    /// returned records represented by the `CaseDetails` objects.
    ///
    /// Case data is available for 12 months after creation. If a case was created
    /// more than
    /// 12 months ago, a request might return an error.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeCases(self: *Self, allocator: std.mem.Allocator, input: describe_cases.DescribeCasesInput, options: describe_cases.Options) !describe_cases.DescribeCasesOutput {
        return describe_cases.execute(self, allocator, input, options);
    }

    /// Returns communications and attachments for one or more support cases. Use
    /// the
    /// `afterTime` and `beforeTime` parameters to filter by date. You
    /// can use the `caseId` parameter to restrict the results to a specific
    /// case.
    ///
    /// Case data is available for 12 months after creation. If a case was created
    /// more than
    /// 12 months ago, a request for data might cause an error.
    ///
    /// You can use the `maxResults` and `nextToken` parameters to
    /// control the pagination of the results. Set `maxResults` to the number of
    /// cases that you want to display on each page, and use `nextToken` to specify
    /// the resumption of pagination.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeCommunications(self: *Self, allocator: std.mem.Allocator, input: describe_communications.DescribeCommunicationsInput, options: describe_communications.Options) !describe_communications.DescribeCommunicationsOutput {
        return describe_communications.execute(self, allocator, input, options);
    }

    /// Returns a list of CreateCaseOption types along with the
    /// corresponding supported hours and language availability. You can specify the
    /// `language`
    /// `categoryCode`,
    /// `issueType` and `serviceCode` used to retrieve the CreateCaseOptions.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeCreateCaseOptions(self: *Self, allocator: std.mem.Allocator, input: describe_create_case_options.DescribeCreateCaseOptionsInput, options: describe_create_case_options.Options) !describe_create_case_options.DescribeCreateCaseOptionsOutput {
        return describe_create_case_options.execute(self, allocator, input, options);
    }

    /// Returns the current list of Amazon Web Services services and a list of
    /// service categories for each
    /// service. You then use service names and categories in your CreateCase
    /// requests. Each Amazon Web Services service has its own set of categories.
    ///
    /// The service codes and category codes correspond to the values that appear in
    /// the
    /// **Service** and **Category** lists on the Amazon Web Services Support Center
    /// [Create Case](https://console.aws.amazon.com/support/home#/case/create)
    /// page. The values in those fields
    /// don't necessarily match the service codes and categories returned by the
    /// `DescribeServices` operation. Always use the service codes and categories
    /// that the `DescribeServices` operation returns, so that you have the most
    /// recent set of service and category codes.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeServices(self: *Self, allocator: std.mem.Allocator, input: describe_services.DescribeServicesInput, options: describe_services.Options) !describe_services.DescribeServicesOutput {
        return describe_services.execute(self, allocator, input, options);
    }

    /// Returns the list of severity levels that you can assign to a support case.
    /// The
    /// severity level for a case is also a field in the CaseDetails data type
    /// that you include for a CreateCase request.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeSeverityLevels(self: *Self, allocator: std.mem.Allocator, input: describe_severity_levels.DescribeSeverityLevelsInput, options: describe_severity_levels.Options) !describe_severity_levels.DescribeSeverityLevelsOutput {
        return describe_severity_levels.execute(self, allocator, input, options);
    }

    /// Returns a list of supported languages for a specified `categoryCode`,
    /// `issueType` and `serviceCode`. The returned supported languages will
    /// include a ISO 639-1 code for the `language`, and the language display name.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeSupportedLanguages(self: *Self, allocator: std.mem.Allocator, input: describe_supported_languages.DescribeSupportedLanguagesInput, options: describe_supported_languages.Options) !describe_supported_languages.DescribeSupportedLanguagesOutput {
        return describe_supported_languages.execute(self, allocator, input, options);
    }

    /// Returns the refresh status of the Trusted Advisor checks that have the
    /// specified check
    /// IDs. You can get the check IDs by calling the DescribeTrustedAdvisorChecks
    /// operation.
    ///
    /// Some checks are refreshed automatically, and you can't return their refresh
    /// statuses
    /// by using the `DescribeTrustedAdvisorCheckRefreshStatuses` operation. If you
    /// call this operation for these checks, you might see an
    /// `InvalidParameterValue` error.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    ///
    /// To call the Trusted Advisor operations in
    /// the Amazon Web Services Support API, you must use the US East (N. Virginia)
    /// endpoint. Currently, the US West (Oregon) and Europe (Ireland)
    /// endpoints don't support the Trusted Advisor operations. For more
    /// information, see [About the Amazon Web Services Support
    /// API](https://docs.aws.amazon.com/awssupport/latest/user/about-support-api.html#endpoint) in the *Amazon Web Services Support User Guide*.
    pub fn describeTrustedAdvisorCheckRefreshStatuses(self: *Self, allocator: std.mem.Allocator, input: describe_trusted_advisor_check_refresh_statuses.DescribeTrustedAdvisorCheckRefreshStatusesInput, options: describe_trusted_advisor_check_refresh_statuses.Options) !describe_trusted_advisor_check_refresh_statuses.DescribeTrustedAdvisorCheckRefreshStatusesOutput {
        return describe_trusted_advisor_check_refresh_statuses.execute(self, allocator, input, options);
    }

    /// Returns the results of the Trusted Advisor check that has the specified
    /// check ID. You
    /// can get the check IDs by calling the DescribeTrustedAdvisorChecks
    /// operation.
    ///
    /// The response contains a TrustedAdvisorCheckResult object, which
    /// contains these three objects:
    ///
    /// * TrustedAdvisorCategorySpecificSummary
    ///
    /// * TrustedAdvisorResourceDetail
    ///
    /// * TrustedAdvisorResourcesSummary
    ///
    /// In addition, the response contains these fields:
    ///
    /// * **status** - The alert status of the check
    /// can be `ok` (green), `warning` (yellow),
    /// `error` (red), or `not_available`.
    ///
    /// * **timestamp** - The time of the last refresh
    /// of the check.
    ///
    /// * **checkId** - The unique identifier for the
    /// check.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    ///
    /// To call the Trusted Advisor operations in
    /// the Amazon Web Services Support API, you must use the US East (N. Virginia)
    /// endpoint. Currently, the US West (Oregon) and Europe (Ireland)
    /// endpoints don't support the Trusted Advisor operations. For more
    /// information, see [About the Amazon Web Services Support
    /// API](https://docs.aws.amazon.com/awssupport/latest/user/about-support-api.html#endpoint) in the *Amazon Web Services Support User Guide*.
    pub fn describeTrustedAdvisorCheckResult(self: *Self, allocator: std.mem.Allocator, input: describe_trusted_advisor_check_result.DescribeTrustedAdvisorCheckResultInput, options: describe_trusted_advisor_check_result.Options) !describe_trusted_advisor_check_result.DescribeTrustedAdvisorCheckResultOutput {
        return describe_trusted_advisor_check_result.execute(self, allocator, input, options);
    }

    /// Returns the results for the Trusted Advisor check summaries for the check
    /// IDs that you
    /// specified. You can get the check IDs by calling the
    /// DescribeTrustedAdvisorChecks operation.
    ///
    /// The response contains an array of TrustedAdvisorCheckSummary
    /// objects.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    ///
    /// To call the Trusted Advisor operations in
    /// the Amazon Web Services Support API, you must use the US East (N. Virginia)
    /// endpoint. Currently, the US West (Oregon) and Europe (Ireland)
    /// endpoints don't support the Trusted Advisor operations. For more
    /// information, see [About the Amazon Web Services Support
    /// API](https://docs.aws.amazon.com/awssupport/latest/user/about-support-api.html#endpoint) in the *Amazon Web Services Support User Guide*.
    pub fn describeTrustedAdvisorCheckSummaries(self: *Self, allocator: std.mem.Allocator, input: describe_trusted_advisor_check_summaries.DescribeTrustedAdvisorCheckSummariesInput, options: describe_trusted_advisor_check_summaries.Options) !describe_trusted_advisor_check_summaries.DescribeTrustedAdvisorCheckSummariesOutput {
        return describe_trusted_advisor_check_summaries.execute(self, allocator, input, options);
    }

    /// Returns information about all available Trusted Advisor checks, including
    /// the name, ID,
    /// category, description, and metadata. You must specify a language code.
    ///
    /// The response contains a TrustedAdvisorCheckDescription object for
    /// each check. You must set the Amazon Web Services Region to us-east-1.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error
    /// message appears. For information about changing your support plan, see
    /// [Amazon Web Services Support](http://aws.amazon.com/premiumsupport/).
    ///
    /// * The names and descriptions for Trusted Advisor checks are subject to
    ///   change. We
    /// recommend that you specify the check ID in your code to uniquely identify a
    /// check.
    ///
    /// To call the Trusted Advisor operations in
    /// the Amazon Web Services Support API, you must use the US East (N. Virginia)
    /// endpoint. Currently, the US West (Oregon) and Europe (Ireland)
    /// endpoints don't support the Trusted Advisor operations. For more
    /// information, see [About the Amazon Web Services Support
    /// API](https://docs.aws.amazon.com/awssupport/latest/user/about-support-api.html#endpoint) in the *Amazon Web Services Support User Guide*.
    pub fn describeTrustedAdvisorChecks(self: *Self, allocator: std.mem.Allocator, input: describe_trusted_advisor_checks.DescribeTrustedAdvisorChecksInput, options: describe_trusted_advisor_checks.Options) !describe_trusted_advisor_checks.DescribeTrustedAdvisorChecksOutput {
        return describe_trusted_advisor_checks.execute(self, allocator, input, options);
    }

    /// Refreshes the Trusted Advisor check that you specify using the check ID. You
    /// can get the
    /// check IDs by calling the DescribeTrustedAdvisorChecks
    /// operation.
    ///
    /// Some checks are refreshed automatically. If you call the
    /// `RefreshTrustedAdvisorCheck` operation to refresh them, you might see
    /// the `InvalidParameterValue` error.
    ///
    /// The response contains a TrustedAdvisorCheckRefreshStatus
    /// object.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    ///
    /// To call the Trusted Advisor operations in
    /// the Amazon Web Services Support API, you must use the US East (N. Virginia)
    /// endpoint. Currently, the US West (Oregon) and Europe (Ireland)
    /// endpoints don't support the Trusted Advisor operations. For more
    /// information, see [About the Amazon Web Services Support
    /// API](https://docs.aws.amazon.com/awssupport/latest/user/about-support-api.html#endpoint) in the *Amazon Web Services Support User Guide*.
    pub fn refreshTrustedAdvisorCheck(self: *Self, allocator: std.mem.Allocator, input: refresh_trusted_advisor_check.RefreshTrustedAdvisorCheckInput, options: refresh_trusted_advisor_check.Options) !refresh_trusted_advisor_check.RefreshTrustedAdvisorCheckOutput {
        return refresh_trusted_advisor_check.execute(self, allocator, input, options);
    }

    /// Resolves a support case. This operation takes a `caseId` and returns the
    /// initial and final state of the case.
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   to use the Amazon Web Services Support
    /// API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn resolveCase(self: *Self, allocator: std.mem.Allocator, input: resolve_case.ResolveCaseInput, options: resolve_case.Options) !resolve_case.ResolveCaseOutput {
        return resolve_case.execute(self, allocator, input, options);
    }

    pub fn describeCasesPaginator(self: *Self, params: describe_cases.DescribeCasesInput) paginator.DescribeCasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCommunicationsPaginator(self: *Self, params: describe_communications.DescribeCommunicationsInput) paginator.DescribeCommunicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
