const aws = @import("aws");
const std = @import("std");

const accept_administrator_invitation = @import("accept_administrator_invitation.zig");
const accept_invitation = @import("accept_invitation.zig");
const batch_delete_automation_rules = @import("batch_delete_automation_rules.zig");
const batch_disable_standards = @import("batch_disable_standards.zig");
const batch_enable_standards = @import("batch_enable_standards.zig");
const batch_get_automation_rules = @import("batch_get_automation_rules.zig");
const batch_get_configuration_policy_associations = @import("batch_get_configuration_policy_associations.zig");
const batch_get_security_controls = @import("batch_get_security_controls.zig");
const batch_get_standards_control_associations = @import("batch_get_standards_control_associations.zig");
const batch_import_findings = @import("batch_import_findings.zig");
const batch_update_automation_rules = @import("batch_update_automation_rules.zig");
const batch_update_findings = @import("batch_update_findings.zig");
const batch_update_findings_v2 = @import("batch_update_findings_v2.zig");
const batch_update_standards_control_associations = @import("batch_update_standards_control_associations.zig");
const create_action_target = @import("create_action_target.zig");
const create_aggregator_v2 = @import("create_aggregator_v2.zig");
const create_automation_rule = @import("create_automation_rule.zig");
const create_automation_rule_v2 = @import("create_automation_rule_v2.zig");
const create_configuration_policy = @import("create_configuration_policy.zig");
const create_connector_v2 = @import("create_connector_v2.zig");
const create_finding_aggregator = @import("create_finding_aggregator.zig");
const create_insight = @import("create_insight.zig");
const create_members = @import("create_members.zig");
const create_ticket_v2 = @import("create_ticket_v2.zig");
const decline_invitations = @import("decline_invitations.zig");
const delete_action_target = @import("delete_action_target.zig");
const delete_aggregator_v2 = @import("delete_aggregator_v2.zig");
const delete_automation_rule_v2 = @import("delete_automation_rule_v2.zig");
const delete_configuration_policy = @import("delete_configuration_policy.zig");
const delete_connector_v2 = @import("delete_connector_v2.zig");
const delete_finding_aggregator = @import("delete_finding_aggregator.zig");
const delete_insight = @import("delete_insight.zig");
const delete_invitations = @import("delete_invitations.zig");
const delete_members = @import("delete_members.zig");
const describe_action_targets = @import("describe_action_targets.zig");
const describe_hub = @import("describe_hub.zig");
const describe_organization_configuration = @import("describe_organization_configuration.zig");
const describe_products = @import("describe_products.zig");
const describe_products_v2 = @import("describe_products_v2.zig");
const describe_security_hub_v2 = @import("describe_security_hub_v2.zig");
const describe_standards = @import("describe_standards.zig");
const describe_standards_controls = @import("describe_standards_controls.zig");
const disable_import_findings_for_product = @import("disable_import_findings_for_product.zig");
const disable_organization_admin_account = @import("disable_organization_admin_account.zig");
const disable_security_hub = @import("disable_security_hub.zig");
const disable_security_hub_v2 = @import("disable_security_hub_v2.zig");
const disassociate_from_administrator_account = @import("disassociate_from_administrator_account.zig");
const disassociate_from_master_account = @import("disassociate_from_master_account.zig");
const disassociate_members = @import("disassociate_members.zig");
const enable_import_findings_for_product = @import("enable_import_findings_for_product.zig");
const enable_organization_admin_account = @import("enable_organization_admin_account.zig");
const enable_security_hub = @import("enable_security_hub.zig");
const enable_security_hub_v2 = @import("enable_security_hub_v2.zig");
const get_administrator_account = @import("get_administrator_account.zig");
const get_aggregator_v2 = @import("get_aggregator_v2.zig");
const get_automation_rule_v2 = @import("get_automation_rule_v2.zig");
const get_configuration_policy = @import("get_configuration_policy.zig");
const get_configuration_policy_association = @import("get_configuration_policy_association.zig");
const get_connector_v2 = @import("get_connector_v2.zig");
const get_enabled_standards = @import("get_enabled_standards.zig");
const get_finding_aggregator = @import("get_finding_aggregator.zig");
const get_finding_history = @import("get_finding_history.zig");
const get_finding_statistics_v2 = @import("get_finding_statistics_v2.zig");
const get_findings = @import("get_findings.zig");
const get_findings_trends_v2 = @import("get_findings_trends_v2.zig");
const get_findings_v2 = @import("get_findings_v2.zig");
const get_insight_results = @import("get_insight_results.zig");
const get_insights = @import("get_insights.zig");
const get_invitations_count = @import("get_invitations_count.zig");
const get_master_account = @import("get_master_account.zig");
const get_members = @import("get_members.zig");
const get_resources_statistics_v2 = @import("get_resources_statistics_v2.zig");
const get_resources_trends_v2 = @import("get_resources_trends_v2.zig");
const get_resources_v2 = @import("get_resources_v2.zig");
const get_security_control_definition = @import("get_security_control_definition.zig");
const invite_members = @import("invite_members.zig");
const list_aggregators_v2 = @import("list_aggregators_v2.zig");
const list_automation_rules = @import("list_automation_rules.zig");
const list_automation_rules_v2 = @import("list_automation_rules_v2.zig");
const list_configuration_policies = @import("list_configuration_policies.zig");
const list_configuration_policy_associations = @import("list_configuration_policy_associations.zig");
const list_connectors_v2 = @import("list_connectors_v2.zig");
const list_enabled_products_for_import = @import("list_enabled_products_for_import.zig");
const list_finding_aggregators = @import("list_finding_aggregators.zig");
const list_invitations = @import("list_invitations.zig");
const list_members = @import("list_members.zig");
const list_organization_admin_accounts = @import("list_organization_admin_accounts.zig");
const list_security_control_definitions = @import("list_security_control_definitions.zig");
const list_standards_control_associations = @import("list_standards_control_associations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_connector_v2 = @import("register_connector_v2.zig");
const start_configuration_policy_association = @import("start_configuration_policy_association.zig");
const start_configuration_policy_disassociation = @import("start_configuration_policy_disassociation.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_action_target = @import("update_action_target.zig");
const update_aggregator_v2 = @import("update_aggregator_v2.zig");
const update_automation_rule_v2 = @import("update_automation_rule_v2.zig");
const update_configuration_policy = @import("update_configuration_policy.zig");
const update_connector_v2 = @import("update_connector_v2.zig");
const update_finding_aggregator = @import("update_finding_aggregator.zig");
const update_findings = @import("update_findings.zig");
const update_insight = @import("update_insight.zig");
const update_organization_configuration = @import("update_organization_configuration.zig");
const update_security_control = @import("update_security_control.zig");
const update_security_hub_configuration = @import("update_security_hub_configuration.zig");
const update_standards_control = @import("update_standards_control.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SecurityHub";

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

    /// We recommend using Organizations instead of Security Hub invitations to
    /// manage your member accounts.
    /// For information, see [Managing Security Hub administrator and member
    /// accounts with
    /// Organizations](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-accounts-orgs.html)
    /// in the *Security Hub User Guide*.
    ///
    /// Accepts the invitation to be a member account and be monitored by the
    /// Security Hub administrator
    /// account that the invitation was sent from.
    ///
    /// This operation is only used by member accounts that are not added through
    /// Organizations.
    ///
    /// When the member account accepts the invitation, permission is granted to the
    /// administrator
    /// account to view findings generated in the member account.
    pub fn acceptAdministratorInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_administrator_invitation.AcceptAdministratorInvitationInput, options: CallOptions) !accept_administrator_invitation.AcceptAdministratorInvitationOutput {
        return accept_administrator_invitation.execute(self, allocator, input, options);
    }

    /// This method is deprecated. Instead, use `AcceptAdministratorInvitation`.
    ///
    /// The Security Hub console continues to use `AcceptInvitation`. It will
    /// eventually change to use `AcceptAdministratorInvitation`. Any IAM policies
    /// that specifically control access to this function must continue to use
    /// `AcceptInvitation`. You should also add `AcceptAdministratorInvitation` to
    /// your policies to ensure that the correct permissions are in place after the
    /// console begins to use `AcceptAdministratorInvitation`.
    ///
    /// Accepts the invitation to be a member account and be monitored by the
    /// Security Hub administrator
    /// account that the invitation was sent from.
    ///
    /// This operation is only used by member accounts that are not added through
    /// Organizations.
    ///
    /// When the member account accepts the invitation, permission is granted to the
    /// administrator
    /// account to view findings generated in the member account.
    pub fn acceptInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_invitation.AcceptInvitationInput, options: CallOptions) !accept_invitation.AcceptInvitationOutput {
        return accept_invitation.execute(self, allocator, input, options);
    }

    /// Deletes one or more automation rules.
    pub fn batchDeleteAutomationRules(self: *Self, allocator: std.mem.Allocator, input: batch_delete_automation_rules.BatchDeleteAutomationRulesInput, options: CallOptions) !batch_delete_automation_rules.BatchDeleteAutomationRulesOutput {
        return batch_delete_automation_rules.execute(self, allocator, input, options);
    }

    /// Disables the standards specified by the provided
    /// `StandardsSubscriptionArns`.
    ///
    /// For more information, see [Security
    /// Standards](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards.html) section of the *Security Hub User
    /// Guide*.
    pub fn batchDisableStandards(self: *Self, allocator: std.mem.Allocator, input: batch_disable_standards.BatchDisableStandardsInput, options: CallOptions) !batch_disable_standards.BatchDisableStandardsOutput {
        return batch_disable_standards.execute(self, allocator, input, options);
    }

    /// Enables the standards specified by the provided `StandardsArn`. To obtain
    /// the
    /// ARN for a standard, use the `DescribeStandards`
    /// operation.
    ///
    /// For more information, see the [Security
    /// Standards](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards.html)
    /// section of the *Security Hub User Guide*.
    pub fn batchEnableStandards(self: *Self, allocator: std.mem.Allocator, input: batch_enable_standards.BatchEnableStandardsInput, options: CallOptions) !batch_enable_standards.BatchEnableStandardsOutput {
        return batch_enable_standards.execute(self, allocator, input, options);
    }

    /// Retrieves a list of details for automation rules based on rule Amazon
    /// Resource Names
    /// (ARNs).
    pub fn batchGetAutomationRules(self: *Self, allocator: std.mem.Allocator, input: batch_get_automation_rules.BatchGetAutomationRulesInput, options: CallOptions) !batch_get_automation_rules.BatchGetAutomationRulesOutput {
        return batch_get_automation_rules.execute(self, allocator, input, options);
    }

    /// Returns associations between an Security Hub configuration and a batch of
    /// target accounts, organizational units, or the root.
    /// Only the Security Hub delegated administrator can invoke this operation from
    /// the home Region. A configuration
    /// can refer to a configuration policy or to a self-managed configuration.
    pub fn batchGetConfigurationPolicyAssociations(self: *Self, allocator: std.mem.Allocator, input: batch_get_configuration_policy_associations.BatchGetConfigurationPolicyAssociationsInput, options: CallOptions) !batch_get_configuration_policy_associations.BatchGetConfigurationPolicyAssociationsOutput {
        return batch_get_configuration_policy_associations.execute(self, allocator, input, options);
    }

    /// Provides details about a batch of security controls for the current Amazon
    /// Web Services account and Amazon Web Services Region.
    pub fn batchGetSecurityControls(self: *Self, allocator: std.mem.Allocator, input: batch_get_security_controls.BatchGetSecurityControlsInput, options: CallOptions) !batch_get_security_controls.BatchGetSecurityControlsOutput {
        return batch_get_security_controls.execute(self, allocator, input, options);
    }

    /// For a batch of security controls and standards, identifies whether each
    /// control is currently enabled or disabled in a standard.
    ///
    /// Calls to this operation return a `RESOURCE_NOT_FOUND_EXCEPTION` error when
    /// the standard subscription for the association has a `NOT_READY_FOR_UPDATES`
    /// value for `StandardsControlsUpdatable`.
    pub fn batchGetStandardsControlAssociations(self: *Self, allocator: std.mem.Allocator, input: batch_get_standards_control_associations.BatchGetStandardsControlAssociationsInput, options: CallOptions) !batch_get_standards_control_associations.BatchGetStandardsControlAssociationsOutput {
        return batch_get_standards_control_associations.execute(self, allocator, input, options);
    }

    /// Imports security findings generated by a finding provider into Security Hub.
    /// This action is requested by the finding provider to import its findings into
    /// Security Hub.
    ///
    /// `BatchImportFindings` must be called by one of the following:
    ///
    /// * The Amazon Web Services account that is associated with a finding if you
    ///   are using
    /// the [default product
    /// ARN](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-custom-providers.html#securityhub-custom-providers-bfi-reqs)
    /// or are a partner sending findings from within a customer's Amazon Web
    /// Services account.
    /// In these cases, the identifier of the account that you are calling
    /// `BatchImportFindings`
    /// from needs to be the same as the `AwsAccountId` attribute for the finding.
    ///
    /// * An Amazon Web Services account that Security Hub has allow-listed for an
    ///   official partner
    /// integration. In this case, you can call `BatchImportFindings` from the
    /// allow-listed
    /// account and send findings from different customer accounts in the same
    /// batch.
    ///
    /// The maximum allowed size for a finding is 240 Kb. An error is returned for
    /// any finding
    /// larger than 240 Kb.
    ///
    /// After a finding is created, `BatchImportFindings` cannot be used to update
    /// the following finding fields and objects, which Security Hub customers use
    /// to manage their
    /// investigation workflow.
    ///
    /// * `Note`
    ///
    /// * `UserDefinedFields`
    ///
    /// * `VerificationState`
    ///
    /// * `Workflow`
    ///
    /// Finding providers also should not use `BatchImportFindings` to update the
    /// following attributes.
    ///
    /// * `Confidence`
    ///
    /// * `Criticality`
    ///
    /// * `RelatedFindings`
    ///
    /// * `Severity`
    ///
    /// * `Types`
    ///
    /// Instead, finding providers use `FindingProviderFields` to provide values for
    /// these attributes.
    pub fn batchImportFindings(self: *Self, allocator: std.mem.Allocator, input: batch_import_findings.BatchImportFindingsInput, options: CallOptions) !batch_import_findings.BatchImportFindingsOutput {
        return batch_import_findings.execute(self, allocator, input, options);
    }

    /// Updates one or more automation rules based on rule Amazon Resource Names
    /// (ARNs)
    /// and input parameters.
    pub fn batchUpdateAutomationRules(self: *Self, allocator: std.mem.Allocator, input: batch_update_automation_rules.BatchUpdateAutomationRulesInput, options: CallOptions) !batch_update_automation_rules.BatchUpdateAutomationRulesOutput {
        return batch_update_automation_rules.execute(self, allocator, input, options);
    }

    /// Used by Security Hub customers to update information about their
    /// investigation into one or more findings.
    /// Requested by administrator accounts or member accounts.
    /// Administrator accounts can update findings for their account and their
    /// member accounts.
    /// A member account can update findings only for their own account.
    /// Administrator and member accounts can use this operation to update the
    /// following fields and objects for one or more findings:
    ///
    /// * `Confidence`
    ///
    /// * `Criticality`
    ///
    /// * `Note`
    ///
    /// * `RelatedFindings`
    ///
    /// * `Severity`
    ///
    /// * `Types`
    ///
    /// * `UserDefinedFields`
    ///
    /// * `VerificationState`
    ///
    /// * `Workflow`
    ///
    /// If you use this operation to update a finding, your updates don’t affect the
    /// value for the `UpdatedAt` field of the finding.
    /// Also note that it can take several minutes for Security Hub to process your
    /// request and update each finding specified in the request.
    ///
    /// You can configure IAM policies to restrict access to fields and field
    /// values.
    /// For example, you might not want member accounts to be able to suppress
    /// findings or change the finding severity.
    /// For more information see [Configuring access to
    /// BatchUpdateFindings](https://docs.aws.amazon.com/securityhub/latest/userguide/finding-update-batchupdatefindings.html#batchupdatefindings-configure-access) in the *Security Hub User Guide*.
    pub fn batchUpdateFindings(self: *Self, allocator: std.mem.Allocator, input: batch_update_findings.BatchUpdateFindingsInput, options: CallOptions) !batch_update_findings.BatchUpdateFindingsOutput {
        return batch_update_findings.execute(self, allocator, input, options);
    }

    /// Used by customers to update information about their investigation into a
    /// finding.
    /// Requested by delegated administrator accounts or member accounts.
    /// Delegated administrator accounts can update findings for their account and
    /// their member accounts.
    /// Member accounts can update findings for their account. `BatchUpdateFindings`
    /// and `BatchUpdateFindingV2` both use `securityhub:BatchUpdateFindings` in the
    /// `Action` element of an IAM policy statement.
    /// You must have permission to perform the `securityhub:BatchUpdateFindings`
    /// action.
    /// Updates from `BatchUpdateFindingsV2` don't affect the value of
    /// f`inding_info.modified_time`, `finding_info.modified_time_dt`, `time`,
    /// `time_dt for a finding`.
    pub fn batchUpdateFindingsV2(self: *Self, allocator: std.mem.Allocator, input: batch_update_findings_v2.BatchUpdateFindingsV2Input, options: CallOptions) !batch_update_findings_v2.BatchUpdateFindingsV2Output {
        return batch_update_findings_v2.execute(self, allocator, input, options);
    }

    /// For a batch of security controls and standards, this operation updates the
    /// enablement status of a control in a standard.
    pub fn batchUpdateStandardsControlAssociations(self: *Self, allocator: std.mem.Allocator, input: batch_update_standards_control_associations.BatchUpdateStandardsControlAssociationsInput, options: CallOptions) !batch_update_standards_control_associations.BatchUpdateStandardsControlAssociationsOutput {
        return batch_update_standards_control_associations.execute(self, allocator, input, options);
    }

    /// Creates a custom action target in Security Hub.
    ///
    /// You can use custom actions on findings and insights in Security Hub to
    /// trigger target actions
    /// in Amazon CloudWatch Events.
    pub fn createActionTarget(self: *Self, allocator: std.mem.Allocator, input: create_action_target.CreateActionTargetInput, options: CallOptions) !create_action_target.CreateActionTargetOutput {
        return create_action_target.execute(self, allocator, input, options);
    }

    /// Enables aggregation across Amazon Web Services Regions.
    pub fn createAggregatorV2(self: *Self, allocator: std.mem.Allocator, input: create_aggregator_v2.CreateAggregatorV2Input, options: CallOptions) !create_aggregator_v2.CreateAggregatorV2Output {
        return create_aggregator_v2.execute(self, allocator, input, options);
    }

    /// Creates an automation rule based on input parameters.
    pub fn createAutomationRule(self: *Self, allocator: std.mem.Allocator, input: create_automation_rule.CreateAutomationRuleInput, options: CallOptions) !create_automation_rule.CreateAutomationRuleOutput {
        return create_automation_rule.execute(self, allocator, input, options);
    }

    /// Creates a V2 automation rule.
    pub fn createAutomationRuleV2(self: *Self, allocator: std.mem.Allocator, input: create_automation_rule_v2.CreateAutomationRuleV2Input, options: CallOptions) !create_automation_rule_v2.CreateAutomationRuleV2Output {
        return create_automation_rule_v2.execute(self, allocator, input, options);
    }

    /// Creates a configuration policy with the defined configuration. Only the
    /// Security Hub delegated administrator
    /// can invoke this operation from the home Region.
    pub fn createConfigurationPolicy(self: *Self, allocator: std.mem.Allocator, input: create_configuration_policy.CreateConfigurationPolicyInput, options: CallOptions) !create_configuration_policy.CreateConfigurationPolicyOutput {
        return create_configuration_policy.execute(self, allocator, input, options);
    }

    /// Grants permission to create a connectorV2 based on input parameters.
    pub fn createConnectorV2(self: *Self, allocator: std.mem.Allocator, input: create_connector_v2.CreateConnectorV2Input, options: CallOptions) !create_connector_v2.CreateConnectorV2Output {
        return create_connector_v2.execute(self, allocator, input, options);
    }

    /// The *aggregation Region* is now called the *home Region*.
    ///
    /// Used to enable cross-Region aggregation. This operation can be invoked from
    /// the home Region only.
    ///
    /// For information about how cross-Region aggregation works, see [Understanding
    /// cross-Region aggregation in Security
    /// Hub](https://docs.aws.amazon.com/securityhub/latest/userguide/finding-aggregation.html) in the *Security Hub User Guide*.
    pub fn createFindingAggregator(self: *Self, allocator: std.mem.Allocator, input: create_finding_aggregator.CreateFindingAggregatorInput, options: CallOptions) !create_finding_aggregator.CreateFindingAggregatorOutput {
        return create_finding_aggregator.execute(self, allocator, input, options);
    }

    /// Creates a custom insight in Security Hub. An insight is a consolidation of
    /// findings that relate
    /// to a security issue that requires attention or remediation.
    ///
    /// To group the related findings in the insight, use the
    /// `GroupByAttribute`.
    pub fn createInsight(self: *Self, allocator: std.mem.Allocator, input: create_insight.CreateInsightInput, options: CallOptions) !create_insight.CreateInsightOutput {
        return create_insight.execute(self, allocator, input, options);
    }

    /// Creates a member association in Security Hub between the specified accounts
    /// and the account
    /// used to make the request, which is the administrator account. If you are
    /// integrated with
    /// Organizations, then the administrator account is designated by the
    /// organization management account.
    ///
    /// `CreateMembers` is always used to add accounts that are not organization
    /// members.
    ///
    /// For accounts that are managed using Organizations, `CreateMembers` is only
    /// used
    /// in the following cases:
    ///
    /// * Security Hub is not configured to automatically add new organization
    ///   accounts.
    ///
    /// * The account was disassociated or deleted in Security Hub.
    ///
    /// This action can only be used by an account that has Security Hub enabled. To
    /// enable Security Hub, you
    /// can use the `EnableSecurityHub` operation.
    ///
    /// For accounts that are not organization members, you create the account
    /// association and
    /// then send an invitation to the member account. To send the invitation, you
    /// use the
    /// `InviteMembers` operation. If the account owner accepts
    /// the invitation, the account becomes a member account in Security Hub.
    ///
    /// Accounts that are managed using Organizations don't receive an invitation.
    /// They
    /// automatically become a member account in Security Hub.
    ///
    /// * If the organization account does not have Security Hub enabled, then
    ///   Security Hub and the default standards are automatically enabled. Note
    ///   that Security Hub cannot be enabled automatically for the organization
    ///   management account. The organization management account must enable
    ///   Security Hub before the administrator account enables it as a member
    ///   account.
    ///
    /// * For organization accounts that already have Security Hub enabled, Security
    ///   Hub does not make any other changes to those accounts. It does not change
    ///   their enabled standards or controls.
    ///
    /// A permissions policy is added that permits the administrator account to view
    /// the findings
    /// generated in the member account.
    ///
    /// To remove the association between the administrator and member accounts, use
    /// the `DisassociateFromMasterAccount` or `DisassociateMembers` operation.
    pub fn createMembers(self: *Self, allocator: std.mem.Allocator, input: create_members.CreateMembersInput, options: CallOptions) !create_members.CreateMembersOutput {
        return create_members.execute(self, allocator, input, options);
    }

    /// Grants permission to create a ticket in the chosen ITSM based on finding
    /// information for the provided finding metadata UID.
    pub fn createTicketV2(self: *Self, allocator: std.mem.Allocator, input: create_ticket_v2.CreateTicketV2Input, options: CallOptions) !create_ticket_v2.CreateTicketV2Output {
        return create_ticket_v2.execute(self, allocator, input, options);
    }

    /// We recommend using Organizations instead of Security Hub invitations to
    /// manage your member accounts.
    /// For information, see [Managing Security Hub administrator and member
    /// accounts with
    /// Organizations](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-accounts-orgs.html)
    /// in the *Security Hub User Guide*.
    ///
    /// Declines invitations to become a Security Hub member account.
    ///
    /// A prospective member account uses this operation to decline an invitation to
    /// become a member.
    ///
    /// Only member accounts that aren't part of an Amazon Web Services organization
    /// should use this operation.
    /// Organization accounts don't receive invitations.
    pub fn declineInvitations(self: *Self, allocator: std.mem.Allocator, input: decline_invitations.DeclineInvitationsInput, options: CallOptions) !decline_invitations.DeclineInvitationsOutput {
        return decline_invitations.execute(self, allocator, input, options);
    }

    /// Deletes a custom action target from Security Hub.
    ///
    /// Deleting a custom action target does not affect any findings or insights
    /// that were
    /// already sent to Amazon CloudWatch Events using the custom action.
    pub fn deleteActionTarget(self: *Self, allocator: std.mem.Allocator, input: delete_action_target.DeleteActionTargetInput, options: CallOptions) !delete_action_target.DeleteActionTargetOutput {
        return delete_action_target.execute(self, allocator, input, options);
    }

    /// Deletes the Aggregator V2.
    pub fn deleteAggregatorV2(self: *Self, allocator: std.mem.Allocator, input: delete_aggregator_v2.DeleteAggregatorV2Input, options: CallOptions) !delete_aggregator_v2.DeleteAggregatorV2Output {
        return delete_aggregator_v2.execute(self, allocator, input, options);
    }

    /// Deletes a V2 automation rule.
    pub fn deleteAutomationRuleV2(self: *Self, allocator: std.mem.Allocator, input: delete_automation_rule_v2.DeleteAutomationRuleV2Input, options: CallOptions) !delete_automation_rule_v2.DeleteAutomationRuleV2Output {
        return delete_automation_rule_v2.execute(self, allocator, input, options);
    }

    /// Deletes a configuration policy. Only the Security Hub delegated
    /// administrator can invoke this operation
    /// from the home Region. For the deletion to succeed, you must first
    /// disassociate a configuration policy from target accounts,
    /// organizational units, or the root by invoking the
    /// `StartConfigurationPolicyDisassociation` operation.
    pub fn deleteConfigurationPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_policy.DeleteConfigurationPolicyInput, options: CallOptions) !delete_configuration_policy.DeleteConfigurationPolicyOutput {
        return delete_configuration_policy.execute(self, allocator, input, options);
    }

    /// Grants permission to delete a connectorV2.
    pub fn deleteConnectorV2(self: *Self, allocator: std.mem.Allocator, input: delete_connector_v2.DeleteConnectorV2Input, options: CallOptions) !delete_connector_v2.DeleteConnectorV2Output {
        return delete_connector_v2.execute(self, allocator, input, options);
    }

    /// The *aggregation Region* is now called the *home Region*.
    ///
    /// Deletes a finding aggregator. When you delete the finding aggregator, you
    /// stop cross-Region aggregation. Finding replication stops
    /// occurring from the linked Regions to the home Region.
    ///
    /// When you stop cross-Region aggregation, findings that were already
    /// replicated and sent to the home Region are still visible from
    /// the home Region. However, new findings and finding updates are no longer
    /// replicated and sent to the home Region.
    pub fn deleteFindingAggregator(self: *Self, allocator: std.mem.Allocator, input: delete_finding_aggregator.DeleteFindingAggregatorInput, options: CallOptions) !delete_finding_aggregator.DeleteFindingAggregatorOutput {
        return delete_finding_aggregator.execute(self, allocator, input, options);
    }

    /// Deletes the insight specified by the `InsightArn`.
    pub fn deleteInsight(self: *Self, allocator: std.mem.Allocator, input: delete_insight.DeleteInsightInput, options: CallOptions) !delete_insight.DeleteInsightOutput {
        return delete_insight.execute(self, allocator, input, options);
    }

    /// We recommend using Organizations instead of Security Hub invitations to
    /// manage your member accounts.
    /// For information, see [Managing Security Hub administrator and member
    /// accounts with
    /// Organizations](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-accounts-orgs.html)
    /// in the *Security Hub User Guide*.
    ///
    /// Deletes invitations to become a Security Hub member account.
    ///
    /// A Security Hub administrator account can use this operation to delete
    /// invitations sent to one or more prospective member accounts.
    ///
    /// This operation is only used to delete invitations that are sent to
    /// prospective member accounts that aren't part of an Amazon Web Services
    /// organization.
    /// Organization accounts don't receive invitations.
    pub fn deleteInvitations(self: *Self, allocator: std.mem.Allocator, input: delete_invitations.DeleteInvitationsInput, options: CallOptions) !delete_invitations.DeleteInvitationsOutput {
        return delete_invitations.execute(self, allocator, input, options);
    }

    /// Deletes the specified member accounts from Security Hub.
    ///
    /// You can invoke this API only to delete accounts that became members through
    /// invitation. You can't invoke this
    /// API to delete accounts that belong to an Organizations organization.
    pub fn deleteMembers(self: *Self, allocator: std.mem.Allocator, input: delete_members.DeleteMembersInput, options: CallOptions) !delete_members.DeleteMembersOutput {
        return delete_members.execute(self, allocator, input, options);
    }

    /// Returns a list of the custom action targets in Security Hub in your account.
    pub fn describeActionTargets(self: *Self, allocator: std.mem.Allocator, input: describe_action_targets.DescribeActionTargetsInput, options: CallOptions) !describe_action_targets.DescribeActionTargetsOutput {
        return describe_action_targets.execute(self, allocator, input, options);
    }

    /// Returns details about the Hub resource in your account, including the
    /// `HubArn` and the time when you enabled Security Hub.
    pub fn describeHub(self: *Self, allocator: std.mem.Allocator, input: describe_hub.DescribeHubInput, options: CallOptions) !describe_hub.DescribeHubOutput {
        return describe_hub.execute(self, allocator, input, options);
    }

    /// Returns information about the way your organization is configured in
    /// Security Hub. Only the
    /// Security Hub administrator account can invoke this operation.
    pub fn describeOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_organization_configuration.DescribeOrganizationConfigurationInput, options: CallOptions) !describe_organization_configuration.DescribeOrganizationConfigurationOutput {
        return describe_organization_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about product integrations in Security Hub.
    ///
    /// You can optionally provide an integration ARN. If you provide an integration
    /// ARN, then
    /// the results only include that integration.
    ///
    /// If you don't provide an integration ARN, then the results include all of the
    /// available
    /// product integrations.
    pub fn describeProducts(self: *Self, allocator: std.mem.Allocator, input: describe_products.DescribeProductsInput, options: CallOptions) !describe_products.DescribeProductsOutput {
        return describe_products.execute(self, allocator, input, options);
    }

    /// Gets information about the product integration.
    pub fn describeProductsV2(self: *Self, allocator: std.mem.Allocator, input: describe_products_v2.DescribeProductsV2Input, options: CallOptions) !describe_products_v2.DescribeProductsV2Output {
        return describe_products_v2.execute(self, allocator, input, options);
    }

    /// Returns details about the service resource in your account.
    pub fn describeSecurityHubV2(self: *Self, allocator: std.mem.Allocator, input: describe_security_hub_v2.DescribeSecurityHubV2Input, options: CallOptions) !describe_security_hub_v2.DescribeSecurityHubV2Output {
        return describe_security_hub_v2.execute(self, allocator, input, options);
    }

    /// Returns a list of the available standards in Security Hub.
    ///
    /// For each standard, the results include the standard ARN, the name, and a
    /// description.
    pub fn describeStandards(self: *Self, allocator: std.mem.Allocator, input: describe_standards.DescribeStandardsInput, options: CallOptions) !describe_standards.DescribeStandardsOutput {
        return describe_standards.execute(self, allocator, input, options);
    }

    /// Returns a list of security standards controls.
    ///
    /// For each control, the results include information about whether it is
    /// currently enabled,
    /// the severity, and a link to remediation information.
    ///
    /// This operation returns an empty list for standard subscriptions where
    /// `StandardsControlsUpdatable` has value `NOT_READY_FOR_UPDATES`.
    pub fn describeStandardsControls(self: *Self, allocator: std.mem.Allocator, input: describe_standards_controls.DescribeStandardsControlsInput, options: CallOptions) !describe_standards_controls.DescribeStandardsControlsOutput {
        return describe_standards_controls.execute(self, allocator, input, options);
    }

    /// Disables the integration of the specified product with Security Hub. After
    /// the integration is
    /// disabled, findings from that product are no longer sent to Security Hub.
    pub fn disableImportFindingsForProduct(self: *Self, allocator: std.mem.Allocator, input: disable_import_findings_for_product.DisableImportFindingsForProductInput, options: CallOptions) !disable_import_findings_for_product.DisableImportFindingsForProductOutput {
        return disable_import_findings_for_product.execute(self, allocator, input, options);
    }

    /// Disables a Security Hub administrator account. Can only be called by the
    /// organization
    /// management account.
    pub fn disableOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: disable_organization_admin_account.DisableOrganizationAdminAccountInput, options: CallOptions) !disable_organization_admin_account.DisableOrganizationAdminAccountOutput {
        return disable_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Disables Security Hub in your account only in the current Amazon Web
    /// Services Region. To disable Security Hub in all
    /// Regions, you must submit one request per Region where you have enabled
    /// Security Hub.
    ///
    /// You can't disable Security Hub in an account that is currently the Security
    /// Hub administrator.
    ///
    /// When you disable Security Hub, your existing findings and insights and any
    /// Security Hub configuration
    /// settings are deleted after 90 days and cannot be recovered. Any standards
    /// that were enabled
    /// are disabled, and your administrator and member account associations are
    /// removed.
    ///
    /// If you want to save your existing findings, you must export them before you
    /// disable
    /// Security Hub.
    pub fn disableSecurityHub(self: *Self, allocator: std.mem.Allocator, input: disable_security_hub.DisableSecurityHubInput, options: CallOptions) !disable_security_hub.DisableSecurityHubOutput {
        return disable_security_hub.execute(self, allocator, input, options);
    }

    /// Disable the service for the current Amazon Web Services Region or specified
    /// Amazon Web Services Region.
    pub fn disableSecurityHubV2(self: *Self, allocator: std.mem.Allocator, input: disable_security_hub_v2.DisableSecurityHubV2Input, options: CallOptions) !disable_security_hub_v2.DisableSecurityHubV2Output {
        return disable_security_hub_v2.execute(self, allocator, input, options);
    }

    /// Disassociates the current Security Hub member account from the associated
    /// administrator
    /// account.
    ///
    /// This operation is only used by accounts that are not part of an
    /// organization. For
    /// organization accounts, only the administrator account can
    /// disassociate a member account.
    pub fn disassociateFromAdministratorAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_from_administrator_account.DisassociateFromAdministratorAccountInput, options: CallOptions) !disassociate_from_administrator_account.DisassociateFromAdministratorAccountOutput {
        return disassociate_from_administrator_account.execute(self, allocator, input, options);
    }

    /// This method is deprecated. Instead, use
    /// `DisassociateFromAdministratorAccount`.
    ///
    /// The Security Hub console continues to use `DisassociateFromMasterAccount`.
    /// It will eventually change to use `DisassociateFromAdministratorAccount`. Any
    /// IAM policies that specifically control access to this function must continue
    /// to use `DisassociateFromMasterAccount`. You should also add
    /// `DisassociateFromAdministratorAccount` to your policies to ensure that the
    /// correct permissions are in place after the console begins to use
    /// `DisassociateFromAdministratorAccount`.
    ///
    /// Disassociates the current Security Hub member account from the associated
    /// administrator
    /// account.
    ///
    /// This operation is only used by accounts that are not part of an
    /// organization. For
    /// organization accounts, only the administrator account can
    /// disassociate a member account.
    pub fn disassociateFromMasterAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_from_master_account.DisassociateFromMasterAccountInput, options: CallOptions) !disassociate_from_master_account.DisassociateFromMasterAccountOutput {
        return disassociate_from_master_account.execute(self, allocator, input, options);
    }

    /// Disassociates the specified member accounts from the associated
    /// administrator account.
    ///
    /// Can be used to disassociate both accounts that are managed using
    /// Organizations and accounts that
    /// were invited manually.
    pub fn disassociateMembers(self: *Self, allocator: std.mem.Allocator, input: disassociate_members.DisassociateMembersInput, options: CallOptions) !disassociate_members.DisassociateMembersOutput {
        return disassociate_members.execute(self, allocator, input, options);
    }

    /// Enables the integration of a partner product with Security Hub. Integrated
    /// products send
    /// findings to Security Hub.
    ///
    /// When you enable a product integration, a permissions policy that grants
    /// permission for
    /// the product to send findings to Security Hub is applied.
    pub fn enableImportFindingsForProduct(self: *Self, allocator: std.mem.Allocator, input: enable_import_findings_for_product.EnableImportFindingsForProductInput, options: CallOptions) !enable_import_findings_for_product.EnableImportFindingsForProductOutput {
        return enable_import_findings_for_product.execute(self, allocator, input, options);
    }

    /// Designates the Security Hub administrator account for an organization. Can
    /// only be called by
    /// the organization management account.
    pub fn enableOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: enable_organization_admin_account.EnableOrganizationAdminAccountInput, options: CallOptions) !enable_organization_admin_account.EnableOrganizationAdminAccountOutput {
        return enable_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Enables Security Hub for your account in the current Region or the Region
    /// you specify in the
    /// request.
    ///
    /// When you enable Security Hub, you grant to Security Hub the permissions
    /// necessary to gather findings
    /// from other services that are integrated with Security Hub.
    ///
    /// When you use the `EnableSecurityHub` operation to enable Security Hub, you
    /// also
    /// automatically enable the following standards:
    ///
    /// * Center for Internet Security (CIS) Amazon Web Services Foundations
    ///   Benchmark v1.2.0
    ///
    /// * Amazon Web Services Foundational Security Best Practices
    ///
    /// Other standards are not automatically enabled.
    ///
    /// To opt out of automatically enabled standards, set
    /// `EnableDefaultStandards` to `false`.
    ///
    /// After you enable Security Hub, to enable a standard, use the
    /// `BatchEnableStandards` operation. To disable a standard, use the
    /// `BatchDisableStandards` operation.
    ///
    /// To learn more, see the [setup
    /// information](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-settingup.html) in the *Security Hub User Guide*.
    pub fn enableSecurityHub(self: *Self, allocator: std.mem.Allocator, input: enable_security_hub.EnableSecurityHubInput, options: CallOptions) !enable_security_hub.EnableSecurityHubOutput {
        return enable_security_hub.execute(self, allocator, input, options);
    }

    /// Enables the service in account for the current Amazon Web Services Region or
    /// specified Amazon Web Services Region.
    pub fn enableSecurityHubV2(self: *Self, allocator: std.mem.Allocator, input: enable_security_hub_v2.EnableSecurityHubV2Input, options: CallOptions) !enable_security_hub_v2.EnableSecurityHubV2Output {
        return enable_security_hub_v2.execute(self, allocator, input, options);
    }

    /// Provides the details for the Security Hub administrator account for the
    /// current member account.
    ///
    /// Can be used by both member accounts that are managed using Organizations and
    /// accounts that were
    /// invited manually.
    pub fn getAdministratorAccount(self: *Self, allocator: std.mem.Allocator, input: get_administrator_account.GetAdministratorAccountInput, options: CallOptions) !get_administrator_account.GetAdministratorAccountOutput {
        return get_administrator_account.execute(self, allocator, input, options);
    }

    /// Returns the configuration of the specified Aggregator V2.
    pub fn getAggregatorV2(self: *Self, allocator: std.mem.Allocator, input: get_aggregator_v2.GetAggregatorV2Input, options: CallOptions) !get_aggregator_v2.GetAggregatorV2Output {
        return get_aggregator_v2.execute(self, allocator, input, options);
    }

    /// Returns an automation rule for the V2 service.
    pub fn getAutomationRuleV2(self: *Self, allocator: std.mem.Allocator, input: get_automation_rule_v2.GetAutomationRuleV2Input, options: CallOptions) !get_automation_rule_v2.GetAutomationRuleV2Output {
        return get_automation_rule_v2.execute(self, allocator, input, options);
    }

    /// Provides information about a configuration policy. Only the Security Hub
    /// delegated administrator can invoke
    /// this operation from the home Region.
    pub fn getConfigurationPolicy(self: *Self, allocator: std.mem.Allocator, input: get_configuration_policy.GetConfigurationPolicyInput, options: CallOptions) !get_configuration_policy.GetConfigurationPolicyOutput {
        return get_configuration_policy.execute(self, allocator, input, options);
    }

    /// Returns the association between a configuration and a target account,
    /// organizational unit, or the root. The
    /// configuration can be a configuration policy or self-managed behavior. Only
    /// the Security Hub delegated administrator can
    /// invoke this operation from the home Region.
    pub fn getConfigurationPolicyAssociation(self: *Self, allocator: std.mem.Allocator, input: get_configuration_policy_association.GetConfigurationPolicyAssociationInput, options: CallOptions) !get_configuration_policy_association.GetConfigurationPolicyAssociationOutput {
        return get_configuration_policy_association.execute(self, allocator, input, options);
    }

    /// Grants permission to retrieve details for a connectorV2 based on connector
    /// id.
    pub fn getConnectorV2(self: *Self, allocator: std.mem.Allocator, input: get_connector_v2.GetConnectorV2Input, options: CallOptions) !get_connector_v2.GetConnectorV2Output {
        return get_connector_v2.execute(self, allocator, input, options);
    }

    /// Returns a list of the standards that are currently enabled.
    pub fn getEnabledStandards(self: *Self, allocator: std.mem.Allocator, input: get_enabled_standards.GetEnabledStandardsInput, options: CallOptions) !get_enabled_standards.GetEnabledStandardsOutput {
        return get_enabled_standards.execute(self, allocator, input, options);
    }

    /// The *aggregation Region* is now called the *home Region*.
    ///
    /// Returns the current configuration in the calling account for cross-Region
    /// aggregation. A finding aggregator is a resource that establishes
    /// the home Region and any linked Regions.
    pub fn getFindingAggregator(self: *Self, allocator: std.mem.Allocator, input: get_finding_aggregator.GetFindingAggregatorInput, options: CallOptions) !get_finding_aggregator.GetFindingAggregatorOutput {
        return get_finding_aggregator.execute(self, allocator, input, options);
    }

    /// Returns the history of a Security Hub finding. The history includes changes
    /// made to any fields in
    /// the Amazon Web Services Security Finding Format (ASFF) except top-level
    /// timestamp fields, such as the `CreatedAt` and
    /// `UpdatedAt` fields.
    ///
    /// This operation might return fewer results than the maximum number of results
    /// (`MaxResults`) specified in a request, even
    /// when more results are available. If this occurs, the response includes a
    /// `NextToken` value, which you should use to retrieve
    /// the next set of results in the response. The presence of a `NextToken` value
    /// in a response doesn't necessarily indicate
    /// that the results are incomplete. However, you should continue to specify a
    /// `NextToken` value until you receive a
    /// response that doesn't include this value.
    pub fn getFindingHistory(self: *Self, allocator: std.mem.Allocator, input: get_finding_history.GetFindingHistoryInput, options: CallOptions) !get_finding_history.GetFindingHistoryOutput {
        return get_finding_history.execute(self, allocator, input, options);
    }

    /// Returns aggregated statistical data about findings.
    /// `GetFindingStatisticsV2` use `securityhub:GetAdhocInsightResults` in the
    /// `Action` element of an IAM policy statement.
    /// You must have permission to perform the `s` action.
    pub fn getFindingStatisticsV2(self: *Self, allocator: std.mem.Allocator, input: get_finding_statistics_v2.GetFindingStatisticsV2Input, options: CallOptions) !get_finding_statistics_v2.GetFindingStatisticsV2Output {
        return get_finding_statistics_v2.execute(self, allocator, input, options);
    }

    /// Returns a list of findings that match the specified criteria.
    ///
    /// If cross-Region aggregation is enabled, then when you call `GetFindings`
    /// from the home Region, the results include all of the matching findings from
    /// both the home Region and linked Regions.
    pub fn getFindings(self: *Self, allocator: std.mem.Allocator, input: get_findings.GetFindingsInput, options: CallOptions) !get_findings.GetFindingsOutput {
        return get_findings.execute(self, allocator, input, options);
    }

    /// Returns findings trend data based on the specified criteria. This operation
    /// helps you analyze patterns and changes in findings over time.
    pub fn getFindingsTrendsV2(self: *Self, allocator: std.mem.Allocator, input: get_findings_trends_v2.GetFindingsTrendsV2Input, options: CallOptions) !get_findings_trends_v2.GetFindingsTrendsV2Output {
        return get_findings_trends_v2.execute(self, allocator, input, options);
    }

    /// Return a list of findings that match the specified criteria.
    /// `GetFindings` and `GetFindingsV2` both use `securityhub:GetFindings` in the
    /// `Action` element of an IAM policy statement.
    /// You must have permission to perform the `securityhub:GetFindings` action.
    pub fn getFindingsV2(self: *Self, allocator: std.mem.Allocator, input: get_findings_v2.GetFindingsV2Input, options: CallOptions) !get_findings_v2.GetFindingsV2Output {
        return get_findings_v2.execute(self, allocator, input, options);
    }

    /// Lists the results of the Security Hub insight specified by the insight ARN.
    pub fn getInsightResults(self: *Self, allocator: std.mem.Allocator, input: get_insight_results.GetInsightResultsInput, options: CallOptions) !get_insight_results.GetInsightResultsOutput {
        return get_insight_results.execute(self, allocator, input, options);
    }

    /// Lists and describes insights for the specified insight ARNs.
    pub fn getInsights(self: *Self, allocator: std.mem.Allocator, input: get_insights.GetInsightsInput, options: CallOptions) !get_insights.GetInsightsOutput {
        return get_insights.execute(self, allocator, input, options);
    }

    /// We recommend using Organizations instead of Security Hub invitations to
    /// manage your member accounts.
    /// For information, see [Managing Security Hub administrator and member
    /// accounts with
    /// Organizations](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-accounts-orgs.html)
    /// in the *Security Hub User Guide*.
    ///
    /// Returns the count of all Security Hub membership invitations that were sent
    /// to the
    /// calling member account, not including the currently accepted invitation.
    pub fn getInvitationsCount(self: *Self, allocator: std.mem.Allocator, input: get_invitations_count.GetInvitationsCountInput, options: CallOptions) !get_invitations_count.GetInvitationsCountOutput {
        return get_invitations_count.execute(self, allocator, input, options);
    }

    /// This method is deprecated. Instead, use `GetAdministratorAccount`.
    ///
    /// The Security Hub console continues to use `GetMasterAccount`. It will
    /// eventually change to use `GetAdministratorAccount`. Any IAM policies that
    /// specifically control access to this function must continue to use
    /// `GetMasterAccount`. You should also add `GetAdministratorAccount` to your
    /// policies to ensure that the correct permissions are in place after the
    /// console begins to use `GetAdministratorAccount`.
    ///
    /// Provides the details for the Security Hub administrator account for the
    /// current member account.
    ///
    /// Can be used by both member accounts that are managed using Organizations and
    /// accounts that were
    /// invited manually.
    pub fn getMasterAccount(self: *Self, allocator: std.mem.Allocator, input: get_master_account.GetMasterAccountInput, options: CallOptions) !get_master_account.GetMasterAccountOutput {
        return get_master_account.execute(self, allocator, input, options);
    }

    /// Returns the details for the Security Hub member accounts for the specified
    /// account IDs.
    ///
    /// An administrator account can be either the delegated Security Hub
    /// administrator account for an
    /// organization or an administrator account that enabled Security Hub manually.
    ///
    /// The results include both member accounts that are managed using
    /// Organizations and accounts that
    /// were invited manually.
    pub fn getMembers(self: *Self, allocator: std.mem.Allocator, input: get_members.GetMembersInput, options: CallOptions) !get_members.GetMembersOutput {
        return get_members.execute(self, allocator, input, options);
    }

    /// Retrieves statistical information about Amazon Web Services resources and
    /// their associated security findings.
    pub fn getResourcesStatisticsV2(self: *Self, allocator: std.mem.Allocator, input: get_resources_statistics_v2.GetResourcesStatisticsV2Input, options: CallOptions) !get_resources_statistics_v2.GetResourcesStatisticsV2Output {
        return get_resources_statistics_v2.execute(self, allocator, input, options);
    }

    /// Returns resource trend data based on the specified criteria. This operation
    /// helps you analyze patterns and changes in resource compliance over time.
    pub fn getResourcesTrendsV2(self: *Self, allocator: std.mem.Allocator, input: get_resources_trends_v2.GetResourcesTrendsV2Input, options: CallOptions) !get_resources_trends_v2.GetResourcesTrendsV2Output {
        return get_resources_trends_v2.execute(self, allocator, input, options);
    }

    /// Returns a list of resources.
    pub fn getResourcesV2(self: *Self, allocator: std.mem.Allocator, input: get_resources_v2.GetResourcesV2Input, options: CallOptions) !get_resources_v2.GetResourcesV2Output {
        return get_resources_v2.execute(self, allocator, input, options);
    }

    /// Retrieves the definition of a security control. The definition includes the
    /// control title, description, Region availability, parameter definitions, and
    /// other details.
    pub fn getSecurityControlDefinition(self: *Self, allocator: std.mem.Allocator, input: get_security_control_definition.GetSecurityControlDefinitionInput, options: CallOptions) !get_security_control_definition.GetSecurityControlDefinitionOutput {
        return get_security_control_definition.execute(self, allocator, input, options);
    }

    /// We recommend using Organizations instead of Security Hub invitations to
    /// manage your member accounts.
    /// For information, see [Managing Security Hub administrator and member
    /// accounts with
    /// Organizations](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-accounts-orgs.html)
    /// in the *Security Hub User Guide*.
    ///
    /// Invites other Amazon Web Services accounts to become member accounts for the
    /// Security Hub administrator account that
    /// the invitation is sent from.
    ///
    /// This operation is only used to invite accounts that don't belong to an
    /// Amazon Web Services organization.
    /// Organization accounts don't receive invitations.
    ///
    /// Before you can use this action to invite a member, you must first use the
    /// `CreateMembers` action to create the member account in Security Hub.
    ///
    /// When the account owner enables Security Hub and accepts the invitation to
    /// become a member
    /// account, the administrator account can view the findings generated in the
    /// member account.
    pub fn inviteMembers(self: *Self, allocator: std.mem.Allocator, input: invite_members.InviteMembersInput, options: CallOptions) !invite_members.InviteMembersOutput {
        return invite_members.execute(self, allocator, input, options);
    }

    /// Retrieves a list of V2 aggregators.
    pub fn listAggregatorsV2(self: *Self, allocator: std.mem.Allocator, input: list_aggregators_v2.ListAggregatorsV2Input, options: CallOptions) !list_aggregators_v2.ListAggregatorsV2Output {
        return list_aggregators_v2.execute(self, allocator, input, options);
    }

    /// A list of automation rules and their metadata for the calling account.
    pub fn listAutomationRules(self: *Self, allocator: std.mem.Allocator, input: list_automation_rules.ListAutomationRulesInput, options: CallOptions) !list_automation_rules.ListAutomationRulesOutput {
        return list_automation_rules.execute(self, allocator, input, options);
    }

    /// Returns a list of automation rules and metadata for the calling account.
    pub fn listAutomationRulesV2(self: *Self, allocator: std.mem.Allocator, input: list_automation_rules_v2.ListAutomationRulesV2Input, options: CallOptions) !list_automation_rules_v2.ListAutomationRulesV2Output {
        return list_automation_rules_v2.execute(self, allocator, input, options);
    }

    /// Lists the configuration policies that the Security Hub delegated
    /// administrator has created for your
    /// organization. Only the delegated administrator can invoke this operation
    /// from the home Region.
    pub fn listConfigurationPolicies(self: *Self, allocator: std.mem.Allocator, input: list_configuration_policies.ListConfigurationPoliciesInput, options: CallOptions) !list_configuration_policies.ListConfigurationPoliciesOutput {
        return list_configuration_policies.execute(self, allocator, input, options);
    }

    /// Provides information about the associations for your configuration policies
    /// and self-managed behavior. Only the
    /// Security Hub delegated administrator can invoke this operation from the home
    /// Region.
    pub fn listConfigurationPolicyAssociations(self: *Self, allocator: std.mem.Allocator, input: list_configuration_policy_associations.ListConfigurationPolicyAssociationsInput, options: CallOptions) !list_configuration_policy_associations.ListConfigurationPolicyAssociationsOutput {
        return list_configuration_policy_associations.execute(self, allocator, input, options);
    }

    /// Grants permission to retrieve a list of connectorsV2 and their metadata for
    /// the calling account.
    pub fn listConnectorsV2(self: *Self, allocator: std.mem.Allocator, input: list_connectors_v2.ListConnectorsV2Input, options: CallOptions) !list_connectors_v2.ListConnectorsV2Output {
        return list_connectors_v2.execute(self, allocator, input, options);
    }

    /// Lists all findings-generating solutions (products) that you are subscribed
    /// to receive
    /// findings from in Security Hub.
    pub fn listEnabledProductsForImport(self: *Self, allocator: std.mem.Allocator, input: list_enabled_products_for_import.ListEnabledProductsForImportInput, options: CallOptions) !list_enabled_products_for_import.ListEnabledProductsForImportOutput {
        return list_enabled_products_for_import.execute(self, allocator, input, options);
    }

    /// If cross-Region aggregation is enabled, then `ListFindingAggregators`
    /// returns the Amazon Resource Name (ARN)
    /// of the finding aggregator. You can run this operation from any Amazon Web
    /// Services Region.
    pub fn listFindingAggregators(self: *Self, allocator: std.mem.Allocator, input: list_finding_aggregators.ListFindingAggregatorsInput, options: CallOptions) !list_finding_aggregators.ListFindingAggregatorsOutput {
        return list_finding_aggregators.execute(self, allocator, input, options);
    }

    /// We recommend using Organizations instead of Security Hub invitations to
    /// manage your member accounts.
    /// For information, see [Managing Security Hub administrator and member
    /// accounts with
    /// Organizations](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-accounts-orgs.html)
    /// in the *Security Hub User Guide*.
    ///
    /// Lists all Security Hub membership invitations that were sent to the calling
    /// account.
    ///
    /// Only accounts that are managed by invitation can use this operation.
    /// Accounts that are managed using the integration with Organizations don't
    /// receive invitations.
    pub fn listInvitations(self: *Self, allocator: std.mem.Allocator, input: list_invitations.ListInvitationsInput, options: CallOptions) !list_invitations.ListInvitationsOutput {
        return list_invitations.execute(self, allocator, input, options);
    }

    /// Lists details about all member accounts for the current Security Hub
    /// administrator
    /// account.
    ///
    /// The results include both member accounts that belong to an organization and
    /// member
    /// accounts that were invited manually.
    pub fn listMembers(self: *Self, allocator: std.mem.Allocator, input: list_members.ListMembersInput, options: CallOptions) !list_members.ListMembersOutput {
        return list_members.execute(self, allocator, input, options);
    }

    /// Lists the Security Hub administrator accounts. Can only be called by the
    /// organization
    /// management account.
    pub fn listOrganizationAdminAccounts(self: *Self, allocator: std.mem.Allocator, input: list_organization_admin_accounts.ListOrganizationAdminAccountsInput, options: CallOptions) !list_organization_admin_accounts.ListOrganizationAdminAccountsOutput {
        return list_organization_admin_accounts.execute(self, allocator, input, options);
    }

    /// Lists all of the security controls that apply to a specified standard.
    pub fn listSecurityControlDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_security_control_definitions.ListSecurityControlDefinitionsInput, options: CallOptions) !list_security_control_definitions.ListSecurityControlDefinitionsOutput {
        return list_security_control_definitions.execute(self, allocator, input, options);
    }

    /// Specifies whether a control is currently enabled or disabled in each enabled
    /// standard in the calling account.
    ///
    /// This operation omits standards control associations for standard
    /// subscriptions where `StandardsControlsUpdatable` has value
    /// `NOT_READY_FOR_UPDATES`.
    pub fn listStandardsControlAssociations(self: *Self, allocator: std.mem.Allocator, input: list_standards_control_associations.ListStandardsControlAssociationsInput, options: CallOptions) !list_standards_control_associations.ListStandardsControlAssociationsOutput {
        return list_standards_control_associations.execute(self, allocator, input, options);
    }

    /// Returns a list of tags associated with a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Grants permission to complete the authorization based on input parameters.
    pub fn registerConnectorV2(self: *Self, allocator: std.mem.Allocator, input: register_connector_v2.RegisterConnectorV2Input, options: CallOptions) !register_connector_v2.RegisterConnectorV2Output {
        return register_connector_v2.execute(self, allocator, input, options);
    }

    /// Associates a target account, organizational unit, or the root with a
    /// specified configuration. The target can be
    /// associated with a configuration policy or self-managed behavior. Only the
    /// Security Hub delegated administrator can
    /// invoke this operation from the home Region.
    pub fn startConfigurationPolicyAssociation(self: *Self, allocator: std.mem.Allocator, input: start_configuration_policy_association.StartConfigurationPolicyAssociationInput, options: CallOptions) !start_configuration_policy_association.StartConfigurationPolicyAssociationOutput {
        return start_configuration_policy_association.execute(self, allocator, input, options);
    }

    /// Disassociates a target account, organizational unit, or the root from a
    /// specified configuration. When you
    /// disassociate a configuration from its target, the target inherits the
    /// configuration of the closest parent. If there’s no
    /// configuration to inherit, the target retains its settings but becomes a
    /// self-managed account. A target can be disassociated from
    /// a configuration policy or self-managed behavior. Only the Security Hub
    /// delegated administrator can invoke this
    /// operation from the home Region.
    pub fn startConfigurationPolicyDisassociation(self: *Self, allocator: std.mem.Allocator, input: start_configuration_policy_disassociation.StartConfigurationPolicyDisassociationInput, options: CallOptions) !start_configuration_policy_disassociation.StartConfigurationPolicyDisassociationOutput {
        return start_configuration_policy_disassociation.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the name and description of a custom action target in Security Hub.
    pub fn updateActionTarget(self: *Self, allocator: std.mem.Allocator, input: update_action_target.UpdateActionTargetInput, options: CallOptions) !update_action_target.UpdateActionTargetOutput {
        return update_action_target.execute(self, allocator, input, options);
    }

    /// Udpates the configuration for the Aggregator V2.
    pub fn updateAggregatorV2(self: *Self, allocator: std.mem.Allocator, input: update_aggregator_v2.UpdateAggregatorV2Input, options: CallOptions) !update_aggregator_v2.UpdateAggregatorV2Output {
        return update_aggregator_v2.execute(self, allocator, input, options);
    }

    /// Updates a V2 automation rule.
    pub fn updateAutomationRuleV2(self: *Self, allocator: std.mem.Allocator, input: update_automation_rule_v2.UpdateAutomationRuleV2Input, options: CallOptions) !update_automation_rule_v2.UpdateAutomationRuleV2Output {
        return update_automation_rule_v2.execute(self, allocator, input, options);
    }

    /// Updates a configuration policy. Only the Security Hub delegated
    /// administrator can invoke this operation from the home Region.
    pub fn updateConfigurationPolicy(self: *Self, allocator: std.mem.Allocator, input: update_configuration_policy.UpdateConfigurationPolicyInput, options: CallOptions) !update_configuration_policy.UpdateConfigurationPolicyOutput {
        return update_configuration_policy.execute(self, allocator, input, options);
    }

    /// Grants permission to update a connectorV2 based on its id and input
    /// parameters.
    pub fn updateConnectorV2(self: *Self, allocator: std.mem.Allocator, input: update_connector_v2.UpdateConnectorV2Input, options: CallOptions) !update_connector_v2.UpdateConnectorV2Output {
        return update_connector_v2.execute(self, allocator, input, options);
    }

    /// The *aggregation Region* is now called the *home Region*.
    ///
    /// Updates cross-Region aggregation settings. You can use this operation to
    /// update the Region linking mode and the list
    /// of included or excluded Amazon Web Services Regions. However, you can't use
    /// this operation to change the home Region.
    ///
    /// You can invoke this operation from the current home Region only.
    pub fn updateFindingAggregator(self: *Self, allocator: std.mem.Allocator, input: update_finding_aggregator.UpdateFindingAggregatorInput, options: CallOptions) !update_finding_aggregator.UpdateFindingAggregatorOutput {
        return update_finding_aggregator.execute(self, allocator, input, options);
    }

    /// `UpdateFindings` is a deprecated operation. Instead of `UpdateFindings`, use
    /// the `BatchUpdateFindings` operation.
    ///
    /// The `UpdateFindings` operation updates the `Note` and `RecordState` of the
    /// Security Hub aggregated
    /// findings that the filter attributes specify. Any member account that can
    /// view the finding
    /// can also see the update to the finding.
    ///
    /// Finding updates made with `UpdateFindings` aren't persisted if the same
    /// finding is later updated by the
    /// finding provider through the `BatchImportFindings` operation. In addition,
    /// Security Hub doesn't
    /// record updates made with `UpdateFindings` in the finding history.
    pub fn updateFindings(self: *Self, allocator: std.mem.Allocator, input: update_findings.UpdateFindingsInput, options: CallOptions) !update_findings.UpdateFindingsOutput {
        return update_findings.execute(self, allocator, input, options);
    }

    /// Updates the Security Hub insight identified by the specified insight ARN.
    pub fn updateInsight(self: *Self, allocator: std.mem.Allocator, input: update_insight.UpdateInsightInput, options: CallOptions) !update_insight.UpdateInsightOutput {
        return update_insight.execute(self, allocator, input, options);
    }

    /// Updates the configuration of your organization in Security Hub. Only the
    /// Security Hub administrator account can invoke this operation.
    pub fn updateOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_organization_configuration.UpdateOrganizationConfigurationInput, options: CallOptions) !update_organization_configuration.UpdateOrganizationConfigurationOutput {
        return update_organization_configuration.execute(self, allocator, input, options);
    }

    /// Updates the properties of a security control.
    pub fn updateSecurityControl(self: *Self, allocator: std.mem.Allocator, input: update_security_control.UpdateSecurityControlInput, options: CallOptions) !update_security_control.UpdateSecurityControlOutput {
        return update_security_control.execute(self, allocator, input, options);
    }

    /// Updates configuration options for Security Hub.
    pub fn updateSecurityHubConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_security_hub_configuration.UpdateSecurityHubConfigurationInput, options: CallOptions) !update_security_hub_configuration.UpdateSecurityHubConfigurationOutput {
        return update_security_hub_configuration.execute(self, allocator, input, options);
    }

    /// Used to control whether an individual security standard control is enabled
    /// or
    /// disabled.
    ///
    /// Calls to this operation return a `RESOURCE_NOT_FOUND_EXCEPTION` error when
    /// the standard subscription for the control has `StandardsControlsUpdatable`
    /// value `NOT_READY_FOR_UPDATES`.
    pub fn updateStandardsControl(self: *Self, allocator: std.mem.Allocator, input: update_standards_control.UpdateStandardsControlInput, options: CallOptions) !update_standards_control.UpdateStandardsControlOutput {
        return update_standards_control.execute(self, allocator, input, options);
    }

    pub fn describeActionTargetsPaginator(self: *Self, params: describe_action_targets.DescribeActionTargetsInput) paginator.DescribeActionTargetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeProductsPaginator(self: *Self, params: describe_products.DescribeProductsInput) paginator.DescribeProductsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeProductsV2Paginator(self: *Self, params: describe_products_v2.DescribeProductsV2Input) paginator.DescribeProductsV2Paginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeStandardsPaginator(self: *Self, params: describe_standards.DescribeStandardsInput) paginator.DescribeStandardsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeStandardsControlsPaginator(self: *Self, params: describe_standards_controls.DescribeStandardsControlsInput) paginator.DescribeStandardsControlsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getEnabledStandardsPaginator(self: *Self, params: get_enabled_standards.GetEnabledStandardsInput) paginator.GetEnabledStandardsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getFindingHistoryPaginator(self: *Self, params: get_finding_history.GetFindingHistoryInput) paginator.GetFindingHistoryPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getFindingsPaginator(self: *Self, params: get_findings.GetFindingsInput) paginator.GetFindingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getFindingsTrendsV2Paginator(self: *Self, params: get_findings_trends_v2.GetFindingsTrendsV2Input) paginator.GetFindingsTrendsV2Paginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getFindingsV2Paginator(self: *Self, params: get_findings_v2.GetFindingsV2Input) paginator.GetFindingsV2Paginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getInsightsPaginator(self: *Self, params: get_insights.GetInsightsInput) paginator.GetInsightsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getResourcesTrendsV2Paginator(self: *Self, params: get_resources_trends_v2.GetResourcesTrendsV2Input) paginator.GetResourcesTrendsV2Paginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getResourcesV2Paginator(self: *Self, params: get_resources_v2.GetResourcesV2Input) paginator.GetResourcesV2Paginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAggregatorsV2Paginator(self: *Self, params: list_aggregators_v2.ListAggregatorsV2Input) paginator.ListAggregatorsV2Paginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConfigurationPoliciesPaginator(self: *Self, params: list_configuration_policies.ListConfigurationPoliciesInput) paginator.ListConfigurationPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConfigurationPolicyAssociationsPaginator(self: *Self, params: list_configuration_policy_associations.ListConfigurationPolicyAssociationsInput) paginator.ListConfigurationPolicyAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnabledProductsForImportPaginator(self: *Self, params: list_enabled_products_for_import.ListEnabledProductsForImportInput) paginator.ListEnabledProductsForImportPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFindingAggregatorsPaginator(self: *Self, params: list_finding_aggregators.ListFindingAggregatorsInput) paginator.ListFindingAggregatorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listInvitationsPaginator(self: *Self, params: list_invitations.ListInvitationsInput) paginator.ListInvitationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMembersPaginator(self: *Self, params: list_members.ListMembersInput) paginator.ListMembersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOrganizationAdminAccountsPaginator(self: *Self, params: list_organization_admin_accounts.ListOrganizationAdminAccountsInput) paginator.ListOrganizationAdminAccountsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSecurityControlDefinitionsPaginator(self: *Self, params: list_security_control_definitions.ListSecurityControlDefinitionsInput) paginator.ListSecurityControlDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listStandardsControlAssociationsPaginator(self: *Self, params: list_standards_control_associations.ListStandardsControlAssociationsInput) paginator.ListStandardsControlAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
