const aws = @import("aws");
const std = @import("std");

const associate_service_quota_template = @import("associate_service_quota_template.zig");
const create_support_case = @import("create_support_case.zig");
const delete_service_quota_increase_request_from_template = @import("delete_service_quota_increase_request_from_template.zig");
const disassociate_service_quota_template = @import("disassociate_service_quota_template.zig");
const get_association_for_service_quota_template = @import("get_association_for_service_quota_template.zig");
const get_auto_management_configuration = @import("get_auto_management_configuration.zig");
const get_aws_default_service_quota = @import("get_aws_default_service_quota.zig");
const get_quota_utilization_report = @import("get_quota_utilization_report.zig");
const get_requested_service_quota_change = @import("get_requested_service_quota_change.zig");
const get_service_quota = @import("get_service_quota.zig");
const get_service_quota_increase_request_from_template = @import("get_service_quota_increase_request_from_template.zig");
const list_aws_default_service_quotas = @import("list_aws_default_service_quotas.zig");
const list_requested_service_quota_change_history = @import("list_requested_service_quota_change_history.zig");
const list_requested_service_quota_change_history_by_quota = @import("list_requested_service_quota_change_history_by_quota.zig");
const list_service_quota_increase_requests_in_template = @import("list_service_quota_increase_requests_in_template.zig");
const list_service_quotas = @import("list_service_quotas.zig");
const list_services = @import("list_services.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_service_quota_increase_request_into_template = @import("put_service_quota_increase_request_into_template.zig");
const request_service_quota_increase = @import("request_service_quota_increase.zig");
const start_auto_management = @import("start_auto_management.zig");
const start_quota_utilization_report = @import("start_quota_utilization_report.zig");
const stop_auto_management = @import("stop_auto_management.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_auto_management = @import("update_auto_management.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Service Quotas";

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

    /// Associates your quota request template with your organization. When a new
    /// Amazon Web Services account is created in your organization, the quota
    /// increase requests in the
    /// template are automatically applied to the account. You can add a quota
    /// increase request
    /// for any adjustable quota to your template.
    pub fn associateServiceQuotaTemplate(self: *Self, allocator: std.mem.Allocator, input: associate_service_quota_template.AssociateServiceQuotaTemplateInput, options: associate_service_quota_template.Options) !associate_service_quota_template.AssociateServiceQuotaTemplateOutput {
        return associate_service_quota_template.execute(self, allocator, input, options);
    }

    /// Creates a Support case for an existing quota increase request. This call
    /// only creates
    /// a Support case if the request has a `Pending` status.
    pub fn createSupportCase(self: *Self, allocator: std.mem.Allocator, input: create_support_case.CreateSupportCaseInput, options: create_support_case.Options) !create_support_case.CreateSupportCaseOutput {
        return create_support_case.execute(self, allocator, input, options);
    }

    /// Deletes the quota increase request for the specified quota from your quota
    /// request
    /// template.
    pub fn deleteServiceQuotaIncreaseRequestFromTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_service_quota_increase_request_from_template.DeleteServiceQuotaIncreaseRequestFromTemplateInput, options: delete_service_quota_increase_request_from_template.Options) !delete_service_quota_increase_request_from_template.DeleteServiceQuotaIncreaseRequestFromTemplateOutput {
        return delete_service_quota_increase_request_from_template.execute(self, allocator, input, options);
    }

    /// Disables your quota request template. After a template is disabled, the
    /// quota increase
    /// requests in the template are not applied to new Amazon Web Services accounts
    /// in your organization.
    /// Disabling a quota request template does not apply its quota increase
    /// requests.
    pub fn disassociateServiceQuotaTemplate(self: *Self, allocator: std.mem.Allocator, input: disassociate_service_quota_template.DisassociateServiceQuotaTemplateInput, options: disassociate_service_quota_template.Options) !disassociate_service_quota_template.DisassociateServiceQuotaTemplateOutput {
        return disassociate_service_quota_template.execute(self, allocator, input, options);
    }

    /// Retrieves the status of the association for the quota request template.
    pub fn getAssociationForServiceQuotaTemplate(self: *Self, allocator: std.mem.Allocator, input: get_association_for_service_quota_template.GetAssociationForServiceQuotaTemplateInput, options: get_association_for_service_quota_template.Options) !get_association_for_service_quota_template.GetAssociationForServiceQuotaTemplateOutput {
        return get_association_for_service_quota_template.execute(self, allocator, input, options);
    }

    /// Retrieves information about your [Service Quotas Automatic
    /// Management](https://docs.aws.amazon.com/servicequotas/latest/userguide/automatic-management.html) configuration. Automatic Management monitors your Service Quotas utilization and notifies you before you
    /// run out of your allocated quotas.
    pub fn getAutoManagementConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_auto_management_configuration.GetAutoManagementConfigurationInput, options: get_auto_management_configuration.Options) !get_auto_management_configuration.GetAutoManagementConfigurationOutput {
        return get_auto_management_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the default value for the specified quota. The default value does
    /// not
    /// reflect any quota increases.
    pub fn getAwsDefaultServiceQuota(self: *Self, allocator: std.mem.Allocator, input: get_aws_default_service_quota.GetAWSDefaultServiceQuotaInput, options: get_aws_default_service_quota.Options) !get_aws_default_service_quota.GetAWSDefaultServiceQuotaOutput {
        return get_aws_default_service_quota.execute(self, allocator, input, options);
    }

    /// Retrieves the quota utilization report for your Amazon Web Services account.
    /// This operation returns
    /// paginated results showing your quota usage across all Amazon Web Services
    /// services, sorted by utilization
    /// percentage in descending order (highest utilization first).
    ///
    /// You must first initiate a report using the `StartQuotaUtilizationReport`
    /// operation. The report generation process is asynchronous and may take
    /// several seconds to
    /// complete. Poll this operation periodically to check the status and retrieve
    /// results when
    /// the report is ready.
    ///
    /// Each report contains up to 1,000 quota records per page. Use the `NextToken`
    /// parameter to retrieve additional pages of results. Reports are automatically
    /// deleted after
    /// 15 minutes.
    pub fn getQuotaUtilizationReport(self: *Self, allocator: std.mem.Allocator, input: get_quota_utilization_report.GetQuotaUtilizationReportInput, options: get_quota_utilization_report.Options) !get_quota_utilization_report.GetQuotaUtilizationReportOutput {
        return get_quota_utilization_report.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified quota increase request.
    pub fn getRequestedServiceQuotaChange(self: *Self, allocator: std.mem.Allocator, input: get_requested_service_quota_change.GetRequestedServiceQuotaChangeInput, options: get_requested_service_quota_change.Options) !get_requested_service_quota_change.GetRequestedServiceQuotaChangeOutput {
        return get_requested_service_quota_change.execute(self, allocator, input, options);
    }

    /// Retrieves the applied quota value for the specified account-level or
    /// resource-level
    /// quota. For some quotas, only the default values are available. If the
    /// applied quota
    /// value is not available for a quota, the quota is not retrieved.
    pub fn getServiceQuota(self: *Self, allocator: std.mem.Allocator, input: get_service_quota.GetServiceQuotaInput, options: get_service_quota.Options) !get_service_quota.GetServiceQuotaOutput {
        return get_service_quota.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified quota increase request in your
    /// quota request
    /// template.
    pub fn getServiceQuotaIncreaseRequestFromTemplate(self: *Self, allocator: std.mem.Allocator, input: get_service_quota_increase_request_from_template.GetServiceQuotaIncreaseRequestFromTemplateInput, options: get_service_quota_increase_request_from_template.Options) !get_service_quota_increase_request_from_template.GetServiceQuotaIncreaseRequestFromTemplateOutput {
        return get_service_quota_increase_request_from_template.execute(self, allocator, input, options);
    }

    /// Lists the default values for the quotas for the specified Amazon Web
    /// Services service. A default
    /// value does not reflect any quota increases.
    pub fn listAwsDefaultServiceQuotas(self: *Self, allocator: std.mem.Allocator, input: list_aws_default_service_quotas.ListAWSDefaultServiceQuotasInput, options: list_aws_default_service_quotas.Options) !list_aws_default_service_quotas.ListAWSDefaultServiceQuotasOutput {
        return list_aws_default_service_quotas.execute(self, allocator, input, options);
    }

    /// Retrieves the quota increase requests for the specified Amazon Web Services
    /// service. Filter
    /// responses to return quota requests at either the account level, resource
    /// level, or all
    /// levels. Responses include any open or closed requests within 90 days.
    pub fn listRequestedServiceQuotaChangeHistory(self: *Self, allocator: std.mem.Allocator, input: list_requested_service_quota_change_history.ListRequestedServiceQuotaChangeHistoryInput, options: list_requested_service_quota_change_history.Options) !list_requested_service_quota_change_history.ListRequestedServiceQuotaChangeHistoryOutput {
        return list_requested_service_quota_change_history.execute(self, allocator, input, options);
    }

    /// Retrieves the quota increase requests for the specified quota. Filter
    /// responses to
    /// return quota requests at either the account level, resource level, or all
    /// levels.
    pub fn listRequestedServiceQuotaChangeHistoryByQuota(self: *Self, allocator: std.mem.Allocator, input: list_requested_service_quota_change_history_by_quota.ListRequestedServiceQuotaChangeHistoryByQuotaInput, options: list_requested_service_quota_change_history_by_quota.Options) !list_requested_service_quota_change_history_by_quota.ListRequestedServiceQuotaChangeHistoryByQuotaOutput {
        return list_requested_service_quota_change_history_by_quota.execute(self, allocator, input, options);
    }

    /// Lists the quota increase requests in the specified quota request template.
    pub fn listServiceQuotaIncreaseRequestsInTemplate(self: *Self, allocator: std.mem.Allocator, input: list_service_quota_increase_requests_in_template.ListServiceQuotaIncreaseRequestsInTemplateInput, options: list_service_quota_increase_requests_in_template.Options) !list_service_quota_increase_requests_in_template.ListServiceQuotaIncreaseRequestsInTemplateOutput {
        return list_service_quota_increase_requests_in_template.execute(self, allocator, input, options);
    }

    /// Lists the applied quota values for the specified Amazon Web Services
    /// service. For some quotas, only
    /// the default values are available. If the applied quota value is not
    /// available for a
    /// quota, the quota is not retrieved. Filter responses to return applied quota
    /// values at
    /// either the account level, resource level, or all levels.
    pub fn listServiceQuotas(self: *Self, allocator: std.mem.Allocator, input: list_service_quotas.ListServiceQuotasInput, options: list_service_quotas.Options) !list_service_quotas.ListServiceQuotasOutput {
        return list_service_quotas.execute(self, allocator, input, options);
    }

    /// Lists the names and codes for the Amazon Web Services services integrated
    /// with Service Quotas.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: list_services.Options) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags assigned to the specified applied quota.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds a quota increase request to your quota request template.
    pub fn putServiceQuotaIncreaseRequestIntoTemplate(self: *Self, allocator: std.mem.Allocator, input: put_service_quota_increase_request_into_template.PutServiceQuotaIncreaseRequestIntoTemplateInput, options: put_service_quota_increase_request_into_template.Options) !put_service_quota_increase_request_into_template.PutServiceQuotaIncreaseRequestIntoTemplateOutput {
        return put_service_quota_increase_request_into_template.execute(self, allocator, input, options);
    }

    /// Submits a quota increase request for the specified quota at the account or
    /// resource
    /// level.
    pub fn requestServiceQuotaIncrease(self: *Self, allocator: std.mem.Allocator, input: request_service_quota_increase.RequestServiceQuotaIncreaseInput, options: request_service_quota_increase.Options) !request_service_quota_increase.RequestServiceQuotaIncreaseOutput {
        return request_service_quota_increase.execute(self, allocator, input, options);
    }

    /// Starts [Service Quotas Automatic
    /// Management](https://docs.aws.amazon.com/servicequotas/latest/userguide/automatic-management.html) for an Amazon Web Services account, including notification preferences
    /// and excluded quotas configurations. Automatic Management monitors your
    /// Service Quotas utilization and notifies you before you
    /// run out of your allocated quotas.
    pub fn startAutoManagement(self: *Self, allocator: std.mem.Allocator, input: start_auto_management.StartAutoManagementInput, options: start_auto_management.Options) !start_auto_management.StartAutoManagementOutput {
        return start_auto_management.execute(self, allocator, input, options);
    }

    /// Initiates the generation of a quota utilization report for your Amazon Web
    /// Services account. This
    /// asynchronous operation analyzes your quota usage across all Amazon Web
    /// Services services and returns
    /// a unique report identifier that you can use to retrieve the results.
    ///
    /// The report generation process may take several seconds to complete,
    /// depending on the
    /// number of quotas in your account. Use the `GetQuotaUtilizationReport`
    /// operation
    /// to check the status and retrieve the results when the report is ready.
    pub fn startQuotaUtilizationReport(self: *Self, allocator: std.mem.Allocator, input: start_quota_utilization_report.StartQuotaUtilizationReportInput, options: start_quota_utilization_report.Options) !start_quota_utilization_report.StartQuotaUtilizationReportOutput {
        return start_quota_utilization_report.execute(self, allocator, input, options);
    }

    /// Stops [Service Quotas Automatic
    /// Management](https://docs.aws.amazon.com/servicequotas/latest/userguide/automatic-management.html) for an Amazon Web Services account and removes all associated
    /// configurations. Automatic Management monitors your Service Quotas
    /// utilization and notifies you before you
    /// run out of your allocated quotas.
    pub fn stopAutoManagement(self: *Self, allocator: std.mem.Allocator, input: stop_auto_management.StopAutoManagementInput, options: stop_auto_management.Options) !stop_auto_management.StopAutoManagementOutput {
        return stop_auto_management.execute(self, allocator, input, options);
    }

    /// Adds tags to the specified applied quota. You can include one or more tags
    /// to add to
    /// the quota.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified applied quota. You can specify one or more
    /// tags to
    /// remove.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates your [Service Quotas Automatic
    /// Management](https://docs.aws.amazon.com/servicequotas/latest/userguide/automatic-management.html) configuration, including notification preferences and
    /// excluded quotas. Automatic Management monitors your Service Quotas
    /// utilization and notifies you before you
    /// run out of your allocated quotas.
    pub fn updateAutoManagement(self: *Self, allocator: std.mem.Allocator, input: update_auto_management.UpdateAutoManagementInput, options: update_auto_management.Options) !update_auto_management.UpdateAutoManagementOutput {
        return update_auto_management.execute(self, allocator, input, options);
    }

    pub fn listAwsDefaultServiceQuotasPaginator(self: *Self, params: list_aws_default_service_quotas.ListAWSDefaultServiceQuotasInput) paginator.ListAWSDefaultServiceQuotasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRequestedServiceQuotaChangeHistoryPaginator(self: *Self, params: list_requested_service_quota_change_history.ListRequestedServiceQuotaChangeHistoryInput) paginator.ListRequestedServiceQuotaChangeHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRequestedServiceQuotaChangeHistoryByQuotaPaginator(self: *Self, params: list_requested_service_quota_change_history_by_quota.ListRequestedServiceQuotaChangeHistoryByQuotaInput) paginator.ListRequestedServiceQuotaChangeHistoryByQuotaPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceQuotaIncreaseRequestsInTemplatePaginator(self: *Self, params: list_service_quota_increase_requests_in_template.ListServiceQuotaIncreaseRequestsInTemplateInput) paginator.ListServiceQuotaIncreaseRequestsInTemplatePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceQuotasPaginator(self: *Self, params: list_service_quotas.ListServiceQuotasInput) paginator.ListServiceQuotasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
