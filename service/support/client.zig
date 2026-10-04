const aws = @import("aws");
const std = @import("std");

const add_attachments_to_set = @import("add_attachments_to_set.zig");
const add_communication_to_case = @import("add_communication_to_case.zig");
const complete_attachment_upload = @import("complete_attachment_upload.zig");
const create_case = @import("create_case.zig");
const describe_attachment = @import("describe_attachment.zig");
const describe_attachment_upload_status = @import("describe_attachment_upload_status.zig");
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
const get_attachment_download_link = @import("get_attachment_download_link.zig");
const get_attachment_upload_links = @import("get_attachment_upload_links.zig");
const refresh_trusted_advisor_check = @import("refresh_trusted_advisor_check.zig");
const resolve_case = @import("resolve_case.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Support";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Adds one or more attachments to an attachment set.
    ///
    /// An attachment set is a temporary container for attachments that you add to a
    /// case or
    /// case communication. The set is available for 1 hour after it's created. The
    /// `expiryTime` returned in the response is when the set expires.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn addAttachmentsToSet(self: *Self, allocator: std.mem.Allocator, input: add_attachments_to_set.AddAttachmentsToSetInput, options: CallOptions) !add_attachments_to_set.AddAttachmentsToSetOutput {
        return add_attachments_to_set.execute(self, allocator, input, options);
    }

    /// Adds additional customer communication to a Amazon Web Services Support
    /// case. Use the `caseId`
    /// parameter to identify the case to which to add communication. To list a set
    /// of
    /// email addresses to copy on the communication, use the `ccEmailAddresses`
    /// parameter. The `communicationBody` value contains the text of the
    /// communication.
    ///
    /// To attach files larger than 5 MB to the communication, use the `uploadIds`
    /// parameter.
    ///
    /// Amazon Web Services Support automatically redacts sensitive information from
    /// support cases to protect your data. The following information is replaced
    /// with `[REDACTED_BY_Amazon Web Services]` and is not stored:
    ///
    /// * Amazon Web Services secret keys - The complete key is replaced. Example:
    ///   `[REDACTED_BY_Amazon Web Services]`
    ///
    /// * Private keys - The complete key is replaced. Example: `[REDACTED_BY_Amazon
    ///   Web Services]`
    ///
    /// * Credit card numbers - The number is redacted, but the last 4 digits
    ///   remain. Example: `[REDACTED_BY_Amazon Web Services]-7016`
    ///
    /// This sensitive information is never required by Amazon Web Services Support.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn addCommunicationToCase(self: *Self, allocator: std.mem.Allocator, input: add_communication_to_case.AddCommunicationToCaseInput, options: CallOptions) !add_communication_to_case.AddCommunicationToCaseOutput {
        return add_communication_to_case.execute(self, allocator, input, options);
    }

    /// Completes an attachment upload that was started with
    /// GetAttachmentUploadLinks. After you upload a part of the file to its
    /// presigned Amazon S3 URL, call `CompleteAttachmentUpload` with the
    /// `partIndex` and `eTag` of that part. You can include one part per
    /// call, or multiple parts in a single call. After `CompleteAttachmentUpload`
    /// has
    /// been called for every part of the file, the service processes the upload
    /// asynchronously. The
    /// `attachment-ready` status might not be reflected immediately. Use
    /// DescribeAttachmentUploadStatus to poll for the `uploadStatus` to
    /// become `attachment-ready` before passing the `uploadId` to CreateCase or
    /// AddCommunicationToCase.
    pub fn completeAttachmentUpload(self: *Self, allocator: std.mem.Allocator, input: complete_attachment_upload.CompleteAttachmentUploadInput, options: CallOptions) !complete_attachment_upload.CompleteAttachmentUploadOutput {
        return complete_attachment_upload.execute(self, allocator, input, options);
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
    /// Amazon Web Services Support automatically redacts sensitive information from
    /// support cases to protect your data. The following information is replaced
    /// with `[REDACTED_BY_Amazon Web Services]` and is not stored:
    ///
    /// * Amazon Web Services secret keys - The complete key is replaced. Example:
    ///   `[REDACTED_BY_Amazon Web Services]`
    ///
    /// * Private keys - The complete key is replaced. Example: `[REDACTED_BY_Amazon
    ///   Web Services]`
    ///
    /// * Credit card numbers - The number is redacted, but the last 4 digits
    ///   remain. Example: `[REDACTED_BY_Amazon Web Services]-7016`
    ///
    /// This sensitive information is never required by Amazon Web Services Support.
    ///
    /// A successful `CreateCase` request returns a Amazon Web Services Support case
    /// number. You can use
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
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn createCase(self: *Self, allocator: std.mem.Allocator, input: create_case.CreateCaseInput, options: CallOptions) !create_case.CreateCaseOutput {
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
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    ///
    /// `DescribeAttachment` can't return attachments larger than 5 MB. If the
    /// specified `attachmentId` refers to an attachment larger than 5 MB, the
    /// request fails with `InvalidParameterValueException`.
    ///
    /// To download an attachment of any size, including attachments larger than 5
    /// MB, use
    /// GetAttachmentDownloadLink.
    /// `GetAttachmentDownloadLink` returns an Amazon S3 presigned URL that you can
    /// use to download the attachment directly.
    pub fn describeAttachment(self: *Self, allocator: std.mem.Allocator, input: describe_attachment.DescribeAttachmentInput, options: CallOptions) !describe_attachment.DescribeAttachmentOutput {
        return describe_attachment.execute(self, allocator, input, options);
    }

    /// Returns the current status, file name, and progress of a multipart
    /// attachment upload that
    /// was started with GetAttachmentUploadLinks. Use this operation to track
    /// where an upload is in the workflow. While parts are still being uploaded and
    /// reported through
    /// CompleteAttachmentUpload, the `uploadStatus` is
    /// `attachment-not-ready` and `uploadProgress` reports the total number
    /// of parts and how many have been completed so far. After every part has been
    /// reported and the
    /// service finishes processing the upload asynchronously, the `uploadStatus`
    /// becomes
    /// `attachment-ready` and the `uploadId` can be attached to a case
    /// through CreateCase or AddCommunicationToCase.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeAttachmentUploadStatus(self: *Self, allocator: std.mem.Allocator, input: describe_attachment_upload_status.DescribeAttachmentUploadStatusInput, options: CallOptions) !describe_attachment_upload_status.DescribeAttachmentUploadStatusOutput {
        return describe_attachment_upload_status.execute(self, allocator, input, options);
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
    /// Case data is available for 24 months after creation. If a case was created
    /// more than
    /// 24 months ago, a request might return an error.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    ///
    /// Each Communication returned by this operation includes
    /// attachment information in two fields:
    ///
    /// * `attachmentSet`: returns only attachments that are 5 MB or
    /// smaller. Attachments larger than 5 MB are not included in this field.
    ///
    /// * `attachments`: returns all attachments regardless of size.
    ///
    /// Amazon Web Services recommends that you use the `attachments` field and
    /// download each
    /// attachment with GetAttachmentDownloadLink, which supports
    /// attachments of any size. The `attachmentSet` field and DescribeAttachment
    /// return only attachments that are 5 MB or
    /// smaller.
    pub fn describeCases(self: *Self, allocator: std.mem.Allocator, input: describe_cases.DescribeCasesInput, options: CallOptions) !describe_cases.DescribeCasesOutput {
        return describe_cases.execute(self, allocator, input, options);
    }

    /// Returns communications and attachments for one or more support cases. Use
    /// the
    /// `afterTime` and `beforeTime` parameters to filter by date. You
    /// can use the `caseId` parameter to restrict the results to a specific
    /// case.
    ///
    /// Case data is available for 24 months after creation. If a case was created
    /// more than
    /// 24 months ago, a request for data might cause an error.
    ///
    /// You can use the `maxResults` and `nextToken` parameters to
    /// control the pagination of the results. Set `maxResults` to the number of
    /// cases that you want to display on each page, and use `nextToken` to specify
    /// the resumption of pagination.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    ///
    /// Each Communication returned by this operation includes
    /// attachment information in two fields:
    ///
    /// * `attachmentSet`: returns only attachments that are 5 MB or
    /// smaller. Attachments larger than 5 MB are not included in this field.
    ///
    /// * `attachments`: returns all attachments regardless of size.
    ///
    /// Amazon Web Services recommends that you use the `attachments` field and
    /// download each
    /// attachment with GetAttachmentDownloadLink, which supports
    /// attachments of any size. The `attachmentSet` field and DescribeAttachment
    /// return only attachments that are 5 MB or
    /// smaller.
    pub fn describeCommunications(self: *Self, allocator: std.mem.Allocator, input: describe_communications.DescribeCommunicationsInput, options: CallOptions) !describe_communications.DescribeCommunicationsOutput {
        return describe_communications.execute(self, allocator, input, options);
    }

    /// Returns a list of CreateCaseOption types along with the
    /// corresponding supported hours and language availability. You can specify the
    /// `language`
    /// `categoryCode`,
    /// `issueType` and `serviceCode` used to retrieve the CreateCaseOptions.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeCreateCaseOptions(self: *Self, allocator: std.mem.Allocator, input: describe_create_case_options.DescribeCreateCaseOptionsInput, options: CallOptions) !describe_create_case_options.DescribeCreateCaseOptionsOutput {
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
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeServices(self: *Self, allocator: std.mem.Allocator, input: describe_services.DescribeServicesInput, options: CallOptions) !describe_services.DescribeServicesOutput {
        return describe_services.execute(self, allocator, input, options);
    }

    /// Returns the list of severity levels that you can assign to a support case.
    /// The
    /// severity level for a case is also a field in the CaseDetails data type
    /// that you include for a CreateCase request.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeSeverityLevels(self: *Self, allocator: std.mem.Allocator, input: describe_severity_levels.DescribeSeverityLevelsInput, options: CallOptions) !describe_severity_levels.DescribeSeverityLevelsOutput {
        return describe_severity_levels.execute(self, allocator, input, options);
    }

    /// Returns a list of supported languages for a specified `categoryCode`,
    /// `issueType` and `serviceCode`. The returned supported languages will
    /// include a ISO 639-1 code for the `language`, and the language display name.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn describeSupportedLanguages(self: *Self, allocator: std.mem.Allocator, input: describe_supported_languages.DescribeSupportedLanguagesInput, options: CallOptions) !describe_supported_languages.DescribeSupportedLanguagesOutput {
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
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
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
    pub fn describeTrustedAdvisorCheckRefreshStatuses(self: *Self, allocator: std.mem.Allocator, input: describe_trusted_advisor_check_refresh_statuses.DescribeTrustedAdvisorCheckRefreshStatusesInput, options: CallOptions) !describe_trusted_advisor_check_refresh_statuses.DescribeTrustedAdvisorCheckRefreshStatusesOutput {
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
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
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
    pub fn describeTrustedAdvisorCheckResult(self: *Self, allocator: std.mem.Allocator, input: describe_trusted_advisor_check_result.DescribeTrustedAdvisorCheckResultInput, options: CallOptions) !describe_trusted_advisor_check_result.DescribeTrustedAdvisorCheckResultOutput {
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
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
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
    ///
    /// **Understanding the Trusted Advisor Resources processed value**
    ///
    /// The **Resources processed** value, `resourcesProcessed`, usually shows both
    /// flagged resources (those with warnings or errors) and resources in good
    /// standing (ok status resources). However, some checks report flagged
    /// resources only. To understand what a specific check reports, review the
    /// detailed check information in the [Trusted Advisor check
    /// reference](https://docs.aws.amazon.com/awssupport/latest/user/trusted-advisor-check-reference.html). If you see a **Green** criterion listed in the **Alert criteria**, then the check reports all resources. If there's no **Green** criterion listed in the **Alert criteria**, then the check reports only flagged resources. For example, the [Amazon EC2 Reserved Instance optimization check (cX3c2R1chu)](https://docs.aws.amazon.com/awssupport/latest/user/cost-optimization-checks.html#amazon-ec2-reserved-instances-optimization) doesn't list a **Green** criterion in the **Alert criteria**. So, this check only reports flagged resources.
    pub fn describeTrustedAdvisorCheckSummaries(self: *Self, allocator: std.mem.Allocator, input: describe_trusted_advisor_check_summaries.DescribeTrustedAdvisorCheckSummariesInput, options: CallOptions) !describe_trusted_advisor_check_summaries.DescribeTrustedAdvisorCheckSummariesOutput {
        return describe_trusted_advisor_check_summaries.execute(self, allocator, input, options);
    }

    /// Returns information about all available Trusted Advisor checks, including
    /// the name, ID,
    /// category, description, and metadata. You must specify a language code.
    ///
    /// The response contains a TrustedAdvisorCheckDescription object for
    /// each check. You must set the Amazon Web Services Region to us-east-1.
    ///
    /// * You must have a Amazon Web Services Business Support+, Amazon Web Services
    ///   Enterprise Support, or Amazon Web Services Unified Operations plan to use
    ///   the Amazon Web Services Support API.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have a
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
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
    pub fn describeTrustedAdvisorChecks(self: *Self, allocator: std.mem.Allocator, input: describe_trusted_advisor_checks.DescribeTrustedAdvisorChecksInput, options: CallOptions) !describe_trusted_advisor_checks.DescribeTrustedAdvisorChecksOutput {
        return describe_trusted_advisor_checks.execute(self, allocator, input, options);
    }

    /// Returns a presigned download URL for an attachment that is associated with a
    /// case
    /// communication. The download link works for an attachment of any size,
    /// including attachments
    /// added through `AddAttachmentsToSet` and attachments uploaded through
    /// GetAttachmentUploadLinks. The download URL is time-limited and expires at
    /// the
    /// date and time indicated in the `downloadUrl` response field. Download the
    /// attachment from the URL before it expires.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn getAttachmentDownloadLink(self: *Self, allocator: std.mem.Allocator, input: get_attachment_download_link.GetAttachmentDownloadLinkInput, options: CallOptions) !get_attachment_download_link.GetAttachmentDownloadLinkOutput {
        return get_attachment_download_link.execute(self, allocator, input, options);
    }

    /// Returns one or more presigned upload URLs for uploading a large file
    /// attachment to a
    /// support case by using a multipart upload workflow. The maximum file size
    /// that you can upload
    /// with this workflow is 150 MB, and parts can be up to 100 MB each. Initiate a
    /// new upload by
    /// providing `fileName` and `fileSizeBytes`; the response returns a unique
    /// `uploadId`, the part size, the total number of parts, and a list of
    /// presigned
    /// upload URLs for the requested range of parts. A maximum of 10 upload URLs
    /// are returned per
    /// call. To retrieve more upload URLs for an upload
    /// that's already in progress, call `GetAttachmentUploadLinks` again with the
    /// existing
    /// `uploadId` and a new `uploadRange`.
    ///
    /// Upload each part to its presigned URL by using HTTP `PUT` and capture the
    /// ETag
    /// from the response. After you upload all parts, call CompleteAttachmentUpload
    /// with the `uploadId` and the list of part indexes and ETags to finalize the
    /// upload.
    /// You can then attach the upload to a case by passing the `uploadId` in the
    /// `uploadIds` parameter of CreateCase or AddCommunicationToCase. To monitor
    /// progress before completion, call DescribeAttachmentUploadStatus.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn getAttachmentUploadLinks(self: *Self, allocator: std.mem.Allocator, input: get_attachment_upload_links.GetAttachmentUploadLinksInput, options: CallOptions) !get_attachment_upload_links.GetAttachmentUploadLinksOutput {
        return get_attachment_upload_links.execute(self, allocator, input, options);
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
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
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
    pub fn refreshTrustedAdvisorCheck(self: *Self, allocator: std.mem.Allocator, input: refresh_trusted_advisor_check.RefreshTrustedAdvisorCheckInput, options: CallOptions) !refresh_trusted_advisor_check.RefreshTrustedAdvisorCheckOutput {
        return refresh_trusted_advisor_check.execute(self, allocator, input, options);
    }

    /// Resolves a support case. This operation takes a `caseId` and returns the
    /// initial and final state of the case.
    ///
    /// * You must have an Amazon Web Services Business Support+, Amazon Web
    ///   Services Enterprise Support, or Amazon Web Services Unified Operations
    ///   plan to use the Amazon Web Services Support
    /// API. If you're in an Amazon Web Services Region that doesn't offer one of
    /// these Amazon Web Services Support plans, or if you haven't transitioned to
    /// one of these plans, you can use the Amazon Web Services Support API with a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan.
    ///
    /// * If you call the Amazon Web Services Support API from an account that
    ///   doesn't have an
    /// Amazon Web Services Business Support+, Amazon Web Services Enterprise
    /// Support, or Amazon Web Services Unified Operations plan, the
    /// `SubscriptionRequiredException` error message appears. For
    /// information about changing your support plan, see [Amazon Web Services
    /// Support](http://aws.amazon.com/premiumsupport/).
    pub fn resolveCase(self: *Self, allocator: std.mem.Allocator, input: resolve_case.ResolveCaseInput, options: CallOptions) !resolve_case.ResolveCaseOutput {
        return resolve_case.execute(self, allocator, input, options);
    }

    pub fn describeCasesPaginator(self: *Self, params: describe_cases.DescribeCasesInput) paginator.DescribeCasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeCommunicationsPaginator(self: *Self, params: describe_communications.DescribeCommunicationsInput) paginator.DescribeCommunicationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
