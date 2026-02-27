const RecentCaseCommunications = @import("recent_case_communications.zig").RecentCaseCommunications;

/// A JSON-formatted object that contains the metadata for a support case. It is
/// contained
/// in the response from a DescribeCases request. **CaseDetails** contains the
/// following fields:
///
/// * **caseId** - The support case ID requested
/// or returned in the call. The case ID is an alphanumeric string formatted as
/// shown in this example:
/// case-*12345678910-2013-c4c1d2bf33c5cf47*.
///
/// * **categoryCode** - The category of problem
/// for the support case. Corresponds to the `CategoryCode` values
/// returned by a call to DescribeServices.
///
/// * **displayId** - The identifier for the case
/// on pages in the Amazon Web Services Support Center.
///
/// * **language** - The language in which Amazon Web Services Support handles
///   the case. Amazon Web Services Support
/// currently supports Chinese (“zh”), English ("en"), Japanese ("ja") and
/// Korean (“ko”). You must specify the ISO 639-1
/// code for the `language` parameter if you want support in that language.
///
/// * **nextToken** - A resumption point for
/// pagination.
///
/// * **recentCommunications** - One or more Communication objects. Fields of
///   these objects are
/// `attachments`, `body`, `caseId`,
/// `submittedBy`, and `timeCreated`.
///
/// * **serviceCode** - The identifier for the
/// Amazon Web Services service that corresponds to the service code defined in
/// the call to DescribeServices.
///
/// * **severityCode** - The severity code
/// assigned to the case. Contains one of the values returned by the call to
/// DescribeSeverityLevels. The possible values are:
/// `low`, `normal`, `high`,
/// `urgent`, and `critical`.
///
/// * **status** - The status of the case in the
/// Amazon Web Services Support Center. Valid values:
///
/// * `all-open`
///
/// * `customer-action-completed`
///
/// * `opened`
///
/// * `pending-customer-action`
///
/// * `reopened`
///
/// * `resolved`
///
/// * `unassigned`
///
/// * `work-in-progress`
///
/// * **subject** - The subject line of the
/// case.
///
/// * **submittedBy** - The email address of the
/// account that submitted the case.
///
/// * **timeCreated** - The time the case was
/// created, in ISO-8601 format.
pub const CaseDetails = struct {
    /// The support case ID requested or returned in the call. The case ID is an
    /// alphanumeric
    /// string formatted as shown in this example:
    /// case-*12345678910-2013-c4c1d2bf33c5cf47*
    case_id: ?[]const u8,

    /// The category of problem for the support case.
    category_code: ?[]const u8,

    /// The email addresses that receive copies of communication about the case.
    cc_email_addresses: ?[]const []const u8,

    /// The ID displayed for the case in the Amazon Web Services Support Center.
    /// This is a numeric
    /// string.
    display_id: ?[]const u8,

    /// The language in which Amazon Web Services Support handles the case. Amazon
    /// Web Services Support
    /// currently supports Chinese (“zh”), English ("en"), Japanese ("ja") and
    /// Korean (“ko”). You must specify the ISO 639-1
    /// code for the `language` parameter if you want support in that language.
    language: ?[]const u8,

    /// The five most recent communications between you and Amazon Web Services
    /// Support Center, including the
    /// IDs of any attachments to the communications. Also includes a `nextToken`
    /// that you can use to retrieve earlier communications.
    recent_communications: ?RecentCaseCommunications,

    /// The code for the Amazon Web Services service. You can get a list of codes
    /// and the corresponding
    /// service names by calling DescribeServices.
    service_code: ?[]const u8,

    /// The code for the severity level returned by the call to
    /// DescribeSeverityLevels.
    severity_code: ?[]const u8,

    /// The status of the case.
    ///
    /// Valid values:
    ///
    /// * `all-open`
    ///
    /// * `customer-action-completed`
    ///
    /// * `opened`
    ///
    /// * `pending-customer-action`
    ///
    /// * `reopened`
    ///
    /// * `resolved`
    ///
    /// * `unassigned`
    ///
    /// * `work-in-progress`
    status: ?[]const u8,

    /// The subject line for the case in the Amazon Web Services Support Center.
    subject: ?[]const u8,

    /// The email address of the account that submitted the case.
    submitted_by: ?[]const u8,

    /// The time that the case was created in the Amazon Web Services Support
    /// Center.
    time_created: ?[]const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
        .category_code = "categoryCode",
        .cc_email_addresses = "ccEmailAddresses",
        .display_id = "displayId",
        .language = "language",
        .recent_communications = "recentCommunications",
        .service_code = "serviceCode",
        .severity_code = "severityCode",
        .status = "status",
        .subject = "subject",
        .submitted_by = "submittedBy",
        .time_created = "timeCreated",
    };
};
