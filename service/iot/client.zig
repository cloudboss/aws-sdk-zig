const aws = @import("aws");
const std = @import("std");

const accept_certificate_transfer = @import("accept_certificate_transfer.zig");
const add_thing_to_billing_group = @import("add_thing_to_billing_group.zig");
const add_thing_to_thing_group = @import("add_thing_to_thing_group.zig");
const associate_sbom_with_package_version = @import("associate_sbom_with_package_version.zig");
const associate_targets_with_job = @import("associate_targets_with_job.zig");
const attach_policy = @import("attach_policy.zig");
const attach_principal_policy = @import("attach_principal_policy.zig");
const attach_security_profile = @import("attach_security_profile.zig");
const attach_thing_principal = @import("attach_thing_principal.zig");
const cancel_audit_mitigation_actions_task = @import("cancel_audit_mitigation_actions_task.zig");
const cancel_audit_task = @import("cancel_audit_task.zig");
const cancel_certificate_transfer = @import("cancel_certificate_transfer.zig");
const cancel_detect_mitigation_actions_task = @import("cancel_detect_mitigation_actions_task.zig");
const cancel_job = @import("cancel_job.zig");
const cancel_job_execution = @import("cancel_job_execution.zig");
const clear_default_authorizer = @import("clear_default_authorizer.zig");
const confirm_topic_rule_destination = @import("confirm_topic_rule_destination.zig");
const create_audit_suppression = @import("create_audit_suppression.zig");
const create_authorizer = @import("create_authorizer.zig");
const create_billing_group = @import("create_billing_group.zig");
const create_certificate_from_csr = @import("create_certificate_from_csr.zig");
const create_certificate_provider = @import("create_certificate_provider.zig");
const create_command = @import("create_command.zig");
const create_custom_metric = @import("create_custom_metric.zig");
const create_dimension = @import("create_dimension.zig");
const create_domain_configuration = @import("create_domain_configuration.zig");
const create_dynamic_thing_group = @import("create_dynamic_thing_group.zig");
const create_fleet_metric = @import("create_fleet_metric.zig");
const create_job = @import("create_job.zig");
const create_job_template = @import("create_job_template.zig");
const create_keys_and_certificate = @import("create_keys_and_certificate.zig");
const create_mitigation_action = @import("create_mitigation_action.zig");
const create_ota_update = @import("create_ota_update.zig");
const create_package = @import("create_package.zig");
const create_package_version = @import("create_package_version.zig");
const create_policy = @import("create_policy.zig");
const create_policy_version = @import("create_policy_version.zig");
const create_provisioning_claim = @import("create_provisioning_claim.zig");
const create_provisioning_template = @import("create_provisioning_template.zig");
const create_provisioning_template_version = @import("create_provisioning_template_version.zig");
const create_role_alias = @import("create_role_alias.zig");
const create_scheduled_audit = @import("create_scheduled_audit.zig");
const create_security_profile = @import("create_security_profile.zig");
const create_stream = @import("create_stream.zig");
const create_thing = @import("create_thing.zig");
const create_thing_group = @import("create_thing_group.zig");
const create_thing_type = @import("create_thing_type.zig");
const create_topic_rule = @import("create_topic_rule.zig");
const create_topic_rule_destination = @import("create_topic_rule_destination.zig");
const delete_account_audit_configuration = @import("delete_account_audit_configuration.zig");
const delete_audit_suppression = @import("delete_audit_suppression.zig");
const delete_authorizer = @import("delete_authorizer.zig");
const delete_billing_group = @import("delete_billing_group.zig");
const delete_ca_certificate = @import("delete_ca_certificate.zig");
const delete_certificate = @import("delete_certificate.zig");
const delete_certificate_provider = @import("delete_certificate_provider.zig");
const delete_command = @import("delete_command.zig");
const delete_command_execution = @import("delete_command_execution.zig");
const delete_custom_metric = @import("delete_custom_metric.zig");
const delete_dimension = @import("delete_dimension.zig");
const delete_domain_configuration = @import("delete_domain_configuration.zig");
const delete_dynamic_thing_group = @import("delete_dynamic_thing_group.zig");
const delete_fleet_metric = @import("delete_fleet_metric.zig");
const delete_job = @import("delete_job.zig");
const delete_job_execution = @import("delete_job_execution.zig");
const delete_job_template = @import("delete_job_template.zig");
const delete_mitigation_action = @import("delete_mitigation_action.zig");
const delete_ota_update = @import("delete_ota_update.zig");
const delete_package = @import("delete_package.zig");
const delete_package_version = @import("delete_package_version.zig");
const delete_policy = @import("delete_policy.zig");
const delete_policy_version = @import("delete_policy_version.zig");
const delete_provisioning_template = @import("delete_provisioning_template.zig");
const delete_provisioning_template_version = @import("delete_provisioning_template_version.zig");
const delete_registration_code = @import("delete_registration_code.zig");
const delete_role_alias = @import("delete_role_alias.zig");
const delete_scheduled_audit = @import("delete_scheduled_audit.zig");
const delete_security_profile = @import("delete_security_profile.zig");
const delete_stream = @import("delete_stream.zig");
const delete_thing = @import("delete_thing.zig");
const delete_thing_group = @import("delete_thing_group.zig");
const delete_thing_type = @import("delete_thing_type.zig");
const delete_topic_rule = @import("delete_topic_rule.zig");
const delete_topic_rule_destination = @import("delete_topic_rule_destination.zig");
const delete_v2_logging_level = @import("delete_v2_logging_level.zig");
const deprecate_thing_type = @import("deprecate_thing_type.zig");
const describe_account_audit_configuration = @import("describe_account_audit_configuration.zig");
const describe_audit_finding = @import("describe_audit_finding.zig");
const describe_audit_mitigation_actions_task = @import("describe_audit_mitigation_actions_task.zig");
const describe_audit_suppression = @import("describe_audit_suppression.zig");
const describe_audit_task = @import("describe_audit_task.zig");
const describe_authorizer = @import("describe_authorizer.zig");
const describe_billing_group = @import("describe_billing_group.zig");
const describe_ca_certificate = @import("describe_ca_certificate.zig");
const describe_certificate = @import("describe_certificate.zig");
const describe_certificate_provider = @import("describe_certificate_provider.zig");
const describe_custom_metric = @import("describe_custom_metric.zig");
const describe_default_authorizer = @import("describe_default_authorizer.zig");
const describe_detect_mitigation_actions_task = @import("describe_detect_mitigation_actions_task.zig");
const describe_dimension = @import("describe_dimension.zig");
const describe_domain_configuration = @import("describe_domain_configuration.zig");
const describe_encryption_configuration = @import("describe_encryption_configuration.zig");
const describe_endpoint = @import("describe_endpoint.zig");
const describe_event_configurations = @import("describe_event_configurations.zig");
const describe_fleet_metric = @import("describe_fleet_metric.zig");
const describe_index = @import("describe_index.zig");
const describe_job = @import("describe_job.zig");
const describe_job_execution = @import("describe_job_execution.zig");
const describe_job_template = @import("describe_job_template.zig");
const describe_managed_job_template = @import("describe_managed_job_template.zig");
const describe_mitigation_action = @import("describe_mitigation_action.zig");
const describe_provisioning_template = @import("describe_provisioning_template.zig");
const describe_provisioning_template_version = @import("describe_provisioning_template_version.zig");
const describe_role_alias = @import("describe_role_alias.zig");
const describe_scheduled_audit = @import("describe_scheduled_audit.zig");
const describe_security_profile = @import("describe_security_profile.zig");
const describe_stream = @import("describe_stream.zig");
const describe_thing = @import("describe_thing.zig");
const describe_thing_group = @import("describe_thing_group.zig");
const describe_thing_registration_task = @import("describe_thing_registration_task.zig");
const describe_thing_type = @import("describe_thing_type.zig");
const detach_policy = @import("detach_policy.zig");
const detach_principal_policy = @import("detach_principal_policy.zig");
const detach_security_profile = @import("detach_security_profile.zig");
const detach_thing_principal = @import("detach_thing_principal.zig");
const disable_topic_rule = @import("disable_topic_rule.zig");
const disassociate_sbom_from_package_version = @import("disassociate_sbom_from_package_version.zig");
const enable_topic_rule = @import("enable_topic_rule.zig");
const get_behavior_model_training_summaries = @import("get_behavior_model_training_summaries.zig");
const get_buckets_aggregation = @import("get_buckets_aggregation.zig");
const get_cardinality = @import("get_cardinality.zig");
const get_command = @import("get_command.zig");
const get_command_execution = @import("get_command_execution.zig");
const get_effective_policies = @import("get_effective_policies.zig");
const get_indexing_configuration = @import("get_indexing_configuration.zig");
const get_job_document = @import("get_job_document.zig");
const get_logging_options = @import("get_logging_options.zig");
const get_ota_update = @import("get_ota_update.zig");
const get_package = @import("get_package.zig");
const get_package_configuration = @import("get_package_configuration.zig");
const get_package_version = @import("get_package_version.zig");
const get_percentiles = @import("get_percentiles.zig");
const get_policy = @import("get_policy.zig");
const get_policy_version = @import("get_policy_version.zig");
const get_registration_code = @import("get_registration_code.zig");
const get_statistics = @import("get_statistics.zig");
const get_thing_connectivity_data = @import("get_thing_connectivity_data.zig");
const get_topic_rule = @import("get_topic_rule.zig");
const get_topic_rule_destination = @import("get_topic_rule_destination.zig");
const get_v2_logging_options = @import("get_v2_logging_options.zig");
const list_active_violations = @import("list_active_violations.zig");
const list_attached_policies = @import("list_attached_policies.zig");
const list_audit_findings = @import("list_audit_findings.zig");
const list_audit_mitigation_actions_executions = @import("list_audit_mitigation_actions_executions.zig");
const list_audit_mitigation_actions_tasks = @import("list_audit_mitigation_actions_tasks.zig");
const list_audit_suppressions = @import("list_audit_suppressions.zig");
const list_audit_tasks = @import("list_audit_tasks.zig");
const list_authorizers = @import("list_authorizers.zig");
const list_billing_groups = @import("list_billing_groups.zig");
const list_ca_certificates = @import("list_ca_certificates.zig");
const list_certificate_providers = @import("list_certificate_providers.zig");
const list_certificates = @import("list_certificates.zig");
const list_certificates_by_ca = @import("list_certificates_by_ca.zig");
const list_command_executions = @import("list_command_executions.zig");
const list_commands = @import("list_commands.zig");
const list_custom_metrics = @import("list_custom_metrics.zig");
const list_detect_mitigation_actions_executions = @import("list_detect_mitigation_actions_executions.zig");
const list_detect_mitigation_actions_tasks = @import("list_detect_mitigation_actions_tasks.zig");
const list_dimensions = @import("list_dimensions.zig");
const list_domain_configurations = @import("list_domain_configurations.zig");
const list_fleet_metrics = @import("list_fleet_metrics.zig");
const list_indices = @import("list_indices.zig");
const list_job_executions_for_job = @import("list_job_executions_for_job.zig");
const list_job_executions_for_thing = @import("list_job_executions_for_thing.zig");
const list_job_templates = @import("list_job_templates.zig");
const list_jobs = @import("list_jobs.zig");
const list_managed_job_templates = @import("list_managed_job_templates.zig");
const list_metric_values = @import("list_metric_values.zig");
const list_mitigation_actions = @import("list_mitigation_actions.zig");
const list_ota_updates = @import("list_ota_updates.zig");
const list_outgoing_certificates = @import("list_outgoing_certificates.zig");
const list_package_versions = @import("list_package_versions.zig");
const list_packages = @import("list_packages.zig");
const list_policies = @import("list_policies.zig");
const list_policy_principals = @import("list_policy_principals.zig");
const list_policy_versions = @import("list_policy_versions.zig");
const list_principal_policies = @import("list_principal_policies.zig");
const list_principal_things = @import("list_principal_things.zig");
const list_principal_things_v2 = @import("list_principal_things_v2.zig");
const list_provisioning_template_versions = @import("list_provisioning_template_versions.zig");
const list_provisioning_templates = @import("list_provisioning_templates.zig");
const list_related_resources_for_audit_finding = @import("list_related_resources_for_audit_finding.zig");
const list_role_aliases = @import("list_role_aliases.zig");
const list_sbom_validation_results = @import("list_sbom_validation_results.zig");
const list_scheduled_audits = @import("list_scheduled_audits.zig");
const list_security_profiles = @import("list_security_profiles.zig");
const list_security_profiles_for_target = @import("list_security_profiles_for_target.zig");
const list_streams = @import("list_streams.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_targets_for_policy = @import("list_targets_for_policy.zig");
const list_targets_for_security_profile = @import("list_targets_for_security_profile.zig");
const list_thing_groups = @import("list_thing_groups.zig");
const list_thing_groups_for_thing = @import("list_thing_groups_for_thing.zig");
const list_thing_principals = @import("list_thing_principals.zig");
const list_thing_principals_v2 = @import("list_thing_principals_v2.zig");
const list_thing_registration_task_reports = @import("list_thing_registration_task_reports.zig");
const list_thing_registration_tasks = @import("list_thing_registration_tasks.zig");
const list_thing_types = @import("list_thing_types.zig");
const list_things = @import("list_things.zig");
const list_things_in_billing_group = @import("list_things_in_billing_group.zig");
const list_things_in_thing_group = @import("list_things_in_thing_group.zig");
const list_topic_rule_destinations = @import("list_topic_rule_destinations.zig");
const list_topic_rules = @import("list_topic_rules.zig");
const list_v2_logging_levels = @import("list_v2_logging_levels.zig");
const list_violation_events = @import("list_violation_events.zig");
const put_verification_state_on_violation = @import("put_verification_state_on_violation.zig");
const register_ca_certificate = @import("register_ca_certificate.zig");
const register_certificate = @import("register_certificate.zig");
const register_certificate_without_ca = @import("register_certificate_without_ca.zig");
const register_thing = @import("register_thing.zig");
const reject_certificate_transfer = @import("reject_certificate_transfer.zig");
const remove_thing_from_billing_group = @import("remove_thing_from_billing_group.zig");
const remove_thing_from_thing_group = @import("remove_thing_from_thing_group.zig");
const replace_topic_rule = @import("replace_topic_rule.zig");
const search_index = @import("search_index.zig");
const set_default_authorizer = @import("set_default_authorizer.zig");
const set_default_policy_version = @import("set_default_policy_version.zig");
const set_logging_options = @import("set_logging_options.zig");
const set_v2_logging_level = @import("set_v2_logging_level.zig");
const set_v2_logging_options = @import("set_v2_logging_options.zig");
const start_audit_mitigation_actions_task = @import("start_audit_mitigation_actions_task.zig");
const start_detect_mitigation_actions_task = @import("start_detect_mitigation_actions_task.zig");
const start_on_demand_audit_task = @import("start_on_demand_audit_task.zig");
const start_thing_registration_task = @import("start_thing_registration_task.zig");
const stop_thing_registration_task = @import("stop_thing_registration_task.zig");
const tag_resource = @import("tag_resource.zig");
const test_authorization = @import("test_authorization.zig");
const test_invoke_authorizer = @import("test_invoke_authorizer.zig");
const transfer_certificate = @import("transfer_certificate.zig");
const untag_resource = @import("untag_resource.zig");
const update_account_audit_configuration = @import("update_account_audit_configuration.zig");
const update_audit_suppression = @import("update_audit_suppression.zig");
const update_authorizer = @import("update_authorizer.zig");
const update_billing_group = @import("update_billing_group.zig");
const update_ca_certificate = @import("update_ca_certificate.zig");
const update_certificate = @import("update_certificate.zig");
const update_certificate_provider = @import("update_certificate_provider.zig");
const update_command = @import("update_command.zig");
const update_custom_metric = @import("update_custom_metric.zig");
const update_dimension = @import("update_dimension.zig");
const update_domain_configuration = @import("update_domain_configuration.zig");
const update_dynamic_thing_group = @import("update_dynamic_thing_group.zig");
const update_encryption_configuration = @import("update_encryption_configuration.zig");
const update_event_configurations = @import("update_event_configurations.zig");
const update_fleet_metric = @import("update_fleet_metric.zig");
const update_indexing_configuration = @import("update_indexing_configuration.zig");
const update_job = @import("update_job.zig");
const update_mitigation_action = @import("update_mitigation_action.zig");
const update_package = @import("update_package.zig");
const update_package_configuration = @import("update_package_configuration.zig");
const update_package_version = @import("update_package_version.zig");
const update_provisioning_template = @import("update_provisioning_template.zig");
const update_role_alias = @import("update_role_alias.zig");
const update_scheduled_audit = @import("update_scheduled_audit.zig");
const update_security_profile = @import("update_security_profile.zig");
const update_stream = @import("update_stream.zig");
const update_thing = @import("update_thing.zig");
const update_thing_group = @import("update_thing_group.zig");
const update_thing_groups_for_thing = @import("update_thing_groups_for_thing.zig");
const update_thing_type = @import("update_thing_type.zig");
const update_topic_rule_destination = @import("update_topic_rule_destination.zig");
const validate_security_profile_behaviors = @import("validate_security_profile_behaviors.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoT";

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

    /// Accepts a pending certificate transfer. The default state of the certificate
    /// is
    /// INACTIVE.
    ///
    /// To check for pending certificate transfers, call ListCertificates
    /// to enumerate your certificates.
    ///
    /// Requires permission to access the
    /// [AcceptCertificateTransfer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn acceptCertificateTransfer(self: *Self, allocator: std.mem.Allocator, input: accept_certificate_transfer.AcceptCertificateTransferInput, options: accept_certificate_transfer.Options) !accept_certificate_transfer.AcceptCertificateTransferOutput {
        return accept_certificate_transfer.execute(self, allocator, input, options);
    }

    /// Adds a thing to a billing group.
    ///
    /// Requires permission to access the
    /// [AddThingToBillingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn addThingToBillingGroup(self: *Self, allocator: std.mem.Allocator, input: add_thing_to_billing_group.AddThingToBillingGroupInput, options: add_thing_to_billing_group.Options) !add_thing_to_billing_group.AddThingToBillingGroupOutput {
        return add_thing_to_billing_group.execute(self, allocator, input, options);
    }

    /// Adds a thing to a thing group.
    ///
    /// Requires permission to access the
    /// [AddThingToThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn addThingToThingGroup(self: *Self, allocator: std.mem.Allocator, input: add_thing_to_thing_group.AddThingToThingGroupInput, options: add_thing_to_thing_group.Options) !add_thing_to_thing_group.AddThingToThingGroupOutput {
        return add_thing_to_thing_group.execute(self, allocator, input, options);
    }

    /// Associates the selected software bill of materials (SBOM) with a specific
    /// software package version.
    ///
    /// Requires permission to access the
    /// [AssociateSbomWithPackageVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn associateSbomWithPackageVersion(self: *Self, allocator: std.mem.Allocator, input: associate_sbom_with_package_version.AssociateSbomWithPackageVersionInput, options: associate_sbom_with_package_version.Options) !associate_sbom_with_package_version.AssociateSbomWithPackageVersionOutput {
        return associate_sbom_with_package_version.execute(self, allocator, input, options);
    }

    /// Associates a group with a continuous job. The following criteria must be
    /// met:
    ///
    /// * The job must have been created with the `targetSelection` field
    /// set to "CONTINUOUS".
    ///
    /// * The job status must currently be "IN_PROGRESS".
    ///
    /// * The total number of targets associated with a job must not exceed
    /// 100.
    ///
    /// Requires permission to access the
    /// [AssociateTargetsWithJob](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn associateTargetsWithJob(self: *Self, allocator: std.mem.Allocator, input: associate_targets_with_job.AssociateTargetsWithJobInput, options: associate_targets_with_job.Options) !associate_targets_with_job.AssociateTargetsWithJobOutput {
        return associate_targets_with_job.execute(self, allocator, input, options);
    }

    /// Attaches the specified policy to the specified principal (certificate or
    /// other
    /// credential).
    ///
    /// Requires permission to access the
    /// [AttachPolicy](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn attachPolicy(self: *Self, allocator: std.mem.Allocator, input: attach_policy.AttachPolicyInput, options: attach_policy.Options) !attach_policy.AttachPolicyOutput {
        return attach_policy.execute(self, allocator, input, options);
    }

    /// Attaches the specified policy to the specified principal (certificate or
    /// other
    /// credential).
    ///
    /// **Note:** This action is deprecated and works as
    /// expected for backward compatibility, but we won't add enhancements. Use
    /// AttachPolicy instead.
    ///
    /// Requires permission to access the
    /// [AttachPrincipalPolicy](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn attachPrincipalPolicy(self: *Self, allocator: std.mem.Allocator, input: attach_principal_policy.AttachPrincipalPolicyInput, options: attach_principal_policy.Options) !attach_principal_policy.AttachPrincipalPolicyOutput {
        return attach_principal_policy.execute(self, allocator, input, options);
    }

    /// Associates a Device Defender security profile with a thing group or this
    /// account. Each
    /// thing group or account can have up to five security profiles associated with
    /// it.
    ///
    /// Requires permission to access the
    /// [AttachSecurityProfile](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn attachSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: attach_security_profile.AttachSecurityProfileInput, options: attach_security_profile.Options) !attach_security_profile.AttachSecurityProfileOutput {
        return attach_security_profile.execute(self, allocator, input, options);
    }

    /// Attaches the specified principal to the specified thing. A principal can be
    /// X.509
    /// certificates, Amazon Cognito identities or federated identities.
    ///
    /// Requires permission to access the
    /// [AttachThingPrincipal](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn attachThingPrincipal(self: *Self, allocator: std.mem.Allocator, input: attach_thing_principal.AttachThingPrincipalInput, options: attach_thing_principal.Options) !attach_thing_principal.AttachThingPrincipalOutput {
        return attach_thing_principal.execute(self, allocator, input, options);
    }

    /// Cancels a mitigation action task that is in progress. If the task
    /// is not
    /// in progress, an InvalidRequestException occurs.
    ///
    /// Requires permission to access the
    /// [CancelAuditMitigationActionsTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn cancelAuditMitigationActionsTask(self: *Self, allocator: std.mem.Allocator, input: cancel_audit_mitigation_actions_task.CancelAuditMitigationActionsTaskInput, options: cancel_audit_mitigation_actions_task.Options) !cancel_audit_mitigation_actions_task.CancelAuditMitigationActionsTaskOutput {
        return cancel_audit_mitigation_actions_task.execute(self, allocator, input, options);
    }

    /// Cancels an audit that is in progress. The audit can be either scheduled or
    /// on demand. If the audit isn't in progress, an "InvalidRequestException"
    /// occurs.
    ///
    /// Requires permission to access the
    /// [CancelAuditTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn cancelAuditTask(self: *Self, allocator: std.mem.Allocator, input: cancel_audit_task.CancelAuditTaskInput, options: cancel_audit_task.Options) !cancel_audit_task.CancelAuditTaskOutput {
        return cancel_audit_task.execute(self, allocator, input, options);
    }

    /// Cancels a pending transfer for the specified certificate.
    ///
    /// **Note** Only the transfer source account can use this
    /// operation to cancel a transfer. (Transfer destinations can use
    /// RejectCertificateTransfer instead.) After transfer, IoT returns the
    /// certificate to the source account in the INACTIVE state. After the
    /// destination account has
    /// accepted the transfer, the transfer cannot be cancelled.
    ///
    /// After a certificate transfer is cancelled, the status of the certificate
    /// changes from
    /// PENDING_TRANSFER to INACTIVE.
    ///
    /// Requires permission to access the
    /// [CancelCertificateTransfer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn cancelCertificateTransfer(self: *Self, allocator: std.mem.Allocator, input: cancel_certificate_transfer.CancelCertificateTransferInput, options: cancel_certificate_transfer.Options) !cancel_certificate_transfer.CancelCertificateTransferOutput {
        return cancel_certificate_transfer.execute(self, allocator, input, options);
    }

    /// Cancels a Device Defender ML Detect mitigation action.
    ///
    /// Requires permission to access the
    /// [CancelDetectMitigationActionsTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn cancelDetectMitigationActionsTask(self: *Self, allocator: std.mem.Allocator, input: cancel_detect_mitigation_actions_task.CancelDetectMitigationActionsTaskInput, options: cancel_detect_mitigation_actions_task.Options) !cancel_detect_mitigation_actions_task.CancelDetectMitigationActionsTaskOutput {
        return cancel_detect_mitigation_actions_task.execute(self, allocator, input, options);
    }

    /// Cancels a job.
    ///
    /// Requires permission to access the
    /// [CancelJob](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn cancelJob(self: *Self, allocator: std.mem.Allocator, input: cancel_job.CancelJobInput, options: cancel_job.Options) !cancel_job.CancelJobOutput {
        return cancel_job.execute(self, allocator, input, options);
    }

    /// Cancels the execution of a job for a given thing.
    ///
    /// Requires permission to access the
    /// [CancelJobExecution](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn cancelJobExecution(self: *Self, allocator: std.mem.Allocator, input: cancel_job_execution.CancelJobExecutionInput, options: cancel_job_execution.Options) !cancel_job_execution.CancelJobExecutionOutput {
        return cancel_job_execution.execute(self, allocator, input, options);
    }

    /// Clears the default authorizer.
    ///
    /// Requires permission to access the
    /// [ClearDefaultAuthorizer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn clearDefaultAuthorizer(self: *Self, allocator: std.mem.Allocator, input: clear_default_authorizer.ClearDefaultAuthorizerInput, options: clear_default_authorizer.Options) !clear_default_authorizer.ClearDefaultAuthorizerOutput {
        return clear_default_authorizer.execute(self, allocator, input, options);
    }

    /// Confirms a topic rule destination. When you create a rule requiring a
    /// destination, IoT
    /// sends a confirmation message to the endpoint or base address you specify.
    /// The message
    /// includes a token which you pass back when calling
    /// `ConfirmTopicRuleDestination`
    /// to confirm that you own or have access to the endpoint.
    ///
    /// Requires permission to access the
    /// [ConfirmTopicRuleDestination](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn confirmTopicRuleDestination(self: *Self, allocator: std.mem.Allocator, input: confirm_topic_rule_destination.ConfirmTopicRuleDestinationInput, options: confirm_topic_rule_destination.Options) !confirm_topic_rule_destination.ConfirmTopicRuleDestinationOutput {
        return confirm_topic_rule_destination.execute(self, allocator, input, options);
    }

    /// Creates a Device Defender audit suppression.
    ///
    /// Requires permission to access the
    /// [CreateAuditSuppression](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createAuditSuppression(self: *Self, allocator: std.mem.Allocator, input: create_audit_suppression.CreateAuditSuppressionInput, options: create_audit_suppression.Options) !create_audit_suppression.CreateAuditSuppressionOutput {
        return create_audit_suppression.execute(self, allocator, input, options);
    }

    /// Creates an authorizer.
    ///
    /// Requires permission to access the
    /// [CreateAuthorizer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createAuthorizer(self: *Self, allocator: std.mem.Allocator, input: create_authorizer.CreateAuthorizerInput, options: create_authorizer.Options) !create_authorizer.CreateAuthorizerOutput {
        return create_authorizer.execute(self, allocator, input, options);
    }

    /// Creates a billing group. If this call is made multiple times using
    /// the same billing group name and configuration, the call will succeed. If
    /// this call is made with
    /// the same billing group name but different configuration a
    /// `ResourceAlreadyExistsException` is thrown.
    ///
    /// Requires permission to access the
    /// [CreateBillingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createBillingGroup(self: *Self, allocator: std.mem.Allocator, input: create_billing_group.CreateBillingGroupInput, options: create_billing_group.Options) !create_billing_group.CreateBillingGroupOutput {
        return create_billing_group.execute(self, allocator, input, options);
    }

    /// Creates an X.509 certificate using the specified certificate signing
    /// request.
    ///
    /// Requires permission to access the
    /// [CreateCertificateFromCsr](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// The CSR must include a public key that is either an RSA key with a length of
    /// at least
    /// 2048 bits or an ECC key from NIST P-256, NIST P-384, or NIST P-521 curves.
    /// For supported
    /// certificates, consult [ Certificate signing algorithms supported by
    /// IoT](https://docs.aws.amazon.com/iot/latest/developerguide/x509-client-certs.html#x509-cert-algorithms).
    ///
    /// Reusing the same certificate signing request (CSR)
    /// results in a distinct certificate.
    ///
    /// You can create multiple certificates in a batch by creating a directory,
    /// copying
    /// multiple `.csr` files into that directory, and then specifying that
    /// directory on the command
    /// line. The following commands show how to create a batch of certificates
    /// given a batch of
    /// CSRs. In the following commands, we assume that a set of CSRs are located
    /// inside of the
    /// directory my-csr-directory:
    ///
    /// On Linux and OS X, the command is:
    ///
    /// `$ ls my-csr-directory/ | xargs -I {} aws iot create-certificate-from-csr
    /// --certificate-signing-request file://my-csr-directory/{}`
    ///
    /// This command lists all of the CSRs in my-csr-directory and pipes each CSR
    /// file name
    /// to the `aws iot create-certificate-from-csr` Amazon Web Services CLI command
    /// to create a certificate for
    /// the corresponding CSR.
    ///
    /// You can also run the `aws iot create-certificate-from-csr` part of the
    /// command in parallel to speed up the certificate creation process:
    ///
    /// `$ ls my-csr-directory/ | xargs -P 10 -I {} aws iot
    /// create-certificate-from-csr
    /// --certificate-signing-request file://my-csr-directory/{}
    /// `
    ///
    /// On Windows PowerShell, the command to create certificates for all CSRs in
    /// my-csr-directory is:
    ///
    /// `> ls -Name my-csr-directory | %{aws iot create-certificate-from-csr
    /// --certificate-signing-request file://my-csr-directory/$_}
    /// `
    ///
    /// On a Windows command prompt, the command to create certificates for all CSRs
    /// in
    /// my-csr-directory is:
    ///
    /// `> forfiles /p my-csr-directory /c "cmd /c aws iot
    /// create-certificate-from-csr
    /// --certificate-signing-request file://@path"
    /// `
    pub fn createCertificateFromCsr(self: *Self, allocator: std.mem.Allocator, input: create_certificate_from_csr.CreateCertificateFromCsrInput, options: create_certificate_from_csr.Options) !create_certificate_from_csr.CreateCertificateFromCsrOutput {
        return create_certificate_from_csr.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services IoT Core certificate provider. You can use
    /// Amazon Web Services IoT Core certificate provider to
    /// customize how to sign a certificate signing request (CSR) in IoT fleet
    /// provisioning. For
    /// more information, see [Customizing certificate
    /// signing using Amazon Web Services IoT Core certificate
    /// provider](https://docs.aws.amazon.com/iot/latest/developerguide/provisioning-cert-provider.html) from *Amazon Web Services IoT Core Developer
    /// Guide*.
    ///
    /// Requires permission to access the
    /// [CreateCertificateProvider](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// After you create a certificate provider, the behavior of [
    /// `CreateCertificateFromCsr` API for fleet
    /// provisioning](https://docs.aws.amazon.com/iot/latest/developerguide/fleet-provision-api.html#create-cert-csr) will
    /// change and all API calls to `CreateCertificateFromCsr` will invoke the
    /// certificate provider to create the certificates. It can take up to a few
    /// minutes for
    /// this behavior to change after a certificate provider is created.
    pub fn createCertificateProvider(self: *Self, allocator: std.mem.Allocator, input: create_certificate_provider.CreateCertificateProviderInput, options: create_certificate_provider.Options) !create_certificate_provider.CreateCertificateProviderOutput {
        return create_certificate_provider.execute(self, allocator, input, options);
    }

    /// Creates a command. A command contains reusable configurations that can be
    /// applied
    /// before they are sent to the devices.
    pub fn createCommand(self: *Self, allocator: std.mem.Allocator, input: create_command.CreateCommandInput, options: create_command.Options) !create_command.CreateCommandOutput {
        return create_command.execute(self, allocator, input, options);
    }

    /// Use this API to define a
    /// Custom
    /// Metric
    /// published by your devices to Device Defender.
    ///
    /// Requires permission to access the
    /// [CreateCustomMetric](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createCustomMetric(self: *Self, allocator: std.mem.Allocator, input: create_custom_metric.CreateCustomMetricInput, options: create_custom_metric.Options) !create_custom_metric.CreateCustomMetricOutput {
        return create_custom_metric.execute(self, allocator, input, options);
    }

    /// Create a dimension that you can use to limit the scope of a metric used in a
    /// security profile for IoT Device Defender.
    /// For example, using a `TOPIC_FILTER` dimension, you can narrow down the scope
    /// of the metric only to MQTT topics whose name match the pattern specified in
    /// the dimension.
    ///
    /// Requires permission to access the
    /// [CreateDimension](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createDimension(self: *Self, allocator: std.mem.Allocator, input: create_dimension.CreateDimensionInput, options: create_dimension.Options) !create_dimension.CreateDimensionOutput {
        return create_dimension.execute(self, allocator, input, options);
    }

    /// Creates a domain configuration.
    ///
    /// Requires permission to access the
    /// [CreateDomainConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createDomainConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_domain_configuration.CreateDomainConfigurationInput, options: create_domain_configuration.Options) !create_domain_configuration.CreateDomainConfigurationOutput {
        return create_domain_configuration.execute(self, allocator, input, options);
    }

    /// Creates a dynamic thing group.
    ///
    /// Requires permission to access the
    /// [CreateDynamicThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createDynamicThingGroup(self: *Self, allocator: std.mem.Allocator, input: create_dynamic_thing_group.CreateDynamicThingGroupInput, options: create_dynamic_thing_group.Options) !create_dynamic_thing_group.CreateDynamicThingGroupOutput {
        return create_dynamic_thing_group.execute(self, allocator, input, options);
    }

    /// Creates a fleet metric.
    ///
    /// Requires permission to access the
    /// [CreateFleetMetric](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createFleetMetric(self: *Self, allocator: std.mem.Allocator, input: create_fleet_metric.CreateFleetMetricInput, options: create_fleet_metric.Options) !create_fleet_metric.CreateFleetMetricOutput {
        return create_fleet_metric.execute(self, allocator, input, options);
    }

    /// Creates a job.
    ///
    /// Requires permission to access the
    /// [CreateJob](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createJob(self: *Self, allocator: std.mem.Allocator, input: create_job.CreateJobInput, options: create_job.Options) !create_job.CreateJobOutput {
        return create_job.execute(self, allocator, input, options);
    }

    /// Creates a job template.
    ///
    /// Requires permission to access the
    /// [CreateJobTemplate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createJobTemplate(self: *Self, allocator: std.mem.Allocator, input: create_job_template.CreateJobTemplateInput, options: create_job_template.Options) !create_job_template.CreateJobTemplateOutput {
        return create_job_template.execute(self, allocator, input, options);
    }

    /// Creates a 2048-bit RSA key pair and issues an X.509 certificate using the
    /// issued
    /// public key. You can also call `CreateKeysAndCertificate` over MQTT from a
    /// device, for more information, see [Provisioning MQTT
    /// API](https://docs.aws.amazon.com/iot/latest/developerguide/provision-wo-cert.html#provision-mqtt-api).
    ///
    /// **Note** This is the only time IoT issues the private key
    /// for this certificate, so it is important to keep it in a secure location.
    ///
    /// Requires permission to access the
    /// [CreateKeysAndCertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createKeysAndCertificate(self: *Self, allocator: std.mem.Allocator, input: create_keys_and_certificate.CreateKeysAndCertificateInput, options: create_keys_and_certificate.Options) !create_keys_and_certificate.CreateKeysAndCertificateOutput {
        return create_keys_and_certificate.execute(self, allocator, input, options);
    }

    /// Defines an action that can be applied to audit findings by using
    /// StartAuditMitigationActionsTask. Only certain types of mitigation actions
    /// can be applied to specific check names.
    /// For more information, see [Mitigation
    /// actions](https://docs.aws.amazon.com/iot/latest/developerguide/device-defender-mitigation-actions.html). Each mitigation action can apply only one type of change.
    ///
    /// Requires permission to access the
    /// [CreateMitigationAction](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createMitigationAction(self: *Self, allocator: std.mem.Allocator, input: create_mitigation_action.CreateMitigationActionInput, options: create_mitigation_action.Options) !create_mitigation_action.CreateMitigationActionOutput {
        return create_mitigation_action.execute(self, allocator, input, options);
    }

    /// Creates an IoT OTA update on a target group of things or groups.
    ///
    /// Requires permission to access the
    /// [CreateOTAUpdate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createOtaUpdate(self: *Self, allocator: std.mem.Allocator, input: create_ota_update.CreateOTAUpdateInput, options: create_ota_update.Options) !create_ota_update.CreateOTAUpdateOutput {
        return create_ota_update.execute(self, allocator, input, options);
    }

    /// Creates an IoT software package that can be deployed to your fleet.
    ///
    /// Requires permission to access the
    /// [CreatePackage](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) and [GetIndexingConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) actions.
    pub fn createPackage(self: *Self, allocator: std.mem.Allocator, input: create_package.CreatePackageInput, options: create_package.Options) !create_package.CreatePackageOutput {
        return create_package.execute(self, allocator, input, options);
    }

    /// Creates a new version for an existing IoT software package.
    ///
    /// Requires permission to access the
    /// [CreatePackageVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) and [GetIndexingConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) actions.
    pub fn createPackageVersion(self: *Self, allocator: std.mem.Allocator, input: create_package_version.CreatePackageVersionInput, options: create_package_version.Options) !create_package_version.CreatePackageVersionOutput {
        return create_package_version.execute(self, allocator, input, options);
    }

    /// Creates an IoT policy.
    ///
    /// The created policy is the default version for the policy. This operation
    /// creates a
    /// policy version with a version identifier of **1** and sets
    /// **1** as the policy's default version.
    ///
    /// Requires permission to access the
    /// [CreatePolicy](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createPolicy(self: *Self, allocator: std.mem.Allocator, input: create_policy.CreatePolicyInput, options: create_policy.Options) !create_policy.CreatePolicyOutput {
        return create_policy.execute(self, allocator, input, options);
    }

    /// Creates a new version of the specified IoT policy. To update a policy,
    /// create a
    /// new policy version. A managed policy can have up to five versions. If the
    /// policy has five
    /// versions, you must use DeletePolicyVersion to delete an existing version
    /// before you create a new one.
    ///
    /// Optionally, you can set the new version as the policy's default version. The
    /// default
    /// version is the operative version (that is, the version that is in effect for
    /// the
    /// certificates to which the policy is attached).
    ///
    /// Requires permission to access the
    /// [CreatePolicyVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: create_policy_version.CreatePolicyVersionInput, options: create_policy_version.Options) !create_policy_version.CreatePolicyVersionOutput {
        return create_policy_version.execute(self, allocator, input, options);
    }

    /// Creates a provisioning claim.
    ///
    /// Requires permission to access the
    /// [CreateProvisioningClaim](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createProvisioningClaim(self: *Self, allocator: std.mem.Allocator, input: create_provisioning_claim.CreateProvisioningClaimInput, options: create_provisioning_claim.Options) !create_provisioning_claim.CreateProvisioningClaimOutput {
        return create_provisioning_claim.execute(self, allocator, input, options);
    }

    /// Creates a provisioning template.
    ///
    /// Requires permission to access the
    /// [CreateProvisioningTemplate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createProvisioningTemplate(self: *Self, allocator: std.mem.Allocator, input: create_provisioning_template.CreateProvisioningTemplateInput, options: create_provisioning_template.Options) !create_provisioning_template.CreateProvisioningTemplateOutput {
        return create_provisioning_template.execute(self, allocator, input, options);
    }

    /// Creates a new version of a provisioning template.
    ///
    /// Requires permission to access the
    /// [CreateProvisioningTemplateVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createProvisioningTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: create_provisioning_template_version.CreateProvisioningTemplateVersionInput, options: create_provisioning_template_version.Options) !create_provisioning_template_version.CreateProvisioningTemplateVersionOutput {
        return create_provisioning_template_version.execute(self, allocator, input, options);
    }

    /// Creates a role alias.
    ///
    /// Requires permission to access the
    /// [CreateRoleAlias](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// The value of [
    /// `credentialDurationSeconds`
    /// ](https://docs.aws.amazon.com/iot/latest/apireference/API_CreateRoleAlias.html#iot-CreateRoleAlias-request-credentialDurationSeconds) must be less than or equal to the maximum session
    /// duration of the IAM role that the role alias references. For more
    /// information, see
    /// [
    /// Modifying a role maximum session duration (Amazon Web Services
    /// API)](https://docs.aws.amazon.com/IAM/latest/UserGuide/roles-managingrole-editing-api.html#roles-modify_max-session-duration-api) from the Amazon Web Services Identity and Access Management User Guide.
    pub fn createRoleAlias(self: *Self, allocator: std.mem.Allocator, input: create_role_alias.CreateRoleAliasInput, options: create_role_alias.Options) !create_role_alias.CreateRoleAliasOutput {
        return create_role_alias.execute(self, allocator, input, options);
    }

    /// Creates a scheduled audit that is run at a specified
    /// time interval.
    ///
    /// Requires permission to access the
    /// [CreateScheduledAudit](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createScheduledAudit(self: *Self, allocator: std.mem.Allocator, input: create_scheduled_audit.CreateScheduledAuditInput, options: create_scheduled_audit.Options) !create_scheduled_audit.CreateScheduledAuditOutput {
        return create_scheduled_audit.execute(self, allocator, input, options);
    }

    /// Creates a Device Defender security profile.
    ///
    /// Requires permission to access the
    /// [CreateSecurityProfile](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: create_security_profile.CreateSecurityProfileInput, options: create_security_profile.Options) !create_security_profile.CreateSecurityProfileOutput {
        return create_security_profile.execute(self, allocator, input, options);
    }

    /// Creates a stream for delivering one or more large files in chunks over MQTT.
    /// A stream transports data
    /// bytes in chunks or blocks packaged as MQTT messages from a source like S3.
    /// You can have one or more files
    /// associated with a stream.
    ///
    /// Requires permission to access the
    /// [CreateStream](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createStream(self: *Self, allocator: std.mem.Allocator, input: create_stream.CreateStreamInput, options: create_stream.Options) !create_stream.CreateStreamOutput {
        return create_stream.execute(self, allocator, input, options);
    }

    /// Creates a thing record in the registry. If this call is made multiple times
    /// using
    /// the same thing name and configuration, the call will succeed. If this call
    /// is made with
    /// the same thing name but different configuration a
    /// `ResourceAlreadyExistsException` is thrown.
    ///
    /// This is a control plane operation. See
    /// [Authorization](https://docs.aws.amazon.com/iot/latest/developerguide/iot-authorization.html) for
    /// information about authorizing control plane actions.
    ///
    /// Requires permission to access the
    /// [CreateThing](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createThing(self: *Self, allocator: std.mem.Allocator, input: create_thing.CreateThingInput, options: create_thing.Options) !create_thing.CreateThingOutput {
        return create_thing.execute(self, allocator, input, options);
    }

    /// Create a thing group.
    ///
    /// This is a control plane operation. See
    /// [Authorization](https://docs.aws.amazon.com/iot/latest/developerguide/iot-authorization.html) for
    /// information about authorizing control plane actions.
    ///
    /// If the `ThingGroup` that you create has the exact same attributes as an
    /// existing
    /// `ThingGroup`, you will get a 200 success response.
    ///
    /// Requires permission to access the
    /// [CreateThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createThingGroup(self: *Self, allocator: std.mem.Allocator, input: create_thing_group.CreateThingGroupInput, options: create_thing_group.Options) !create_thing_group.CreateThingGroupOutput {
        return create_thing_group.execute(self, allocator, input, options);
    }

    /// Creates a new thing type. If this call is made multiple times using
    /// the same thing type name and configuration, the call will succeed. If this
    /// call is made with
    /// the same thing type name but different configuration a
    /// `ResourceAlreadyExistsException` is thrown.
    ///
    /// Requires permission to access the
    /// [CreateThingType](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createThingType(self: *Self, allocator: std.mem.Allocator, input: create_thing_type.CreateThingTypeInput, options: create_thing_type.Options) !create_thing_type.CreateThingTypeOutput {
        return create_thing_type.execute(self, allocator, input, options);
    }

    /// Creates a rule. Creating rules is an administrator-level action. Any user
    /// who has
    /// permission to create rules will be able to access data processed by the
    /// rule.
    ///
    /// Requires permission to access the
    /// [CreateTopicRule](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createTopicRule(self: *Self, allocator: std.mem.Allocator, input: create_topic_rule.CreateTopicRuleInput, options: create_topic_rule.Options) !create_topic_rule.CreateTopicRuleOutput {
        return create_topic_rule.execute(self, allocator, input, options);
    }

    /// Creates a topic rule destination. The destination must be confirmed prior to
    /// use.
    ///
    /// Requires permission to access the
    /// [CreateTopicRuleDestination](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn createTopicRuleDestination(self: *Self, allocator: std.mem.Allocator, input: create_topic_rule_destination.CreateTopicRuleDestinationInput, options: create_topic_rule_destination.Options) !create_topic_rule_destination.CreateTopicRuleDestinationOutput {
        return create_topic_rule_destination.execute(self, allocator, input, options);
    }

    /// Restores the default settings for Device Defender audits for this account.
    /// Any
    /// configuration data you entered is deleted and all audit checks are reset to
    /// disabled.
    ///
    /// Requires permission to access the
    /// [DeleteAccountAuditConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteAccountAuditConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_account_audit_configuration.DeleteAccountAuditConfigurationInput, options: delete_account_audit_configuration.Options) !delete_account_audit_configuration.DeleteAccountAuditConfigurationOutput {
        return delete_account_audit_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a Device Defender audit suppression.
    ///
    /// Requires permission to access the
    /// [DeleteAuditSuppression](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteAuditSuppression(self: *Self, allocator: std.mem.Allocator, input: delete_audit_suppression.DeleteAuditSuppressionInput, options: delete_audit_suppression.Options) !delete_audit_suppression.DeleteAuditSuppressionOutput {
        return delete_audit_suppression.execute(self, allocator, input, options);
    }

    /// Deletes an authorizer.
    ///
    /// Requires permission to access the
    /// [DeleteAuthorizer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteAuthorizer(self: *Self, allocator: std.mem.Allocator, input: delete_authorizer.DeleteAuthorizerInput, options: delete_authorizer.Options) !delete_authorizer.DeleteAuthorizerOutput {
        return delete_authorizer.execute(self, allocator, input, options);
    }

    /// Deletes the billing group.
    ///
    /// Requires permission to access the
    /// [DeleteBillingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteBillingGroup(self: *Self, allocator: std.mem.Allocator, input: delete_billing_group.DeleteBillingGroupInput, options: delete_billing_group.Options) !delete_billing_group.DeleteBillingGroupOutput {
        return delete_billing_group.execute(self, allocator, input, options);
    }

    /// Deletes a registered CA certificate.
    ///
    /// Requires permission to access the
    /// [DeleteCACertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteCaCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_ca_certificate.DeleteCACertificateInput, options: delete_ca_certificate.Options) !delete_ca_certificate.DeleteCACertificateOutput {
        return delete_ca_certificate.execute(self, allocator, input, options);
    }

    /// Deletes the specified certificate.
    ///
    /// A certificate cannot be deleted if it has a policy or IoT thing attached to
    /// it or if
    /// its status is set to ACTIVE. To delete a certificate, first use the
    /// DetachPolicy action to detach all policies. Next, use the UpdateCertificate
    /// action to set the certificate to the INACTIVE
    /// status.
    ///
    /// Requires permission to access the
    /// [DeleteCertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_certificate.DeleteCertificateInput, options: delete_certificate.Options) !delete_certificate.DeleteCertificateOutput {
        return delete_certificate.execute(self, allocator, input, options);
    }

    /// Deletes a certificate provider.
    ///
    /// Requires permission to access the
    /// [DeleteCertificateProvider](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// If you delete the certificate provider resource, the behavior of
    /// `CreateCertificateFromCsr` will resume, and IoT will create
    /// certificates signed by IoT from a certificate signing request (CSR).
    pub fn deleteCertificateProvider(self: *Self, allocator: std.mem.Allocator, input: delete_certificate_provider.DeleteCertificateProviderInput, options: delete_certificate_provider.Options) !delete_certificate_provider.DeleteCertificateProviderOutput {
        return delete_certificate_provider.execute(self, allocator, input, options);
    }

    /// Delete a command resource.
    pub fn deleteCommand(self: *Self, allocator: std.mem.Allocator, input: delete_command.DeleteCommandInput, options: delete_command.Options) !delete_command.DeleteCommandOutput {
        return delete_command.execute(self, allocator, input, options);
    }

    /// Delete a command execution.
    ///
    /// Only command executions that enter a terminal state can be deleted from
    /// your account.
    pub fn deleteCommandExecution(self: *Self, allocator: std.mem.Allocator, input: delete_command_execution.DeleteCommandExecutionInput, options: delete_command_execution.Options) !delete_command_execution.DeleteCommandExecutionOutput {
        return delete_command_execution.execute(self, allocator, input, options);
    }

    /// Deletes a Device Defender detect custom metric.
    ///
    /// Requires permission to access the
    /// [DeleteCustomMetric](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// Before you can delete a custom metric, you must first remove the custom
    /// metric from all
    /// security profiles it's a part of.
    /// The
    /// security
    /// profile associated with the custom metric can be found using the
    /// [ListSecurityProfiles](https://docs.aws.amazon.com/iot/latest/apireference/API_ListSecurityProfiles.html)
    /// API with `metricName` set to your custom metric name.
    pub fn deleteCustomMetric(self: *Self, allocator: std.mem.Allocator, input: delete_custom_metric.DeleteCustomMetricInput, options: delete_custom_metric.Options) !delete_custom_metric.DeleteCustomMetricOutput {
        return delete_custom_metric.execute(self, allocator, input, options);
    }

    /// Removes the specified dimension from your Amazon Web Services accounts.
    ///
    /// Requires permission to access the
    /// [DeleteDimension](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteDimension(self: *Self, allocator: std.mem.Allocator, input: delete_dimension.DeleteDimensionInput, options: delete_dimension.Options) !delete_dimension.DeleteDimensionOutput {
        return delete_dimension.execute(self, allocator, input, options);
    }

    /// Deletes the specified domain configuration.
    ///
    /// Requires permission to access the
    /// [DeleteDomainConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteDomainConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_domain_configuration.DeleteDomainConfigurationInput, options: delete_domain_configuration.Options) !delete_domain_configuration.DeleteDomainConfigurationOutput {
        return delete_domain_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a dynamic thing group.
    ///
    /// Requires permission to access the
    /// [DeleteDynamicThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteDynamicThingGroup(self: *Self, allocator: std.mem.Allocator, input: delete_dynamic_thing_group.DeleteDynamicThingGroupInput, options: delete_dynamic_thing_group.Options) !delete_dynamic_thing_group.DeleteDynamicThingGroupOutput {
        return delete_dynamic_thing_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified fleet metric.
    /// Returns successfully with no error if the deletion is successful or you
    /// specify a fleet metric that doesn't exist.
    ///
    /// Requires permission to access the
    /// [DeleteFleetMetric](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteFleetMetric(self: *Self, allocator: std.mem.Allocator, input: delete_fleet_metric.DeleteFleetMetricInput, options: delete_fleet_metric.Options) !delete_fleet_metric.DeleteFleetMetricOutput {
        return delete_fleet_metric.execute(self, allocator, input, options);
    }

    /// Deletes a job and its related job executions.
    ///
    /// Deleting a job may take time, depending on the number of job executions
    /// created for
    /// the job and various other factors. While the job is being deleted, the
    /// status of the job
    /// will be shown as "DELETION_IN_PROGRESS". Attempting to delete or cancel a
    /// job whose
    /// status is already "DELETION_IN_PROGRESS" will result in an error.
    ///
    /// Only 10 jobs may have status "DELETION_IN_PROGRESS" at the same time, or a
    /// LimitExceededException will occur.
    ///
    /// Requires permission to access the
    /// [DeleteJob](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteJob(self: *Self, allocator: std.mem.Allocator, input: delete_job.DeleteJobInput, options: delete_job.Options) !delete_job.DeleteJobOutput {
        return delete_job.execute(self, allocator, input, options);
    }

    /// Deletes a job execution.
    ///
    /// Requires permission to access the
    /// [DeleteJobExecution](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteJobExecution(self: *Self, allocator: std.mem.Allocator, input: delete_job_execution.DeleteJobExecutionInput, options: delete_job_execution.Options) !delete_job_execution.DeleteJobExecutionOutput {
        return delete_job_execution.execute(self, allocator, input, options);
    }

    /// Deletes the specified job template.
    pub fn deleteJobTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_job_template.DeleteJobTemplateInput, options: delete_job_template.Options) !delete_job_template.DeleteJobTemplateOutput {
        return delete_job_template.execute(self, allocator, input, options);
    }

    /// Deletes a defined mitigation action from your Amazon Web Services accounts.
    ///
    /// Requires permission to access the
    /// [DeleteMitigationAction](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteMitigationAction(self: *Self, allocator: std.mem.Allocator, input: delete_mitigation_action.DeleteMitigationActionInput, options: delete_mitigation_action.Options) !delete_mitigation_action.DeleteMitigationActionOutput {
        return delete_mitigation_action.execute(self, allocator, input, options);
    }

    /// Delete an OTA update.
    ///
    /// Requires permission to access the
    /// [DeleteOTAUpdate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteOtaUpdate(self: *Self, allocator: std.mem.Allocator, input: delete_ota_update.DeleteOTAUpdateInput, options: delete_ota_update.Options) !delete_ota_update.DeleteOTAUpdateOutput {
        return delete_ota_update.execute(self, allocator, input, options);
    }

    /// Deletes a specific version from a software package.
    ///
    /// **Note:** All package versions must be deleted before deleting the software
    /// package.
    ///
    /// Requires permission to access the
    /// [DeletePackageVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deletePackage(self: *Self, allocator: std.mem.Allocator, input: delete_package.DeletePackageInput, options: delete_package.Options) !delete_package.DeletePackageOutput {
        return delete_package.execute(self, allocator, input, options);
    }

    /// Deletes a specific version from a software package.
    ///
    /// **Note:** If a package version is designated as default, you must remove the
    /// designation from the software package using the UpdatePackage action.
    pub fn deletePackageVersion(self: *Self, allocator: std.mem.Allocator, input: delete_package_version.DeletePackageVersionInput, options: delete_package_version.Options) !delete_package_version.DeletePackageVersionOutput {
        return delete_package_version.execute(self, allocator, input, options);
    }

    /// Deletes the specified policy.
    ///
    /// A policy cannot be deleted if it has non-default versions or it is attached
    /// to any
    /// certificate.
    ///
    /// To delete a policy, use the DeletePolicyVersion action to delete all
    /// non-default
    /// versions of the policy; use the DetachPolicy action to detach the policy
    /// from any
    /// certificate; and then use the DeletePolicy action to delete the policy.
    ///
    /// When a policy is deleted using DeletePolicy, its default version is deleted
    /// with
    /// it.
    ///
    /// Because of the distributed nature of Amazon Web Services, it can take up to
    /// five minutes after
    /// a policy is detached before it's ready to be deleted.
    ///
    /// Requires permission to access the
    /// [DeletePolicy](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: delete_policy.Options) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified version of the specified policy. You cannot delete the
    /// default
    /// version of a policy using this action. To delete the default version of a
    /// policy, use DeletePolicy. To find out which version of a policy is marked as
    /// the default
    /// version, use ListPolicyVersions.
    ///
    /// Requires permission to access the
    /// [DeletePolicyVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deletePolicyVersion(self: *Self, allocator: std.mem.Allocator, input: delete_policy_version.DeletePolicyVersionInput, options: delete_policy_version.Options) !delete_policy_version.DeletePolicyVersionOutput {
        return delete_policy_version.execute(self, allocator, input, options);
    }

    /// Deletes a provisioning template.
    ///
    /// Requires permission to access the
    /// [DeleteProvisioningTemplate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteProvisioningTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_provisioning_template.DeleteProvisioningTemplateInput, options: delete_provisioning_template.Options) !delete_provisioning_template.DeleteProvisioningTemplateOutput {
        return delete_provisioning_template.execute(self, allocator, input, options);
    }

    /// Deletes a provisioning template version.
    ///
    /// Requires permission to access the
    /// [DeleteProvisioningTemplateVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteProvisioningTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: delete_provisioning_template_version.DeleteProvisioningTemplateVersionInput, options: delete_provisioning_template_version.Options) !delete_provisioning_template_version.DeleteProvisioningTemplateVersionOutput {
        return delete_provisioning_template_version.execute(self, allocator, input, options);
    }

    /// Deletes a CA certificate registration code.
    ///
    /// Requires permission to access the
    /// [DeleteRegistrationCode](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteRegistrationCode(self: *Self, allocator: std.mem.Allocator, input: delete_registration_code.DeleteRegistrationCodeInput, options: delete_registration_code.Options) !delete_registration_code.DeleteRegistrationCodeOutput {
        return delete_registration_code.execute(self, allocator, input, options);
    }

    /// Deletes a role alias
    ///
    /// Requires permission to access the
    /// [DeleteRoleAlias](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteRoleAlias(self: *Self, allocator: std.mem.Allocator, input: delete_role_alias.DeleteRoleAliasInput, options: delete_role_alias.Options) !delete_role_alias.DeleteRoleAliasOutput {
        return delete_role_alias.execute(self, allocator, input, options);
    }

    /// Deletes a scheduled audit.
    ///
    /// Requires permission to access the
    /// [DeleteScheduledAudit](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteScheduledAudit(self: *Self, allocator: std.mem.Allocator, input: delete_scheduled_audit.DeleteScheduledAuditInput, options: delete_scheduled_audit.Options) !delete_scheduled_audit.DeleteScheduledAuditOutput {
        return delete_scheduled_audit.execute(self, allocator, input, options);
    }

    /// Deletes a Device Defender security profile.
    ///
    /// Requires permission to access the
    /// [DeleteSecurityProfile](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: delete_security_profile.DeleteSecurityProfileInput, options: delete_security_profile.Options) !delete_security_profile.DeleteSecurityProfileOutput {
        return delete_security_profile.execute(self, allocator, input, options);
    }

    /// Deletes a stream.
    ///
    /// Requires permission to access the
    /// [DeleteStream](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteStream(self: *Self, allocator: std.mem.Allocator, input: delete_stream.DeleteStreamInput, options: delete_stream.Options) !delete_stream.DeleteStreamOutput {
        return delete_stream.execute(self, allocator, input, options);
    }

    /// Deletes the specified thing. Returns successfully with no error if the
    /// deletion is
    /// successful or you specify a thing that doesn't exist.
    ///
    /// Requires permission to access the
    /// [DeleteThing](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteThing(self: *Self, allocator: std.mem.Allocator, input: delete_thing.DeleteThingInput, options: delete_thing.Options) !delete_thing.DeleteThingOutput {
        return delete_thing.execute(self, allocator, input, options);
    }

    /// Deletes a thing group.
    ///
    /// Requires permission to access the
    /// [DeleteThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteThingGroup(self: *Self, allocator: std.mem.Allocator, input: delete_thing_group.DeleteThingGroupInput, options: delete_thing_group.Options) !delete_thing_group.DeleteThingGroupOutput {
        return delete_thing_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified thing type. You cannot delete a thing type if it has
    /// things
    /// associated with it. To delete a thing type, first mark it as deprecated by
    /// calling DeprecateThingType, then remove any associated things by calling
    /// UpdateThing to change the thing type on any associated thing, and
    /// finally use DeleteThingType to delete the thing type.
    ///
    /// Requires permission to access the
    /// [DeleteThingType](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteThingType(self: *Self, allocator: std.mem.Allocator, input: delete_thing_type.DeleteThingTypeInput, options: delete_thing_type.Options) !delete_thing_type.DeleteThingTypeOutput {
        return delete_thing_type.execute(self, allocator, input, options);
    }

    /// Deletes the rule.
    ///
    /// Requires permission to access the
    /// [DeleteTopicRule](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteTopicRule(self: *Self, allocator: std.mem.Allocator, input: delete_topic_rule.DeleteTopicRuleInput, options: delete_topic_rule.Options) !delete_topic_rule.DeleteTopicRuleOutput {
        return delete_topic_rule.execute(self, allocator, input, options);
    }

    /// Deletes a topic rule destination.
    ///
    /// Requires permission to access the
    /// [DeleteTopicRuleDestination](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteTopicRuleDestination(self: *Self, allocator: std.mem.Allocator, input: delete_topic_rule_destination.DeleteTopicRuleDestinationInput, options: delete_topic_rule_destination.Options) !delete_topic_rule_destination.DeleteTopicRuleDestinationOutput {
        return delete_topic_rule_destination.execute(self, allocator, input, options);
    }

    /// Deletes a logging level.
    ///
    /// Requires permission to access the
    /// [DeleteV2LoggingLevel](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deleteV2LoggingLevel(self: *Self, allocator: std.mem.Allocator, input: delete_v2_logging_level.DeleteV2LoggingLevelInput, options: delete_v2_logging_level.Options) !delete_v2_logging_level.DeleteV2LoggingLevelOutput {
        return delete_v2_logging_level.execute(self, allocator, input, options);
    }

    /// Deprecates a thing type. You can not associate new things with deprecated
    /// thing
    /// type.
    ///
    /// Requires permission to access the
    /// [DeprecateThingType](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn deprecateThingType(self: *Self, allocator: std.mem.Allocator, input: deprecate_thing_type.DeprecateThingTypeInput, options: deprecate_thing_type.Options) !deprecate_thing_type.DeprecateThingTypeOutput {
        return deprecate_thing_type.execute(self, allocator, input, options);
    }

    /// Gets information about the Device Defender audit settings for this account.
    /// Settings include how audit notifications are sent and which audit checks are
    /// enabled or disabled.
    ///
    /// Requires permission to access the
    /// [DescribeAccountAuditConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeAccountAuditConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_account_audit_configuration.DescribeAccountAuditConfigurationInput, options: describe_account_audit_configuration.Options) !describe_account_audit_configuration.DescribeAccountAuditConfigurationOutput {
        return describe_account_audit_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about a single audit finding. Properties include the reason
    /// for
    /// noncompliance, the severity of the issue,
    /// and the start time
    /// when the audit that returned the
    /// finding.
    ///
    /// Requires permission to access the
    /// [DescribeAuditFinding](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeAuditFinding(self: *Self, allocator: std.mem.Allocator, input: describe_audit_finding.DescribeAuditFindingInput, options: describe_audit_finding.Options) !describe_audit_finding.DescribeAuditFindingOutput {
        return describe_audit_finding.execute(self, allocator, input, options);
    }

    /// Gets information about an audit mitigation task that is used to apply
    /// mitigation actions to a set of audit findings. Properties include the
    /// actions being applied, the audit checks to which they're being applied, the
    /// task status, and aggregated task statistics.
    pub fn describeAuditMitigationActionsTask(self: *Self, allocator: std.mem.Allocator, input: describe_audit_mitigation_actions_task.DescribeAuditMitigationActionsTaskInput, options: describe_audit_mitigation_actions_task.Options) !describe_audit_mitigation_actions_task.DescribeAuditMitigationActionsTaskOutput {
        return describe_audit_mitigation_actions_task.execute(self, allocator, input, options);
    }

    /// Gets information about a Device Defender audit suppression.
    pub fn describeAuditSuppression(self: *Self, allocator: std.mem.Allocator, input: describe_audit_suppression.DescribeAuditSuppressionInput, options: describe_audit_suppression.Options) !describe_audit_suppression.DescribeAuditSuppressionOutput {
        return describe_audit_suppression.execute(self, allocator, input, options);
    }

    /// Gets information about a Device Defender audit.
    ///
    /// Requires permission to access the
    /// [DescribeAuditTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeAuditTask(self: *Self, allocator: std.mem.Allocator, input: describe_audit_task.DescribeAuditTaskInput, options: describe_audit_task.Options) !describe_audit_task.DescribeAuditTaskOutput {
        return describe_audit_task.execute(self, allocator, input, options);
    }

    /// Describes an authorizer.
    ///
    /// Requires permission to access the
    /// [DescribeAuthorizer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeAuthorizer(self: *Self, allocator: std.mem.Allocator, input: describe_authorizer.DescribeAuthorizerInput, options: describe_authorizer.Options) !describe_authorizer.DescribeAuthorizerOutput {
        return describe_authorizer.execute(self, allocator, input, options);
    }

    /// Returns information about a billing group.
    ///
    /// Requires permission to access the
    /// [DescribeBillingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeBillingGroup(self: *Self, allocator: std.mem.Allocator, input: describe_billing_group.DescribeBillingGroupInput, options: describe_billing_group.Options) !describe_billing_group.DescribeBillingGroupOutput {
        return describe_billing_group.execute(self, allocator, input, options);
    }

    /// Describes a registered CA certificate.
    ///
    /// Requires permission to access the
    /// [DescribeCACertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeCaCertificate(self: *Self, allocator: std.mem.Allocator, input: describe_ca_certificate.DescribeCACertificateInput, options: describe_ca_certificate.Options) !describe_ca_certificate.DescribeCACertificateOutput {
        return describe_ca_certificate.execute(self, allocator, input, options);
    }

    /// Gets information about the specified certificate.
    ///
    /// Requires permission to access the
    /// [DescribeCertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeCertificate(self: *Self, allocator: std.mem.Allocator, input: describe_certificate.DescribeCertificateInput, options: describe_certificate.Options) !describe_certificate.DescribeCertificateOutput {
        return describe_certificate.execute(self, allocator, input, options);
    }

    /// Describes a certificate provider.
    ///
    /// Requires permission to access the
    /// [DescribeCertificateProvider](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeCertificateProvider(self: *Self, allocator: std.mem.Allocator, input: describe_certificate_provider.DescribeCertificateProviderInput, options: describe_certificate_provider.Options) !describe_certificate_provider.DescribeCertificateProviderOutput {
        return describe_certificate_provider.execute(self, allocator, input, options);
    }

    /// Gets information about a Device Defender detect custom metric.
    ///
    /// Requires permission to access the
    /// [DescribeCustomMetric](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeCustomMetric(self: *Self, allocator: std.mem.Allocator, input: describe_custom_metric.DescribeCustomMetricInput, options: describe_custom_metric.Options) !describe_custom_metric.DescribeCustomMetricOutput {
        return describe_custom_metric.execute(self, allocator, input, options);
    }

    /// Describes the default authorizer.
    ///
    /// Requires permission to access the
    /// [DescribeDefaultAuthorizer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeDefaultAuthorizer(self: *Self, allocator: std.mem.Allocator, input: describe_default_authorizer.DescribeDefaultAuthorizerInput, options: describe_default_authorizer.Options) !describe_default_authorizer.DescribeDefaultAuthorizerOutput {
        return describe_default_authorizer.execute(self, allocator, input, options);
    }

    /// Gets information about a Device Defender ML Detect mitigation action.
    ///
    /// Requires permission to access the
    /// [DescribeDetectMitigationActionsTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeDetectMitigationActionsTask(self: *Self, allocator: std.mem.Allocator, input: describe_detect_mitigation_actions_task.DescribeDetectMitigationActionsTaskInput, options: describe_detect_mitigation_actions_task.Options) !describe_detect_mitigation_actions_task.DescribeDetectMitigationActionsTaskOutput {
        return describe_detect_mitigation_actions_task.execute(self, allocator, input, options);
    }

    /// Provides details about a dimension that is defined in your Amazon Web
    /// Services accounts.
    ///
    /// Requires permission to access the
    /// [DescribeDimension](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeDimension(self: *Self, allocator: std.mem.Allocator, input: describe_dimension.DescribeDimensionInput, options: describe_dimension.Options) !describe_dimension.DescribeDimensionOutput {
        return describe_dimension.execute(self, allocator, input, options);
    }

    /// Gets summary information about a domain configuration.
    ///
    /// Requires permission to access the
    /// [DescribeDomainConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeDomainConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_domain_configuration.DescribeDomainConfigurationInput, options: describe_domain_configuration.Options) !describe_domain_configuration.DescribeDomainConfigurationOutput {
        return describe_domain_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the encryption configuration for resources and data of your Amazon
    /// Web Services account in
    /// Amazon Web Services IoT Core. For more information, see [Data encryption at
    /// rest](https://docs.aws.amazon.com/iot/latest/developerguide/encryption-at-rest.html) in
    /// the *Amazon Web Services IoT Core Developer Guide*.
    pub fn describeEncryptionConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_encryption_configuration.DescribeEncryptionConfigurationInput, options: describe_encryption_configuration.Options) !describe_encryption_configuration.DescribeEncryptionConfigurationOutput {
        return describe_encryption_configuration.execute(self, allocator, input, options);
    }

    /// Returns or creates a unique endpoint specific to the Amazon Web Services
    /// account making the
    /// call.
    ///
    /// The first time `DescribeEndpoint` is called, an endpoint is created. All
    /// subsequent calls to `DescribeEndpoint` return the same endpoint.
    ///
    /// Requires permission to access the
    /// [DescribeEndpoint](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeEndpoint(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint.DescribeEndpointInput, options: describe_endpoint.Options) !describe_endpoint.DescribeEndpointOutput {
        return describe_endpoint.execute(self, allocator, input, options);
    }

    /// Describes event configurations.
    ///
    /// Requires permission to access the
    /// [DescribeEventConfigurations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeEventConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_event_configurations.DescribeEventConfigurationsInput, options: describe_event_configurations.Options) !describe_event_configurations.DescribeEventConfigurationsOutput {
        return describe_event_configurations.execute(self, allocator, input, options);
    }

    /// Gets information about the specified fleet metric.
    ///
    /// Requires permission to access the
    /// [DescribeFleetMetric](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeFleetMetric(self: *Self, allocator: std.mem.Allocator, input: describe_fleet_metric.DescribeFleetMetricInput, options: describe_fleet_metric.Options) !describe_fleet_metric.DescribeFleetMetricOutput {
        return describe_fleet_metric.execute(self, allocator, input, options);
    }

    /// Describes a search index.
    ///
    /// Requires permission to access the
    /// [DescribeIndex](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeIndex(self: *Self, allocator: std.mem.Allocator, input: describe_index.DescribeIndexInput, options: describe_index.Options) !describe_index.DescribeIndexOutput {
        return describe_index.execute(self, allocator, input, options);
    }

    /// Describes a job.
    ///
    /// Requires permission to access the
    /// [DescribeJob](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeJob(self: *Self, allocator: std.mem.Allocator, input: describe_job.DescribeJobInput, options: describe_job.Options) !describe_job.DescribeJobOutput {
        return describe_job.execute(self, allocator, input, options);
    }

    /// Describes a job execution.
    ///
    /// Requires permission to access the
    /// [DescribeJobExecution](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeJobExecution(self: *Self, allocator: std.mem.Allocator, input: describe_job_execution.DescribeJobExecutionInput, options: describe_job_execution.Options) !describe_job_execution.DescribeJobExecutionOutput {
        return describe_job_execution.execute(self, allocator, input, options);
    }

    /// Returns information about a job template.
    pub fn describeJobTemplate(self: *Self, allocator: std.mem.Allocator, input: describe_job_template.DescribeJobTemplateInput, options: describe_job_template.Options) !describe_job_template.DescribeJobTemplateOutput {
        return describe_job_template.execute(self, allocator, input, options);
    }

    /// View details of a managed job template.
    pub fn describeManagedJobTemplate(self: *Self, allocator: std.mem.Allocator, input: describe_managed_job_template.DescribeManagedJobTemplateInput, options: describe_managed_job_template.Options) !describe_managed_job_template.DescribeManagedJobTemplateOutput {
        return describe_managed_job_template.execute(self, allocator, input, options);
    }

    /// Gets information about a mitigation action.
    ///
    /// Requires permission to access the
    /// [DescribeMitigationAction](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeMitigationAction(self: *Self, allocator: std.mem.Allocator, input: describe_mitigation_action.DescribeMitigationActionInput, options: describe_mitigation_action.Options) !describe_mitigation_action.DescribeMitigationActionOutput {
        return describe_mitigation_action.execute(self, allocator, input, options);
    }

    /// Returns information about a provisioning template.
    ///
    /// Requires permission to access the
    /// [DescribeProvisioningTemplate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeProvisioningTemplate(self: *Self, allocator: std.mem.Allocator, input: describe_provisioning_template.DescribeProvisioningTemplateInput, options: describe_provisioning_template.Options) !describe_provisioning_template.DescribeProvisioningTemplateOutput {
        return describe_provisioning_template.execute(self, allocator, input, options);
    }

    /// Returns information about a provisioning template version.
    ///
    /// Requires permission to access the
    /// [DescribeProvisioningTemplateVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeProvisioningTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: describe_provisioning_template_version.DescribeProvisioningTemplateVersionInput, options: describe_provisioning_template_version.Options) !describe_provisioning_template_version.DescribeProvisioningTemplateVersionOutput {
        return describe_provisioning_template_version.execute(self, allocator, input, options);
    }

    /// Describes a role alias.
    ///
    /// Requires permission to access the
    /// [DescribeRoleAlias](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeRoleAlias(self: *Self, allocator: std.mem.Allocator, input: describe_role_alias.DescribeRoleAliasInput, options: describe_role_alias.Options) !describe_role_alias.DescribeRoleAliasOutput {
        return describe_role_alias.execute(self, allocator, input, options);
    }

    /// Gets information about a scheduled audit.
    ///
    /// Requires permission to access the
    /// [DescribeScheduledAudit](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeScheduledAudit(self: *Self, allocator: std.mem.Allocator, input: describe_scheduled_audit.DescribeScheduledAuditInput, options: describe_scheduled_audit.Options) !describe_scheduled_audit.DescribeScheduledAuditOutput {
        return describe_scheduled_audit.execute(self, allocator, input, options);
    }

    /// Gets information about a Device Defender security profile.
    ///
    /// Requires permission to access the
    /// [DescribeSecurityProfile](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: describe_security_profile.DescribeSecurityProfileInput, options: describe_security_profile.Options) !describe_security_profile.DescribeSecurityProfileOutput {
        return describe_security_profile.execute(self, allocator, input, options);
    }

    /// Gets information about a stream.
    ///
    /// Requires permission to access the
    /// [DescribeStream](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeStream(self: *Self, allocator: std.mem.Allocator, input: describe_stream.DescribeStreamInput, options: describe_stream.Options) !describe_stream.DescribeStreamOutput {
        return describe_stream.execute(self, allocator, input, options);
    }

    /// Gets information about the specified thing.
    ///
    /// Requires permission to access the
    /// [DescribeThing](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeThing(self: *Self, allocator: std.mem.Allocator, input: describe_thing.DescribeThingInput, options: describe_thing.Options) !describe_thing.DescribeThingOutput {
        return describe_thing.execute(self, allocator, input, options);
    }

    /// Describe a thing group.
    ///
    /// Requires permission to access the
    /// [DescribeThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeThingGroup(self: *Self, allocator: std.mem.Allocator, input: describe_thing_group.DescribeThingGroupInput, options: describe_thing_group.Options) !describe_thing_group.DescribeThingGroupOutput {
        return describe_thing_group.execute(self, allocator, input, options);
    }

    /// Describes a bulk thing provisioning task.
    ///
    /// Requires permission to access the
    /// [DescribeThingRegistrationTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeThingRegistrationTask(self: *Self, allocator: std.mem.Allocator, input: describe_thing_registration_task.DescribeThingRegistrationTaskInput, options: describe_thing_registration_task.Options) !describe_thing_registration_task.DescribeThingRegistrationTaskOutput {
        return describe_thing_registration_task.execute(self, allocator, input, options);
    }

    /// Gets information about the specified thing type.
    ///
    /// Requires permission to access the
    /// [DescribeThingType](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn describeThingType(self: *Self, allocator: std.mem.Allocator, input: describe_thing_type.DescribeThingTypeInput, options: describe_thing_type.Options) !describe_thing_type.DescribeThingTypeOutput {
        return describe_thing_type.execute(self, allocator, input, options);
    }

    /// Detaches a policy from the specified target.
    ///
    /// Because of the distributed nature of Amazon Web Services, it can take up to
    /// five minutes after
    /// a policy is detached before it's ready to be deleted.
    ///
    /// Requires permission to access the
    /// [DetachPolicy](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn detachPolicy(self: *Self, allocator: std.mem.Allocator, input: detach_policy.DetachPolicyInput, options: detach_policy.Options) !detach_policy.DetachPolicyOutput {
        return detach_policy.execute(self, allocator, input, options);
    }

    /// Removes the specified policy from the specified certificate.
    ///
    /// **Note:** This action is deprecated and works as
    /// expected for backward compatibility, but we won't add enhancements. Use
    /// DetachPolicy instead.
    ///
    /// Requires permission to access the
    /// [DetachPrincipalPolicy](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn detachPrincipalPolicy(self: *Self, allocator: std.mem.Allocator, input: detach_principal_policy.DetachPrincipalPolicyInput, options: detach_principal_policy.Options) !detach_principal_policy.DetachPrincipalPolicyOutput {
        return detach_principal_policy.execute(self, allocator, input, options);
    }

    /// Disassociates a Device Defender security profile from a thing group or from
    /// this account.
    ///
    /// Requires permission to access the
    /// [DetachSecurityProfile](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn detachSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: detach_security_profile.DetachSecurityProfileInput, options: detach_security_profile.Options) !detach_security_profile.DetachSecurityProfileOutput {
        return detach_security_profile.execute(self, allocator, input, options);
    }

    /// Detaches the specified principal from the specified thing. A principal can
    /// be X.509
    /// certificates, IAM users, groups, and roles, Amazon Cognito identities or
    /// federated
    /// identities.
    ///
    /// This call is asynchronous. It might take several seconds for the detachment
    /// to
    /// propagate.
    ///
    /// Requires permission to access the
    /// [DetachThingPrincipal](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn detachThingPrincipal(self: *Self, allocator: std.mem.Allocator, input: detach_thing_principal.DetachThingPrincipalInput, options: detach_thing_principal.Options) !detach_thing_principal.DetachThingPrincipalOutput {
        return detach_thing_principal.execute(self, allocator, input, options);
    }

    /// Disables the rule.
    ///
    /// Requires permission to access the
    /// [DisableTopicRule](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn disableTopicRule(self: *Self, allocator: std.mem.Allocator, input: disable_topic_rule.DisableTopicRuleInput, options: disable_topic_rule.Options) !disable_topic_rule.DisableTopicRuleOutput {
        return disable_topic_rule.execute(self, allocator, input, options);
    }

    /// Disassociates the selected software bill of materials (SBOM) from a specific
    /// software package version.
    ///
    /// Requires permission to access the
    /// [DisassociateSbomWithPackageVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn disassociateSbomFromPackageVersion(self: *Self, allocator: std.mem.Allocator, input: disassociate_sbom_from_package_version.DisassociateSbomFromPackageVersionInput, options: disassociate_sbom_from_package_version.Options) !disassociate_sbom_from_package_version.DisassociateSbomFromPackageVersionOutput {
        return disassociate_sbom_from_package_version.execute(self, allocator, input, options);
    }

    /// Enables the rule.
    ///
    /// Requires permission to access the
    /// [EnableTopicRule](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn enableTopicRule(self: *Self, allocator: std.mem.Allocator, input: enable_topic_rule.EnableTopicRuleInput, options: enable_topic_rule.Options) !enable_topic_rule.EnableTopicRuleOutput {
        return enable_topic_rule.execute(self, allocator, input, options);
    }

    /// Returns a Device Defender's ML Detect Security Profile training model's
    /// status.
    ///
    /// Requires permission to access the
    /// [GetBehaviorModelTrainingSummaries](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getBehaviorModelTrainingSummaries(self: *Self, allocator: std.mem.Allocator, input: get_behavior_model_training_summaries.GetBehaviorModelTrainingSummariesInput, options: get_behavior_model_training_summaries.Options) !get_behavior_model_training_summaries.GetBehaviorModelTrainingSummariesOutput {
        return get_behavior_model_training_summaries.execute(self, allocator, input, options);
    }

    /// Aggregates on indexed data with search queries pertaining to particular
    /// fields.
    ///
    /// Requires permission to access the
    /// [GetBucketsAggregation](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getBucketsAggregation(self: *Self, allocator: std.mem.Allocator, input: get_buckets_aggregation.GetBucketsAggregationInput, options: get_buckets_aggregation.Options) !get_buckets_aggregation.GetBucketsAggregationOutput {
        return get_buckets_aggregation.execute(self, allocator, input, options);
    }

    /// Returns the approximate count of unique values that match the query.
    ///
    /// Requires permission to access the
    /// [GetCardinality](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getCardinality(self: *Self, allocator: std.mem.Allocator, input: get_cardinality.GetCardinalityInput, options: get_cardinality.Options) !get_cardinality.GetCardinalityOutput {
        return get_cardinality.execute(self, allocator, input, options);
    }

    /// Gets information about the specified command.
    pub fn getCommand(self: *Self, allocator: std.mem.Allocator, input: get_command.GetCommandInput, options: get_command.Options) !get_command.GetCommandOutput {
        return get_command.execute(self, allocator, input, options);
    }

    /// Gets information about the specific command execution on a single device.
    pub fn getCommandExecution(self: *Self, allocator: std.mem.Allocator, input: get_command_execution.GetCommandExecutionInput, options: get_command_execution.Options) !get_command_execution.GetCommandExecutionOutput {
        return get_command_execution.execute(self, allocator, input, options);
    }

    /// Gets a list of the policies that have an effect on the authorization
    /// behavior of the
    /// specified device when it connects to the IoT device gateway.
    ///
    /// Requires permission to access the
    /// [GetEffectivePolicies](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getEffectivePolicies(self: *Self, allocator: std.mem.Allocator, input: get_effective_policies.GetEffectivePoliciesInput, options: get_effective_policies.Options) !get_effective_policies.GetEffectivePoliciesOutput {
        return get_effective_policies.execute(self, allocator, input, options);
    }

    /// Gets the indexing configuration.
    ///
    /// Requires permission to access the
    /// [GetIndexingConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getIndexingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_indexing_configuration.GetIndexingConfigurationInput, options: get_indexing_configuration.Options) !get_indexing_configuration.GetIndexingConfigurationOutput {
        return get_indexing_configuration.execute(self, allocator, input, options);
    }

    /// Gets a job document.
    ///
    /// Requires permission to access the
    /// [GetJobDocument](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getJobDocument(self: *Self, allocator: std.mem.Allocator, input: get_job_document.GetJobDocumentInput, options: get_job_document.Options) !get_job_document.GetJobDocumentOutput {
        return get_job_document.execute(self, allocator, input, options);
    }

    /// Gets the logging options.
    ///
    /// NOTE: use of this command is not recommended. Use `GetV2LoggingOptions`
    /// instead.
    ///
    /// Requires permission to access the
    /// [GetLoggingOptions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: get_logging_options.GetLoggingOptionsInput, options: get_logging_options.Options) !get_logging_options.GetLoggingOptionsOutput {
        return get_logging_options.execute(self, allocator, input, options);
    }

    /// Gets an OTA update.
    ///
    /// Requires permission to access the
    /// [GetOTAUpdate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getOtaUpdate(self: *Self, allocator: std.mem.Allocator, input: get_ota_update.GetOTAUpdateInput, options: get_ota_update.Options) !get_ota_update.GetOTAUpdateOutput {
        return get_ota_update.execute(self, allocator, input, options);
    }

    /// Gets information about the specified software package.
    ///
    /// Requires permission to access the
    /// [GetPackage](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getPackage(self: *Self, allocator: std.mem.Allocator, input: get_package.GetPackageInput, options: get_package.Options) !get_package.GetPackageOutput {
        return get_package.execute(self, allocator, input, options);
    }

    /// Gets information about the specified software package's configuration.
    ///
    /// Requires permission to access the
    /// [GetPackageConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getPackageConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_package_configuration.GetPackageConfigurationInput, options: get_package_configuration.Options) !get_package_configuration.GetPackageConfigurationOutput {
        return get_package_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about the specified package version.
    ///
    /// Requires permission to access the
    /// [GetPackageVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getPackageVersion(self: *Self, allocator: std.mem.Allocator, input: get_package_version.GetPackageVersionInput, options: get_package_version.Options) !get_package_version.GetPackageVersionOutput {
        return get_package_version.execute(self, allocator, input, options);
    }

    /// Groups the aggregated values that match the query into percentile groupings.
    /// The default
    /// percentile groupings are: 1,5,25,50,75,95,99, although you can specify your
    /// own
    /// when you call `GetPercentiles`. This function returns a value for each
    /// percentile group specified (or the default percentile groupings). The
    /// percentile group
    /// "1" contains the aggregated field value that occurs in approximately one
    /// percent of the
    /// values that match the query. The percentile group "5" contains the
    /// aggregated field value
    /// that occurs in approximately five percent of the values that match the
    /// query, and so on.
    /// The result is an approximation, the more values that match the query, the
    /// more accurate
    /// the percentile values.
    ///
    /// Requires permission to access the
    /// [GetPercentiles](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getPercentiles(self: *Self, allocator: std.mem.Allocator, input: get_percentiles.GetPercentilesInput, options: get_percentiles.Options) !get_percentiles.GetPercentilesOutput {
        return get_percentiles.execute(self, allocator, input, options);
    }

    /// Gets information about the specified policy with the policy document of the
    /// default
    /// version.
    ///
    /// Requires permission to access the
    /// [GetPolicy](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: get_policy.Options) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Gets information about the specified policy version.
    ///
    /// Requires permission to access the
    /// [GetPolicyVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: get_policy_version.GetPolicyVersionInput, options: get_policy_version.Options) !get_policy_version.GetPolicyVersionOutput {
        return get_policy_version.execute(self, allocator, input, options);
    }

    /// Gets a registration code used to register a CA certificate with IoT.
    ///
    /// IoT will create a registration code as part of this API call if the
    /// registration
    /// code doesn't exist or has been deleted. If you already have a registration
    /// code, this API
    /// call will return the same registration code.
    ///
    /// Requires permission to access the
    /// [GetRegistrationCode](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getRegistrationCode(self: *Self, allocator: std.mem.Allocator, input: get_registration_code.GetRegistrationCodeInput, options: get_registration_code.Options) !get_registration_code.GetRegistrationCodeOutput {
        return get_registration_code.execute(self, allocator, input, options);
    }

    /// Returns the count, average, sum, minimum, maximum, sum of squares, variance,
    /// and standard deviation for the specified aggregated field. If the
    /// aggregation field is of type
    /// `String`, only the count statistic is returned.
    ///
    /// Requires permission to access the
    /// [GetStatistics](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getStatistics(self: *Self, allocator: std.mem.Allocator, input: get_statistics.GetStatisticsInput, options: get_statistics.Options) !get_statistics.GetStatisticsOutput {
        return get_statistics.execute(self, allocator, input, options);
    }

    /// Retrieves the live connectivity status per device.
    pub fn getThingConnectivityData(self: *Self, allocator: std.mem.Allocator, input: get_thing_connectivity_data.GetThingConnectivityDataInput, options: get_thing_connectivity_data.Options) !get_thing_connectivity_data.GetThingConnectivityDataOutput {
        return get_thing_connectivity_data.execute(self, allocator, input, options);
    }

    /// Gets information about the rule.
    ///
    /// Requires permission to access the
    /// [GetTopicRule](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getTopicRule(self: *Self, allocator: std.mem.Allocator, input: get_topic_rule.GetTopicRuleInput, options: get_topic_rule.Options) !get_topic_rule.GetTopicRuleOutput {
        return get_topic_rule.execute(self, allocator, input, options);
    }

    /// Gets information about a topic rule destination.
    ///
    /// Requires permission to access the
    /// [GetTopicRuleDestination](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getTopicRuleDestination(self: *Self, allocator: std.mem.Allocator, input: get_topic_rule_destination.GetTopicRuleDestinationInput, options: get_topic_rule_destination.Options) !get_topic_rule_destination.GetTopicRuleDestinationOutput {
        return get_topic_rule_destination.execute(self, allocator, input, options);
    }

    /// Gets the fine grained logging options.
    ///
    /// Requires permission to access the
    /// [GetV2LoggingOptions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn getV2LoggingOptions(self: *Self, allocator: std.mem.Allocator, input: get_v2_logging_options.GetV2LoggingOptionsInput, options: get_v2_logging_options.Options) !get_v2_logging_options.GetV2LoggingOptionsOutput {
        return get_v2_logging_options.execute(self, allocator, input, options);
    }

    /// Lists the active violations for a given Device Defender security profile.
    ///
    /// Requires permission to access the
    /// [ListActiveViolations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listActiveViolations(self: *Self, allocator: std.mem.Allocator, input: list_active_violations.ListActiveViolationsInput, options: list_active_violations.Options) !list_active_violations.ListActiveViolationsOutput {
        return list_active_violations.execute(self, allocator, input, options);
    }

    /// Lists the policies attached to the specified thing group.
    ///
    /// Requires permission to access the
    /// [ListAttachedPolicies](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listAttachedPolicies(self: *Self, allocator: std.mem.Allocator, input: list_attached_policies.ListAttachedPoliciesInput, options: list_attached_policies.Options) !list_attached_policies.ListAttachedPoliciesOutput {
        return list_attached_policies.execute(self, allocator, input, options);
    }

    /// Lists the findings (results) of a Device Defender audit or of the audits
    /// performed during a specified time period. (Findings are retained for 90
    /// days.)
    ///
    /// Requires permission to access the
    /// [ListAuditFindings](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listAuditFindings(self: *Self, allocator: std.mem.Allocator, input: list_audit_findings.ListAuditFindingsInput, options: list_audit_findings.Options) !list_audit_findings.ListAuditFindingsOutput {
        return list_audit_findings.execute(self, allocator, input, options);
    }

    /// Gets the status of audit mitigation action tasks that were
    /// executed.
    ///
    /// Requires permission to access the
    /// [ListAuditMitigationActionsExecutions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listAuditMitigationActionsExecutions(self: *Self, allocator: std.mem.Allocator, input: list_audit_mitigation_actions_executions.ListAuditMitigationActionsExecutionsInput, options: list_audit_mitigation_actions_executions.Options) !list_audit_mitigation_actions_executions.ListAuditMitigationActionsExecutionsOutput {
        return list_audit_mitigation_actions_executions.execute(self, allocator, input, options);
    }

    /// Gets a list of audit mitigation action tasks that match the specified
    /// filters.
    ///
    /// Requires permission to access the
    /// [ListAuditMitigationActionsTasks](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listAuditMitigationActionsTasks(self: *Self, allocator: std.mem.Allocator, input: list_audit_mitigation_actions_tasks.ListAuditMitigationActionsTasksInput, options: list_audit_mitigation_actions_tasks.Options) !list_audit_mitigation_actions_tasks.ListAuditMitigationActionsTasksOutput {
        return list_audit_mitigation_actions_tasks.execute(self, allocator, input, options);
    }

    /// Lists your Device Defender audit listings.
    ///
    /// Requires permission to access the
    /// [ListAuditSuppressions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listAuditSuppressions(self: *Self, allocator: std.mem.Allocator, input: list_audit_suppressions.ListAuditSuppressionsInput, options: list_audit_suppressions.Options) !list_audit_suppressions.ListAuditSuppressionsOutput {
        return list_audit_suppressions.execute(self, allocator, input, options);
    }

    /// Lists the Device Defender audits that have been performed during a given
    /// time period.
    ///
    /// Requires permission to access the
    /// [ListAuditTasks](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listAuditTasks(self: *Self, allocator: std.mem.Allocator, input: list_audit_tasks.ListAuditTasksInput, options: list_audit_tasks.Options) !list_audit_tasks.ListAuditTasksOutput {
        return list_audit_tasks.execute(self, allocator, input, options);
    }

    /// Lists the authorizers registered in your account.
    ///
    /// Requires permission to access the
    /// [ListAuthorizers](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listAuthorizers(self: *Self, allocator: std.mem.Allocator, input: list_authorizers.ListAuthorizersInput, options: list_authorizers.Options) !list_authorizers.ListAuthorizersOutput {
        return list_authorizers.execute(self, allocator, input, options);
    }

    /// Lists the billing groups you have created.
    ///
    /// Requires permission to access the
    /// [ListBillingGroups](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listBillingGroups(self: *Self, allocator: std.mem.Allocator, input: list_billing_groups.ListBillingGroupsInput, options: list_billing_groups.Options) !list_billing_groups.ListBillingGroupsOutput {
        return list_billing_groups.execute(self, allocator, input, options);
    }

    /// Lists the CA certificates registered for your Amazon Web Services account.
    ///
    /// The results are paginated with a default page size of 25. You can use the
    /// returned
    /// marker to retrieve additional results.
    ///
    /// Requires permission to access the
    /// [ListCACertificates](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listCaCertificates(self: *Self, allocator: std.mem.Allocator, input: list_ca_certificates.ListCACertificatesInput, options: list_ca_certificates.Options) !list_ca_certificates.ListCACertificatesOutput {
        return list_ca_certificates.execute(self, allocator, input, options);
    }

    /// Lists all your certificate providers in your Amazon Web Services account.
    ///
    /// Requires permission to access the
    /// [ListCertificateProviders](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listCertificateProviders(self: *Self, allocator: std.mem.Allocator, input: list_certificate_providers.ListCertificateProvidersInput, options: list_certificate_providers.Options) !list_certificate_providers.ListCertificateProvidersOutput {
        return list_certificate_providers.execute(self, allocator, input, options);
    }

    /// Lists the certificates registered in your Amazon Web Services account.
    ///
    /// The results are paginated with a default page size of 25. You can use the
    /// returned
    /// marker to retrieve additional results.
    ///
    /// Requires permission to access the
    /// [ListCertificates](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listCertificates(self: *Self, allocator: std.mem.Allocator, input: list_certificates.ListCertificatesInput, options: list_certificates.Options) !list_certificates.ListCertificatesOutput {
        return list_certificates.execute(self, allocator, input, options);
    }

    /// List the device certificates signed by the specified CA certificate.
    ///
    /// Requires permission to access the
    /// [ListCertificatesByCA](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listCertificatesByCa(self: *Self, allocator: std.mem.Allocator, input: list_certificates_by_ca.ListCertificatesByCAInput, options: list_certificates_by_ca.Options) !list_certificates_by_ca.ListCertificatesByCAOutput {
        return list_certificates_by_ca.execute(self, allocator, input, options);
    }

    /// List all command executions.
    ///
    /// * You must provide only the `startedTimeFilter` or
    /// the `completedTimeFilter` information. If you provide
    /// both time filters, the API will generate an error. You can use
    /// this information to retrieve a list of command executions
    /// within a specific timeframe.
    ///
    /// * You must provide only the `commandArn` or
    /// the `thingArn` information depending on whether you want
    /// to list executions for a specific command or an IoT thing. If you provide
    /// both fields, the API will generate an error.
    ///
    /// For more information about considerations for using this API, see
    /// [List
    /// command executions in your account
    /// (CLI)](https://docs.aws.amazon.com/iot/latest/developerguide/iot-remote-command-execution-start-monitor.html#iot-remote-command-execution-list-cli).
    pub fn listCommandExecutions(self: *Self, allocator: std.mem.Allocator, input: list_command_executions.ListCommandExecutionsInput, options: list_command_executions.Options) !list_command_executions.ListCommandExecutionsOutput {
        return list_command_executions.execute(self, allocator, input, options);
    }

    /// List all commands in your account.
    pub fn listCommands(self: *Self, allocator: std.mem.Allocator, input: list_commands.ListCommandsInput, options: list_commands.Options) !list_commands.ListCommandsOutput {
        return list_commands.execute(self, allocator, input, options);
    }

    /// Lists your Device Defender detect custom metrics.
    ///
    /// Requires permission to access the
    /// [ListCustomMetrics](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listCustomMetrics(self: *Self, allocator: std.mem.Allocator, input: list_custom_metrics.ListCustomMetricsInput, options: list_custom_metrics.Options) !list_custom_metrics.ListCustomMetricsOutput {
        return list_custom_metrics.execute(self, allocator, input, options);
    }

    /// Lists mitigation actions executions for a Device Defender ML Detect Security
    /// Profile.
    ///
    /// Requires permission to access the
    /// [ListDetectMitigationActionsExecutions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listDetectMitigationActionsExecutions(self: *Self, allocator: std.mem.Allocator, input: list_detect_mitigation_actions_executions.ListDetectMitigationActionsExecutionsInput, options: list_detect_mitigation_actions_executions.Options) !list_detect_mitigation_actions_executions.ListDetectMitigationActionsExecutionsOutput {
        return list_detect_mitigation_actions_executions.execute(self, allocator, input, options);
    }

    /// List of Device Defender ML Detect mitigation actions tasks.
    ///
    /// Requires permission to access the
    /// [ListDetectMitigationActionsTasks](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listDetectMitigationActionsTasks(self: *Self, allocator: std.mem.Allocator, input: list_detect_mitigation_actions_tasks.ListDetectMitigationActionsTasksInput, options: list_detect_mitigation_actions_tasks.Options) !list_detect_mitigation_actions_tasks.ListDetectMitigationActionsTasksOutput {
        return list_detect_mitigation_actions_tasks.execute(self, allocator, input, options);
    }

    /// List the set of dimensions that are defined for your Amazon Web Services
    /// accounts.
    ///
    /// Requires permission to access the
    /// [ListDimensions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listDimensions(self: *Self, allocator: std.mem.Allocator, input: list_dimensions.ListDimensionsInput, options: list_dimensions.Options) !list_dimensions.ListDimensionsOutput {
        return list_dimensions.execute(self, allocator, input, options);
    }

    /// Gets a list of domain configurations for the user. This list is sorted
    /// alphabetically by domain configuration name.
    ///
    /// Requires permission to access the
    /// [ListDomainConfigurations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listDomainConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_domain_configurations.ListDomainConfigurationsInput, options: list_domain_configurations.Options) !list_domain_configurations.ListDomainConfigurationsOutput {
        return list_domain_configurations.execute(self, allocator, input, options);
    }

    /// Lists all your fleet metrics.
    ///
    /// Requires permission to access the
    /// [ListFleetMetrics](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listFleetMetrics(self: *Self, allocator: std.mem.Allocator, input: list_fleet_metrics.ListFleetMetricsInput, options: list_fleet_metrics.Options) !list_fleet_metrics.ListFleetMetricsOutput {
        return list_fleet_metrics.execute(self, allocator, input, options);
    }

    /// Lists the search indices.
    ///
    /// Requires permission to access the
    /// [ListIndices](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listIndices(self: *Self, allocator: std.mem.Allocator, input: list_indices.ListIndicesInput, options: list_indices.Options) !list_indices.ListIndicesOutput {
        return list_indices.execute(self, allocator, input, options);
    }

    /// Lists the job executions for a job.
    ///
    /// Requires permission to access the
    /// [ListJobExecutionsForJob](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listJobExecutionsForJob(self: *Self, allocator: std.mem.Allocator, input: list_job_executions_for_job.ListJobExecutionsForJobInput, options: list_job_executions_for_job.Options) !list_job_executions_for_job.ListJobExecutionsForJobOutput {
        return list_job_executions_for_job.execute(self, allocator, input, options);
    }

    /// Lists the job executions for the specified thing.
    ///
    /// Requires permission to access the
    /// [ListJobExecutionsForThing](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listJobExecutionsForThing(self: *Self, allocator: std.mem.Allocator, input: list_job_executions_for_thing.ListJobExecutionsForThingInput, options: list_job_executions_for_thing.Options) !list_job_executions_for_thing.ListJobExecutionsForThingOutput {
        return list_job_executions_for_thing.execute(self, allocator, input, options);
    }

    /// Returns a list of job templates.
    ///
    /// Requires permission to access the
    /// [ListJobTemplates](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listJobTemplates(self: *Self, allocator: std.mem.Allocator, input: list_job_templates.ListJobTemplatesInput, options: list_job_templates.Options) !list_job_templates.ListJobTemplatesOutput {
        return list_job_templates.execute(self, allocator, input, options);
    }

    /// Lists jobs.
    ///
    /// Requires permission to access the
    /// [ListJobs](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: list_jobs.Options) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of managed job templates.
    pub fn listManagedJobTemplates(self: *Self, allocator: std.mem.Allocator, input: list_managed_job_templates.ListManagedJobTemplatesInput, options: list_managed_job_templates.Options) !list_managed_job_templates.ListManagedJobTemplatesOutput {
        return list_managed_job_templates.execute(self, allocator, input, options);
    }

    /// Lists the values reported for an IoT Device Defender metric (device-side
    /// metric, cloud-side metric, or custom metric)
    /// by the given thing during the specified time period.
    pub fn listMetricValues(self: *Self, allocator: std.mem.Allocator, input: list_metric_values.ListMetricValuesInput, options: list_metric_values.Options) !list_metric_values.ListMetricValuesOutput {
        return list_metric_values.execute(self, allocator, input, options);
    }

    /// Gets a list of all mitigation actions that match the specified filter
    /// criteria.
    ///
    /// Requires permission to access the
    /// [ListMitigationActions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listMitigationActions(self: *Self, allocator: std.mem.Allocator, input: list_mitigation_actions.ListMitigationActionsInput, options: list_mitigation_actions.Options) !list_mitigation_actions.ListMitigationActionsOutput {
        return list_mitigation_actions.execute(self, allocator, input, options);
    }

    /// Lists OTA updates.
    ///
    /// Requires permission to access the
    /// [ListOTAUpdates](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listOtaUpdates(self: *Self, allocator: std.mem.Allocator, input: list_ota_updates.ListOTAUpdatesInput, options: list_ota_updates.Options) !list_ota_updates.ListOTAUpdatesOutput {
        return list_ota_updates.execute(self, allocator, input, options);
    }

    /// Lists certificates that are being transferred but not yet accepted.
    ///
    /// Requires permission to access the
    /// [ListOutgoingCertificates](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listOutgoingCertificates(self: *Self, allocator: std.mem.Allocator, input: list_outgoing_certificates.ListOutgoingCertificatesInput, options: list_outgoing_certificates.Options) !list_outgoing_certificates.ListOutgoingCertificatesOutput {
        return list_outgoing_certificates.execute(self, allocator, input, options);
    }

    /// Lists the software package versions associated to the account.
    ///
    /// Requires permission to access the
    /// [ListPackageVersions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listPackageVersions(self: *Self, allocator: std.mem.Allocator, input: list_package_versions.ListPackageVersionsInput, options: list_package_versions.Options) !list_package_versions.ListPackageVersionsOutput {
        return list_package_versions.execute(self, allocator, input, options);
    }

    /// Lists the software packages associated to the account.
    ///
    /// Requires permission to access the
    /// [ListPackages](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listPackages(self: *Self, allocator: std.mem.Allocator, input: list_packages.ListPackagesInput, options: list_packages.Options) !list_packages.ListPackagesOutput {
        return list_packages.execute(self, allocator, input, options);
    }

    /// Lists your policies.
    ///
    /// Requires permission to access the
    /// [ListPolicies](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listPolicies(self: *Self, allocator: std.mem.Allocator, input: list_policies.ListPoliciesInput, options: list_policies.Options) !list_policies.ListPoliciesOutput {
        return list_policies.execute(self, allocator, input, options);
    }

    /// Lists the principals associated with the specified policy.
    ///
    /// **Note:** This action is deprecated and works as
    /// expected for backward compatibility, but we won't add enhancements. Use
    /// ListTargetsForPolicy instead.
    ///
    /// Requires permission to access the
    /// [ListPolicyPrincipals](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listPolicyPrincipals(self: *Self, allocator: std.mem.Allocator, input: list_policy_principals.ListPolicyPrincipalsInput, options: list_policy_principals.Options) !list_policy_principals.ListPolicyPrincipalsOutput {
        return list_policy_principals.execute(self, allocator, input, options);
    }

    /// Lists the versions of the specified policy and identifies the default
    /// version.
    ///
    /// Requires permission to access the
    /// [ListPolicyVersions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listPolicyVersions(self: *Self, allocator: std.mem.Allocator, input: list_policy_versions.ListPolicyVersionsInput, options: list_policy_versions.Options) !list_policy_versions.ListPolicyVersionsOutput {
        return list_policy_versions.execute(self, allocator, input, options);
    }

    /// Lists the policies attached to the specified principal. If you use an
    /// Cognito
    /// identity, the ID must be in [AmazonCognito Identity
    /// format](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetCredentialsForIdentity.html#API_GetCredentialsForIdentity_RequestSyntax).
    ///
    /// **Note:** This action is deprecated and works as
    /// expected for backward compatibility, but we won't add enhancements. Use
    /// ListAttachedPolicies instead.
    ///
    /// Requires permission to access the
    /// [ListPrincipalPolicies](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listPrincipalPolicies(self: *Self, allocator: std.mem.Allocator, input: list_principal_policies.ListPrincipalPoliciesInput, options: list_principal_policies.Options) !list_principal_policies.ListPrincipalPoliciesOutput {
        return list_principal_policies.execute(self, allocator, input, options);
    }

    /// Lists the things associated with the specified principal. A principal can be
    /// X.509
    /// certificates, IAM users, groups, and roles, Amazon Cognito identities or
    /// federated
    /// identities.
    ///
    /// Requires permission to access the
    /// [ListPrincipalThings](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listPrincipalThings(self: *Self, allocator: std.mem.Allocator, input: list_principal_things.ListPrincipalThingsInput, options: list_principal_things.Options) !list_principal_things.ListPrincipalThingsOutput {
        return list_principal_things.execute(self, allocator, input, options);
    }

    /// Lists the things associated with the specified principal. A principal can be
    /// an X.509
    /// certificate or an Amazon Cognito ID.
    ///
    /// Requires permission to access the
    /// [ListPrincipalThings](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listPrincipalThingsV2(self: *Self, allocator: std.mem.Allocator, input: list_principal_things_v2.ListPrincipalThingsV2Input, options: list_principal_things_v2.Options) !list_principal_things_v2.ListPrincipalThingsV2Output {
        return list_principal_things_v2.execute(self, allocator, input, options);
    }

    /// A list of provisioning template versions.
    ///
    /// Requires permission to access the
    /// [ListProvisioningTemplateVersions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listProvisioningTemplateVersions(self: *Self, allocator: std.mem.Allocator, input: list_provisioning_template_versions.ListProvisioningTemplateVersionsInput, options: list_provisioning_template_versions.Options) !list_provisioning_template_versions.ListProvisioningTemplateVersionsOutput {
        return list_provisioning_template_versions.execute(self, allocator, input, options);
    }

    /// Lists the provisioning templates in your Amazon Web Services account.
    ///
    /// Requires permission to access the
    /// [ListProvisioningTemplates](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listProvisioningTemplates(self: *Self, allocator: std.mem.Allocator, input: list_provisioning_templates.ListProvisioningTemplatesInput, options: list_provisioning_templates.Options) !list_provisioning_templates.ListProvisioningTemplatesOutput {
        return list_provisioning_templates.execute(self, allocator, input, options);
    }

    /// The related resources of an Audit finding.
    /// The following resources can be returned from calling this API:
    ///
    /// * DEVICE_CERTIFICATE
    ///
    /// * CA_CERTIFICATE
    ///
    /// * IOT_POLICY
    ///
    /// * COGNITO_IDENTITY_POOL
    ///
    /// * CLIENT_ID
    ///
    /// * ACCOUNT_SETTINGS
    ///
    /// * ROLE_ALIAS
    ///
    /// * IAM_ROLE
    ///
    /// * ISSUER_CERTIFICATE
    ///
    /// This API is similar to DescribeAuditFinding's
    /// [RelatedResources](https://docs.aws.amazon.com/iot/latest/apireference/API_DescribeAuditFinding.html)
    /// but provides pagination and is not limited to 10 resources.
    /// When calling
    /// [DescribeAuditFinding](https://docs.aws.amazon.com/iot/latest/apireference/API_DescribeAuditFinding.html) for the intermediate CA revoked for
    /// active device certificates check, RelatedResources will not be populated.
    /// You must use this API, ListRelatedResourcesForAuditFinding, to list the
    /// certificates.
    pub fn listRelatedResourcesForAuditFinding(self: *Self, allocator: std.mem.Allocator, input: list_related_resources_for_audit_finding.ListRelatedResourcesForAuditFindingInput, options: list_related_resources_for_audit_finding.Options) !list_related_resources_for_audit_finding.ListRelatedResourcesForAuditFindingOutput {
        return list_related_resources_for_audit_finding.execute(self, allocator, input, options);
    }

    /// Lists the role aliases registered in your account.
    ///
    /// Requires permission to access the
    /// [ListRoleAliases](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listRoleAliases(self: *Self, allocator: std.mem.Allocator, input: list_role_aliases.ListRoleAliasesInput, options: list_role_aliases.Options) !list_role_aliases.ListRoleAliasesOutput {
        return list_role_aliases.execute(self, allocator, input, options);
    }

    /// The validation results for all software bill of materials (SBOM) attached to
    /// a specific software package version.
    ///
    /// Requires permission to access the
    /// [ListSbomValidationResults](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listSbomValidationResults(self: *Self, allocator: std.mem.Allocator, input: list_sbom_validation_results.ListSbomValidationResultsInput, options: list_sbom_validation_results.Options) !list_sbom_validation_results.ListSbomValidationResultsOutput {
        return list_sbom_validation_results.execute(self, allocator, input, options);
    }

    /// Lists all of your scheduled audits.
    ///
    /// Requires permission to access the
    /// [ListScheduledAudits](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listScheduledAudits(self: *Self, allocator: std.mem.Allocator, input: list_scheduled_audits.ListScheduledAuditsInput, options: list_scheduled_audits.Options) !list_scheduled_audits.ListScheduledAuditsOutput {
        return list_scheduled_audits.execute(self, allocator, input, options);
    }

    /// Lists the Device Defender security profiles
    /// you've
    /// created. You can filter security profiles by dimension or custom metric.
    ///
    /// Requires permission to access the
    /// [ListSecurityProfiles](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// `dimensionName` and `metricName` cannot be used in the same request.
    pub fn listSecurityProfiles(self: *Self, allocator: std.mem.Allocator, input: list_security_profiles.ListSecurityProfilesInput, options: list_security_profiles.Options) !list_security_profiles.ListSecurityProfilesOutput {
        return list_security_profiles.execute(self, allocator, input, options);
    }

    /// Lists the Device Defender security profiles attached to a target (thing
    /// group).
    ///
    /// Requires permission to access the
    /// [ListSecurityProfilesForTarget](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listSecurityProfilesForTarget(self: *Self, allocator: std.mem.Allocator, input: list_security_profiles_for_target.ListSecurityProfilesForTargetInput, options: list_security_profiles_for_target.Options) !list_security_profiles_for_target.ListSecurityProfilesForTargetOutput {
        return list_security_profiles_for_target.execute(self, allocator, input, options);
    }

    /// Lists all of the streams in your Amazon Web Services account.
    ///
    /// Requires permission to access the
    /// [ListStreams](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listStreams(self: *Self, allocator: std.mem.Allocator, input: list_streams.ListStreamsInput, options: list_streams.Options) !list_streams.ListStreamsOutput {
        return list_streams.execute(self, allocator, input, options);
    }

    /// Lists the tags (metadata) you have assigned to the resource.
    ///
    /// Requires permission to access the
    /// [ListTagsForResource](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List targets for the specified policy.
    ///
    /// Requires permission to access the
    /// [ListTargetsForPolicy](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listTargetsForPolicy(self: *Self, allocator: std.mem.Allocator, input: list_targets_for_policy.ListTargetsForPolicyInput, options: list_targets_for_policy.Options) !list_targets_for_policy.ListTargetsForPolicyOutput {
        return list_targets_for_policy.execute(self, allocator, input, options);
    }

    /// Lists the targets (thing groups) associated with a given Device Defender
    /// security profile.
    ///
    /// Requires permission to access the
    /// [ListTargetsForSecurityProfile](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listTargetsForSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: list_targets_for_security_profile.ListTargetsForSecurityProfileInput, options: list_targets_for_security_profile.Options) !list_targets_for_security_profile.ListTargetsForSecurityProfileOutput {
        return list_targets_for_security_profile.execute(self, allocator, input, options);
    }

    /// List the thing groups in your account.
    ///
    /// Requires permission to access the
    /// [ListThingGroups](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listThingGroups(self: *Self, allocator: std.mem.Allocator, input: list_thing_groups.ListThingGroupsInput, options: list_thing_groups.Options) !list_thing_groups.ListThingGroupsOutput {
        return list_thing_groups.execute(self, allocator, input, options);
    }

    /// List the thing groups to which the specified thing belongs.
    ///
    /// Requires permission to access the
    /// [ListThingGroupsForThing](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listThingGroupsForThing(self: *Self, allocator: std.mem.Allocator, input: list_thing_groups_for_thing.ListThingGroupsForThingInput, options: list_thing_groups_for_thing.Options) !list_thing_groups_for_thing.ListThingGroupsForThingOutput {
        return list_thing_groups_for_thing.execute(self, allocator, input, options);
    }

    /// Lists the principals associated with the specified thing. A principal can be
    /// X.509
    /// certificates, IAM users, groups, and roles, Amazon Cognito identities or
    /// federated
    /// identities.
    ///
    /// Requires permission to access the
    /// [ListThingPrincipals](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listThingPrincipals(self: *Self, allocator: std.mem.Allocator, input: list_thing_principals.ListThingPrincipalsInput, options: list_thing_principals.Options) !list_thing_principals.ListThingPrincipalsOutput {
        return list_thing_principals.execute(self, allocator, input, options);
    }

    /// Lists the principals associated with the specified thing. A principal can be
    /// an X.509
    /// certificate or an Amazon Cognito ID.
    ///
    /// Requires permission to access the
    /// [ListThingPrincipals](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listThingPrincipalsV2(self: *Self, allocator: std.mem.Allocator, input: list_thing_principals_v2.ListThingPrincipalsV2Input, options: list_thing_principals_v2.Options) !list_thing_principals_v2.ListThingPrincipalsV2Output {
        return list_thing_principals_v2.execute(self, allocator, input, options);
    }

    /// Information about the thing registration tasks.
    pub fn listThingRegistrationTaskReports(self: *Self, allocator: std.mem.Allocator, input: list_thing_registration_task_reports.ListThingRegistrationTaskReportsInput, options: list_thing_registration_task_reports.Options) !list_thing_registration_task_reports.ListThingRegistrationTaskReportsOutput {
        return list_thing_registration_task_reports.execute(self, allocator, input, options);
    }

    /// List bulk thing provisioning tasks.
    ///
    /// Requires permission to access the
    /// [ListThingRegistrationTasks](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listThingRegistrationTasks(self: *Self, allocator: std.mem.Allocator, input: list_thing_registration_tasks.ListThingRegistrationTasksInput, options: list_thing_registration_tasks.Options) !list_thing_registration_tasks.ListThingRegistrationTasksOutput {
        return list_thing_registration_tasks.execute(self, allocator, input, options);
    }

    /// Lists the existing thing types.
    ///
    /// Requires permission to access the
    /// [ListThingTypes](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listThingTypes(self: *Self, allocator: std.mem.Allocator, input: list_thing_types.ListThingTypesInput, options: list_thing_types.Options) !list_thing_types.ListThingTypesOutput {
        return list_thing_types.execute(self, allocator, input, options);
    }

    /// Lists your things. Use the **attributeName** and **attributeValue**
    /// parameters to filter your things. For example,
    /// calling `ListThings` with attributeName=Color and attributeValue=Red
    /// retrieves all things in the registry that contain an attribute **Color**
    /// with the value **Red**. For more
    /// information, see [List
    /// Things](https://docs.aws.amazon.com/iot/latest/developerguide/thing-registry.html#list-things) from the *Amazon Web Services IoT Core Developer
    /// Guide*.
    ///
    /// Requires permission to access the
    /// [ListThings](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// You will not be charged for calling this API if an `Access denied` error is
    /// returned. You will also not be charged if no attributes or pagination token
    /// was provided in request and no pagination token and no results were
    /// returned.
    pub fn listThings(self: *Self, allocator: std.mem.Allocator, input: list_things.ListThingsInput, options: list_things.Options) !list_things.ListThingsOutput {
        return list_things.execute(self, allocator, input, options);
    }

    /// Lists the things you have added to the given billing group.
    ///
    /// Requires permission to access the
    /// [ListThingsInBillingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listThingsInBillingGroup(self: *Self, allocator: std.mem.Allocator, input: list_things_in_billing_group.ListThingsInBillingGroupInput, options: list_things_in_billing_group.Options) !list_things_in_billing_group.ListThingsInBillingGroupOutput {
        return list_things_in_billing_group.execute(self, allocator, input, options);
    }

    /// Lists the things in the specified group.
    ///
    /// Requires permission to access the
    /// [ListThingsInThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listThingsInThingGroup(self: *Self, allocator: std.mem.Allocator, input: list_things_in_thing_group.ListThingsInThingGroupInput, options: list_things_in_thing_group.Options) !list_things_in_thing_group.ListThingsInThingGroupOutput {
        return list_things_in_thing_group.execute(self, allocator, input, options);
    }

    /// Lists all the topic rule destinations in your Amazon Web Services account.
    ///
    /// Requires permission to access the
    /// [ListTopicRuleDestinations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listTopicRuleDestinations(self: *Self, allocator: std.mem.Allocator, input: list_topic_rule_destinations.ListTopicRuleDestinationsInput, options: list_topic_rule_destinations.Options) !list_topic_rule_destinations.ListTopicRuleDestinationsOutput {
        return list_topic_rule_destinations.execute(self, allocator, input, options);
    }

    /// Lists the rules for the specific topic.
    ///
    /// Requires permission to access the
    /// [ListTopicRules](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listTopicRules(self: *Self, allocator: std.mem.Allocator, input: list_topic_rules.ListTopicRulesInput, options: list_topic_rules.Options) !list_topic_rules.ListTopicRulesOutput {
        return list_topic_rules.execute(self, allocator, input, options);
    }

    /// Lists logging levels.
    ///
    /// Requires permission to access the
    /// [ListV2LoggingLevels](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listV2LoggingLevels(self: *Self, allocator: std.mem.Allocator, input: list_v2_logging_levels.ListV2LoggingLevelsInput, options: list_v2_logging_levels.Options) !list_v2_logging_levels.ListV2LoggingLevelsOutput {
        return list_v2_logging_levels.execute(self, allocator, input, options);
    }

    /// Lists the Device Defender security profile violations discovered during the
    /// given time period.
    /// You can use filters to limit the results to those alerts issued for a
    /// particular security profile,
    /// behavior, or thing (device).
    ///
    /// Requires permission to access the
    /// [ListViolationEvents](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listViolationEvents(self: *Self, allocator: std.mem.Allocator, input: list_violation_events.ListViolationEventsInput, options: list_violation_events.Options) !list_violation_events.ListViolationEventsOutput {
        return list_violation_events.execute(self, allocator, input, options);
    }

    /// Set a verification state and provide a description of that verification
    /// state on a violation (detect alarm).
    pub fn putVerificationStateOnViolation(self: *Self, allocator: std.mem.Allocator, input: put_verification_state_on_violation.PutVerificationStateOnViolationInput, options: put_verification_state_on_violation.Options) !put_verification_state_on_violation.PutVerificationStateOnViolationOutput {
        return put_verification_state_on_violation.execute(self, allocator, input, options);
    }

    /// Registers a CA certificate with Amazon Web Services IoT Core. There is no
    /// limit to the number of CA
    /// certificates you can register in your Amazon Web Services account. You can
    /// register up to 10 CA
    /// certificates with the same `CA subject field` per Amazon Web Services
    /// account.
    ///
    /// Requires permission to access the
    /// [RegisterCACertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn registerCaCertificate(self: *Self, allocator: std.mem.Allocator, input: register_ca_certificate.RegisterCACertificateInput, options: register_ca_certificate.Options) !register_ca_certificate.RegisterCACertificateOutput {
        return register_ca_certificate.execute(self, allocator, input, options);
    }

    /// Registers a device certificate with IoT in the same [certificate
    /// mode](https://docs.aws.amazon.com/iot/latest/apireference/API_CertificateDescription.html#iot-Type-CertificateDescription-certificateMode) as the signing CA. If you have more than one CA certificate that has the same subject field, you must
    /// specify the CA certificate that was used to sign the device certificate
    /// being
    /// registered.
    ///
    /// Requires permission to access the
    /// [RegisterCertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn registerCertificate(self: *Self, allocator: std.mem.Allocator, input: register_certificate.RegisterCertificateInput, options: register_certificate.Options) !register_certificate.RegisterCertificateOutput {
        return register_certificate.execute(self, allocator, input, options);
    }

    /// Register a certificate that does not have a certificate authority (CA).
    /// For supported certificates, consult [
    /// Certificate signing algorithms supported by
    /// IoT](https://docs.aws.amazon.com/iot/latest/developerguide/x509-client-certs.html#x509-cert-algorithms).
    pub fn registerCertificateWithoutCa(self: *Self, allocator: std.mem.Allocator, input: register_certificate_without_ca.RegisterCertificateWithoutCAInput, options: register_certificate_without_ca.Options) !register_certificate_without_ca.RegisterCertificateWithoutCAOutput {
        return register_certificate_without_ca.execute(self, allocator, input, options);
    }

    /// Provisions a thing in the device registry. RegisterThing calls other IoT
    /// control
    /// plane APIs. These calls might exceed your account level [
    /// IoT Throttling
    /// Limits](https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html#limits_iot) and cause throttle errors. Please contact [Amazon Web Services Customer Support](https://console.aws.amazon.com/support/home) to raise
    /// your throttling limits if necessary.
    ///
    /// Requires permission to access the
    /// [RegisterThing](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn registerThing(self: *Self, allocator: std.mem.Allocator, input: register_thing.RegisterThingInput, options: register_thing.Options) !register_thing.RegisterThingOutput {
        return register_thing.execute(self, allocator, input, options);
    }

    /// Rejects a pending certificate transfer. After IoT rejects a certificate
    /// transfer,
    /// the certificate status changes from **PENDING_TRANSFER** to
    /// **INACTIVE**.
    ///
    /// To check for pending certificate transfers, call ListCertificates
    /// to enumerate your certificates.
    ///
    /// This operation can only be called by the transfer destination. After it is
    /// called,
    /// the certificate will be returned to the source's account in the INACTIVE
    /// state.
    ///
    /// Requires permission to access the
    /// [RejectCertificateTransfer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn rejectCertificateTransfer(self: *Self, allocator: std.mem.Allocator, input: reject_certificate_transfer.RejectCertificateTransferInput, options: reject_certificate_transfer.Options) !reject_certificate_transfer.RejectCertificateTransferOutput {
        return reject_certificate_transfer.execute(self, allocator, input, options);
    }

    /// Removes the given thing from the billing group.
    ///
    /// Requires permission to access the
    /// [RemoveThingFromBillingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// This call is asynchronous. It might take several seconds for the detachment
    /// to propagate.
    pub fn removeThingFromBillingGroup(self: *Self, allocator: std.mem.Allocator, input: remove_thing_from_billing_group.RemoveThingFromBillingGroupInput, options: remove_thing_from_billing_group.Options) !remove_thing_from_billing_group.RemoveThingFromBillingGroupOutput {
        return remove_thing_from_billing_group.execute(self, allocator, input, options);
    }

    /// Remove the specified thing from the specified group.
    ///
    /// You must specify either a `thingGroupArn` or a
    /// `thingGroupName` to identify the thing group and
    /// either a `thingArn` or a `thingName` to
    /// identify the thing to remove from the thing group.
    ///
    /// Requires permission to access the
    /// [RemoveThingFromThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn removeThingFromThingGroup(self: *Self, allocator: std.mem.Allocator, input: remove_thing_from_thing_group.RemoveThingFromThingGroupInput, options: remove_thing_from_thing_group.Options) !remove_thing_from_thing_group.RemoveThingFromThingGroupOutput {
        return remove_thing_from_thing_group.execute(self, allocator, input, options);
    }

    /// Replaces the rule. You must specify all parameters for the new rule.
    /// Creating rules
    /// is an administrator-level action. Any user who has permission to create
    /// rules will be able
    /// to access data processed by the rule.
    ///
    /// Requires permission to access the
    /// [ReplaceTopicRule](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn replaceTopicRule(self: *Self, allocator: std.mem.Allocator, input: replace_topic_rule.ReplaceTopicRuleInput, options: replace_topic_rule.Options) !replace_topic_rule.ReplaceTopicRuleOutput {
        return replace_topic_rule.execute(self, allocator, input, options);
    }

    /// The query search index.
    ///
    /// Requires permission to access the
    /// [SearchIndex](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn searchIndex(self: *Self, allocator: std.mem.Allocator, input: search_index.SearchIndexInput, options: search_index.Options) !search_index.SearchIndexOutput {
        return search_index.execute(self, allocator, input, options);
    }

    /// Sets the default authorizer. This will be used if a websocket connection is
    /// made
    /// without specifying an authorizer.
    ///
    /// Requires permission to access the
    /// [SetDefaultAuthorizer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn setDefaultAuthorizer(self: *Self, allocator: std.mem.Allocator, input: set_default_authorizer.SetDefaultAuthorizerInput, options: set_default_authorizer.Options) !set_default_authorizer.SetDefaultAuthorizerOutput {
        return set_default_authorizer.execute(self, allocator, input, options);
    }

    /// Sets the specified version of the specified policy as the policy's default
    /// (operative) version. This action affects all certificates to which the
    /// policy is attached.
    /// To list the principals the policy is attached to, use the
    /// ListPrincipalPolicies
    /// action.
    ///
    /// Requires permission to access the
    /// [SetDefaultPolicyVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn setDefaultPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: set_default_policy_version.SetDefaultPolicyVersionInput, options: set_default_policy_version.Options) !set_default_policy_version.SetDefaultPolicyVersionOutput {
        return set_default_policy_version.execute(self, allocator, input, options);
    }

    /// Sets the logging options.
    ///
    /// NOTE: use of this command is not recommended. Use `SetV2LoggingOptions`
    /// instead.
    ///
    /// Requires permission to access the
    /// [SetLoggingOptions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn setLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: set_logging_options.SetLoggingOptionsInput, options: set_logging_options.Options) !set_logging_options.SetLoggingOptionsOutput {
        return set_logging_options.execute(self, allocator, input, options);
    }

    /// Sets the logging level.
    ///
    /// Requires permission to access the
    /// [SetV2LoggingLevel](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn setV2LoggingLevel(self: *Self, allocator: std.mem.Allocator, input: set_v2_logging_level.SetV2LoggingLevelInput, options: set_v2_logging_level.Options) !set_v2_logging_level.SetV2LoggingLevelOutput {
        return set_v2_logging_level.execute(self, allocator, input, options);
    }

    /// Sets the logging options for the V2 logging service.
    ///
    /// Requires permission to access the
    /// [SetV2LoggingOptions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn setV2LoggingOptions(self: *Self, allocator: std.mem.Allocator, input: set_v2_logging_options.SetV2LoggingOptionsInput, options: set_v2_logging_options.Options) !set_v2_logging_options.SetV2LoggingOptionsOutput {
        return set_v2_logging_options.execute(self, allocator, input, options);
    }

    /// Starts a task that applies a set of mitigation actions to the specified
    /// target.
    ///
    /// Requires permission to access the
    /// [StartAuditMitigationActionsTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn startAuditMitigationActionsTask(self: *Self, allocator: std.mem.Allocator, input: start_audit_mitigation_actions_task.StartAuditMitigationActionsTaskInput, options: start_audit_mitigation_actions_task.Options) !start_audit_mitigation_actions_task.StartAuditMitigationActionsTaskOutput {
        return start_audit_mitigation_actions_task.execute(self, allocator, input, options);
    }

    /// Starts a Device Defender ML Detect mitigation actions task.
    ///
    /// Requires permission to access the
    /// [StartDetectMitigationActionsTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn startDetectMitigationActionsTask(self: *Self, allocator: std.mem.Allocator, input: start_detect_mitigation_actions_task.StartDetectMitigationActionsTaskInput, options: start_detect_mitigation_actions_task.Options) !start_detect_mitigation_actions_task.StartDetectMitigationActionsTaskOutput {
        return start_detect_mitigation_actions_task.execute(self, allocator, input, options);
    }

    /// Starts an on-demand Device Defender audit.
    ///
    /// Requires permission to access the
    /// [StartOnDemandAuditTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn startOnDemandAuditTask(self: *Self, allocator: std.mem.Allocator, input: start_on_demand_audit_task.StartOnDemandAuditTaskInput, options: start_on_demand_audit_task.Options) !start_on_demand_audit_task.StartOnDemandAuditTaskOutput {
        return start_on_demand_audit_task.execute(self, allocator, input, options);
    }

    /// Creates a bulk thing provisioning task.
    ///
    /// Requires permission to access the
    /// [StartThingRegistrationTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn startThingRegistrationTask(self: *Self, allocator: std.mem.Allocator, input: start_thing_registration_task.StartThingRegistrationTaskInput, options: start_thing_registration_task.Options) !start_thing_registration_task.StartThingRegistrationTaskOutput {
        return start_thing_registration_task.execute(self, allocator, input, options);
    }

    /// Cancels a bulk thing provisioning task.
    ///
    /// Requires permission to access the
    /// [StopThingRegistrationTask](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn stopThingRegistrationTask(self: *Self, allocator: std.mem.Allocator, input: stop_thing_registration_task.StopThingRegistrationTaskInput, options: stop_thing_registration_task.Options) !stop_thing_registration_task.StopThingRegistrationTaskOutput {
        return stop_thing_registration_task.execute(self, allocator, input, options);
    }

    /// Adds to or modifies the tags of the given resource. Tags are metadata which
    /// can be
    /// used to manage a resource.
    ///
    /// Requires permission to access the
    /// [TagResource](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests if a specified principal is authorized to perform an IoT action on a
    /// specified resource. Use this to test and debug the authorization behavior of
    /// devices that
    /// connect to the IoT device gateway.
    ///
    /// Requires permission to access the
    /// [TestAuthorization](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn testAuthorization(self: *Self, allocator: std.mem.Allocator, input: test_authorization.TestAuthorizationInput, options: test_authorization.Options) !test_authorization.TestAuthorizationOutput {
        return test_authorization.execute(self, allocator, input, options);
    }

    /// Tests a custom authorization behavior by invoking a specified custom
    /// authorizer. Use
    /// this to test and debug the custom authorization behavior of devices that
    /// connect to the IoT
    /// device gateway.
    ///
    /// Requires permission to access the
    /// [TestInvokeAuthorizer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn testInvokeAuthorizer(self: *Self, allocator: std.mem.Allocator, input: test_invoke_authorizer.TestInvokeAuthorizerInput, options: test_invoke_authorizer.Options) !test_invoke_authorizer.TestInvokeAuthorizerOutput {
        return test_invoke_authorizer.execute(self, allocator, input, options);
    }

    /// Transfers the specified certificate to the specified Amazon Web Services
    /// account.
    ///
    /// Requires permission to access the
    /// [TransferCertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// You can cancel the transfer until it is accepted by the recipient.
    ///
    /// No notification is sent to the transfer destination's account. The caller is
    /// responsible for notifying the transfer target.
    ///
    /// The certificate being transferred must not be in the `ACTIVE` state. You can
    /// use the
    /// UpdateCertificate action to deactivate it.
    ///
    /// The certificate must not have any policies attached to it. You can use the
    /// DetachPolicy action to detach them.
    ///
    /// **Customer managed key behavior:** When you use a customer managed key to
    /// encrypt your data and then transfer
    /// the certificate to a customer in a different account using the
    /// `TransferCertificate` operation, the certificates will no longer be
    /// encrypted by their
    /// customer managed key configuration. During the transfer process,
    /// certificates are encrypted using Amazon Web Services IoT Core owned keys.
    ///
    /// While a certificate is in the **PENDING_TRANSFER** state, it's always
    /// protected by Amazon Web Services IoT Core owned keys, regardless of the
    /// customer managed key configuration of either the source or destination
    /// account.
    ///
    /// Once the transfer is completed through AcceptCertificateTransfer,
    /// RejectCertificateTransfer, or
    /// CancelCertificateTransfer, the certificate will be protected by the customer
    /// managed key configuration of the account that owns
    /// the certificate after the transfer operation:
    ///
    /// * If the transfer is accepted: The certificate is encrypted by the target
    ///   account's customer managed key configuration.
    ///
    /// * If the transfer is rejected or cancelled: The certificate is protected by
    ///   the source account's customer managed key configuration.
    pub fn transferCertificate(self: *Self, allocator: std.mem.Allocator, input: transfer_certificate.TransferCertificateInput, options: transfer_certificate.Options) !transfer_certificate.TransferCertificateOutput {
        return transfer_certificate.execute(self, allocator, input, options);
    }

    /// Removes the given tags (metadata) from the resource.
    ///
    /// Requires permission to access the
    /// [UntagResource](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Configures or reconfigures the Device Defender audit settings for this
    /// account.
    /// Settings include how audit notifications are sent and which audit checks are
    /// enabled or disabled.
    ///
    /// Requires permission to access the
    /// [UpdateAccountAuditConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateAccountAuditConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_account_audit_configuration.UpdateAccountAuditConfigurationInput, options: update_account_audit_configuration.Options) !update_account_audit_configuration.UpdateAccountAuditConfigurationOutput {
        return update_account_audit_configuration.execute(self, allocator, input, options);
    }

    /// Updates a Device Defender audit suppression.
    pub fn updateAuditSuppression(self: *Self, allocator: std.mem.Allocator, input: update_audit_suppression.UpdateAuditSuppressionInput, options: update_audit_suppression.Options) !update_audit_suppression.UpdateAuditSuppressionOutput {
        return update_audit_suppression.execute(self, allocator, input, options);
    }

    /// Updates an authorizer.
    ///
    /// Requires permission to access the
    /// [UpdateAuthorizer](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateAuthorizer(self: *Self, allocator: std.mem.Allocator, input: update_authorizer.UpdateAuthorizerInput, options: update_authorizer.Options) !update_authorizer.UpdateAuthorizerOutput {
        return update_authorizer.execute(self, allocator, input, options);
    }

    /// Updates information about the billing group.
    ///
    /// Requires permission to access the
    /// [UpdateBillingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateBillingGroup(self: *Self, allocator: std.mem.Allocator, input: update_billing_group.UpdateBillingGroupInput, options: update_billing_group.Options) !update_billing_group.UpdateBillingGroupOutput {
        return update_billing_group.execute(self, allocator, input, options);
    }

    /// Updates a registered CA certificate.
    ///
    /// Requires permission to access the
    /// [UpdateCACertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateCaCertificate(self: *Self, allocator: std.mem.Allocator, input: update_ca_certificate.UpdateCACertificateInput, options: update_ca_certificate.Options) !update_ca_certificate.UpdateCACertificateOutput {
        return update_ca_certificate.execute(self, allocator, input, options);
    }

    /// Updates the status of the specified certificate. This operation is
    /// idempotent.
    ///
    /// Requires permission to access the
    /// [UpdateCertificate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// Certificates must be in the ACTIVE state to authenticate devices that use
    /// a certificate to connect to IoT.
    ///
    /// Within a few minutes of updating a certificate from the ACTIVE state to any
    /// other
    /// state, IoT disconnects all devices that used that certificate to connect.
    /// Devices cannot
    /// use a certificate that is not in the ACTIVE state to reconnect.
    pub fn updateCertificate(self: *Self, allocator: std.mem.Allocator, input: update_certificate.UpdateCertificateInput, options: update_certificate.Options) !update_certificate.UpdateCertificateOutput {
        return update_certificate.execute(self, allocator, input, options);
    }

    /// Updates a certificate provider.
    ///
    /// Requires permission to access the
    /// [UpdateCertificateProvider](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateCertificateProvider(self: *Self, allocator: std.mem.Allocator, input: update_certificate_provider.UpdateCertificateProviderInput, options: update_certificate_provider.Options) !update_certificate_provider.UpdateCertificateProviderOutput {
        return update_certificate_provider.execute(self, allocator, input, options);
    }

    /// Update information about a command or mark a command for deprecation.
    pub fn updateCommand(self: *Self, allocator: std.mem.Allocator, input: update_command.UpdateCommandInput, options: update_command.Options) !update_command.UpdateCommandOutput {
        return update_command.execute(self, allocator, input, options);
    }

    /// Updates a
    /// Device Defender detect custom metric.
    ///
    /// Requires permission to access the
    /// [UpdateCustomMetric](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateCustomMetric(self: *Self, allocator: std.mem.Allocator, input: update_custom_metric.UpdateCustomMetricInput, options: update_custom_metric.Options) !update_custom_metric.UpdateCustomMetricOutput {
        return update_custom_metric.execute(self, allocator, input, options);
    }

    /// Updates the definition for a dimension. You
    /// cannot
    /// change the type of a dimension after
    /// it is created (you can delete it and
    /// recreate
    /// it).
    ///
    /// Requires permission to access the
    /// [UpdateDimension](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateDimension(self: *Self, allocator: std.mem.Allocator, input: update_dimension.UpdateDimensionInput, options: update_dimension.Options) !update_dimension.UpdateDimensionOutput {
        return update_dimension.execute(self, allocator, input, options);
    }

    /// Updates values stored in the domain configuration. Domain configurations for
    /// default
    /// endpoints can't be updated.
    ///
    /// Requires permission to access the
    /// [UpdateDomainConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateDomainConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_domain_configuration.UpdateDomainConfigurationInput, options: update_domain_configuration.Options) !update_domain_configuration.UpdateDomainConfigurationOutput {
        return update_domain_configuration.execute(self, allocator, input, options);
    }

    /// Updates a dynamic thing group.
    ///
    /// Requires permission to access the
    /// [UpdateDynamicThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateDynamicThingGroup(self: *Self, allocator: std.mem.Allocator, input: update_dynamic_thing_group.UpdateDynamicThingGroupInput, options: update_dynamic_thing_group.Options) !update_dynamic_thing_group.UpdateDynamicThingGroupOutput {
        return update_dynamic_thing_group.execute(self, allocator, input, options);
    }

    /// Updates the encryption configuration. By default, Amazon Web Services IoT
    /// Core encrypts your data at rest using Amazon Web Services owned keys. Amazon
    /// Web Services IoT Core also supports symmetric customer managed keys
    /// from Key Management Service (KMS). With customer managed keys, you create,
    /// own, and
    /// manage the KMS keys in your Amazon Web Services account.
    ///
    /// Before using this API, you must set up permissions for Amazon Web Services
    /// IoT Core to access KMS. For more information, see [Data encryption at
    /// rest](https://docs.aws.amazon.com/iot/latest/developerguide/encryption-at-rest.html) in the *Amazon Web Services IoT Core Developer Guide*.
    pub fn updateEncryptionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_encryption_configuration.UpdateEncryptionConfigurationInput, options: update_encryption_configuration.Options) !update_encryption_configuration.UpdateEncryptionConfigurationOutput {
        return update_encryption_configuration.execute(self, allocator, input, options);
    }

    /// Updates the event configurations.
    ///
    /// Requires permission to access the
    /// [UpdateEventConfigurations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateEventConfigurations(self: *Self, allocator: std.mem.Allocator, input: update_event_configurations.UpdateEventConfigurationsInput, options: update_event_configurations.Options) !update_event_configurations.UpdateEventConfigurationsOutput {
        return update_event_configurations.execute(self, allocator, input, options);
    }

    /// Updates the data for a fleet metric.
    ///
    /// Requires permission to access the
    /// [UpdateFleetMetric](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateFleetMetric(self: *Self, allocator: std.mem.Allocator, input: update_fleet_metric.UpdateFleetMetricInput, options: update_fleet_metric.Options) !update_fleet_metric.UpdateFleetMetricOutput {
        return update_fleet_metric.execute(self, allocator, input, options);
    }

    /// Updates the search configuration.
    ///
    /// Requires permission to access the
    /// [UpdateIndexingConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateIndexingConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_indexing_configuration.UpdateIndexingConfigurationInput, options: update_indexing_configuration.Options) !update_indexing_configuration.UpdateIndexingConfigurationOutput {
        return update_indexing_configuration.execute(self, allocator, input, options);
    }

    /// Updates supported fields of the specified job.
    ///
    /// Requires permission to access the
    /// [UpdateJob](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateJob(self: *Self, allocator: std.mem.Allocator, input: update_job.UpdateJobInput, options: update_job.Options) !update_job.UpdateJobOutput {
        return update_job.execute(self, allocator, input, options);
    }

    /// Updates the definition for the specified mitigation action.
    ///
    /// Requires permission to access the
    /// [UpdateMitigationAction](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateMitigationAction(self: *Self, allocator: std.mem.Allocator, input: update_mitigation_action.UpdateMitigationActionInput, options: update_mitigation_action.Options) !update_mitigation_action.UpdateMitigationActionOutput {
        return update_mitigation_action.execute(self, allocator, input, options);
    }

    /// Updates the supported fields for a specific software package.
    ///
    /// Requires permission to access the
    /// [UpdatePackage](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) and [GetIndexingConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) actions.
    pub fn updatePackage(self: *Self, allocator: std.mem.Allocator, input: update_package.UpdatePackageInput, options: update_package.Options) !update_package.UpdatePackageOutput {
        return update_package.execute(self, allocator, input, options);
    }

    /// Updates the software package configuration.
    ///
    /// Requires permission to access the
    /// [UpdatePackageConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) and [iam:PassRole](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html) actions.
    pub fn updatePackageConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_package_configuration.UpdatePackageConfigurationInput, options: update_package_configuration.Options) !update_package_configuration.UpdatePackageConfigurationOutput {
        return update_package_configuration.execute(self, allocator, input, options);
    }

    /// Updates the supported fields for a specific package version.
    ///
    /// Requires permission to access the
    /// [UpdatePackageVersion](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) and [GetIndexingConfiguration](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) actions.
    pub fn updatePackageVersion(self: *Self, allocator: std.mem.Allocator, input: update_package_version.UpdatePackageVersionInput, options: update_package_version.Options) !update_package_version.UpdatePackageVersionOutput {
        return update_package_version.execute(self, allocator, input, options);
    }

    /// Updates a provisioning template.
    ///
    /// Requires permission to access the
    /// [UpdateProvisioningTemplate](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateProvisioningTemplate(self: *Self, allocator: std.mem.Allocator, input: update_provisioning_template.UpdateProvisioningTemplateInput, options: update_provisioning_template.Options) !update_provisioning_template.UpdateProvisioningTemplateOutput {
        return update_provisioning_template.execute(self, allocator, input, options);
    }

    /// Updates a role alias.
    ///
    /// Requires permission to access the
    /// [UpdateRoleAlias](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// The value of [
    /// `credentialDurationSeconds`
    /// ](https://docs.aws.amazon.com/iot/latest/apireference/API_UpdateRoleAlias.html#iot-UpdateRoleAlias-request-credentialDurationSeconds) must be less than or equal to the
    /// maximum session duration of the IAM role that the role alias references. For
    /// more
    /// information, see [ Modifying a role maximum session duration (Amazon Web
    /// Services
    /// API)](https://docs.aws.amazon.com/IAM/latest/UserGuide/roles-managingrole-editing-api.html#roles-modify_max-session-duration-api) from the Amazon Web Services
    /// Identity and Access Management User Guide.
    pub fn updateRoleAlias(self: *Self, allocator: std.mem.Allocator, input: update_role_alias.UpdateRoleAliasInput, options: update_role_alias.Options) !update_role_alias.UpdateRoleAliasOutput {
        return update_role_alias.execute(self, allocator, input, options);
    }

    /// Updates a scheduled audit, including which checks are performed and
    /// how often the audit takes place.
    ///
    /// Requires permission to access the
    /// [UpdateScheduledAudit](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateScheduledAudit(self: *Self, allocator: std.mem.Allocator, input: update_scheduled_audit.UpdateScheduledAuditInput, options: update_scheduled_audit.Options) !update_scheduled_audit.UpdateScheduledAuditOutput {
        return update_scheduled_audit.execute(self, allocator, input, options);
    }

    /// Updates a Device Defender security profile.
    ///
    /// Requires permission to access the
    /// [UpdateSecurityProfile](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: update_security_profile.UpdateSecurityProfileInput, options: update_security_profile.Options) !update_security_profile.UpdateSecurityProfileOutput {
        return update_security_profile.execute(self, allocator, input, options);
    }

    /// Updates an existing stream. The stream version will be incremented by one.
    ///
    /// Requires permission to access the
    /// [UpdateStream](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateStream(self: *Self, allocator: std.mem.Allocator, input: update_stream.UpdateStreamInput, options: update_stream.Options) !update_stream.UpdateStreamOutput {
        return update_stream.execute(self, allocator, input, options);
    }

    /// Updates the data for a thing.
    ///
    /// Requires permission to access the
    /// [UpdateThing](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateThing(self: *Self, allocator: std.mem.Allocator, input: update_thing.UpdateThingInput, options: update_thing.Options) !update_thing.UpdateThingOutput {
        return update_thing.execute(self, allocator, input, options);
    }

    /// Update a thing group.
    ///
    /// Requires permission to access the
    /// [UpdateThingGroup](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateThingGroup(self: *Self, allocator: std.mem.Allocator, input: update_thing_group.UpdateThingGroupInput, options: update_thing_group.Options) !update_thing_group.UpdateThingGroupOutput {
        return update_thing_group.execute(self, allocator, input, options);
    }

    /// Updates the groups to which the thing belongs.
    ///
    /// Requires permission to access the
    /// [UpdateThingGroupsForThing](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateThingGroupsForThing(self: *Self, allocator: std.mem.Allocator, input: update_thing_groups_for_thing.UpdateThingGroupsForThingInput, options: update_thing_groups_for_thing.Options) !update_thing_groups_for_thing.UpdateThingGroupsForThingOutput {
        return update_thing_groups_for_thing.execute(self, allocator, input, options);
    }

    /// Updates a thing type.
    pub fn updateThingType(self: *Self, allocator: std.mem.Allocator, input: update_thing_type.UpdateThingTypeInput, options: update_thing_type.Options) !update_thing_type.UpdateThingTypeOutput {
        return update_thing_type.execute(self, allocator, input, options);
    }

    /// Updates a topic rule destination. You use this to change the status,
    /// endpoint URL, or
    /// confirmation URL of the destination.
    ///
    /// Requires permission to access the
    /// [UpdateTopicRuleDestination](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn updateTopicRuleDestination(self: *Self, allocator: std.mem.Allocator, input: update_topic_rule_destination.UpdateTopicRuleDestinationInput, options: update_topic_rule_destination.Options) !update_topic_rule_destination.UpdateTopicRuleDestinationOutput {
        return update_topic_rule_destination.execute(self, allocator, input, options);
    }

    /// Validates a Device Defender security profile behaviors specification.
    ///
    /// Requires permission to access the
    /// [ValidateSecurityProfileBehaviors](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn validateSecurityProfileBehaviors(self: *Self, allocator: std.mem.Allocator, input: validate_security_profile_behaviors.ValidateSecurityProfileBehaviorsInput, options: validate_security_profile_behaviors.Options) !validate_security_profile_behaviors.ValidateSecurityProfileBehaviorsOutput {
        return validate_security_profile_behaviors.execute(self, allocator, input, options);
    }

    pub fn getBehaviorModelTrainingSummariesPaginator(self: *Self, params: get_behavior_model_training_summaries.GetBehaviorModelTrainingSummariesInput) paginator.GetBehaviorModelTrainingSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listActiveViolationsPaginator(self: *Self, params: list_active_violations.ListActiveViolationsInput) paginator.ListActiveViolationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttachedPoliciesPaginator(self: *Self, params: list_attached_policies.ListAttachedPoliciesInput) paginator.ListAttachedPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAuditFindingsPaginator(self: *Self, params: list_audit_findings.ListAuditFindingsInput) paginator.ListAuditFindingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAuditMitigationActionsExecutionsPaginator(self: *Self, params: list_audit_mitigation_actions_executions.ListAuditMitigationActionsExecutionsInput) paginator.ListAuditMitigationActionsExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAuditMitigationActionsTasksPaginator(self: *Self, params: list_audit_mitigation_actions_tasks.ListAuditMitigationActionsTasksInput) paginator.ListAuditMitigationActionsTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAuditSuppressionsPaginator(self: *Self, params: list_audit_suppressions.ListAuditSuppressionsInput) paginator.ListAuditSuppressionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAuditTasksPaginator(self: *Self, params: list_audit_tasks.ListAuditTasksInput) paginator.ListAuditTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAuthorizersPaginator(self: *Self, params: list_authorizers.ListAuthorizersInput) paginator.ListAuthorizersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBillingGroupsPaginator(self: *Self, params: list_billing_groups.ListBillingGroupsInput) paginator.ListBillingGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCaCertificatesPaginator(self: *Self, params: list_ca_certificates.ListCACertificatesInput) paginator.ListCACertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCertificatesPaginator(self: *Self, params: list_certificates.ListCertificatesInput) paginator.ListCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCertificatesByCaPaginator(self: *Self, params: list_certificates_by_ca.ListCertificatesByCAInput) paginator.ListCertificatesByCAPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCommandExecutionsPaginator(self: *Self, params: list_command_executions.ListCommandExecutionsInput) paginator.ListCommandExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCommandsPaginator(self: *Self, params: list_commands.ListCommandsInput) paginator.ListCommandsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCustomMetricsPaginator(self: *Self, params: list_custom_metrics.ListCustomMetricsInput) paginator.ListCustomMetricsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDetectMitigationActionsExecutionsPaginator(self: *Self, params: list_detect_mitigation_actions_executions.ListDetectMitigationActionsExecutionsInput) paginator.ListDetectMitigationActionsExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDetectMitigationActionsTasksPaginator(self: *Self, params: list_detect_mitigation_actions_tasks.ListDetectMitigationActionsTasksInput) paginator.ListDetectMitigationActionsTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDimensionsPaginator(self: *Self, params: list_dimensions.ListDimensionsInput) paginator.ListDimensionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainConfigurationsPaginator(self: *Self, params: list_domain_configurations.ListDomainConfigurationsInput) paginator.ListDomainConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFleetMetricsPaginator(self: *Self, params: list_fleet_metrics.ListFleetMetricsInput) paginator.ListFleetMetricsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIndicesPaginator(self: *Self, params: list_indices.ListIndicesInput) paginator.ListIndicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobExecutionsForJobPaginator(self: *Self, params: list_job_executions_for_job.ListJobExecutionsForJobInput) paginator.ListJobExecutionsForJobPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobExecutionsForThingPaginator(self: *Self, params: list_job_executions_for_thing.ListJobExecutionsForThingInput) paginator.ListJobExecutionsForThingPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobTemplatesPaginator(self: *Self, params: list_job_templates.ListJobTemplatesInput) paginator.ListJobTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobsPaginator(self: *Self, params: list_jobs.ListJobsInput) paginator.ListJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedJobTemplatesPaginator(self: *Self, params: list_managed_job_templates.ListManagedJobTemplatesInput) paginator.ListManagedJobTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMetricValuesPaginator(self: *Self, params: list_metric_values.ListMetricValuesInput) paginator.ListMetricValuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMitigationActionsPaginator(self: *Self, params: list_mitigation_actions.ListMitigationActionsInput) paginator.ListMitigationActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOtaUpdatesPaginator(self: *Self, params: list_ota_updates.ListOTAUpdatesInput) paginator.ListOTAUpdatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOutgoingCertificatesPaginator(self: *Self, params: list_outgoing_certificates.ListOutgoingCertificatesInput) paginator.ListOutgoingCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackageVersionsPaginator(self: *Self, params: list_package_versions.ListPackageVersionsInput) paginator.ListPackageVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackagesPaginator(self: *Self, params: list_packages.ListPackagesInput) paginator.ListPackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPoliciesPaginator(self: *Self, params: list_policies.ListPoliciesInput) paginator.ListPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyPrincipalsPaginator(self: *Self, params: list_policy_principals.ListPolicyPrincipalsInput) paginator.ListPolicyPrincipalsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPrincipalPoliciesPaginator(self: *Self, params: list_principal_policies.ListPrincipalPoliciesInput) paginator.ListPrincipalPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPrincipalThingsPaginator(self: *Self, params: list_principal_things.ListPrincipalThingsInput) paginator.ListPrincipalThingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPrincipalThingsV2Paginator(self: *Self, params: list_principal_things_v2.ListPrincipalThingsV2Input) paginator.ListPrincipalThingsV2Paginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProvisioningTemplateVersionsPaginator(self: *Self, params: list_provisioning_template_versions.ListProvisioningTemplateVersionsInput) paginator.ListProvisioningTemplateVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProvisioningTemplatesPaginator(self: *Self, params: list_provisioning_templates.ListProvisioningTemplatesInput) paginator.ListProvisioningTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRelatedResourcesForAuditFindingPaginator(self: *Self, params: list_related_resources_for_audit_finding.ListRelatedResourcesForAuditFindingInput) paginator.ListRelatedResourcesForAuditFindingPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoleAliasesPaginator(self: *Self, params: list_role_aliases.ListRoleAliasesInput) paginator.ListRoleAliasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSbomValidationResultsPaginator(self: *Self, params: list_sbom_validation_results.ListSbomValidationResultsInput) paginator.ListSbomValidationResultsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listScheduledAuditsPaginator(self: *Self, params: list_scheduled_audits.ListScheduledAuditsInput) paginator.ListScheduledAuditsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityProfilesPaginator(self: *Self, params: list_security_profiles.ListSecurityProfilesInput) paginator.ListSecurityProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityProfilesForTargetPaginator(self: *Self, params: list_security_profiles_for_target.ListSecurityProfilesForTargetInput) paginator.ListSecurityProfilesForTargetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamsPaginator(self: *Self, params: list_streams.ListStreamsInput) paginator.ListStreamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTargetsForPolicyPaginator(self: *Self, params: list_targets_for_policy.ListTargetsForPolicyInput) paginator.ListTargetsForPolicyPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTargetsForSecurityProfilePaginator(self: *Self, params: list_targets_for_security_profile.ListTargetsForSecurityProfileInput) paginator.ListTargetsForSecurityProfilePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingGroupsPaginator(self: *Self, params: list_thing_groups.ListThingGroupsInput) paginator.ListThingGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingGroupsForThingPaginator(self: *Self, params: list_thing_groups_for_thing.ListThingGroupsForThingInput) paginator.ListThingGroupsForThingPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingPrincipalsPaginator(self: *Self, params: list_thing_principals.ListThingPrincipalsInput) paginator.ListThingPrincipalsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingPrincipalsV2Paginator(self: *Self, params: list_thing_principals_v2.ListThingPrincipalsV2Input) paginator.ListThingPrincipalsV2Paginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingRegistrationTaskReportsPaginator(self: *Self, params: list_thing_registration_task_reports.ListThingRegistrationTaskReportsInput) paginator.ListThingRegistrationTaskReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingRegistrationTasksPaginator(self: *Self, params: list_thing_registration_tasks.ListThingRegistrationTasksInput) paginator.ListThingRegistrationTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingTypesPaginator(self: *Self, params: list_thing_types.ListThingTypesInput) paginator.ListThingTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingsPaginator(self: *Self, params: list_things.ListThingsInput) paginator.ListThingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingsInBillingGroupPaginator(self: *Self, params: list_things_in_billing_group.ListThingsInBillingGroupInput) paginator.ListThingsInBillingGroupPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThingsInThingGroupPaginator(self: *Self, params: list_things_in_thing_group.ListThingsInThingGroupInput) paginator.ListThingsInThingGroupPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTopicRuleDestinationsPaginator(self: *Self, params: list_topic_rule_destinations.ListTopicRuleDestinationsInput) paginator.ListTopicRuleDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTopicRulesPaginator(self: *Self, params: list_topic_rules.ListTopicRulesInput) paginator.ListTopicRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listV2LoggingLevelsPaginator(self: *Self, params: list_v2_logging_levels.ListV2LoggingLevelsInput) paginator.ListV2LoggingLevelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listViolationEventsPaginator(self: *Self, params: list_violation_events.ListViolationEventsInput) paginator.ListViolationEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
