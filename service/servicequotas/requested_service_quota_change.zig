const QuotaContextInfo = @import("quota_context_info.zig").QuotaContextInfo;
const AppliedLevelEnum = @import("applied_level_enum.zig").AppliedLevelEnum;
const RequestType = @import("request_type.zig").RequestType;
const RequestStatus = @import("request_status.zig").RequestStatus;

/// Information about a quota increase request.
pub const RequestedServiceQuotaChange = struct {
    /// The case ID.
    case_id: ?[]const u8,

    /// The date and time when the quota increase request was received and the case
    /// ID was
    /// created.
    created: ?i64,

    /// The new, increased value for the quota.
    desired_value: ?f64,

    /// Indicates whether the quota is global.
    global_quota: bool = false,

    /// The unique identifier.
    id: ?[]const u8,

    /// The date and time of the most recent change.
    last_updated: ?i64,

    /// The Amazon Resource Name (ARN) of the quota.
    quota_arn: ?[]const u8,

    /// Specifies the quota identifier. To find the quota code for a specific
    /// quota, use the ListServiceQuotas operation, and look for the
    /// `QuotaCode` response in the output for the quota you want.
    quota_code: ?[]const u8,

    /// The context for this service quota.
    quota_context: ?QuotaContextInfo,

    /// Specifies the quota name.
    quota_name: ?[]const u8,

    /// Filters the response to return quota requests for the `ACCOUNT`, `RESOURCE`,
    /// or `ALL` levels. `ACCOUNT` is the default.
    quota_requested_at_level: ?AppliedLevelEnum,

    /// The IAM identity of the requester.
    requester: ?[]const u8,

    /// The type of quota increase request. Possible values include:
    ///
    /// * `AutomaticManagement` - The request was automatically created by
    /// Service Quotas Automatic Management when quota utilization approached the
    /// limit.
    ///
    /// If this field is not present, the request was manually created by a user.
    request_type: ?RequestType,

    /// Specifies the service identifier. To find the service code value
    /// for an Amazon Web Services service, use the ListServices operation.
    service_code: ?[]const u8,

    /// Specifies the service name.
    service_name: ?[]const u8,

    /// The state of the quota increase request.
    ///
    /// * `PENDING`: The quota increase request is under review by Amazon Web
    ///   Services.
    ///
    /// * `CASE_OPENED`: Service Quotas opened a support case to process the quota
    ///   increase
    /// request. Follow-up on the support case for more information.
    ///
    /// * `APPROVED`: The quota increase request is approved.
    ///
    /// * `DENIED`: The quota increase request can't be approved by Service Quotas.
    ///   Contact
    /// Amazon Web Services Support for more details.
    ///
    /// * `NOT APPROVED`: The quota increase request can't be approved by Service
    ///   Quotas. Contact
    /// Amazon Web Services Support for more details.
    ///
    /// * `CASE_CLOSED`: The support case associated with this quota increase
    ///   request was closed.
    /// Check the support case correspondence for the outcome of your quota request.
    ///
    /// * `INVALID_REQUEST`: Service Quotas couldn't process your resource-level
    ///   quota increase request because the
    /// Amazon Resource Name (ARN) specified as part of the `ContextId` is invalid.
    status: ?RequestStatus,

    /// The unit of measurement.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .case_id = "CaseId",
        .created = "Created",
        .desired_value = "DesiredValue",
        .global_quota = "GlobalQuota",
        .id = "Id",
        .last_updated = "LastUpdated",
        .quota_arn = "QuotaArn",
        .quota_code = "QuotaCode",
        .quota_context = "QuotaContext",
        .quota_name = "QuotaName",
        .quota_requested_at_level = "QuotaRequestedAtLevel",
        .requester = "Requester",
        .request_type = "RequestType",
        .service_code = "ServiceCode",
        .service_name = "ServiceName",
        .status = "Status",
        .unit = "Unit",
    };
};
