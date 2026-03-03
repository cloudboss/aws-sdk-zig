const aws = @import("aws");
const std = @import("std");

const activate_evaluation_form = @import("activate_evaluation_form.zig");
const associate_analytics_data_set = @import("associate_analytics_data_set.zig");
const associate_approved_origin = @import("associate_approved_origin.zig");
const associate_bot = @import("associate_bot.zig");
const associate_contact_with_user = @import("associate_contact_with_user.zig");
const associate_default_vocabulary = @import("associate_default_vocabulary.zig");
const associate_email_address_alias = @import("associate_email_address_alias.zig");
const associate_flow = @import("associate_flow.zig");
const associate_hours_of_operations = @import("associate_hours_of_operations.zig");
const associate_instance_storage_config = @import("associate_instance_storage_config.zig");
const associate_lambda_function = @import("associate_lambda_function.zig");
const associate_lex_bot = @import("associate_lex_bot.zig");
const associate_phone_number_contact_flow = @import("associate_phone_number_contact_flow.zig");
const associate_queue_quick_connects = @import("associate_queue_quick_connects.zig");
const associate_routing_profile_queues = @import("associate_routing_profile_queues.zig");
const associate_security_key = @import("associate_security_key.zig");
const associate_security_profiles = @import("associate_security_profiles.zig");
const associate_traffic_distribution_group_user = @import("associate_traffic_distribution_group_user.zig");
const associate_user_proficiencies = @import("associate_user_proficiencies.zig");
const associate_workspace = @import("associate_workspace.zig");
const batch_associate_analytics_data_set = @import("batch_associate_analytics_data_set.zig");
const batch_create_data_table_value = @import("batch_create_data_table_value.zig");
const batch_delete_data_table_value = @import("batch_delete_data_table_value.zig");
const batch_describe_data_table_value = @import("batch_describe_data_table_value.zig");
const batch_disassociate_analytics_data_set = @import("batch_disassociate_analytics_data_set.zig");
const batch_get_attached_file_metadata = @import("batch_get_attached_file_metadata.zig");
const batch_get_flow_association = @import("batch_get_flow_association.zig");
const batch_put_contact = @import("batch_put_contact.zig");
const batch_update_data_table_value = @import("batch_update_data_table_value.zig");
const claim_phone_number = @import("claim_phone_number.zig");
const complete_attached_file_upload = @import("complete_attached_file_upload.zig");
const create_agent_status = @import("create_agent_status.zig");
const create_contact = @import("create_contact.zig");
const create_contact_flow = @import("create_contact_flow.zig");
const create_contact_flow_module = @import("create_contact_flow_module.zig");
const create_contact_flow_module_alias = @import("create_contact_flow_module_alias.zig");
const create_contact_flow_module_version = @import("create_contact_flow_module_version.zig");
const create_contact_flow_version = @import("create_contact_flow_version.zig");
const create_data_table = @import("create_data_table.zig");
const create_data_table_attribute = @import("create_data_table_attribute.zig");
const create_email_address = @import("create_email_address.zig");
const create_evaluation_form = @import("create_evaluation_form.zig");
const create_hours_of_operation = @import("create_hours_of_operation.zig");
const create_hours_of_operation_override = @import("create_hours_of_operation_override.zig");
const create_instance = @import("create_instance.zig");
const create_integration_association = @import("create_integration_association.zig");
const create_participant = @import("create_participant.zig");
const create_persistent_contact_association = @import("create_persistent_contact_association.zig");
const create_predefined_attribute = @import("create_predefined_attribute.zig");
const create_prompt = @import("create_prompt.zig");
const create_push_notification_registration = @import("create_push_notification_registration.zig");
const create_queue = @import("create_queue.zig");
const create_quick_connect = @import("create_quick_connect.zig");
const create_routing_profile = @import("create_routing_profile.zig");
const create_rule = @import("create_rule.zig");
const create_security_profile = @import("create_security_profile.zig");
const create_task_template = @import("create_task_template.zig");
const create_test_case = @import("create_test_case.zig");
const create_traffic_distribution_group = @import("create_traffic_distribution_group.zig");
const create_use_case = @import("create_use_case.zig");
const create_user = @import("create_user.zig");
const create_user_hierarchy_group = @import("create_user_hierarchy_group.zig");
const create_view = @import("create_view.zig");
const create_view_version = @import("create_view_version.zig");
const create_vocabulary = @import("create_vocabulary.zig");
const create_workspace = @import("create_workspace.zig");
const create_workspace_page = @import("create_workspace_page.zig");
const deactivate_evaluation_form = @import("deactivate_evaluation_form.zig");
const delete_attached_file = @import("delete_attached_file.zig");
const delete_contact_evaluation = @import("delete_contact_evaluation.zig");
const delete_contact_flow = @import("delete_contact_flow.zig");
const delete_contact_flow_module = @import("delete_contact_flow_module.zig");
const delete_contact_flow_module_alias = @import("delete_contact_flow_module_alias.zig");
const delete_contact_flow_module_version = @import("delete_contact_flow_module_version.zig");
const delete_contact_flow_version = @import("delete_contact_flow_version.zig");
const delete_data_table = @import("delete_data_table.zig");
const delete_data_table_attribute = @import("delete_data_table_attribute.zig");
const delete_email_address = @import("delete_email_address.zig");
const delete_evaluation_form = @import("delete_evaluation_form.zig");
const delete_hours_of_operation = @import("delete_hours_of_operation.zig");
const delete_hours_of_operation_override = @import("delete_hours_of_operation_override.zig");
const delete_instance = @import("delete_instance.zig");
const delete_integration_association = @import("delete_integration_association.zig");
const delete_predefined_attribute = @import("delete_predefined_attribute.zig");
const delete_prompt = @import("delete_prompt.zig");
const delete_push_notification_registration = @import("delete_push_notification_registration.zig");
const delete_queue = @import("delete_queue.zig");
const delete_quick_connect = @import("delete_quick_connect.zig");
const delete_routing_profile = @import("delete_routing_profile.zig");
const delete_rule = @import("delete_rule.zig");
const delete_security_profile = @import("delete_security_profile.zig");
const delete_task_template = @import("delete_task_template.zig");
const delete_test_case = @import("delete_test_case.zig");
const delete_traffic_distribution_group = @import("delete_traffic_distribution_group.zig");
const delete_use_case = @import("delete_use_case.zig");
const delete_user = @import("delete_user.zig");
const delete_user_hierarchy_group = @import("delete_user_hierarchy_group.zig");
const delete_view = @import("delete_view.zig");
const delete_view_version = @import("delete_view_version.zig");
const delete_vocabulary = @import("delete_vocabulary.zig");
const delete_workspace = @import("delete_workspace.zig");
const delete_workspace_media = @import("delete_workspace_media.zig");
const delete_workspace_page = @import("delete_workspace_page.zig");
const describe_agent_status = @import("describe_agent_status.zig");
const describe_authentication_profile = @import("describe_authentication_profile.zig");
const describe_contact = @import("describe_contact.zig");
const describe_contact_evaluation = @import("describe_contact_evaluation.zig");
const describe_contact_flow = @import("describe_contact_flow.zig");
const describe_contact_flow_module = @import("describe_contact_flow_module.zig");
const describe_contact_flow_module_alias = @import("describe_contact_flow_module_alias.zig");
const describe_data_table = @import("describe_data_table.zig");
const describe_data_table_attribute = @import("describe_data_table_attribute.zig");
const describe_email_address = @import("describe_email_address.zig");
const describe_evaluation_form = @import("describe_evaluation_form.zig");
const describe_hours_of_operation = @import("describe_hours_of_operation.zig");
const describe_hours_of_operation_override = @import("describe_hours_of_operation_override.zig");
const describe_instance = @import("describe_instance.zig");
const describe_instance_attribute = @import("describe_instance_attribute.zig");
const describe_instance_storage_config = @import("describe_instance_storage_config.zig");
const describe_phone_number = @import("describe_phone_number.zig");
const describe_predefined_attribute = @import("describe_predefined_attribute.zig");
const describe_prompt = @import("describe_prompt.zig");
const describe_queue = @import("describe_queue.zig");
const describe_quick_connect = @import("describe_quick_connect.zig");
const describe_routing_profile = @import("describe_routing_profile.zig");
const describe_rule = @import("describe_rule.zig");
const describe_security_profile = @import("describe_security_profile.zig");
const describe_test_case = @import("describe_test_case.zig");
const describe_traffic_distribution_group = @import("describe_traffic_distribution_group.zig");
const describe_user = @import("describe_user.zig");
const describe_user_hierarchy_group = @import("describe_user_hierarchy_group.zig");
const describe_user_hierarchy_structure = @import("describe_user_hierarchy_structure.zig");
const describe_view = @import("describe_view.zig");
const describe_vocabulary = @import("describe_vocabulary.zig");
const describe_workspace = @import("describe_workspace.zig");
const disassociate_analytics_data_set = @import("disassociate_analytics_data_set.zig");
const disassociate_approved_origin = @import("disassociate_approved_origin.zig");
const disassociate_bot = @import("disassociate_bot.zig");
const disassociate_email_address_alias = @import("disassociate_email_address_alias.zig");
const disassociate_flow = @import("disassociate_flow.zig");
const disassociate_hours_of_operations = @import("disassociate_hours_of_operations.zig");
const disassociate_instance_storage_config = @import("disassociate_instance_storage_config.zig");
const disassociate_lambda_function = @import("disassociate_lambda_function.zig");
const disassociate_lex_bot = @import("disassociate_lex_bot.zig");
const disassociate_phone_number_contact_flow = @import("disassociate_phone_number_contact_flow.zig");
const disassociate_queue_quick_connects = @import("disassociate_queue_quick_connects.zig");
const disassociate_routing_profile_queues = @import("disassociate_routing_profile_queues.zig");
const disassociate_security_key = @import("disassociate_security_key.zig");
const disassociate_security_profiles = @import("disassociate_security_profiles.zig");
const disassociate_traffic_distribution_group_user = @import("disassociate_traffic_distribution_group_user.zig");
const disassociate_user_proficiencies = @import("disassociate_user_proficiencies.zig");
const disassociate_workspace = @import("disassociate_workspace.zig");
const dismiss_user_contact = @import("dismiss_user_contact.zig");
const evaluate_data_table_values = @import("evaluate_data_table_values.zig");
const get_attached_file = @import("get_attached_file.zig");
const get_contact_attributes = @import("get_contact_attributes.zig");
const get_contact_metrics = @import("get_contact_metrics.zig");
const get_current_metric_data = @import("get_current_metric_data.zig");
const get_current_user_data = @import("get_current_user_data.zig");
const get_effective_hours_of_operations = @import("get_effective_hours_of_operations.zig");
const get_federation_token = @import("get_federation_token.zig");
const get_flow_association = @import("get_flow_association.zig");
const get_metric_data = @import("get_metric_data.zig");
const get_metric_data_v2 = @import("get_metric_data_v2.zig");
const get_prompt_file = @import("get_prompt_file.zig");
const get_task_template = @import("get_task_template.zig");
const get_test_case_execution_summary = @import("get_test_case_execution_summary.zig");
const get_traffic_distribution = @import("get_traffic_distribution.zig");
const import_phone_number = @import("import_phone_number.zig");
const import_workspace_media = @import("import_workspace_media.zig");
const list_agent_statuses = @import("list_agent_statuses.zig");
const list_analytics_data_associations = @import("list_analytics_data_associations.zig");
const list_analytics_data_lake_data_sets = @import("list_analytics_data_lake_data_sets.zig");
const list_approved_origins = @import("list_approved_origins.zig");
const list_associated_contacts = @import("list_associated_contacts.zig");
const list_authentication_profiles = @import("list_authentication_profiles.zig");
const list_bots = @import("list_bots.zig");
const list_child_hours_of_operations = @import("list_child_hours_of_operations.zig");
const list_contact_evaluations = @import("list_contact_evaluations.zig");
const list_contact_flow_module_aliases = @import("list_contact_flow_module_aliases.zig");
const list_contact_flow_module_versions = @import("list_contact_flow_module_versions.zig");
const list_contact_flow_modules = @import("list_contact_flow_modules.zig");
const list_contact_flow_versions = @import("list_contact_flow_versions.zig");
const list_contact_flows = @import("list_contact_flows.zig");
const list_contact_references = @import("list_contact_references.zig");
const list_data_table_attributes = @import("list_data_table_attributes.zig");
const list_data_table_primary_values = @import("list_data_table_primary_values.zig");
const list_data_table_values = @import("list_data_table_values.zig");
const list_data_tables = @import("list_data_tables.zig");
const list_default_vocabularies = @import("list_default_vocabularies.zig");
const list_entity_security_profiles = @import("list_entity_security_profiles.zig");
const list_evaluation_form_versions = @import("list_evaluation_form_versions.zig");
const list_evaluation_forms = @import("list_evaluation_forms.zig");
const list_flow_associations = @import("list_flow_associations.zig");
const list_hours_of_operation_overrides = @import("list_hours_of_operation_overrides.zig");
const list_hours_of_operations = @import("list_hours_of_operations.zig");
const list_instance_attributes = @import("list_instance_attributes.zig");
const list_instance_storage_configs = @import("list_instance_storage_configs.zig");
const list_instances = @import("list_instances.zig");
const list_integration_associations = @import("list_integration_associations.zig");
const list_lambda_functions = @import("list_lambda_functions.zig");
const list_lex_bots = @import("list_lex_bots.zig");
const list_phone_numbers = @import("list_phone_numbers.zig");
const list_phone_numbers_v2 = @import("list_phone_numbers_v2.zig");
const list_predefined_attributes = @import("list_predefined_attributes.zig");
const list_prompts = @import("list_prompts.zig");
const list_queue_quick_connects = @import("list_queue_quick_connects.zig");
const list_queues = @import("list_queues.zig");
const list_quick_connects = @import("list_quick_connects.zig");
const list_realtime_contact_analysis_segments_v2 = @import("list_realtime_contact_analysis_segments_v2.zig");
const list_routing_profile_manual_assignment_queues = @import("list_routing_profile_manual_assignment_queues.zig");
const list_routing_profile_queues = @import("list_routing_profile_queues.zig");
const list_routing_profiles = @import("list_routing_profiles.zig");
const list_rules = @import("list_rules.zig");
const list_security_keys = @import("list_security_keys.zig");
const list_security_profile_applications = @import("list_security_profile_applications.zig");
const list_security_profile_flow_modules = @import("list_security_profile_flow_modules.zig");
const list_security_profile_permissions = @import("list_security_profile_permissions.zig");
const list_security_profiles = @import("list_security_profiles.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_task_templates = @import("list_task_templates.zig");
const list_test_case_execution_records = @import("list_test_case_execution_records.zig");
const list_test_case_executions = @import("list_test_case_executions.zig");
const list_test_cases = @import("list_test_cases.zig");
const list_traffic_distribution_group_users = @import("list_traffic_distribution_group_users.zig");
const list_traffic_distribution_groups = @import("list_traffic_distribution_groups.zig");
const list_use_cases = @import("list_use_cases.zig");
const list_user_hierarchy_groups = @import("list_user_hierarchy_groups.zig");
const list_user_proficiencies = @import("list_user_proficiencies.zig");
const list_users = @import("list_users.zig");
const list_view_versions = @import("list_view_versions.zig");
const list_views = @import("list_views.zig");
const list_workspace_media = @import("list_workspace_media.zig");
const list_workspace_pages = @import("list_workspace_pages.zig");
const list_workspaces = @import("list_workspaces.zig");
const monitor_contact = @import("monitor_contact.zig");
const pause_contact = @import("pause_contact.zig");
const put_user_status = @import("put_user_status.zig");
const release_phone_number = @import("release_phone_number.zig");
const replicate_instance = @import("replicate_instance.zig");
const resume_contact = @import("resume_contact.zig");
const resume_contact_recording = @import("resume_contact_recording.zig");
const search_agent_statuses = @import("search_agent_statuses.zig");
const search_available_phone_numbers = @import("search_available_phone_numbers.zig");
const search_contact_evaluations = @import("search_contact_evaluations.zig");
const search_contact_flow_modules = @import("search_contact_flow_modules.zig");
const search_contact_flows = @import("search_contact_flows.zig");
const search_contacts = @import("search_contacts.zig");
const search_data_tables = @import("search_data_tables.zig");
const search_email_addresses = @import("search_email_addresses.zig");
const search_evaluation_forms = @import("search_evaluation_forms.zig");
const search_hours_of_operation_overrides = @import("search_hours_of_operation_overrides.zig");
const search_hours_of_operations = @import("search_hours_of_operations.zig");
const search_predefined_attributes = @import("search_predefined_attributes.zig");
const search_prompts = @import("search_prompts.zig");
const search_queues = @import("search_queues.zig");
const search_quick_connects = @import("search_quick_connects.zig");
const search_resource_tags = @import("search_resource_tags.zig");
const search_routing_profiles = @import("search_routing_profiles.zig");
const search_security_profiles = @import("search_security_profiles.zig");
const search_test_cases = @import("search_test_cases.zig");
const search_user_hierarchy_groups = @import("search_user_hierarchy_groups.zig");
const search_users = @import("search_users.zig");
const search_views = @import("search_views.zig");
const search_vocabularies = @import("search_vocabularies.zig");
const search_workspace_associations = @import("search_workspace_associations.zig");
const search_workspaces = @import("search_workspaces.zig");
const send_chat_integration_event = @import("send_chat_integration_event.zig");
const send_outbound_email = @import("send_outbound_email.zig");
const start_attached_file_upload = @import("start_attached_file_upload.zig");
const start_chat_contact = @import("start_chat_contact.zig");
const start_contact_evaluation = @import("start_contact_evaluation.zig");
const start_contact_media_processing = @import("start_contact_media_processing.zig");
const start_contact_recording = @import("start_contact_recording.zig");
const start_contact_streaming = @import("start_contact_streaming.zig");
const start_email_contact = @import("start_email_contact.zig");
const start_outbound_chat_contact = @import("start_outbound_chat_contact.zig");
const start_outbound_email_contact = @import("start_outbound_email_contact.zig");
const start_outbound_voice_contact = @import("start_outbound_voice_contact.zig");
const start_screen_sharing = @import("start_screen_sharing.zig");
const start_task_contact = @import("start_task_contact.zig");
const start_test_case_execution = @import("start_test_case_execution.zig");
const start_web_rtc_contact = @import("start_web_rtc_contact.zig");
const stop_contact = @import("stop_contact.zig");
const stop_contact_media_processing = @import("stop_contact_media_processing.zig");
const stop_contact_recording = @import("stop_contact_recording.zig");
const stop_contact_streaming = @import("stop_contact_streaming.zig");
const stop_test_case_execution = @import("stop_test_case_execution.zig");
const submit_contact_evaluation = @import("submit_contact_evaluation.zig");
const suspend_contact_recording = @import("suspend_contact_recording.zig");
const tag_contact = @import("tag_contact.zig");
const tag_resource = @import("tag_resource.zig");
const transfer_contact = @import("transfer_contact.zig");
const untag_contact = @import("untag_contact.zig");
const untag_resource = @import("untag_resource.zig");
const update_agent_status = @import("update_agent_status.zig");
const update_authentication_profile = @import("update_authentication_profile.zig");
const update_contact = @import("update_contact.zig");
const update_contact_attributes = @import("update_contact_attributes.zig");
const update_contact_evaluation = @import("update_contact_evaluation.zig");
const update_contact_flow_content = @import("update_contact_flow_content.zig");
const update_contact_flow_metadata = @import("update_contact_flow_metadata.zig");
const update_contact_flow_module_alias = @import("update_contact_flow_module_alias.zig");
const update_contact_flow_module_content = @import("update_contact_flow_module_content.zig");
const update_contact_flow_module_metadata = @import("update_contact_flow_module_metadata.zig");
const update_contact_flow_name = @import("update_contact_flow_name.zig");
const update_contact_routing_data = @import("update_contact_routing_data.zig");
const update_contact_schedule = @import("update_contact_schedule.zig");
const update_data_table_attribute = @import("update_data_table_attribute.zig");
const update_data_table_metadata = @import("update_data_table_metadata.zig");
const update_data_table_primary_values = @import("update_data_table_primary_values.zig");
const update_email_address_metadata = @import("update_email_address_metadata.zig");
const update_evaluation_form = @import("update_evaluation_form.zig");
const update_hours_of_operation = @import("update_hours_of_operation.zig");
const update_hours_of_operation_override = @import("update_hours_of_operation_override.zig");
const update_instance_attribute = @import("update_instance_attribute.zig");
const update_instance_storage_config = @import("update_instance_storage_config.zig");
const update_participant_authentication = @import("update_participant_authentication.zig");
const update_participant_role_config = @import("update_participant_role_config.zig");
const update_phone_number = @import("update_phone_number.zig");
const update_phone_number_metadata = @import("update_phone_number_metadata.zig");
const update_predefined_attribute = @import("update_predefined_attribute.zig");
const update_prompt = @import("update_prompt.zig");
const update_queue_hours_of_operation = @import("update_queue_hours_of_operation.zig");
const update_queue_max_contacts = @import("update_queue_max_contacts.zig");
const update_queue_name = @import("update_queue_name.zig");
const update_queue_outbound_caller_config = @import("update_queue_outbound_caller_config.zig");
const update_queue_outbound_email_config = @import("update_queue_outbound_email_config.zig");
const update_queue_status = @import("update_queue_status.zig");
const update_quick_connect_config = @import("update_quick_connect_config.zig");
const update_quick_connect_name = @import("update_quick_connect_name.zig");
const update_routing_profile_agent_availability_timer = @import("update_routing_profile_agent_availability_timer.zig");
const update_routing_profile_concurrency = @import("update_routing_profile_concurrency.zig");
const update_routing_profile_default_outbound_queue = @import("update_routing_profile_default_outbound_queue.zig");
const update_routing_profile_name = @import("update_routing_profile_name.zig");
const update_routing_profile_queues = @import("update_routing_profile_queues.zig");
const update_rule = @import("update_rule.zig");
const update_security_profile = @import("update_security_profile.zig");
const update_task_template = @import("update_task_template.zig");
const update_test_case = @import("update_test_case.zig");
const update_traffic_distribution = @import("update_traffic_distribution.zig");
const update_user_hierarchy = @import("update_user_hierarchy.zig");
const update_user_hierarchy_group_name = @import("update_user_hierarchy_group_name.zig");
const update_user_hierarchy_structure = @import("update_user_hierarchy_structure.zig");
const update_user_identity_info = @import("update_user_identity_info.zig");
const update_user_phone_config = @import("update_user_phone_config.zig");
const update_user_proficiencies = @import("update_user_proficiencies.zig");
const update_user_routing_profile = @import("update_user_routing_profile.zig");
const update_user_security_profiles = @import("update_user_security_profiles.zig");
const update_view_content = @import("update_view_content.zig");
const update_view_metadata = @import("update_view_metadata.zig");
const update_workspace_metadata = @import("update_workspace_metadata.zig");
const update_workspace_page = @import("update_workspace_page.zig");
const update_workspace_theme = @import("update_workspace_theme.zig");
const update_workspace_visibility = @import("update_workspace_visibility.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Connect";

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

    /// Activates an evaluation form in the specified Amazon Connect instance. After
    /// the evaluation form is
    /// activated, it is available to start new evaluations based on the form.
    pub fn activateEvaluationForm(self: *Self, allocator: std.mem.Allocator, input: activate_evaluation_form.ActivateEvaluationFormInput, options: CallOptions) !activate_evaluation_form.ActivateEvaluationFormOutput {
        return activate_evaluation_form.execute(self, allocator, input, options);
    }

    /// Associates the specified dataset for a Amazon Connect instance with the
    /// target account. You can associate
    /// only one dataset in a single call.
    pub fn associateAnalyticsDataSet(self: *Self, allocator: std.mem.Allocator, input: associate_analytics_data_set.AssociateAnalyticsDataSetInput, options: CallOptions) !associate_analytics_data_set.AssociateAnalyticsDataSetOutput {
        return associate_analytics_data_set.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Associates an approved origin to an Amazon Connect instance.
    pub fn associateApprovedOrigin(self: *Self, allocator: std.mem.Allocator, input: associate_approved_origin.AssociateApprovedOriginInput, options: CallOptions) !associate_approved_origin.AssociateApprovedOriginOutput {
        return associate_approved_origin.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Allows the specified Amazon Connect instance to access the specified Amazon
    /// Lex or Amazon Lex V2
    /// bot.
    pub fn associateBot(self: *Self, allocator: std.mem.Allocator, input: associate_bot.AssociateBotInput, options: CallOptions) !associate_bot.AssociateBotOutput {
        return associate_bot.execute(self, allocator, input, options);
    }

    /// Associates a queued contact with an agent.
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * Programmatically assign queued contacts to available users.
    ///
    /// * Leverage the IAM context key `connect:PreferredUserArn` to restrict
    ///   contact association to specific
    /// preferred user.
    ///
    /// **Important things to know**
    ///
    /// * Use this API with chat, email, and task contacts. It does not support
    ///   voice contacts.
    ///
    /// * Use it to associate contacts with users regardless of their current state,
    ///   including custom states. Ensure
    /// your application logic accounts for user availability before making
    /// associations.
    ///
    /// * It honors the IAM context key `connect:PreferredUserArn` to prevent
    ///   unauthorized contact
    /// associations.
    ///
    /// * It respects the IAM context key `connect:PreferredUserArn` to enforce
    ///   authorization controls and
    /// prevent unauthorized contact associations. Verify that your IAM policies are
    /// properly configured to support your
    /// intended use cases.
    ///
    /// * The service quota *Queues per routing profile per instance* applies to
    ///   manually assigned
    /// queues, too. For more information about this quota, see [Amazon Connect
    /// quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#connect-quotas) in the *Amazon Connect Administrator Guide*.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn associateContactWithUser(self: *Self, allocator: std.mem.Allocator, input: associate_contact_with_user.AssociateContactWithUserInput, options: CallOptions) !associate_contact_with_user.AssociateContactWithUserOutput {
        return associate_contact_with_user.execute(self, allocator, input, options);
    }

    /// Associates an existing vocabulary as the default. Contact Lens for Amazon
    /// Connect uses the vocabulary in post-call and real-time
    /// analysis sessions for the given language.
    pub fn associateDefaultVocabulary(self: *Self, allocator: std.mem.Allocator, input: associate_default_vocabulary.AssociateDefaultVocabularyInput, options: CallOptions) !associate_default_vocabulary.AssociateDefaultVocabularyOutput {
        return associate_default_vocabulary.execute(self, allocator, input, options);
    }

    /// Associates an email address alias with an existing email address in an
    /// Amazon Connect instance. This creates
    /// a forwarding relationship where emails sent to the alias email address are
    /// automatically forwarded to the primary
    /// email address.
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * **Unified customer support**: Create multiple entry points (for example,
    /// support@example.com, help@example.com, customercare@example.com) that all
    /// forward to a single agent queue for
    /// streamlined management.
    ///
    /// * **Department consolidation**: Forward emails from legacy department
    ///   addresses
    /// (for example, sales@example.com, info@example.com) to a centralized customer
    /// service email during organizational
    /// restructuring.
    ///
    /// * **Brand management**: Enable you to use familiar brand-specific email
    ///   addresses
    /// that forward to the appropriate Amazon Connect instance email address.
    ///
    /// **Important things to know**
    ///
    /// * Each email address can have a maximum of one alias. You cannot create
    ///   multiple aliases for the same email
    /// address.
    ///
    /// * If the alias email address already receives direct emails, it continues to
    ///   receive direct emails plus
    /// forwarded emails.
    ///
    /// * You cannot chain email aliases together (that is, create an alias of an
    ///   alias).
    ///
    /// `AssociateEmailAddressAlias` does not return the following information:
    ///
    /// * A confirmation of the alias relationship details (you must call
    ///   [DescribeEmailAddress](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeEmailAddress.html) to verify).
    ///
    /// * The timestamp of when the association occurred.
    ///
    /// * The status of the forwarding configuration.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    ///
    /// **Related operations**
    ///
    /// *
    ///   [DisassociateEmailAddressAlias](https://docs.aws.amazon.com/connect/latest/APIReference/API_DisassociateEmailAddressAlias.html): Removes the alias association between two email addresses in an Amazon Connect instance.
    ///
    /// *
    ///   [DescribeEmailAddress](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeEmailAddress.html): View current alias configurations for an email address.
    ///
    /// *
    ///   [SearchEmailAddresses](https://docs.aws.amazon.com/connect/latest/APIReference/API_SearchEmailAddresses.html): Find email addresses and their alias relationships across an instance.
    ///
    /// *
    ///   [CreateEmailAddress](https://docs.aws.amazon.com/connect/latest/APIReference/API_CreateEmailAddress.html): Create new email addresses that can participate in alias relationships.
    ///
    /// *
    ///   [DeleteEmailAddress](https://docs.aws.amazon.com/connect/latest/APIReference/API_DeleteEmailAddress.html): Remove email addresses (automatically removes any alias relationships).
    ///
    /// *
    ///   [UpdateEmailAddressMetadata](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdateEmailAddressMetadata.html): Modify email address properties (does not affect alias relationships).
    pub fn associateEmailAddressAlias(self: *Self, allocator: std.mem.Allocator, input: associate_email_address_alias.AssociateEmailAddressAliasInput, options: CallOptions) !associate_email_address_alias.AssociateEmailAddressAliasOutput {
        return associate_email_address_alias.execute(self, allocator, input, options);
    }

    /// Associates a connect resource to a flow.
    pub fn associateFlow(self: *Self, allocator: std.mem.Allocator, input: associate_flow.AssociateFlowInput, options: CallOptions) !associate_flow.AssociateFlowOutput {
        return associate_flow.execute(self, allocator, input, options);
    }

    /// Associates a set of hours of operations with another hours of operation.
    /// Refer to Administrator Guide [ here
    /// ](https://docs.aws.amazon.com/connect/latest/adminguide/hours-of-operation-overrides.html) for more information on inheriting overrides from parent hours of operation(s).
    pub fn associateHoursOfOperations(self: *Self, allocator: std.mem.Allocator, input: associate_hours_of_operations.AssociateHoursOfOperationsInput, options: CallOptions) !associate_hours_of_operations.AssociateHoursOfOperationsOutput {
        return associate_hours_of_operations.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Associates a storage resource type for the first time. You can only
    /// associate one type of storage configuration
    /// in a single call. This means, for example, that you can't define an instance
    /// with multiple S3 buckets for storing
    /// chat transcripts.
    ///
    /// This API does not create a resource that doesn't exist. It only associates
    /// it to the instance. Ensure that the
    /// resource being specified in the storage configuration, like an S3 bucket,
    /// exists when being used for
    /// association.
    pub fn associateInstanceStorageConfig(self: *Self, allocator: std.mem.Allocator, input: associate_instance_storage_config.AssociateInstanceStorageConfigInput, options: CallOptions) !associate_instance_storage_config.AssociateInstanceStorageConfigOutput {
        return associate_instance_storage_config.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Allows the specified Amazon Connect instance to access the specified Lambda
    /// function.
    pub fn associateLambdaFunction(self: *Self, allocator: std.mem.Allocator, input: associate_lambda_function.AssociateLambdaFunctionInput, options: CallOptions) !associate_lambda_function.AssociateLambdaFunctionOutput {
        return associate_lambda_function.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Allows the specified Amazon Connect instance to access the specified Amazon
    /// Lex V1 bot. This API
    /// only supports the association of Amazon Lex V1 bots.
    pub fn associateLexBot(self: *Self, allocator: std.mem.Allocator, input: associate_lex_bot.AssociateLexBotInput, options: CallOptions) !associate_lex_bot.AssociateLexBotOutput {
        return associate_lex_bot.execute(self, allocator, input, options);
    }

    /// Associates a flow with a phone number claimed to your Amazon Connect
    /// instance.
    ///
    /// If the number is claimed to a traffic distribution group, and you are
    /// calling this API using an instance in the Amazon Web Services Region where
    /// the traffic distribution group was created, you can use either a full phone
    /// number ARN or UUID value for the
    /// `PhoneNumberId` URI request parameter. However, if the number is claimed to
    /// a traffic distribution group and you are calling
    /// this API using an instance in the alternate Amazon Web Services Region
    /// associated with the traffic distribution group, you must provide a
    /// full phone number ARN. If a UUID is provided
    /// in
    /// this scenario, you will receive a `ResourceNotFoundException`.
    pub fn associatePhoneNumberContactFlow(self: *Self, allocator: std.mem.Allocator, input: associate_phone_number_contact_flow.AssociatePhoneNumberContactFlowInput, options: CallOptions) !associate_phone_number_contact_flow.AssociatePhoneNumberContactFlowOutput {
        return associate_phone_number_contact_flow.execute(self, allocator, input, options);
    }

    /// Associates a set of quick connects with a queue.
    pub fn associateQueueQuickConnects(self: *Self, allocator: std.mem.Allocator, input: associate_queue_quick_connects.AssociateQueueQuickConnectsInput, options: CallOptions) !associate_queue_quick_connects.AssociateQueueQuickConnectsOutput {
        return associate_queue_quick_connects.execute(self, allocator, input, options);
    }

    /// Associates a set of queues with a routing profile.
    pub fn associateRoutingProfileQueues(self: *Self, allocator: std.mem.Allocator, input: associate_routing_profile_queues.AssociateRoutingProfileQueuesInput, options: CallOptions) !associate_routing_profile_queues.AssociateRoutingProfileQueuesOutput {
        return associate_routing_profile_queues.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Associates a security key to the instance.
    pub fn associateSecurityKey(self: *Self, allocator: std.mem.Allocator, input: associate_security_key.AssociateSecurityKeyInput, options: CallOptions) !associate_security_key.AssociateSecurityKeyOutput {
        return associate_security_key.execute(self, allocator, input, options);
    }

    /// Associate security profiles with an Entity in an Amazon Connect instance.
    pub fn associateSecurityProfiles(self: *Self, allocator: std.mem.Allocator, input: associate_security_profiles.AssociateSecurityProfilesInput, options: CallOptions) !associate_security_profiles.AssociateSecurityProfilesOutput {
        return associate_security_profiles.execute(self, allocator, input, options);
    }

    /// Associates an agent with a traffic distribution group. This API can be
    /// called only in the Region where the traffic distribution group
    /// is created.
    pub fn associateTrafficDistributionGroupUser(self: *Self, allocator: std.mem.Allocator, input: associate_traffic_distribution_group_user.AssociateTrafficDistributionGroupUserInput, options: CallOptions) !associate_traffic_distribution_group_user.AssociateTrafficDistributionGroupUserOutput {
        return associate_traffic_distribution_group_user.execute(self, allocator, input, options);
    }

    /// Associates a set of proficiencies with a user.
    pub fn associateUserProficiencies(self: *Self, allocator: std.mem.Allocator, input: associate_user_proficiencies.AssociateUserProficienciesInput, options: CallOptions) !associate_user_proficiencies.AssociateUserProficienciesOutput {
        return associate_user_proficiencies.execute(self, allocator, input, options);
    }

    /// Associates a workspace with one or more users or routing profiles, allowing
    /// them to access the workspace's
    /// configured views and pages.
    pub fn associateWorkspace(self: *Self, allocator: std.mem.Allocator, input: associate_workspace.AssociateWorkspaceInput, options: CallOptions) !associate_workspace.AssociateWorkspaceOutput {
        return associate_workspace.execute(self, allocator, input, options);
    }

    /// Associates a list of analytics datasets for a given Amazon Connect instance
    /// to a target account. You can
    /// associate multiple datasets in a single call.
    pub fn batchAssociateAnalyticsDataSet(self: *Self, allocator: std.mem.Allocator, input: batch_associate_analytics_data_set.BatchAssociateAnalyticsDataSetInput, options: CallOptions) !batch_associate_analytics_data_set.BatchAssociateAnalyticsDataSetOutput {
        return batch_associate_analytics_data_set.execute(self, allocator, input, options);
    }

    /// Creates values for attributes in a data table. The value may be a default or
    /// it may be associated with a primary
    /// value. The value must pass all customer defined validation as well as the
    /// default validation for the value type. The
    /// operation must conform to Batch Operation API Standards. Although the
    /// standard specifies that successful and failed
    /// entities are listed separately in the response, authorization fails if any
    /// primary values or attributes are
    /// unauthorized. The combination of primary values and the attribute name serve
    /// as the identifier for the individual
    /// item request.
    pub fn batchCreateDataTableValue(self: *Self, allocator: std.mem.Allocator, input: batch_create_data_table_value.BatchCreateDataTableValueInput, options: CallOptions) !batch_create_data_table_value.BatchCreateDataTableValueOutput {
        return batch_create_data_table_value.execute(self, allocator, input, options);
    }

    /// Deletes multiple values from a data table. API users may delete values at
    /// any time. When deletion is requested
    /// from the admin website, a warning is shown alerting the user of the most
    /// recent time the attribute and its values
    /// were accessed. System managed values are not deletable by customers.
    pub fn batchDeleteDataTableValue(self: *Self, allocator: std.mem.Allocator, input: batch_delete_data_table_value.BatchDeleteDataTableValueInput, options: CallOptions) !batch_delete_data_table_value.BatchDeleteDataTableValueOutput {
        return batch_delete_data_table_value.execute(self, allocator, input, options);
    }

    /// Retrieves multiple values from a data table without evaluating expressions.
    /// Returns the raw stored values along
    /// with metadata such as lock versions and modification timestamps. "Describe"
    /// is a deprecated term but is allowed to
    /// maintain consistency with existing operations.
    pub fn batchDescribeDataTableValue(self: *Self, allocator: std.mem.Allocator, input: batch_describe_data_table_value.BatchDescribeDataTableValueInput, options: CallOptions) !batch_describe_data_table_value.BatchDescribeDataTableValueOutput {
        return batch_describe_data_table_value.execute(self, allocator, input, options);
    }

    /// Removes a list of analytics datasets associated with a given Amazon Connect
    /// instance. You can disassociate
    /// multiple datasets in a single call.
    pub fn batchDisassociateAnalyticsDataSet(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_analytics_data_set.BatchDisassociateAnalyticsDataSetInput, options: CallOptions) !batch_disassociate_analytics_data_set.BatchDisassociateAnalyticsDataSetOutput {
        return batch_disassociate_analytics_data_set.execute(self, allocator, input, options);
    }

    /// Allows you to retrieve metadata about multiple attached files on an
    /// associated resource. Each attached file
    /// provided in the input list must be associated with the input
    /// AssociatedResourceArn.
    pub fn batchGetAttachedFileMetadata(self: *Self, allocator: std.mem.Allocator, input: batch_get_attached_file_metadata.BatchGetAttachedFileMetadataInput, options: CallOptions) !batch_get_attached_file_metadata.BatchGetAttachedFileMetadataOutput {
        return batch_get_attached_file_metadata.execute(self, allocator, input, options);
    }

    /// Retrieve the flow associations for the given resources.
    pub fn batchGetFlowAssociation(self: *Self, allocator: std.mem.Allocator, input: batch_get_flow_association.BatchGetFlowAssociationInput, options: CallOptions) !batch_get_flow_association.BatchGetFlowAssociationOutput {
        return batch_get_flow_association.execute(self, allocator, input, options);
    }

    /// Only the Amazon Connect outbound campaigns service principal is allowed to
    /// assume a role in your account
    /// and call this API.
    ///
    /// Allows you to create a batch of contacts in Amazon Connect. The outbound
    /// campaigns capability ingests dial
    /// requests via the
    /// [PutDialRequestBatch](https://docs.aws.amazon.com/connect-outbound/latest/APIReference/API_PutDialRequestBatch.html) API. It then uses BatchPutContact to create contacts corresponding to those dial
    /// requests. If agents are available, the dial requests are dialed out, which
    /// results in a voice call. The resulting
    /// voice call uses the same contactId that was created by BatchPutContact.
    pub fn batchPutContact(self: *Self, allocator: std.mem.Allocator, input: batch_put_contact.BatchPutContactInput, options: CallOptions) !batch_put_contact.BatchPutContactOutput {
        return batch_put_contact.execute(self, allocator, input, options);
    }

    /// Updates multiple data table values using all properties from
    /// BatchCreateDataTableValue. System managed values
    /// are not modifiable by customers. The operation requires proper lock versions
    /// to prevent concurrent modification
    /// conflicts.
    pub fn batchUpdateDataTableValue(self: *Self, allocator: std.mem.Allocator, input: batch_update_data_table_value.BatchUpdateDataTableValueInput, options: CallOptions) !batch_update_data_table_value.BatchUpdateDataTableValueOutput {
        return batch_update_data_table_value.execute(self, allocator, input, options);
    }

    /// Claims an available phone number to your Amazon Connect instance or traffic
    /// distribution group. You can call
    /// this API only in the same Amazon Web Services Region where the Amazon
    /// Connect instance or traffic distribution group was
    /// created.
    ///
    /// For more information about how to use this operation, see [Claim a phone
    /// number in your
    /// country](https://docs.aws.amazon.com/connect/latest/adminguide/claim-phone-number.html) and [Claim
    /// phone numbers to traffic distribution
    /// groups](https://docs.aws.amazon.com/connect/latest/adminguide/claim-phone-numbers-traffic-distribution-groups.html) in the *Amazon Connect Administrator
    /// Guide*.
    ///
    /// You can call the
    /// [SearchAvailablePhoneNumbers](https://docs.aws.amazon.com/connect/latest/APIReference/API_SearchAvailablePhoneNumbers.html) API for
    /// available phone numbers that you can claim. Call the
    /// [DescribePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribePhoneNumber.html) API to verify the status
    /// of a previous
    /// [ClaimPhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_ClaimPhoneNumber.html) operation.
    ///
    /// If you plan to claim and release numbers frequently,
    /// contact us for a service quota exception. Otherwise, it is possible you will
    /// be blocked from
    /// claiming and releasing any more numbers until up to 180 days past the oldest
    /// number
    /// released has expired.
    ///
    /// By default you can claim and release up to 200% of your maximum number of
    /// active
    /// phone numbers. If you claim and release phone numbers using
    /// the UI or API during a rolling 180 day cycle that exceeds 200% of your phone
    /// number
    /// service level quota, you will be blocked from claiming any more numbers
    /// until 180
    /// days past the oldest number released has expired.
    ///
    /// For example, if you already have 99 claimed numbers and a service level
    /// quota of 99 phone numbers, and in any 180
    /// day period you release 99, claim 99, and then release 99, you will have
    /// exceeded the
    /// 200% limit. At that point you are blocked from claiming any more numbers
    /// until you
    /// open an Amazon Web Services support ticket.
    pub fn claimPhoneNumber(self: *Self, allocator: std.mem.Allocator, input: claim_phone_number.ClaimPhoneNumberInput, options: CallOptions) !claim_phone_number.ClaimPhoneNumberOutput {
        return claim_phone_number.execute(self, allocator, input, options);
    }

    /// Allows you to confirm that the attached file has been uploaded using the
    /// pre-signed URL provided in the
    /// StartAttachedFileUpload API.
    pub fn completeAttachedFileUpload(self: *Self, allocator: std.mem.Allocator, input: complete_attached_file_upload.CompleteAttachedFileUploadInput, options: CallOptions) !complete_attached_file_upload.CompleteAttachedFileUploadOutput {
        return complete_attached_file_upload.execute(self, allocator, input, options);
    }

    /// Creates an agent status for the specified Amazon Connect instance.
    pub fn createAgentStatus(self: *Self, allocator: std.mem.Allocator, input: create_agent_status.CreateAgentStatusInput, options: CallOptions) !create_agent_status.CreateAgentStatusOutput {
        return create_agent_status.execute(self, allocator, input, options);
    }

    /// Only the VOICE, EMAIL, and TASK channels are supported.
    ///
    /// * For VOICE: The supported initiation method is `TRANSFER`. The contacts
    ///   created with this
    /// initiation method have a subtype `connect:ExternalAudio`.
    ///
    /// * For EMAIL: The supported initiation methods are `OUTBOUND`, `AGENT_REPLY`,
    ///   and
    /// `FLOW`.
    ///
    /// * For TASK: The supported initiation method is `API`. Contacts created with
    ///   this API have a sub-type
    /// of `connect:ExternalTask`.
    ///
    /// Creates a new VOICE, EMAIL, or TASK contact.
    ///
    /// After a contact is created, you can move it to the desired state by using
    /// the `InitiateAs` parameter.
    /// While you can use API to create task contacts that are in the `COMPLETED`
    /// state, you must contact Amazon Web Services Support before using it for bulk
    /// import use cases. Bulk import causes your requests to be throttled or
    /// fail if your CreateContact limits aren't high enough.
    pub fn createContact(self: *Self, allocator: std.mem.Allocator, input: create_contact.CreateContactInput, options: CallOptions) !create_contact.CreateContactOutput {
        return create_contact.execute(self, allocator, input, options);
    }

    /// Creates a flow for the specified Amazon Connect instance.
    ///
    /// You can also create and update flows using the [Amazon Connect
    /// Flow
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/flow-language.html).
    pub fn createContactFlow(self: *Self, allocator: std.mem.Allocator, input: create_contact_flow.CreateContactFlowInput, options: CallOptions) !create_contact_flow.CreateContactFlowOutput {
        return create_contact_flow.execute(self, allocator, input, options);
    }

    /// Creates a flow module for the specified Amazon Connect instance.
    pub fn createContactFlowModule(self: *Self, allocator: std.mem.Allocator, input: create_contact_flow_module.CreateContactFlowModuleInput, options: CallOptions) !create_contact_flow_module.CreateContactFlowModuleOutput {
        return create_contact_flow_module.execute(self, allocator, input, options);
    }

    /// Creates a named alias that points to a specific version of a contact flow
    /// module.
    pub fn createContactFlowModuleAlias(self: *Self, allocator: std.mem.Allocator, input: create_contact_flow_module_alias.CreateContactFlowModuleAliasInput, options: CallOptions) !create_contact_flow_module_alias.CreateContactFlowModuleAliasOutput {
        return create_contact_flow_module_alias.execute(self, allocator, input, options);
    }

    /// Creates an immutable snapshot of a contact flow module, preserving its
    /// content and settings at a specific point
    /// in time for version control and rollback capabilities.
    pub fn createContactFlowModuleVersion(self: *Self, allocator: std.mem.Allocator, input: create_contact_flow_module_version.CreateContactFlowModuleVersionInput, options: CallOptions) !create_contact_flow_module_version.CreateContactFlowModuleVersionOutput {
        return create_contact_flow_module_version.execute(self, allocator, input, options);
    }

    /// Publishes a new version of the flow provided. Versions are immutable and
    /// monotonically increasing. If the
    /// `FlowContentSha256` provided is different from the `FlowContentSha256` of
    /// the
    /// `$LATEST` published flow content, then an error is returned. This API only
    /// supports creating versions for
    /// flows of type `Campaign`.
    pub fn createContactFlowVersion(self: *Self, allocator: std.mem.Allocator, input: create_contact_flow_version.CreateContactFlowVersionInput, options: CallOptions) !create_contact_flow_version.CreateContactFlowVersionOutput {
        return create_contact_flow_version.execute(self, allocator, input, options);
    }

    /// Creates a new data table with the specified properties. Supports the
    /// creation of all table properties except for
    /// attributes and values. A table with no attributes and values is a valid
    /// state for a table. The number of tables per
    /// instance is limited to 100 per instance. Customers can request an increase
    /// by using Amazon Web Services Service Quotas.
    pub fn createDataTable(self: *Self, allocator: std.mem.Allocator, input: create_data_table.CreateDataTableInput, options: CallOptions) !create_data_table.CreateDataTableOutput {
        return create_data_table.execute(self, allocator, input, options);
    }

    /// Adds an attribute to an existing data table. Creating a new primary
    /// attribute uses the empty value for the
    /// specified value type for all existing records. This should not affect
    /// uniqueness of published data tables since the
    /// existing primary values will already be unique. Creating attributes does not
    /// create any values. System managed tables
    /// may not allow customers to create new attributes.
    pub fn createDataTableAttribute(self: *Self, allocator: std.mem.Allocator, input: create_data_table_attribute.CreateDataTableAttributeInput, options: CallOptions) !create_data_table_attribute.CreateDataTableAttributeOutput {
        return create_data_table_attribute.execute(self, allocator, input, options);
    }

    /// Create new email address in the specified Amazon Connect instance. For more
    /// information about email
    /// addresses, see [Create email
    /// addresses](https://docs.aws.amazon.com/connect/latest/adminguide/create-email-address1.html) in the Amazon Connect Administrator Guide.
    pub fn createEmailAddress(self: *Self, allocator: std.mem.Allocator, input: create_email_address.CreateEmailAddressInput, options: CallOptions) !create_email_address.CreateEmailAddressOutput {
        return create_email_address.execute(self, allocator, input, options);
    }

    /// Creates an evaluation form in the specified Amazon Connect instance. The
    /// form can be used to define
    /// questions related to agent performance, and create sections to organize such
    /// questions. Question and section
    /// identifiers cannot be duplicated within the same evaluation form.
    pub fn createEvaluationForm(self: *Self, allocator: std.mem.Allocator, input: create_evaluation_form.CreateEvaluationFormInput, options: CallOptions) !create_evaluation_form.CreateEvaluationFormOutput {
        return create_evaluation_form.execute(self, allocator, input, options);
    }

    /// Creates hours of operation.
    pub fn createHoursOfOperation(self: *Self, allocator: std.mem.Allocator, input: create_hours_of_operation.CreateHoursOfOperationInput, options: CallOptions) !create_hours_of_operation.CreateHoursOfOperationOutput {
        return create_hours_of_operation.execute(self, allocator, input, options);
    }

    /// Creates an hours of operation override in an Amazon Connect hours of
    /// operation resource.
    pub fn createHoursOfOperationOverride(self: *Self, allocator: std.mem.Allocator, input: create_hours_of_operation_override.CreateHoursOfOperationOverrideInput, options: CallOptions) !create_hours_of_operation_override.CreateHoursOfOperationOverrideOutput {
        return create_hours_of_operation_override.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Initiates an Amazon Connect instance with all the supported channels
    /// enabled. It does not attach any
    /// storage, such as Amazon Simple Storage Service (Amazon S3) or Amazon
    /// Kinesis. It also does not allow for any
    /// configurations on features, such as Contact Lens for Amazon Connect.
    ///
    /// For more information, see [Create an Amazon Connect
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-instances.html) in the
    /// *Amazon Connect Administrator Guide*.
    ///
    /// Amazon Connect enforces a limit on the total number of instances that you
    /// can create or delete in 30 days.
    /// If you exceed this limit, you will get an error message indicating there has
    /// been an excessive number of attempts at creating or deleting instances.
    /// You must wait 30 days before you can restart creating and deleting instances
    /// in your account.
    pub fn createInstance(self: *Self, allocator: std.mem.Allocator, input: create_instance.CreateInstanceInput, options: CallOptions) !create_instance.CreateInstanceOutput {
        return create_instance.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services resource association with an Amazon Connect
    /// instance.
    pub fn createIntegrationAssociation(self: *Self, allocator: std.mem.Allocator, input: create_integration_association.CreateIntegrationAssociationInput, options: CallOptions) !create_integration_association.CreateIntegrationAssociationOutput {
        return create_integration_association.execute(self, allocator, input, options);
    }

    /// Adds a new participant into an on-going chat contact or webRTC call. For
    /// more information, see [Customize chat flow experiences by
    /// integrating custom
    /// participants](https://docs.aws.amazon.com/connect/latest/adminguide/chat-customize-flow.html) or [Enable multi-user web, in-app, and video
    /// calling](https://docs.aws.amazon.com/connect/latest/adminguide/enable-multiuser-inapp.html).
    pub fn createParticipant(self: *Self, allocator: std.mem.Allocator, input: create_participant.CreateParticipantInput, options: CallOptions) !create_participant.CreateParticipantOutput {
        return create_participant.execute(self, allocator, input, options);
    }

    /// Enables rehydration of chats for the lifespan of a contact. For more
    /// information about chat rehydration, see
    /// [Enable persistent
    /// chat](https://docs.aws.amazon.com/connect/latest/adminguide/chat-persistence.html) in
    /// the *Amazon Connect Administrator Guide*.
    pub fn createPersistentContactAssociation(self: *Self, allocator: std.mem.Allocator, input: create_persistent_contact_association.CreatePersistentContactAssociationInput, options: CallOptions) !create_persistent_contact_association.CreatePersistentContactAssociationOutput {
        return create_persistent_contact_association.execute(self, allocator, input, options);
    }

    /// Creates a new predefined attribute for the specified Amazon Connect
    /// instance. A *predefined attribute*
    /// is made up of a name and a value.
    ///
    /// For the predefined attributes per instance quota, see [Amazon Connect
    /// quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#connect-quotas).
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * Create an attribute for routing proficiency (for example, agent
    ///   certification) that has predefined values (for
    /// example, a list of possible certifications). For more information, see
    /// [Create predefined attributes for routing contacts to
    /// agents](https://docs.aws.amazon.com/connect/latest/adminguide/predefined-attributes.html).
    ///
    /// * Create an attribute for business unit name that has a list of predefined
    ///   business unit names used in your
    /// organization. This is a use case where information for a contact varies
    /// between transfers or conferences. For more
    /// information, see [Use contact segment
    /// attributes](https://docs.aws.amazon.com/connect/latest/adminguide/use-contact-segment-attributes.html).
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn createPredefinedAttribute(self: *Self, allocator: std.mem.Allocator, input: create_predefined_attribute.CreatePredefinedAttributeInput, options: CallOptions) !create_predefined_attribute.CreatePredefinedAttributeOutput {
        return create_predefined_attribute.execute(self, allocator, input, options);
    }

    /// Creates a prompt. For more information about prompts, such as supported file
    /// types and maximum length, see
    /// [Create
    /// prompts](https://docs.aws.amazon.com/connect/latest/adminguide/prompts.html)
    /// in the
    /// *Amazon Connect Administrator Guide*.
    pub fn createPrompt(self: *Self, allocator: std.mem.Allocator, input: create_prompt.CreatePromptInput, options: CallOptions) !create_prompt.CreatePromptOutput {
        return create_prompt.execute(self, allocator, input, options);
    }

    /// Creates registration for a device token and a chat contact to receive
    /// real-time push notifications. For more
    /// information about push notifications, see [Set up push notifications in
    /// Amazon Connect for mobile
    /// chat](https://docs.aws.amazon.com/connect/latest/adminguide/enable-push-notifications-for-mobile-chat.html) in the *Amazon Connect Administrator Guide*.
    pub fn createPushNotificationRegistration(self: *Self, allocator: std.mem.Allocator, input: create_push_notification_registration.CreatePushNotificationRegistrationInput, options: CallOptions) !create_push_notification_registration.CreatePushNotificationRegistrationOutput {
        return create_push_notification_registration.execute(self, allocator, input, options);
    }

    /// Creates a new queue for the specified Amazon Connect instance.
    ///
    /// * If the phone number is claimed to a traffic distribution group that was
    ///   created in the
    /// same Region as the Amazon Connect instance where you are calling this API,
    /// then you can use a
    /// full phone number ARN or a UUID for `OutboundCallerIdNumberId`. However, if
    /// the phone number is claimed
    /// to a traffic distribution group that is in one Region, and you are calling
    /// this API from an instance in another Amazon Web Services Region that is
    /// associated with the traffic distribution group, you must provide a full
    /// phone number ARN. If a
    /// UUID is provided in this scenario, you will receive a
    /// `ResourceNotFoundException`.
    ///
    /// * Only use the phone number ARN format that doesn't contain `instance` in
    ///   the path, for example,
    /// `arn:aws:connect:us-east-1:1234567890:phone-number/uuid`. This is the same
    /// ARN format that is returned
    /// when you call the
    /// [ListPhoneNumbersV2](https://docs.aws.amazon.com/connect/latest/APIReference/API_ListPhoneNumbersV2.html) API.
    ///
    /// * If you plan to use IAM policies to allow/deny access to this API for phone
    ///   number resources
    /// claimed to a traffic distribution group, see [Allow or Deny queue API
    /// actions for phone numbers in a replica
    /// Region](https://docs.aws.amazon.com/connect/latest/adminguide/security_iam_resource-level-policy-examples.html#allow-deny-queue-actions-replica-region).
    pub fn createQueue(self: *Self, allocator: std.mem.Allocator, input: create_queue.CreateQueueInput, options: CallOptions) !create_queue.CreateQueueOutput {
        return create_queue.execute(self, allocator, input, options);
    }

    /// Creates a quick connect for the specified Amazon Connect instance.
    pub fn createQuickConnect(self: *Self, allocator: std.mem.Allocator, input: create_quick_connect.CreateQuickConnectInput, options: CallOptions) !create_quick_connect.CreateQuickConnectOutput {
        return create_quick_connect.execute(self, allocator, input, options);
    }

    /// Creates a new routing profile.
    pub fn createRoutingProfile(self: *Self, allocator: std.mem.Allocator, input: create_routing_profile.CreateRoutingProfileInput, options: CallOptions) !create_routing_profile.CreateRoutingProfileOutput {
        return create_routing_profile.execute(self, allocator, input, options);
    }

    /// Creates a rule for the specified Amazon Connect instance.
    ///
    /// Use the [Rules Function
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/connect-rules-language.html) to code conditions for the rule.
    pub fn createRule(self: *Self, allocator: std.mem.Allocator, input: create_rule.CreateRuleInput, options: CallOptions) !create_rule.CreateRuleOutput {
        return create_rule.execute(self, allocator, input, options);
    }

    /// Creates a security profile.
    ///
    /// For information about security profiles, see [Security
    /// Profiles](https://docs.aws.amazon.com/connect/latest/adminguide/connect-security-profiles.html) in the *Amazon Connect Administrator Guide*. For a mapping of the API name and user interface name of the security
    /// profile permissions, see [List
    /// of security profile
    /// permissions](https://docs.aws.amazon.com/connect/latest/adminguide/security-profile-list.html).
    pub fn createSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: create_security_profile.CreateSecurityProfileInput, options: CallOptions) !create_security_profile.CreateSecurityProfileOutput {
        return create_security_profile.execute(self, allocator, input, options);
    }

    /// Creates a new task template in the specified Amazon Connect instance.
    pub fn createTaskTemplate(self: *Self, allocator: std.mem.Allocator, input: create_task_template.CreateTaskTemplateInput, options: CallOptions) !create_task_template.CreateTaskTemplateOutput {
        return create_task_template.execute(self, allocator, input, options);
    }

    /// Creates a test case with its content and metadata for the specified Amazon
    /// Connect instance.
    pub fn createTestCase(self: *Self, allocator: std.mem.Allocator, input: create_test_case.CreateTestCaseInput, options: CallOptions) !create_test_case.CreateTestCaseOutput {
        return create_test_case.execute(self, allocator, input, options);
    }

    /// Creates a traffic distribution group given an Amazon Connect instance that
    /// has been replicated.
    ///
    /// The `SignInConfig` distribution is available only on a
    /// default `TrafficDistributionGroup` (see the `IsDefault` parameter in the
    /// [TrafficDistributionGroup](https://docs.aws.amazon.com/connect/latest/APIReference/API_TrafficDistributionGroup.html)
    /// data type). If you call
    /// `UpdateTrafficDistribution` with a modified `SignInConfig` and a non-default
    /// `TrafficDistributionGroup`,
    /// an `InvalidRequestException` is returned.
    ///
    /// For more information about creating traffic distribution groups, see [Set up
    /// traffic distribution
    /// groups](https://docs.aws.amazon.com/connect/latest/adminguide/setup-traffic-distribution-groups.html) in the
    /// *Amazon Connect Administrator Guide*.
    pub fn createTrafficDistributionGroup(self: *Self, allocator: std.mem.Allocator, input: create_traffic_distribution_group.CreateTrafficDistributionGroupInput, options: CallOptions) !create_traffic_distribution_group.CreateTrafficDistributionGroupOutput {
        return create_traffic_distribution_group.execute(self, allocator, input, options);
    }

    /// Creates a use case for an integration association.
    pub fn createUseCase(self: *Self, allocator: std.mem.Allocator, input: create_use_case.CreateUseCaseInput, options: CallOptions) !create_use_case.CreateUseCaseOutput {
        return create_use_case.execute(self, allocator, input, options);
    }

    /// Creates a user account for the specified Amazon Connect instance.
    ///
    /// Certain
    /// [UserIdentityInfo](https://docs.aws.amazon.com/connect/latest/APIReference/API_UserIdentityInfo.html) parameters are required in some situations. For example, `Email`,
    /// `FirstName` and `LastName` are required if you are using Amazon Connect or
    /// SAML for
    /// identity management.
    ///
    /// For information about how to create users using the Amazon Connect admin
    /// website, see [Add
    /// Users](https://docs.aws.amazon.com/connect/latest/adminguide/user-management.html) in the *Amazon Connect
    /// Administrator Guide*.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: CallOptions) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Creates a new user hierarchy group.
    pub fn createUserHierarchyGroup(self: *Self, allocator: std.mem.Allocator, input: create_user_hierarchy_group.CreateUserHierarchyGroupInput, options: CallOptions) !create_user_hierarchy_group.CreateUserHierarchyGroupOutput {
        return create_user_hierarchy_group.execute(self, allocator, input, options);
    }

    /// Creates a new view with the possible status of `SAVED` or `PUBLISHED`.
    ///
    /// The views will have a unique name for each connect instance.
    ///
    /// It performs basic content validation if the status is `SAVED` or full
    /// content validation if the
    /// status is set to `PUBLISHED`. An error is returned if validation fails. It
    /// associates either the
    /// `$SAVED` qualifier or both of the `$SAVED` and `$LATEST` qualifiers with the
    /// provided view content based on the status. The view is idempotent if
    /// ClientToken is provided.
    pub fn createView(self: *Self, allocator: std.mem.Allocator, input: create_view.CreateViewInput, options: CallOptions) !create_view.CreateViewOutput {
        return create_view.execute(self, allocator, input, options);
    }

    /// Publishes a new version of the view identifier.
    ///
    /// Versions are immutable and monotonically increasing.
    ///
    /// It returns the highest version if there is no change in content compared to
    /// that version. An error is displayed
    /// if the supplied ViewContentSha256 is different from the ViewContentSha256 of
    /// the `$LATEST` alias.
    pub fn createViewVersion(self: *Self, allocator: std.mem.Allocator, input: create_view_version.CreateViewVersionInput, options: CallOptions) !create_view_version.CreateViewVersionOutput {
        return create_view_version.execute(self, allocator, input, options);
    }

    /// Creates a custom vocabulary associated with your Amazon Connect instance.
    /// You can set a custom vocabulary to
    /// be your default vocabulary for a given language. Contact Lens for Amazon
    /// Connect uses the default vocabulary in post-call and real-time
    /// contact analysis sessions for that language.
    pub fn createVocabulary(self: *Self, allocator: std.mem.Allocator, input: create_vocabulary.CreateVocabularyInput, options: CallOptions) !create_vocabulary.CreateVocabularyOutput {
        return create_vocabulary.execute(self, allocator, input, options);
    }

    /// Creates a workspace that defines the user experience by mapping views to
    /// pages. Workspaces can be assigned to
    /// users or routing profiles.
    pub fn createWorkspace(self: *Self, allocator: std.mem.Allocator, input: create_workspace.CreateWorkspaceInput, options: CallOptions) !create_workspace.CreateWorkspaceOutput {
        return create_workspace.execute(self, allocator, input, options);
    }

    /// Associates a view with a page in a workspace, defining what users see when
    /// they navigate to that page.
    pub fn createWorkspacePage(self: *Self, allocator: std.mem.Allocator, input: create_workspace_page.CreateWorkspacePageInput, options: CallOptions) !create_workspace_page.CreateWorkspacePageOutput {
        return create_workspace_page.execute(self, allocator, input, options);
    }

    /// Deactivates an evaluation form in the specified Amazon Connect instance.
    /// After a form is deactivated, it is no longer
    /// available for users to start new evaluations based on the form.
    pub fn deactivateEvaluationForm(self: *Self, allocator: std.mem.Allocator, input: deactivate_evaluation_form.DeactivateEvaluationFormInput, options: CallOptions) !deactivate_evaluation_form.DeactivateEvaluationFormOutput {
        return deactivate_evaluation_form.execute(self, allocator, input, options);
    }

    /// Deletes an attached file along with the underlying S3 Object.
    ///
    /// The attached file is **permanently deleted** if S3 bucket versioning is not
    /// enabled.
    pub fn deleteAttachedFile(self: *Self, allocator: std.mem.Allocator, input: delete_attached_file.DeleteAttachedFileInput, options: CallOptions) !delete_attached_file.DeleteAttachedFileOutput {
        return delete_attached_file.execute(self, allocator, input, options);
    }

    /// Deletes a contact evaluation in the specified Amazon Connect instance.
    pub fn deleteContactEvaluation(self: *Self, allocator: std.mem.Allocator, input: delete_contact_evaluation.DeleteContactEvaluationInput, options: CallOptions) !delete_contact_evaluation.DeleteContactEvaluationOutput {
        return delete_contact_evaluation.execute(self, allocator, input, options);
    }

    /// Deletes a flow for the specified Amazon Connect instance.
    pub fn deleteContactFlow(self: *Self, allocator: std.mem.Allocator, input: delete_contact_flow.DeleteContactFlowInput, options: CallOptions) !delete_contact_flow.DeleteContactFlowOutput {
        return delete_contact_flow.execute(self, allocator, input, options);
    }

    /// Deletes the specified flow module.
    pub fn deleteContactFlowModule(self: *Self, allocator: std.mem.Allocator, input: delete_contact_flow_module.DeleteContactFlowModuleInput, options: CallOptions) !delete_contact_flow_module.DeleteContactFlowModuleOutput {
        return delete_contact_flow_module.execute(self, allocator, input, options);
    }

    /// Removes an alias reference, breaking the named connection to the underlying
    /// module version without affecting the
    /// version itself.
    pub fn deleteContactFlowModuleAlias(self: *Self, allocator: std.mem.Allocator, input: delete_contact_flow_module_alias.DeleteContactFlowModuleAliasInput, options: CallOptions) !delete_contact_flow_module_alias.DeleteContactFlowModuleAliasOutput {
        return delete_contact_flow_module_alias.execute(self, allocator, input, options);
    }

    /// Removes a specific version of a contact flow module.
    pub fn deleteContactFlowModuleVersion(self: *Self, allocator: std.mem.Allocator, input: delete_contact_flow_module_version.DeleteContactFlowModuleVersionInput, options: CallOptions) !delete_contact_flow_module_version.DeleteContactFlowModuleVersionOutput {
        return delete_contact_flow_module_version.execute(self, allocator, input, options);
    }

    /// Deletes the particular version specified in flow version identifier.
    pub fn deleteContactFlowVersion(self: *Self, allocator: std.mem.Allocator, input: delete_contact_flow_version.DeleteContactFlowVersionInput, options: CallOptions) !delete_contact_flow_version.DeleteContactFlowVersionOutput {
        return delete_contact_flow_version.execute(self, allocator, input, options);
    }

    /// Deletes a data table and all associated attributes, versions, audits, and
    /// values. Does not update any references
    /// to the data table, even from other data tables. This includes dynamic values
    /// and conditional validations. System
    /// managed data tables are not deletable by customers. API users may delete the
    /// table at any time. When deletion is
    /// requested from the admin website, a warning is shown alerting the user of
    /// the most recent time the table and its
    /// values were accessed.
    pub fn deleteDataTable(self: *Self, allocator: std.mem.Allocator, input: delete_data_table.DeleteDataTableInput, options: CallOptions) !delete_data_table.DeleteDataTableOutput {
        return delete_data_table.execute(self, allocator, input, options);
    }

    /// Deletes an attribute and all its values from a data table.
    pub fn deleteDataTableAttribute(self: *Self, allocator: std.mem.Allocator, input: delete_data_table_attribute.DeleteDataTableAttributeInput, options: CallOptions) !delete_data_table_attribute.DeleteDataTableAttributeOutput {
        return delete_data_table_attribute.execute(self, allocator, input, options);
    }

    /// Deletes email address from the specified Amazon Connect instance.
    pub fn deleteEmailAddress(self: *Self, allocator: std.mem.Allocator, input: delete_email_address.DeleteEmailAddressInput, options: CallOptions) !delete_email_address.DeleteEmailAddressOutput {
        return delete_email_address.execute(self, allocator, input, options);
    }

    /// Deletes an evaluation form in the specified Amazon Connect instance.
    ///
    /// * If the version property is provided, only the specified version of the
    ///   evaluation form is deleted.
    ///
    /// * If no version is provided, then the full form (all versions) is deleted.
    pub fn deleteEvaluationForm(self: *Self, allocator: std.mem.Allocator, input: delete_evaluation_form.DeleteEvaluationFormInput, options: CallOptions) !delete_evaluation_form.DeleteEvaluationFormOutput {
        return delete_evaluation_form.execute(self, allocator, input, options);
    }

    /// Deletes an hours of operation.
    pub fn deleteHoursOfOperation(self: *Self, allocator: std.mem.Allocator, input: delete_hours_of_operation.DeleteHoursOfOperationInput, options: CallOptions) !delete_hours_of_operation.DeleteHoursOfOperationOutput {
        return delete_hours_of_operation.execute(self, allocator, input, options);
    }

    /// Deletes an hours of operation override in an Amazon Connect hours of
    /// operation resource.
    pub fn deleteHoursOfOperationOverride(self: *Self, allocator: std.mem.Allocator, input: delete_hours_of_operation_override.DeleteHoursOfOperationOverrideInput, options: CallOptions) !delete_hours_of_operation_override.DeleteHoursOfOperationOverrideOutput {
        return delete_hours_of_operation_override.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Deletes the Amazon Connect instance. For more information, see [Delete your
    /// Amazon Connect
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/delete-connect-instance.html) in the
    /// *Amazon Connect Administrator Guide*.
    ///
    /// Amazon Connect enforces a limit on the total number of instances that you
    /// can create or delete in 30 days.
    /// If you exceed this limit, you will get an error message indicating there has
    /// been an excessive number of attempts at creating or deleting instances.
    /// You must wait 30 days before you can restart creating and deleting instances
    /// in your account.
    pub fn deleteInstance(self: *Self, allocator: std.mem.Allocator, input: delete_instance.DeleteInstanceInput, options: CallOptions) !delete_instance.DeleteInstanceOutput {
        return delete_instance.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Web Services resource association from an Amazon Connect
    /// instance. The association must not
    /// have any use cases associated with it.
    pub fn deleteIntegrationAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_integration_association.DeleteIntegrationAssociationInput, options: CallOptions) !delete_integration_association.DeleteIntegrationAssociationOutput {
        return delete_integration_association.execute(self, allocator, input, options);
    }

    /// Deletes a predefined attribute from the specified Amazon Connect instance.
    pub fn deletePredefinedAttribute(self: *Self, allocator: std.mem.Allocator, input: delete_predefined_attribute.DeletePredefinedAttributeInput, options: CallOptions) !delete_predefined_attribute.DeletePredefinedAttributeOutput {
        return delete_predefined_attribute.execute(self, allocator, input, options);
    }

    /// Deletes a prompt.
    pub fn deletePrompt(self: *Self, allocator: std.mem.Allocator, input: delete_prompt.DeletePromptInput, options: CallOptions) !delete_prompt.DeletePromptOutput {
        return delete_prompt.execute(self, allocator, input, options);
    }

    /// Deletes registration for a device token and a chat contact.
    pub fn deletePushNotificationRegistration(self: *Self, allocator: std.mem.Allocator, input: delete_push_notification_registration.DeletePushNotificationRegistrationInput, options: CallOptions) !delete_push_notification_registration.DeletePushNotificationRegistrationOutput {
        return delete_push_notification_registration.execute(self, allocator, input, options);
    }

    /// Deletes a queue.
    pub fn deleteQueue(self: *Self, allocator: std.mem.Allocator, input: delete_queue.DeleteQueueInput, options: CallOptions) !delete_queue.DeleteQueueOutput {
        return delete_queue.execute(self, allocator, input, options);
    }

    /// Deletes a quick connect.
    ///
    /// After calling
    /// [DeleteUser](https://docs.aws.amazon.com/connect/latest/APIReference/API_DeleteUser.html), it's important to call `DeleteQuickConnect` to delete any records related to the
    /// deleted users. This will help you:
    ///
    /// * Avoid dangling resources that impact your service quotas.
    ///
    /// * Remove deleted users so they don't appear to agents as transfer options.
    ///
    /// * Avoid the disruption of other Amazon Connect processes, such as instance
    ///   replication and syncing if
    /// you're using [Amazon Connect Global
    /// Resiliency](https://docs.aws.amazon.com/connect/latest/adminguide/setup-connect-global-resiliency.html).
    pub fn deleteQuickConnect(self: *Self, allocator: std.mem.Allocator, input: delete_quick_connect.DeleteQuickConnectInput, options: CallOptions) !delete_quick_connect.DeleteQuickConnectOutput {
        return delete_quick_connect.execute(self, allocator, input, options);
    }

    /// Deletes a routing profile.
    pub fn deleteRoutingProfile(self: *Self, allocator: std.mem.Allocator, input: delete_routing_profile.DeleteRoutingProfileInput, options: CallOptions) !delete_routing_profile.DeleteRoutingProfileOutput {
        return delete_routing_profile.execute(self, allocator, input, options);
    }

    /// Deletes a rule for the specified Amazon Connect instance.
    pub fn deleteRule(self: *Self, allocator: std.mem.Allocator, input: delete_rule.DeleteRuleInput, options: CallOptions) !delete_rule.DeleteRuleOutput {
        return delete_rule.execute(self, allocator, input, options);
    }

    /// Deletes a security profile.
    pub fn deleteSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: delete_security_profile.DeleteSecurityProfileInput, options: CallOptions) !delete_security_profile.DeleteSecurityProfileOutput {
        return delete_security_profile.execute(self, allocator, input, options);
    }

    /// Deletes the task template.
    pub fn deleteTaskTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_task_template.DeleteTaskTemplateInput, options: CallOptions) !delete_task_template.DeleteTaskTemplateOutput {
        return delete_task_template.execute(self, allocator, input, options);
    }

    /// Deletes the test case that has already been created for the specified Amazon
    /// Connect instance.
    pub fn deleteTestCase(self: *Self, allocator: std.mem.Allocator, input: delete_test_case.DeleteTestCaseInput, options: CallOptions) !delete_test_case.DeleteTestCaseOutput {
        return delete_test_case.execute(self, allocator, input, options);
    }

    /// Deletes a traffic distribution group. This API can be called only in the
    /// Region where the traffic distribution group is created.
    ///
    /// For more information about deleting traffic distribution groups, see [Delete
    /// traffic distribution
    /// groups](https://docs.aws.amazon.com/connect/latest/adminguide/delete-traffic-distribution-groups.html) in the
    /// *Amazon Connect Administrator Guide*.
    pub fn deleteTrafficDistributionGroup(self: *Self, allocator: std.mem.Allocator, input: delete_traffic_distribution_group.DeleteTrafficDistributionGroupInput, options: CallOptions) !delete_traffic_distribution_group.DeleteTrafficDistributionGroupOutput {
        return delete_traffic_distribution_group.execute(self, allocator, input, options);
    }

    /// Deletes a use case from an integration association.
    pub fn deleteUseCase(self: *Self, allocator: std.mem.Allocator, input: delete_use_case.DeleteUseCaseInput, options: CallOptions) !delete_use_case.DeleteUseCaseOutput {
        return delete_use_case.execute(self, allocator, input, options);
    }

    /// Deletes a user account from the specified Amazon Connect instance.
    ///
    /// For information about what happens to a user's data when their account is
    /// deleted, see [Delete Users from Your Amazon Connect
    /// Instance](https://docs.aws.amazon.com/connect/latest/adminguide/delete-users.html) in the *Amazon Connect Administrator Guide*.
    ///
    /// After calling DeleteUser, call
    /// [DeleteQuickConnect](https://docs.aws.amazon.com/connect/latest/APIReference/API_DeleteQuickConnect.html) to delete any records
    /// related to the deleted users. This will help you:
    ///
    /// * Avoid dangling resources that impact your service quotas.
    ///
    /// * Remove deleted users so they don't appear to agents as transfer options.
    ///
    /// * Avoid the disruption of other Amazon Connect processes, such as instance
    ///   replication and syncing if
    /// you're using [Amazon Connect Global
    /// Resiliency](https://docs.aws.amazon.com/connect/latest/adminguide/setup-connect-global-resiliency.html).
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: CallOptions) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Deletes an existing user hierarchy group. It must not be associated with any
    /// agents or have any active child
    /// groups.
    pub fn deleteUserHierarchyGroup(self: *Self, allocator: std.mem.Allocator, input: delete_user_hierarchy_group.DeleteUserHierarchyGroupInput, options: CallOptions) !delete_user_hierarchy_group.DeleteUserHierarchyGroupOutput {
        return delete_user_hierarchy_group.execute(self, allocator, input, options);
    }

    /// Deletes the view entirely. It deletes the view and all associated qualifiers
    /// (versions and aliases).
    pub fn deleteView(self: *Self, allocator: std.mem.Allocator, input: delete_view.DeleteViewInput, options: CallOptions) !delete_view.DeleteViewOutput {
        return delete_view.execute(self, allocator, input, options);
    }

    /// Deletes the particular version specified in `ViewVersion` identifier.
    pub fn deleteViewVersion(self: *Self, allocator: std.mem.Allocator, input: delete_view_version.DeleteViewVersionInput, options: CallOptions) !delete_view_version.DeleteViewVersionOutput {
        return delete_view_version.execute(self, allocator, input, options);
    }

    /// Deletes the vocabulary that has the given identifier.
    pub fn deleteVocabulary(self: *Self, allocator: std.mem.Allocator, input: delete_vocabulary.DeleteVocabularyInput, options: CallOptions) !delete_vocabulary.DeleteVocabularyOutput {
        return delete_vocabulary.execute(self, allocator, input, options);
    }

    /// Deletes a workspace and removes all associated view and resource
    /// assignments.
    pub fn deleteWorkspace(self: *Self, allocator: std.mem.Allocator, input: delete_workspace.DeleteWorkspaceInput, options: CallOptions) !delete_workspace.DeleteWorkspaceOutput {
        return delete_workspace.execute(self, allocator, input, options);
    }

    /// Deletes a media asset (such as a logo) from a workspace.
    pub fn deleteWorkspaceMedia(self: *Self, allocator: std.mem.Allocator, input: delete_workspace_media.DeleteWorkspaceMediaInput, options: CallOptions) !delete_workspace_media.DeleteWorkspaceMediaOutput {
        return delete_workspace_media.execute(self, allocator, input, options);
    }

    /// Removes the association between a view and a page in a workspace. The page
    /// will display the default view after
    /// deletion.
    pub fn deleteWorkspacePage(self: *Self, allocator: std.mem.Allocator, input: delete_workspace_page.DeleteWorkspacePageInput, options: CallOptions) !delete_workspace_page.DeleteWorkspacePageOutput {
        return delete_workspace_page.execute(self, allocator, input, options);
    }

    /// Describes an agent status.
    pub fn describeAgentStatus(self: *Self, allocator: std.mem.Allocator, input: describe_agent_status.DescribeAgentStatusInput, options: CallOptions) !describe_agent_status.DescribeAgentStatusOutput {
        return describe_agent_status.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    /// To
    /// request access to this API, contact Amazon Web Services Support.
    ///
    /// Describes the target authentication profile.
    pub fn describeAuthenticationProfile(self: *Self, allocator: std.mem.Allocator, input: describe_authentication_profile.DescribeAuthenticationProfileInput, options: CallOptions) !describe_authentication_profile.DescribeAuthenticationProfileOutput {
        return describe_authentication_profile.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Describes the specified contact.
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * Retrieve contact information such as the caller's phone number and the
    ///   specific number the caller dialed to
    /// integrate into custom monitoring or custom agent experience solutions.
    ///
    /// * Detect when a customer chat session disconnects due to a network issue on
    ///   the agent's end. Use the
    /// DisconnectReason field in the
    /// [ContactTraceRecord](https://docs.aws.amazon.com/connect/latest/adminguide/ctr-data-model.html#ctr-ContactTraceRecord) to detect
    /// this event and then re-queue the chat for followup.
    ///
    /// * Identify after contact work (ACW) duration and call recordings information
    ///   when a COMPLETED event is received
    /// by using the [contact event
    /// stream](https://docs.aws.amazon.com/connect/latest/adminguide/contact-events.html).
    ///
    /// **Important things to know**
    ///
    /// * `SystemEndpoint` is not populated for contacts with initiation method of
    ///   MONITOR, QUEUE_TRANSFER,
    /// or CALLBACK
    ///
    /// * Contact information remains available in Amazon Connect for 24 months from
    ///   the
    /// `InitiationTimestamp`, and then it is deleted. Only contact information that
    /// is available in Amazon Connect is returned by this API.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn describeContact(self: *Self, allocator: std.mem.Allocator, input: describe_contact.DescribeContactInput, options: CallOptions) !describe_contact.DescribeContactOutput {
        return describe_contact.execute(self, allocator, input, options);
    }

    /// Describes a contact evaluation in the specified Amazon Connect instance.
    pub fn describeContactEvaluation(self: *Self, allocator: std.mem.Allocator, input: describe_contact_evaluation.DescribeContactEvaluationInput, options: CallOptions) !describe_contact_evaluation.DescribeContactEvaluationOutput {
        return describe_contact_evaluation.execute(self, allocator, input, options);
    }

    /// Describes the specified flow.
    ///
    /// You can also create and update flows using the [Amazon Connect
    /// Flow
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/flow-language.html).
    ///
    /// Use the `$SAVED` alias in the request to describe the `SAVED` content of a
    /// Flow. For
    /// example, `arn:aws:.../contact-flow/{id}:$SAVED`. After a flow is published,
    /// `$SAVED` needs to
    /// be supplied to view saved content that has not been published.
    ///
    /// Use `arn:aws:.../contact-flow/{id}:{version}` to retrieve the content of a
    /// specific flow
    /// version.
    ///
    /// In the response, **Status** indicates the flow status as either `SAVED`
    /// or `PUBLISHED`. The `PUBLISHED` status will initiate validation on the
    /// content.
    /// `SAVED` does not initiate validation of the content. `SAVED` | `PUBLISHED`
    pub fn describeContactFlow(self: *Self, allocator: std.mem.Allocator, input: describe_contact_flow.DescribeContactFlowInput, options: CallOptions) !describe_contact_flow.DescribeContactFlowOutput {
        return describe_contact_flow.execute(self, allocator, input, options);
    }

    /// Describes the specified flow module.
    ///
    /// Use the `$SAVED` alias in the request to describe the `SAVED` content of a
    /// Flow. For
    /// example, `arn:aws:.../contact-flow/{id}:$SAVED`. After a flow is published,
    /// `$SAVED` needs to
    /// be supplied to view saved content that has not been published.
    pub fn describeContactFlowModule(self: *Self, allocator: std.mem.Allocator, input: describe_contact_flow_module.DescribeContactFlowModuleInput, options: CallOptions) !describe_contact_flow_module.DescribeContactFlowModuleOutput {
        return describe_contact_flow_module.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific alias, including which
    /// version it currently points to and its
    /// metadata.
    pub fn describeContactFlowModuleAlias(self: *Self, allocator: std.mem.Allocator, input: describe_contact_flow_module_alias.DescribeContactFlowModuleAliasInput, options: CallOptions) !describe_contact_flow_module_alias.DescribeContactFlowModuleAliasOutput {
        return describe_contact_flow_module_alias.execute(self, allocator, input, options);
    }

    /// Returns all properties for a data table except for attributes and values.
    /// All properties from CreateDataTable
    /// are returned as well as properties for region replication, versioning, and
    /// system tables. "Describe" is a deprecated
    /// term but is allowed to maintain consistency with existing operations.
    pub fn describeDataTable(self: *Self, allocator: std.mem.Allocator, input: describe_data_table.DescribeDataTableInput, options: CallOptions) !describe_data_table.DescribeDataTableOutput {
        return describe_data_table.execute(self, allocator, input, options);
    }

    /// Returns detailed information for a specific data table attribute including
    /// its configuration, validation rules,
    /// and metadata. "Describe" is a deprecated term but is allowed to maintain
    /// consistency with existing operations.
    pub fn describeDataTableAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_data_table_attribute.DescribeDataTableAttributeInput, options: CallOptions) !describe_data_table_attribute.DescribeDataTableAttributeOutput {
        return describe_data_table_attribute.execute(self, allocator, input, options);
    }

    /// Describe email address form the specified Amazon Connect instance.
    pub fn describeEmailAddress(self: *Self, allocator: std.mem.Allocator, input: describe_email_address.DescribeEmailAddressInput, options: CallOptions) !describe_email_address.DescribeEmailAddressOutput {
        return describe_email_address.execute(self, allocator, input, options);
    }

    /// Describes an evaluation form in the specified Amazon Connect instance. If
    /// the version property is not
    /// provided, the latest version of the evaluation form is described.
    pub fn describeEvaluationForm(self: *Self, allocator: std.mem.Allocator, input: describe_evaluation_form.DescribeEvaluationFormInput, options: CallOptions) !describe_evaluation_form.DescribeEvaluationFormOutput {
        return describe_evaluation_form.execute(self, allocator, input, options);
    }

    /// Describes the hours of operation.
    pub fn describeHoursOfOperation(self: *Self, allocator: std.mem.Allocator, input: describe_hours_of_operation.DescribeHoursOfOperationInput, options: CallOptions) !describe_hours_of_operation.DescribeHoursOfOperationOutput {
        return describe_hours_of_operation.execute(self, allocator, input, options);
    }

    /// Describes the hours of operation override.
    pub fn describeHoursOfOperationOverride(self: *Self, allocator: std.mem.Allocator, input: describe_hours_of_operation_override.DescribeHoursOfOperationOverrideInput, options: CallOptions) !describe_hours_of_operation_override.DescribeHoursOfOperationOverrideOutput {
        return describe_hours_of_operation_override.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Returns the current state of the specified instance identifier. It tracks
    /// the instance while it is being created
    /// and returns an error status, if applicable.
    ///
    /// If an instance is not created successfully, the instance status reason field
    /// returns details relevant to the
    /// reason. The instance in a failed state is returned only for 24 hours after
    /// the CreateInstance API was invoked.
    pub fn describeInstance(self: *Self, allocator: std.mem.Allocator, input: describe_instance.DescribeInstanceInput, options: CallOptions) !describe_instance.DescribeInstanceOutput {
        return describe_instance.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Describes the specified instance attribute.
    pub fn describeInstanceAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_instance_attribute.DescribeInstanceAttributeInput, options: CallOptions) !describe_instance_attribute.DescribeInstanceAttributeOutput {
        return describe_instance_attribute.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Retrieves the current storage configurations for the specified resource
    /// type, association ID, and instance
    /// ID.
    pub fn describeInstanceStorageConfig(self: *Self, allocator: std.mem.Allocator, input: describe_instance_storage_config.DescribeInstanceStorageConfigInput, options: CallOptions) !describe_instance_storage_config.DescribeInstanceStorageConfigOutput {
        return describe_instance_storage_config.execute(self, allocator, input, options);
    }

    /// Gets details and status of a phone number that’s claimed to your Amazon
    /// Connect instance or traffic distribution group.
    ///
    /// If the number is claimed to a traffic distribution group, and you are
    /// calling in the Amazon Web Services Region where the traffic distribution
    /// group was
    /// created, you can use either a phone number ARN or UUID value for the
    /// `PhoneNumberId` URI request
    /// parameter. However, if the number is claimed to a traffic distribution group
    /// and you are calling this API in the alternate Amazon Web Services Region
    /// associated with the traffic distribution group, you must provide a full
    /// phone number ARN. If a UUID is provided
    /// in
    /// this scenario, you receive a `ResourceNotFoundException`.
    pub fn describePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: describe_phone_number.DescribePhoneNumberInput, options: CallOptions) !describe_phone_number.DescribePhoneNumberOutput {
        return describe_phone_number.execute(self, allocator, input, options);
    }

    /// Describes a predefined attribute for the specified Amazon Connect instance.
    /// A *predefined attribute*
    /// is made up of a name and a value. You can use predefined attributes for:
    ///
    /// * Routing proficiency (for example, agent certification) that has predefined
    ///   values (for example, a list of
    /// possible certifications). For more information, see [Create predefined
    /// attributes for routing contacts to
    /// agents](https://docs.aws.amazon.com/connect/latest/adminguide/predefined-attributes.html).
    ///
    /// * Contact information that varies between transfers or conferences, such as
    ///   the name of the business unit
    /// handling the contact. For more information, see [Use contact segment
    /// attributes](https://docs.aws.amazon.com/connect/latest/adminguide/use-contact-segment-attributes.html).
    ///
    /// For the predefined attributes per instance quota, see [Amazon Connect
    /// quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#connect-quotas).
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn describePredefinedAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_predefined_attribute.DescribePredefinedAttributeInput, options: CallOptions) !describe_predefined_attribute.DescribePredefinedAttributeOutput {
        return describe_predefined_attribute.execute(self, allocator, input, options);
    }

    /// Describes the prompt.
    pub fn describePrompt(self: *Self, allocator: std.mem.Allocator, input: describe_prompt.DescribePromptInput, options: CallOptions) !describe_prompt.DescribePromptOutput {
        return describe_prompt.execute(self, allocator, input, options);
    }

    /// Describes the specified queue.
    pub fn describeQueue(self: *Self, allocator: std.mem.Allocator, input: describe_queue.DescribeQueueInput, options: CallOptions) !describe_queue.DescribeQueueOutput {
        return describe_queue.execute(self, allocator, input, options);
    }

    /// Describes the quick connect.
    pub fn describeQuickConnect(self: *Self, allocator: std.mem.Allocator, input: describe_quick_connect.DescribeQuickConnectInput, options: CallOptions) !describe_quick_connect.DescribeQuickConnectOutput {
        return describe_quick_connect.execute(self, allocator, input, options);
    }

    /// Describes the specified routing profile.
    ///
    /// `DescribeRoutingProfile` does not populate AssociatedQueueIds in its
    /// response. The example Response
    /// Syntax shown on this page is incorrect; we are working to update it.
    /// [SearchRoutingProfiles](https://docs.aws.amazon.com/connect/latest/APIReference/API_SearchRoutingProfiles.html) does include
    /// AssociatedQueueIds.
    pub fn describeRoutingProfile(self: *Self, allocator: std.mem.Allocator, input: describe_routing_profile.DescribeRoutingProfileInput, options: CallOptions) !describe_routing_profile.DescribeRoutingProfileOutput {
        return describe_routing_profile.execute(self, allocator, input, options);
    }

    /// Describes a rule for the specified Amazon Connect instance.
    pub fn describeRule(self: *Self, allocator: std.mem.Allocator, input: describe_rule.DescribeRuleInput, options: CallOptions) !describe_rule.DescribeRuleOutput {
        return describe_rule.execute(self, allocator, input, options);
    }

    /// Gets basic information about the security profile.
    ///
    /// For information about security profiles, see [Security
    /// Profiles](https://docs.aws.amazon.com/connect/latest/adminguide/connect-security-profiles.html) in the *Amazon Connect Administrator Guide*. For a mapping of the API name and user interface name of the security
    /// profile permissions, see [List
    /// of security profile
    /// permissions](https://docs.aws.amazon.com/connect/latest/adminguide/security-profile-list.html).
    pub fn describeSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: describe_security_profile.DescribeSecurityProfileInput, options: CallOptions) !describe_security_profile.DescribeSecurityProfileOutput {
        return describe_security_profile.execute(self, allocator, input, options);
    }

    /// Describes the specified test case and allows you to get the content and
    /// metadata of the test case for the specified Amazon Connect instance.
    pub fn describeTestCase(self: *Self, allocator: std.mem.Allocator, input: describe_test_case.DescribeTestCaseInput, options: CallOptions) !describe_test_case.DescribeTestCaseOutput {
        return describe_test_case.execute(self, allocator, input, options);
    }

    /// Gets details and status of a traffic distribution group.
    pub fn describeTrafficDistributionGroup(self: *Self, allocator: std.mem.Allocator, input: describe_traffic_distribution_group.DescribeTrafficDistributionGroupInput, options: CallOptions) !describe_traffic_distribution_group.DescribeTrafficDistributionGroupOutput {
        return describe_traffic_distribution_group.execute(self, allocator, input, options);
    }

    /// Describes the specified user. You can [find the instance ID in the Amazon
    /// Connect
    /// console](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) (it’s the final part of the ARN). The console does not display the user IDs. Instead, list the users
    /// and note the IDs provided in the output.
    pub fn describeUser(self: *Self, allocator: std.mem.Allocator, input: describe_user.DescribeUserInput, options: CallOptions) !describe_user.DescribeUserOutput {
        return describe_user.execute(self, allocator, input, options);
    }

    /// Describes the specified hierarchy group.
    pub fn describeUserHierarchyGroup(self: *Self, allocator: std.mem.Allocator, input: describe_user_hierarchy_group.DescribeUserHierarchyGroupInput, options: CallOptions) !describe_user_hierarchy_group.DescribeUserHierarchyGroupOutput {
        return describe_user_hierarchy_group.execute(self, allocator, input, options);
    }

    /// Describes the hierarchy structure of the specified Amazon Connect instance.
    pub fn describeUserHierarchyStructure(self: *Self, allocator: std.mem.Allocator, input: describe_user_hierarchy_structure.DescribeUserHierarchyStructureInput, options: CallOptions) !describe_user_hierarchy_structure.DescribeUserHierarchyStructureOutput {
        return describe_user_hierarchy_structure.execute(self, allocator, input, options);
    }

    /// Retrieves the view for the specified Amazon Connect instance and view
    /// identifier.
    ///
    /// The view identifier can be supplied as a ViewId or ARN.
    ///
    /// `$SAVED` needs to be supplied if a view is unpublished.
    ///
    /// The view identifier can contain an optional qualifier, for example,
    /// `:$SAVED`, which
    /// is either an actual version number or an Amazon Connect managed qualifier
    /// `$SAVED | $LATEST`. If it is
    /// not supplied, then `$LATEST` is assumed for customer managed views and an
    /// error is returned if there is no
    /// published content available. Version 1 is assumed for Amazon Web Services
    /// managed views.
    pub fn describeView(self: *Self, allocator: std.mem.Allocator, input: describe_view.DescribeViewInput, options: CallOptions) !describe_view.DescribeViewOutput {
        return describe_view.execute(self, allocator, input, options);
    }

    /// Describes the specified vocabulary.
    pub fn describeVocabulary(self: *Self, allocator: std.mem.Allocator, input: describe_vocabulary.DescribeVocabularyInput, options: CallOptions) !describe_vocabulary.DescribeVocabularyOutput {
        return describe_vocabulary.execute(self, allocator, input, options);
    }

    /// Retrieves details about a workspace, including its configuration and
    /// metadata.
    pub fn describeWorkspace(self: *Self, allocator: std.mem.Allocator, input: describe_workspace.DescribeWorkspaceInput, options: CallOptions) !describe_workspace.DescribeWorkspaceOutput {
        return describe_workspace.execute(self, allocator, input, options);
    }

    /// Removes the dataset ID associated with a given Amazon Connect instance.
    pub fn disassociateAnalyticsDataSet(self: *Self, allocator: std.mem.Allocator, input: disassociate_analytics_data_set.DisassociateAnalyticsDataSetInput, options: CallOptions) !disassociate_analytics_data_set.DisassociateAnalyticsDataSetOutput {
        return disassociate_analytics_data_set.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Revokes access to integrated applications from Amazon Connect.
    pub fn disassociateApprovedOrigin(self: *Self, allocator: std.mem.Allocator, input: disassociate_approved_origin.DisassociateApprovedOriginInput, options: CallOptions) !disassociate_approved_origin.DisassociateApprovedOriginOutput {
        return disassociate_approved_origin.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Revokes authorization from the specified instance to access the specified
    /// Amazon Lex or Amazon Lex V2 bot.
    pub fn disassociateBot(self: *Self, allocator: std.mem.Allocator, input: disassociate_bot.DisassociateBotInput, options: CallOptions) !disassociate_bot.DisassociateBotOutput {
        return disassociate_bot.execute(self, allocator, input, options);
    }

    /// Removes the alias association between two email addresses in an Amazon
    /// Connect instance. After
    /// disassociation, emails sent to the former alias email address are no longer
    /// forwarded to the primary email address.
    /// Both email addresses continue to exist independently and can receive emails
    /// directly.
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * **Department separation**: Remove alias relationships when splitting a
    /// consolidated support queue back into separate department-specific queues.
    ///
    /// * **Email address retirement**: Cleanly remove forwarding relationships
    ///   before
    /// decommissioning old email addresses.
    ///
    /// * **Organizational restructuring**: Reconfigure email routing when business
    /// processes change and aliases are no longer needed.
    ///
    /// **Important things to know**
    ///
    /// * Concurrent operations: This API uses distributed locking, so concurrent
    ///   operations on the same email addresses
    /// may be temporarily blocked.
    ///
    /// * Emails sent to the former alias address are still delivered directly to
    ///   that address if it exists.
    ///
    /// * You do not need to delete the email addresses after disassociation. Both
    ///   addresses remain active
    /// independently.
    ///
    /// * After a successful disassociation, you can immediately create a new alias
    ///   relationship with the same
    /// addresses.
    ///
    /// * 200 status means alias was successfully disassociated.
    ///
    /// `DisassociateEmailAddressAlias` does not return the following information:
    ///
    /// * Details in the response about the email that was disassociated. The
    ///   response returns an empty body.
    ///
    /// * The timestamp of when the disassociation occurred.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    ///
    /// **Related operations**
    ///
    /// *
    ///   [AssociateEmailAddressAlias](https://docs.aws.amazon.com/connect/latest/APIReference/API_AssociateEmailAddressAlias.html): Associates an email address alias with an existing email address in an
    /// Amazon Connect instance.
    ///
    /// *
    ///   [DescribeEmailAddress](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeEmailAddress.html): View current alias configurations for an email address.
    ///
    /// *
    ///   [SearchEmailAddresses](https://docs.aws.amazon.com/connect/latest/APIReference/API_SearchEmailAddresses.html): Find email addresses and their alias relationships across an instance.
    ///
    /// *
    ///   [CreateEmailAddress](https://docs.aws.amazon.com/connect/latest/APIReference/API_CreateEmailAddress.html): Create new email addresses that can participate in alias relationships.
    ///
    /// *
    ///   [DeleteEmailAddress](https://docs.aws.amazon.com/connect/latest/APIReference/API_DeleteEmailAddress.html): Remove email addresses (automatically removes any alias relationships).
    ///
    /// *
    ///   [UpdateEmailAddressMetadata](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdateEmailAddressMetadata.html): Modify email address properties (does not affect alias relationships).
    pub fn disassociateEmailAddressAlias(self: *Self, allocator: std.mem.Allocator, input: disassociate_email_address_alias.DisassociateEmailAddressAliasInput, options: CallOptions) !disassociate_email_address_alias.DisassociateEmailAddressAliasOutput {
        return disassociate_email_address_alias.execute(self, allocator, input, options);
    }

    /// Disassociates a connect resource from a flow.
    pub fn disassociateFlow(self: *Self, allocator: std.mem.Allocator, input: disassociate_flow.DisassociateFlowInput, options: CallOptions) !disassociate_flow.DisassociateFlowOutput {
        return disassociate_flow.execute(self, allocator, input, options);
    }

    /// Disassociates a set of hours of operations with another hours of operation.
    /// Refer to Administrator Guide [ here
    /// ](https://docs.aws.amazon.com/connect/latest/adminguide/hours-of-operation-overrides.html) for more information on inheriting overrides from parent hours of operation(s).
    pub fn disassociateHoursOfOperations(self: *Self, allocator: std.mem.Allocator, input: disassociate_hours_of_operations.DisassociateHoursOfOperationsInput, options: CallOptions) !disassociate_hours_of_operations.DisassociateHoursOfOperationsOutput {
        return disassociate_hours_of_operations.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Removes the storage type configurations for the specified resource type and
    /// association ID.
    pub fn disassociateInstanceStorageConfig(self: *Self, allocator: std.mem.Allocator, input: disassociate_instance_storage_config.DisassociateInstanceStorageConfigInput, options: CallOptions) !disassociate_instance_storage_config.DisassociateInstanceStorageConfigOutput {
        return disassociate_instance_storage_config.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Remove the Lambda function from the dropdown options available in the
    /// relevant flow blocks.
    pub fn disassociateLambdaFunction(self: *Self, allocator: std.mem.Allocator, input: disassociate_lambda_function.DisassociateLambdaFunctionInput, options: CallOptions) !disassociate_lambda_function.DisassociateLambdaFunctionOutput {
        return disassociate_lambda_function.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Revokes authorization from the specified instance to access the specified
    /// Amazon Lex bot.
    pub fn disassociateLexBot(self: *Self, allocator: std.mem.Allocator, input: disassociate_lex_bot.DisassociateLexBotInput, options: CallOptions) !disassociate_lex_bot.DisassociateLexBotOutput {
        return disassociate_lex_bot.execute(self, allocator, input, options);
    }

    /// Removes the flow association from a phone number claimed to your Amazon
    /// Connect instance.
    ///
    /// If the number is claimed to a traffic distribution group, and you are
    /// calling this API using an instance in the Amazon Web Services Region where
    /// the traffic distribution group was created, you can use either a full phone
    /// number ARN or UUID value for the
    /// `PhoneNumberId` URI request parameter. However, if the number is claimed to
    /// a traffic distribution group and you are calling
    /// this API using an instance in the alternate Amazon Web Services Region
    /// associated with the traffic distribution group, you must provide a
    /// full phone number ARN. If a UUID is provided in this scenario, you will
    /// receive a
    /// `ResourceNotFoundException`.
    pub fn disassociatePhoneNumberContactFlow(self: *Self, allocator: std.mem.Allocator, input: disassociate_phone_number_contact_flow.DisassociatePhoneNumberContactFlowInput, options: CallOptions) !disassociate_phone_number_contact_flow.DisassociatePhoneNumberContactFlowOutput {
        return disassociate_phone_number_contact_flow.execute(self, allocator, input, options);
    }

    /// Disassociates a set of quick connects from a queue.
    pub fn disassociateQueueQuickConnects(self: *Self, allocator: std.mem.Allocator, input: disassociate_queue_quick_connects.DisassociateQueueQuickConnectsInput, options: CallOptions) !disassociate_queue_quick_connects.DisassociateQueueQuickConnectsOutput {
        return disassociate_queue_quick_connects.execute(self, allocator, input, options);
    }

    /// Disassociates a set of queues from a routing profile.
    ///
    /// Up to 10 queue references can be disassociated in a single API call. More
    /// than 10 queue references results in a
    /// single call results in an InvalidParameterException.
    pub fn disassociateRoutingProfileQueues(self: *Self, allocator: std.mem.Allocator, input: disassociate_routing_profile_queues.DisassociateRoutingProfileQueuesInput, options: CallOptions) !disassociate_routing_profile_queues.DisassociateRoutingProfileQueuesOutput {
        return disassociate_routing_profile_queues.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Deletes the specified security key.
    pub fn disassociateSecurityKey(self: *Self, allocator: std.mem.Allocator, input: disassociate_security_key.DisassociateSecurityKeyInput, options: CallOptions) !disassociate_security_key.DisassociateSecurityKeyOutput {
        return disassociate_security_key.execute(self, allocator, input, options);
    }

    /// Disassociates a security profile attached to a Q in Connect AI Agent Entity
    /// in an Amazon Connect instance.
    pub fn disassociateSecurityProfiles(self: *Self, allocator: std.mem.Allocator, input: disassociate_security_profiles.DisassociateSecurityProfilesInput, options: CallOptions) !disassociate_security_profiles.DisassociateSecurityProfilesOutput {
        return disassociate_security_profiles.execute(self, allocator, input, options);
    }

    /// Disassociates an agent from a traffic distribution group. This API can be
    /// called only in the Region where the
    /// traffic distribution group is created.
    pub fn disassociateTrafficDistributionGroupUser(self: *Self, allocator: std.mem.Allocator, input: disassociate_traffic_distribution_group_user.DisassociateTrafficDistributionGroupUserInput, options: CallOptions) !disassociate_traffic_distribution_group_user.DisassociateTrafficDistributionGroupUserOutput {
        return disassociate_traffic_distribution_group_user.execute(self, allocator, input, options);
    }

    /// Disassociates a set of proficiencies from a user.
    pub fn disassociateUserProficiencies(self: *Self, allocator: std.mem.Allocator, input: disassociate_user_proficiencies.DisassociateUserProficienciesInput, options: CallOptions) !disassociate_user_proficiencies.DisassociateUserProficienciesOutput {
        return disassociate_user_proficiencies.execute(self, allocator, input, options);
    }

    /// Removes the association between a workspace and one or more users or routing
    /// profiles.
    pub fn disassociateWorkspace(self: *Self, allocator: std.mem.Allocator, input: disassociate_workspace.DisassociateWorkspaceInput, options: CallOptions) !disassociate_workspace.DisassociateWorkspaceOutput {
        return disassociate_workspace.execute(self, allocator, input, options);
    }

    /// Dismisses contacts from an agent’s CCP and returns the agent to an available
    /// state, which allows the agent to
    /// receive a new routed contact. Contacts can only be dismissed if they are in
    /// a `MISSED`,
    /// `ERROR`, `ENDED`, or `REJECTED` state in the [Agent Event
    /// Stream](https://docs.aws.amazon.com/connect/latest/adminguide/about-contact-states.html).
    pub fn dismissUserContact(self: *Self, allocator: std.mem.Allocator, input: dismiss_user_contact.DismissUserContactInput, options: CallOptions) !dismiss_user_contact.DismissUserContactOutput {
        return dismiss_user_contact.execute(self, allocator, input, options);
    }

    /// Evaluates values at the time of the request and returns them. It considers
    /// the request's timezone or the table's
    /// timezone, in that order, when accessing time based tables. When a value is
    /// accessed, the accessor's identity and the
    /// time of access are saved alongside the value to help identify values that
    /// are actively in use. The term "Batch" is
    /// not included in the operation name since it does not meet all the criteria
    /// for a batch operation as specified in
    /// Batch Operations: Amazon Web Services API Standards.
    pub fn evaluateDataTableValues(self: *Self, allocator: std.mem.Allocator, input: evaluate_data_table_values.EvaluateDataTableValuesInput, options: CallOptions) !evaluate_data_table_values.EvaluateDataTableValuesOutput {
        return evaluate_data_table_values.execute(self, allocator, input, options);
    }

    /// Provides a pre-signed URL for download of an approved attached file. This
    /// API also returns metadata about the
    /// attached file. It will only return a downloadURL if the status of the
    /// attached file is `APPROVED`.
    pub fn getAttachedFile(self: *Self, allocator: std.mem.Allocator, input: get_attached_file.GetAttachedFileInput, options: CallOptions) !get_attached_file.GetAttachedFileOutput {
        return get_attached_file.execute(self, allocator, input, options);
    }

    /// Retrieves the contact attributes for the specified contact.
    pub fn getContactAttributes(self: *Self, allocator: std.mem.Allocator, input: get_contact_attributes.GetContactAttributesInput, options: CallOptions) !get_contact_attributes.GetContactAttributesOutput {
        return get_contact_attributes.execute(self, allocator, input, options);
    }

    /// Retrieves contact metric data for a specified contact.
    ///
    /// **Use cases**
    ///
    /// Following are common use cases for position in queue and estimated wait
    /// time:
    ///
    /// * Customer-Facing Wait Time Announcements - Display or announce the
    ///   estimated wait time and position in queue to customers before or during
    ///   their queue experience.
    ///
    /// * Callback Offerings - Offer customers a callback option when the estimated
    ///   wait time or position in queue exceeds a defined threshold.
    ///
    /// * Queue Routing Decisions - Route incoming contacts to less congested queues
    ///   by comparing estimated wait time and position in queue across multiple
    ///   queues.
    ///
    /// * Self-Service Deflection - Redirect customers to self-service options like
    ///   chatbots or FAQs when estimated wait time is high or position in queue is
    ///   unfavorable.
    ///
    /// **Important things to know**
    ///
    /// * Metrics are only available while the contact is actively in queue.
    ///
    /// * For more information, see the [Position in
    ///   queue](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html) metric in the *Amazon Connect Administrator Guide*.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn getContactMetrics(self: *Self, allocator: std.mem.Allocator, input: get_contact_metrics.GetContactMetricsInput, options: CallOptions) !get_contact_metrics.GetContactMetricsOutput {
        return get_contact_metrics.execute(self, allocator, input, options);
    }

    /// Gets the real-time metric data from the specified Amazon Connect instance.
    ///
    /// For a description of each metric, see [Metrics
    /// definitions](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html) in the *Amazon Connect Administrator Guide*.
    ///
    /// When you make a successful API request, you can expect the following metric
    /// values in the response:
    ///
    /// * **Metric value is null**: The calculation cannot be performed due to
    ///   divide by
    /// zero or insufficient data
    ///
    /// * **Metric value is a number (including 0) of defined type**: The number
    ///   provided
    /// is the calculation result
    ///
    /// * **MetricResult list is empty**: The request cannot find any data in the
    /// system
    ///
    /// The following guidelines can help you work with the API:
    ///
    /// * Each dimension in the metric response must contain a value
    ///
    /// * Each item in MetricResult must include all requested metrics
    ///
    /// * If the response is slow due to large result sets, try these approaches:
    ///
    /// * Add filters to reduce the amount of data returned
    pub fn getCurrentMetricData(self: *Self, allocator: std.mem.Allocator, input: get_current_metric_data.GetCurrentMetricDataInput, options: CallOptions) !get_current_metric_data.GetCurrentMetricDataOutput {
        return get_current_metric_data.execute(self, allocator, input, options);
    }

    /// Gets the real-time active user data from the specified Amazon Connect
    /// instance.
    pub fn getCurrentUserData(self: *Self, allocator: std.mem.Allocator, input: get_current_user_data.GetCurrentUserDataInput, options: CallOptions) !get_current_user_data.GetCurrentUserDataOutput {
        return get_current_user_data.execute(self, allocator, input, options);
    }

    /// Get the hours of operations with the effective override applied.
    pub fn getEffectiveHoursOfOperations(self: *Self, allocator: std.mem.Allocator, input: get_effective_hours_of_operations.GetEffectiveHoursOfOperationsInput, options: CallOptions) !get_effective_hours_of_operations.GetEffectiveHoursOfOperationsOutput {
        return get_effective_hours_of_operations.execute(self, allocator, input, options);
    }

    /// Supports SAML sign-in for Amazon Connect. Retrieves a token for federation.
    /// The token is for the Amazon Connect user which corresponds to the IAM
    /// credentials that were used to invoke this action.
    ///
    /// For more information about how SAML sign-in works in Amazon Connect, see
    /// [Configure SAML with IAM for Amazon Connect
    /// in the *Amazon Connect Administrator
    /// Guide*.](https://docs.aws.amazon.com/connect/latest/adminguide/configure-saml.html )
    ///
    /// This API doesn't support root users. If you try to invoke GetFederationToken
    /// with root credentials, an error
    /// message similar to the following one appears:
    ///
    /// `Provided identity: Principal: .... User: .... cannot be used for federation
    /// with Amazon Connect`
    pub fn getFederationToken(self: *Self, allocator: std.mem.Allocator, input: get_federation_token.GetFederationTokenInput, options: CallOptions) !get_federation_token.GetFederationTokenOutput {
        return get_federation_token.execute(self, allocator, input, options);
    }

    /// Retrieves the flow associated for a given resource.
    pub fn getFlowAssociation(self: *Self, allocator: std.mem.Allocator, input: get_flow_association.GetFlowAssociationInput, options: CallOptions) !get_flow_association.GetFlowAssociationOutput {
        return get_flow_association.execute(self, allocator, input, options);
    }

    /// Gets historical metric data from the specified Amazon Connect instance.
    ///
    /// For a description of each historical metric, see [Metrics
    /// definitions](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html) in the *Amazon Connect Administrator Guide*.
    ///
    /// We recommend using the
    /// [GetMetricDataV2](https://docs.aws.amazon.com/connect/latest/APIReference/API_GetMetricDataV2.html) API. It provides more flexibility, features, and the ability to query longer time ranges
    /// than `GetMetricData`. Use it to retrieve historical agent and contact
    /// metrics for the last 3 months, at
    /// varying intervals. You can also use it to build custom dashboards to measure
    /// historical queue and agent performance.
    /// For example, you can track the number of incoming contacts for the last 7
    /// days, with data split by day, to see how
    /// contact volume changed per day of the week.
    pub fn getMetricData(self: *Self, allocator: std.mem.Allocator, input: get_metric_data.GetMetricDataInput, options: CallOptions) !get_metric_data.GetMetricDataOutput {
        return get_metric_data.execute(self, allocator, input, options);
    }

    /// Gets metric data from the specified Amazon Connect instance.
    ///
    /// `GetMetricDataV2` offers more features than
    /// [GetMetricData](https://docs.aws.amazon.com/connect/latest/APIReference/API_GetMetricData.html), the previous version of this API. It
    /// has new metrics, offers filtering at a metric level, and offers the ability
    /// to filter and group data by channels,
    /// queues, routing profiles, agents, and agent hierarchy levels. It can
    /// retrieve historical data for the last 3 months,
    /// at varying intervals. It does not support agent queues.
    ///
    /// For a description of the historical metrics that are supported by
    /// `GetMetricDataV2` and
    /// `GetMetricData`, see [Metrics
    /// definitions](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-definitions.html) in the *Amazon Connect Administrator Guide*.
    ///
    /// When you make a successful API request, you can expect the following metric
    /// values in the response:
    ///
    /// * **Metric value is null**: The calculation cannot be performed due to
    ///   divide by
    /// zero or insufficient data
    ///
    /// * **Metric value is a number (including 0) of defined type**: The number
    ///   provided
    /// is the calculation result
    ///
    /// * **MetricResult list is empty**: The request cannot find any data in the
    /// system
    ///
    /// The following guidelines can help you work with the API:
    ///
    /// * Each dimension in the metric response must contain a value
    ///
    /// * Each item in MetricResult must include all requested metrics
    ///
    /// * If the response is slow due to large result sets, try these approaches:
    ///
    /// * Narrow the time range of your request
    ///
    /// * Add filters to reduce the amount of data returned
    pub fn getMetricDataV2(self: *Self, allocator: std.mem.Allocator, input: get_metric_data_v2.GetMetricDataV2Input, options: CallOptions) !get_metric_data_v2.GetMetricDataV2Output {
        return get_metric_data_v2.execute(self, allocator, input, options);
    }

    /// Gets the prompt file.
    pub fn getPromptFile(self: *Self, allocator: std.mem.Allocator, input: get_prompt_file.GetPromptFileInput, options: CallOptions) !get_prompt_file.GetPromptFileOutput {
        return get_prompt_file.execute(self, allocator, input, options);
    }

    /// Gets details about a specific task template in the specified Amazon Connect
    /// instance.
    pub fn getTaskTemplate(self: *Self, allocator: std.mem.Allocator, input: get_task_template.GetTaskTemplateInput, options: CallOptions) !get_task_template.GetTaskTemplateOutput {
        return get_task_template.execute(self, allocator, input, options);
    }

    /// Retrieves an overview of a test execution that includes the status of the
    /// execution, start and end time, and observation summary.
    pub fn getTestCaseExecutionSummary(self: *Self, allocator: std.mem.Allocator, input: get_test_case_execution_summary.GetTestCaseExecutionSummaryInput, options: CallOptions) !get_test_case_execution_summary.GetTestCaseExecutionSummaryOutput {
        return get_test_case_execution_summary.execute(self, allocator, input, options);
    }

    /// Retrieves the current traffic distribution for a given traffic distribution
    /// group.
    pub fn getTrafficDistribution(self: *Self, allocator: std.mem.Allocator, input: get_traffic_distribution.GetTrafficDistributionInput, options: CallOptions) !get_traffic_distribution.GetTrafficDistributionOutput {
        return get_traffic_distribution.execute(self, allocator, input, options);
    }

    /// Imports a claimed phone number from an external service, such as Amazon Web
    /// Services End User Messaging, into an
    /// Amazon Connect instance. You can call this API only in the same Amazon Web
    /// Services Region where the Amazon Connect instance was created.
    ///
    /// Call the
    /// [DescribePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribePhoneNumber.html) API to verify the status of a previous `ImportPhoneNumber` operation.
    ///
    /// If you plan to claim or import numbers and then release numbers frequently,
    /// contact us for a service quota
    /// exception. Otherwise, it is possible you will be blocked from claiming and
    /// releasing any more numbers until up to 180
    /// days past the oldest number released has expired.
    ///
    /// By default you can claim or import and then release up to 200% of your
    /// maximum number of active phone numbers.
    /// If you claim or import and then release phone numbers using the UI or API
    /// during a rolling 180 day cycle that exceeds
    /// 200% of your phone number service level quota, you will be blocked from
    /// claiming or importing any more numbers until
    /// 180 days past the oldest number released has expired.
    ///
    /// For example, if you already have 99 claimed or imported numbers and a
    /// service level quota of 99 phone numbers,
    /// and in any 180 day period you release 99, claim 99, and then release 99, you
    /// will have exceeded the 200% limit. At
    /// that point you are blocked from claiming any more numbers until you open an
    /// Amazon Web Services Support ticket.
    pub fn importPhoneNumber(self: *Self, allocator: std.mem.Allocator, input: import_phone_number.ImportPhoneNumberInput, options: CallOptions) !import_phone_number.ImportPhoneNumberOutput {
        return import_phone_number.execute(self, allocator, input, options);
    }

    /// Imports a media asset (such as a logo) for use in a workspace.
    pub fn importWorkspaceMedia(self: *Self, allocator: std.mem.Allocator, input: import_workspace_media.ImportWorkspaceMediaInput, options: CallOptions) !import_workspace_media.ImportWorkspaceMediaOutput {
        return import_workspace_media.execute(self, allocator, input, options);
    }

    /// Lists agent statuses.
    pub fn listAgentStatuses(self: *Self, allocator: std.mem.Allocator, input: list_agent_statuses.ListAgentStatusesInput, options: CallOptions) !list_agent_statuses.ListAgentStatusesOutput {
        return list_agent_statuses.execute(self, allocator, input, options);
    }

    /// Lists the association status of requested dataset ID for a given Amazon
    /// Connect instance.
    pub fn listAnalyticsDataAssociations(self: *Self, allocator: std.mem.Allocator, input: list_analytics_data_associations.ListAnalyticsDataAssociationsInput, options: CallOptions) !list_analytics_data_associations.ListAnalyticsDataAssociationsOutput {
        return list_analytics_data_associations.execute(self, allocator, input, options);
    }

    /// Lists the data lake datasets available to associate with for a given Amazon
    /// Connect instance.
    pub fn listAnalyticsDataLakeDataSets(self: *Self, allocator: std.mem.Allocator, input: list_analytics_data_lake_data_sets.ListAnalyticsDataLakeDataSetsInput, options: CallOptions) !list_analytics_data_lake_data_sets.ListAnalyticsDataLakeDataSetsOutput {
        return list_analytics_data_lake_data_sets.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Returns a paginated list of all approved origins associated with the
    /// instance.
    pub fn listApprovedOrigins(self: *Self, allocator: std.mem.Allocator, input: list_approved_origins.ListApprovedOriginsInput, options: CallOptions) !list_approved_origins.ListApprovedOriginsOutput {
        return list_approved_origins.execute(self, allocator, input, options);
    }

    /// Provides information about contact tree, a list of associated contacts with
    /// a unique identifier.
    pub fn listAssociatedContacts(self: *Self, allocator: std.mem.Allocator, input: list_associated_contacts.ListAssociatedContactsInput, options: CallOptions) !list_associated_contacts.ListAssociatedContactsOutput {
        return list_associated_contacts.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    /// To
    /// request access to this API, contact Amazon Web Services Support.
    ///
    /// Provides summary information about the authentication profiles in a
    /// specified Amazon Connect
    /// instance.
    pub fn listAuthenticationProfiles(self: *Self, allocator: std.mem.Allocator, input: list_authentication_profiles.ListAuthenticationProfilesInput, options: CallOptions) !list_authentication_profiles.ListAuthenticationProfilesOutput {
        return list_authentication_profiles.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// For the specified version of Amazon Lex, returns a paginated list of all the
    /// Amazon Lex bots
    /// currently associated with the instance. Use this API to return both Amazon
    /// Lex V1 and V2
    /// bots.
    pub fn listBots(self: *Self, allocator: std.mem.Allocator, input: list_bots.ListBotsInput, options: CallOptions) !list_bots.ListBotsOutput {
        return list_bots.execute(self, allocator, input, options);
    }

    /// Provides information about the child hours of operations for the specified
    /// parent hours of operation.
    ///
    /// For more information about child hours of operations, see [Link overrides
    /// from different hours of
    /// operation](https://docs.aws.amazon.com/connect/latest/adminguide/) in the
    /// * Administrator Guide*.
    pub fn listChildHoursOfOperations(self: *Self, allocator: std.mem.Allocator, input: list_child_hours_of_operations.ListChildHoursOfOperationsInput, options: CallOptions) !list_child_hours_of_operations.ListChildHoursOfOperationsOutput {
        return list_child_hours_of_operations.execute(self, allocator, input, options);
    }

    /// Lists contact evaluations in the specified Amazon Connect instance.
    pub fn listContactEvaluations(self: *Self, allocator: std.mem.Allocator, input: list_contact_evaluations.ListContactEvaluationsInput, options: CallOptions) !list_contact_evaluations.ListContactEvaluationsOutput {
        return list_contact_evaluations.execute(self, allocator, input, options);
    }

    /// Lists all aliases associated with a contact flow module, showing their
    /// current version mappings and
    /// metadata.
    pub fn listContactFlowModuleAliases(self: *Self, allocator: std.mem.Allocator, input: list_contact_flow_module_aliases.ListContactFlowModuleAliasesInput, options: CallOptions) !list_contact_flow_module_aliases.ListContactFlowModuleAliasesOutput {
        return list_contact_flow_module_aliases.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of all versions for a specific contact flow
    /// module.
    pub fn listContactFlowModuleVersions(self: *Self, allocator: std.mem.Allocator, input: list_contact_flow_module_versions.ListContactFlowModuleVersionsInput, options: CallOptions) !list_contact_flow_module_versions.ListContactFlowModuleVersionsOutput {
        return list_contact_flow_module_versions.execute(self, allocator, input, options);
    }

    /// Provides information about the flow modules for the specified Amazon Connect
    /// instance.
    pub fn listContactFlowModules(self: *Self, allocator: std.mem.Allocator, input: list_contact_flow_modules.ListContactFlowModulesInput, options: CallOptions) !list_contact_flow_modules.ListContactFlowModulesOutput {
        return list_contact_flow_modules.execute(self, allocator, input, options);
    }

    /// Returns all the available versions for the specified Amazon Connect instance
    /// and flow identifier.
    pub fn listContactFlowVersions(self: *Self, allocator: std.mem.Allocator, input: list_contact_flow_versions.ListContactFlowVersionsInput, options: CallOptions) !list_contact_flow_versions.ListContactFlowVersionsOutput {
        return list_contact_flow_versions.execute(self, allocator, input, options);
    }

    /// Provides information about the flows for the specified Amazon Connect
    /// instance.
    ///
    /// You can also create and update flows using the [Amazon Connect
    /// Flow
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/flow-language.html).
    ///
    /// For more information about flows, see
    /// [Flows](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-contact-flows.html) in the *Amazon Connect
    /// Administrator Guide*.
    pub fn listContactFlows(self: *Self, allocator: std.mem.Allocator, input: list_contact_flows.ListContactFlowsInput, options: CallOptions) !list_contact_flows.ListContactFlowsOutput {
        return list_contact_flows.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// For the specified `referenceTypes`, returns a list of references associated
    /// with the contact.
    /// *References* are links to documents that are related to a contact, such as
    /// emails, attachments,
    /// or URLs.
    pub fn listContactReferences(self: *Self, allocator: std.mem.Allocator, input: list_contact_references.ListContactReferencesInput, options: CallOptions) !list_contact_references.ListContactReferencesOutput {
        return list_contact_references.execute(self, allocator, input, options);
    }

    /// Returns all attributes for a specified data table. A maximum of 100
    /// attributes per data table is allowed.
    /// Customers can request an increase by using Amazon Web Services Service
    /// Quotas. The response can be filtered by specific attribute IDs
    /// for CloudFormation integration.
    pub fn listDataTableAttributes(self: *Self, allocator: std.mem.Allocator, input: list_data_table_attributes.ListDataTableAttributesInput, options: CallOptions) !list_data_table_attributes.ListDataTableAttributesOutput {
        return list_data_table_attributes.execute(self, allocator, input, options);
    }

    /// Lists all primary value combinations for a given data table. Returns the
    /// unique combinations of primary
    /// attribute values that identify records in the table. Up to 100 records are
    /// returned per request.
    pub fn listDataTablePrimaryValues(self: *Self, allocator: std.mem.Allocator, input: list_data_table_primary_values.ListDataTablePrimaryValuesInput, options: CallOptions) !list_data_table_primary_values.ListDataTablePrimaryValuesOutput {
        return list_data_table_primary_values.execute(self, allocator, input, options);
    }

    /// Lists values stored in a data table with optional filtering by record IDs or
    /// primary attribute values. Returns
    /// the raw stored values along with metadata such as lock versions and
    /// modification timestamps.
    pub fn listDataTableValues(self: *Self, allocator: std.mem.Allocator, input: list_data_table_values.ListDataTableValuesInput, options: CallOptions) !list_data_table_values.ListDataTableValuesOutput {
        return list_data_table_values.execute(self, allocator, input, options);
    }

    /// Lists all data tables for the specified Amazon Connect instance. Returns
    /// summary information for each table
    /// including basic metadata and modification details.
    pub fn listDataTables(self: *Self, allocator: std.mem.Allocator, input: list_data_tables.ListDataTablesInput, options: CallOptions) !list_data_tables.ListDataTablesOutput {
        return list_data_tables.execute(self, allocator, input, options);
    }

    /// Lists the default vocabularies for the specified Amazon Connect instance.
    pub fn listDefaultVocabularies(self: *Self, allocator: std.mem.Allocator, input: list_default_vocabularies.ListDefaultVocabulariesInput, options: CallOptions) !list_default_vocabularies.ListDefaultVocabulariesOutput {
        return list_default_vocabularies.execute(self, allocator, input, options);
    }

    /// Lists all security profiles attached to a Q in Connect AIAgent Entity in an
    /// Amazon Connect instance.
    pub fn listEntitySecurityProfiles(self: *Self, allocator: std.mem.Allocator, input: list_entity_security_profiles.ListEntitySecurityProfilesInput, options: CallOptions) !list_entity_security_profiles.ListEntitySecurityProfilesOutput {
        return list_entity_security_profiles.execute(self, allocator, input, options);
    }

    /// Lists versions of an evaluation form in the specified Amazon Connect
    /// instance.
    pub fn listEvaluationFormVersions(self: *Self, allocator: std.mem.Allocator, input: list_evaluation_form_versions.ListEvaluationFormVersionsInput, options: CallOptions) !list_evaluation_form_versions.ListEvaluationFormVersionsOutput {
        return list_evaluation_form_versions.execute(self, allocator, input, options);
    }

    /// Lists evaluation forms in the specified Amazon Connect instance.
    pub fn listEvaluationForms(self: *Self, allocator: std.mem.Allocator, input: list_evaluation_forms.ListEvaluationFormsInput, options: CallOptions) !list_evaluation_forms.ListEvaluationFormsOutput {
        return list_evaluation_forms.execute(self, allocator, input, options);
    }

    /// List the flow association based on the filters.
    pub fn listFlowAssociations(self: *Self, allocator: std.mem.Allocator, input: list_flow_associations.ListFlowAssociationsInput, options: CallOptions) !list_flow_associations.ListFlowAssociationsOutput {
        return list_flow_associations.execute(self, allocator, input, options);
    }

    /// List the hours of operation overrides.
    pub fn listHoursOfOperationOverrides(self: *Self, allocator: std.mem.Allocator, input: list_hours_of_operation_overrides.ListHoursOfOperationOverridesInput, options: CallOptions) !list_hours_of_operation_overrides.ListHoursOfOperationOverridesOutput {
        return list_hours_of_operation_overrides.execute(self, allocator, input, options);
    }

    /// Provides information about the hours of operation for the specified Amazon
    /// Connect instance.
    ///
    /// For more information about hours of operation, see [Set the Hours of
    /// Operation for a
    /// Queue](https://docs.aws.amazon.com/connect/latest/adminguide/set-hours-operation.html) in the
    /// *Amazon Connect Administrator Guide*.
    pub fn listHoursOfOperations(self: *Self, allocator: std.mem.Allocator, input: list_hours_of_operations.ListHoursOfOperationsInput, options: CallOptions) !list_hours_of_operations.ListHoursOfOperationsOutput {
        return list_hours_of_operations.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Returns a paginated list of all attribute types for the given instance.
    pub fn listInstanceAttributes(self: *Self, allocator: std.mem.Allocator, input: list_instance_attributes.ListInstanceAttributesInput, options: CallOptions) !list_instance_attributes.ListInstanceAttributesOutput {
        return list_instance_attributes.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Returns a paginated list of storage configs for the identified instance and
    /// resource type.
    pub fn listInstanceStorageConfigs(self: *Self, allocator: std.mem.Allocator, input: list_instance_storage_configs.ListInstanceStorageConfigsInput, options: CallOptions) !list_instance_storage_configs.ListInstanceStorageConfigsOutput {
        return list_instance_storage_configs.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Return a list of instances which are in active state, creation-in-progress
    /// state, and failed state. Instances
    /// that aren't successfully created (they are in a failed state) are returned
    /// only for 24 hours after the CreateInstance
    /// API was invoked.
    pub fn listInstances(self: *Self, allocator: std.mem.Allocator, input: list_instances.ListInstancesInput, options: CallOptions) !list_instances.ListInstancesOutput {
        return list_instances.execute(self, allocator, input, options);
    }

    /// Provides summary information about the Amazon Web Services resource
    /// associations for the specified Amazon Connect instance.
    pub fn listIntegrationAssociations(self: *Self, allocator: std.mem.Allocator, input: list_integration_associations.ListIntegrationAssociationsInput, options: CallOptions) !list_integration_associations.ListIntegrationAssociationsOutput {
        return list_integration_associations.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Returns a paginated list of all Lambda functions that display in the
    /// dropdown options in the relevant flow
    /// blocks.
    pub fn listLambdaFunctions(self: *Self, allocator: std.mem.Allocator, input: list_lambda_functions.ListLambdaFunctionsInput, options: CallOptions) !list_lambda_functions.ListLambdaFunctionsOutput {
        return list_lambda_functions.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Returns a paginated list of all the Amazon Lex V1 bots currently associated
    /// with the instance. To return
    /// both Amazon Lex V1 and V2 bots, use the
    /// [ListBots](https://docs.aws.amazon.com/connect/latest/APIReference/API_ListBots.html) API.
    pub fn listLexBots(self: *Self, allocator: std.mem.Allocator, input: list_lex_bots.ListLexBotsInput, options: CallOptions) !list_lex_bots.ListLexBotsOutput {
        return list_lex_bots.execute(self, allocator, input, options);
    }

    /// Provides information about the phone numbers for the specified Amazon
    /// Connect instance.
    ///
    /// For more information about phone numbers, see [Set Up Phone Numbers for Your
    /// Contact
    /// Center](https://docs.aws.amazon.com/connect/latest/adminguide/contact-center-phone-number.html) in the *Amazon Connect Administrator Guide*.
    ///
    /// * We recommend using
    ///   [ListPhoneNumbersV2](https://docs.aws.amazon.com/connect/latest/APIReference/API_ListPhoneNumbersV2.html) to return phone number types. ListPhoneNumbers doesn't support number types
    /// `UIFN`, `SHARED`, `THIRD_PARTY_TF`, and `THIRD_PARTY_DID`. While it
    /// returns numbers of those types, it incorrectly lists them as `TOLL_FREE` or
    /// `DID`.
    ///
    /// * The phone number `Arn` value that is returned from each of the items in
    ///   the
    ///   [PhoneNumberSummaryList](https://docs.aws.amazon.com/connect/latest/APIReference/API_ListPhoneNumbers.html#connect-ListPhoneNumbers-response-PhoneNumberSummaryList) cannot be used to tag phone number resources. It will fail with a
    /// `ResourceNotFoundException`. Instead, use the
    /// [ListPhoneNumbersV2](https://docs.aws.amazon.com/connect/latest/APIReference/API_ListPhoneNumbersV2.html) API. It returns the new
    /// phone number ARN that can be used to tag phone number resources.
    pub fn listPhoneNumbers(self: *Self, allocator: std.mem.Allocator, input: list_phone_numbers.ListPhoneNumbersInput, options: CallOptions) !list_phone_numbers.ListPhoneNumbersOutput {
        return list_phone_numbers.execute(self, allocator, input, options);
    }

    /// Lists phone numbers claimed to your Amazon Connect instance or traffic
    /// distribution group. If the provided `TargetArn`
    /// is a traffic distribution group, you can call this API in both Amazon Web
    /// Services Regions associated with traffic distribution group.
    ///
    /// For more information about phone numbers, see [Set Up Phone Numbers for Your
    /// Contact
    /// Center](https://docs.aws.amazon.com/connect/latest/adminguide/contact-center-phone-number.html) in the *Amazon Connect Administrator Guide*.
    ///
    /// * When given an instance ARN, `ListPhoneNumbersV2` returns only the phone
    ///   numbers claimed to the
    /// instance.
    ///
    /// * When given a traffic distribution group ARN `ListPhoneNumbersV2` returns
    ///   only the phone numbers claimed to the
    /// traffic distribution group.
    pub fn listPhoneNumbersV2(self: *Self, allocator: std.mem.Allocator, input: list_phone_numbers_v2.ListPhoneNumbersV2Input, options: CallOptions) !list_phone_numbers_v2.ListPhoneNumbersV2Output {
        return list_phone_numbers_v2.execute(self, allocator, input, options);
    }

    /// Lists predefined attributes for the specified Amazon Connect instance. A
    /// *predefined attribute* is
    /// made up of a name and a value. You can use predefined attributes for:
    ///
    /// * Routing proficiency (for example, agent certification) that has predefined
    ///   values (for example, a list of
    /// possible certifications). For more information, see [Create predefined
    /// attributes for routing contacts to
    /// agents](https://docs.aws.amazon.com/connect/latest/adminguide/predefined-attributes.html).
    ///
    /// * Contact information that varies between transfers or conferences, such as
    ///   the name of the business unit
    /// handling the contact. For more information, see [Use contact segment
    /// attributes](https://docs.aws.amazon.com/connect/latest/adminguide/use-contact-segment-attributes.html).
    ///
    /// For the predefined attributes per instance quota, see [Amazon Connect
    /// quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#connect-quotas).
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn listPredefinedAttributes(self: *Self, allocator: std.mem.Allocator, input: list_predefined_attributes.ListPredefinedAttributesInput, options: CallOptions) !list_predefined_attributes.ListPredefinedAttributesOutput {
        return list_predefined_attributes.execute(self, allocator, input, options);
    }

    /// Provides information about the prompts for the specified Amazon Connect
    /// instance.
    pub fn listPrompts(self: *Self, allocator: std.mem.Allocator, input: list_prompts.ListPromptsInput, options: CallOptions) !list_prompts.ListPromptsOutput {
        return list_prompts.execute(self, allocator, input, options);
    }

    /// Lists the quick connects associated with a queue.
    pub fn listQueueQuickConnects(self: *Self, allocator: std.mem.Allocator, input: list_queue_quick_connects.ListQueueQuickConnectsInput, options: CallOptions) !list_queue_quick_connects.ListQueueQuickConnectsOutput {
        return list_queue_quick_connects.execute(self, allocator, input, options);
    }

    /// Provides information about the queues for the specified Amazon Connect
    /// instance.
    ///
    /// If you do not specify a `QueueTypes` parameter, both standard and
    /// agent queues are returned. This might cause an unexpected truncation of
    /// results if you have more than 1000 agents and
    /// you limit the number of results of the API call in code.
    ///
    /// For more information about queues, see [Queues: Standard and
    /// Agent](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-queues-standard-and-agent.html) in the
    /// *Amazon Connect Administrator Guide*.
    pub fn listQueues(self: *Self, allocator: std.mem.Allocator, input: list_queues.ListQueuesInput, options: CallOptions) !list_queues.ListQueuesOutput {
        return list_queues.execute(self, allocator, input, options);
    }

    /// Provides information about the quick connects for the specified Amazon
    /// Connect instance.
    pub fn listQuickConnects(self: *Self, allocator: std.mem.Allocator, input: list_quick_connects.ListQuickConnectsInput, options: CallOptions) !list_quick_connects.ListQuickConnectsOutput {
        return list_quick_connects.execute(self, allocator, input, options);
    }

    /// Provides a list of analysis segments for a real-time chat analysis session.
    /// This API supports CHAT channels
    /// only.
    ///
    /// This API does not support VOICE. If you attempt to use it for VOICE, an
    /// `InvalidRequestException`
    /// occurs.
    pub fn listRealtimeContactAnalysisSegmentsV2(self: *Self, allocator: std.mem.Allocator, input: list_realtime_contact_analysis_segments_v2.ListRealtimeContactAnalysisSegmentsV2Input, options: CallOptions) !list_realtime_contact_analysis_segments_v2.ListRealtimeContactAnalysisSegmentsV2Output {
        return list_realtime_contact_analysis_segments_v2.execute(self, allocator, input, options);
    }

    /// Lists the manual assignment queues associated with a routing profile.
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * This API returns list of queues where contacts can be manually assigned or
    ///   picked by an agent who has access
    /// to the Worklist app. The user can additionally filter on queues, if they
    /// have access to those queues (otherwise a
    /// invalid request exception will be thrown).
    ///
    /// For information about how manual contact assignment works in the agent
    /// workspace, see the [Access the Worklist app in the Amazon Connect agent
    /// workspace](https://docs.aws.amazon.com/connect/latest/adminguide/worklist-app.html) in the *Amazon Connect Administrator Guide*.
    ///
    /// **Important things to know**
    ///
    /// * This API only returns the manual assignment queues associated with a
    ///   routing profile. Use the
    /// ListRoutingProfileQueues API to list the auto assignment queues for the
    /// routing profile.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn listRoutingProfileManualAssignmentQueues(self: *Self, allocator: std.mem.Allocator, input: list_routing_profile_manual_assignment_queues.ListRoutingProfileManualAssignmentQueuesInput, options: CallOptions) !list_routing_profile_manual_assignment_queues.ListRoutingProfileManualAssignmentQueuesOutput {
        return list_routing_profile_manual_assignment_queues.execute(self, allocator, input, options);
    }

    /// Lists the queues associated with a routing profile.
    pub fn listRoutingProfileQueues(self: *Self, allocator: std.mem.Allocator, input: list_routing_profile_queues.ListRoutingProfileQueuesInput, options: CallOptions) !list_routing_profile_queues.ListRoutingProfileQueuesOutput {
        return list_routing_profile_queues.execute(self, allocator, input, options);
    }

    /// Provides summary information about the routing profiles for the specified
    /// Amazon Connect instance.
    ///
    /// For more information about routing profiles, see [Routing
    /// Profiles](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-routing.html) and [Create a Routing Profile](https://docs.aws.amazon.com/connect/latest/adminguide/routing-profiles.html) in the *Amazon Connect Administrator Guide*.
    pub fn listRoutingProfiles(self: *Self, allocator: std.mem.Allocator, input: list_routing_profiles.ListRoutingProfilesInput, options: CallOptions) !list_routing_profiles.ListRoutingProfilesOutput {
        return list_routing_profiles.execute(self, allocator, input, options);
    }

    /// List all rules for the specified Amazon Connect instance.
    pub fn listRules(self: *Self, allocator: std.mem.Allocator, input: list_rules.ListRulesInput, options: CallOptions) !list_rules.ListRulesOutput {
        return list_rules.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Returns a paginated list of all security keys associated with the instance.
    pub fn listSecurityKeys(self: *Self, allocator: std.mem.Allocator, input: list_security_keys.ListSecurityKeysInput, options: CallOptions) !list_security_keys.ListSecurityKeysOutput {
        return list_security_keys.execute(self, allocator, input, options);
    }

    /// Returns a list of third-party applications or MCP Servers in a specific
    /// security profile.
    pub fn listSecurityProfileApplications(self: *Self, allocator: std.mem.Allocator, input: list_security_profile_applications.ListSecurityProfileApplicationsInput, options: CallOptions) !list_security_profile_applications.ListSecurityProfileApplicationsOutput {
        return list_security_profile_applications.execute(self, allocator, input, options);
    }

    /// A list of Flow Modules an AI Agent can invoke as a tool
    pub fn listSecurityProfileFlowModules(self: *Self, allocator: std.mem.Allocator, input: list_security_profile_flow_modules.ListSecurityProfileFlowModulesInput, options: CallOptions) !list_security_profile_flow_modules.ListSecurityProfileFlowModulesOutput {
        return list_security_profile_flow_modules.execute(self, allocator, input, options);
    }

    /// Lists the permissions granted to a security profile.
    ///
    /// For information about security profiles, see [Security
    /// Profiles](https://docs.aws.amazon.com/connect/latest/adminguide/connect-security-profiles.html) in the *Amazon Connect Administrator Guide*. For a mapping of the API name and user interface name of the security
    /// profile permissions, see [List
    /// of security profile
    /// permissions](https://docs.aws.amazon.com/connect/latest/adminguide/security-profile-list.html).
    pub fn listSecurityProfilePermissions(self: *Self, allocator: std.mem.Allocator, input: list_security_profile_permissions.ListSecurityProfilePermissionsInput, options: CallOptions) !list_security_profile_permissions.ListSecurityProfilePermissionsOutput {
        return list_security_profile_permissions.execute(self, allocator, input, options);
    }

    /// Provides summary information about the security profiles for the specified
    /// Amazon Connect instance.
    ///
    /// For more information about security profiles, see [Security
    /// Profiles](https://docs.aws.amazon.com/connect/latest/adminguide/connect-security-profiles.html) in the *Amazon Connect Administrator Guide*. For a mapping of the API name and user interface name of the security
    /// profile permissions, see [List
    /// of security profile
    /// permissions](https://docs.aws.amazon.com/connect/latest/adminguide/security-profile-list.html).
    pub fn listSecurityProfiles(self: *Self, allocator: std.mem.Allocator, input: list_security_profiles.ListSecurityProfilesInput, options: CallOptions) !list_security_profiles.ListSecurityProfilesOutput {
        return list_security_profiles.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    ///
    /// For sample policies that use tags, see [Amazon Connect Identity-Based Policy
    /// Examples](https://docs.aws.amazon.com/connect/latest/adminguide/security_iam_id-based-policy-examples.html) in the *Amazon Connect Administrator Guide*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists task templates for the specified Amazon Connect instance.
    pub fn listTaskTemplates(self: *Self, allocator: std.mem.Allocator, input: list_task_templates.ListTaskTemplatesInput, options: CallOptions) !list_task_templates.ListTaskTemplatesOutput {
        return list_task_templates.execute(self, allocator, input, options);
    }

    /// Lists detailed steps of test case execution that includes all observations
    /// along with actions taken and data associated in the specified Amazon Connect
    /// instance.
    pub fn listTestCaseExecutionRecords(self: *Self, allocator: std.mem.Allocator, input: list_test_case_execution_records.ListTestCaseExecutionRecordsInput, options: CallOptions) !list_test_case_execution_records.ListTestCaseExecutionRecordsOutput {
        return list_test_case_execution_records.execute(self, allocator, input, options);
    }

    /// Lists all test case executions and allows filtering by test case id, test
    /// case name, start time, end time or status of the execution for the specified
    /// Amazon Connect instance.
    pub fn listTestCaseExecutions(self: *Self, allocator: std.mem.Allocator, input: list_test_case_executions.ListTestCaseExecutionsInput, options: CallOptions) !list_test_case_executions.ListTestCaseExecutionsOutput {
        return list_test_case_executions.execute(self, allocator, input, options);
    }

    /// Lists the test cases present in the specific Amazon Connect instance.
    pub fn listTestCases(self: *Self, allocator: std.mem.Allocator, input: list_test_cases.ListTestCasesInput, options: CallOptions) !list_test_cases.ListTestCasesOutput {
        return list_test_cases.execute(self, allocator, input, options);
    }

    /// Lists traffic distribution group users.
    pub fn listTrafficDistributionGroupUsers(self: *Self, allocator: std.mem.Allocator, input: list_traffic_distribution_group_users.ListTrafficDistributionGroupUsersInput, options: CallOptions) !list_traffic_distribution_group_users.ListTrafficDistributionGroupUsersOutput {
        return list_traffic_distribution_group_users.execute(self, allocator, input, options);
    }

    /// Lists traffic distribution groups.
    pub fn listTrafficDistributionGroups(self: *Self, allocator: std.mem.Allocator, input: list_traffic_distribution_groups.ListTrafficDistributionGroupsInput, options: CallOptions) !list_traffic_distribution_groups.ListTrafficDistributionGroupsOutput {
        return list_traffic_distribution_groups.execute(self, allocator, input, options);
    }

    /// Lists the use cases for the integration association.
    pub fn listUseCases(self: *Self, allocator: std.mem.Allocator, input: list_use_cases.ListUseCasesInput, options: CallOptions) !list_use_cases.ListUseCasesOutput {
        return list_use_cases.execute(self, allocator, input, options);
    }

    /// Provides summary information about the hierarchy groups for the specified
    /// Amazon Connect instance.
    ///
    /// For more information about agent hierarchies, see [Set Up Agent
    /// Hierarchies](https://docs.aws.amazon.com/connect/latest/adminguide/agent-hierarchy.html) in the *Amazon Connect Administrator Guide*.
    pub fn listUserHierarchyGroups(self: *Self, allocator: std.mem.Allocator, input: list_user_hierarchy_groups.ListUserHierarchyGroupsInput, options: CallOptions) !list_user_hierarchy_groups.ListUserHierarchyGroupsOutput {
        return list_user_hierarchy_groups.execute(self, allocator, input, options);
    }

    /// Lists proficiencies associated with a user.
    pub fn listUserProficiencies(self: *Self, allocator: std.mem.Allocator, input: list_user_proficiencies.ListUserProficienciesInput, options: CallOptions) !list_user_proficiencies.ListUserProficienciesOutput {
        return list_user_proficiencies.execute(self, allocator, input, options);
    }

    /// Provides summary information about the users for the specified Amazon
    /// Connect instance.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: CallOptions) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Returns all the available versions for the specified Amazon Connect instance
    /// and view identifier.
    ///
    /// Results will be sorted from highest to lowest.
    pub fn listViewVersions(self: *Self, allocator: std.mem.Allocator, input: list_view_versions.ListViewVersionsInput, options: CallOptions) !list_view_versions.ListViewVersionsOutput {
        return list_view_versions.execute(self, allocator, input, options);
    }

    /// Returns views in the given instance.
    ///
    /// Results are sorted primarily by type, and secondarily by name.
    pub fn listViews(self: *Self, allocator: std.mem.Allocator, input: list_views.ListViewsInput, options: CallOptions) !list_views.ListViewsOutput {
        return list_views.execute(self, allocator, input, options);
    }

    /// Lists media assets (such as logos) associated with a workspace.
    pub fn listWorkspaceMedia(self: *Self, allocator: std.mem.Allocator, input: list_workspace_media.ListWorkspaceMediaInput, options: CallOptions) !list_workspace_media.ListWorkspaceMediaOutput {
        return list_workspace_media.execute(self, allocator, input, options);
    }

    /// Lists the page configurations in a workspace, including the views assigned
    /// to each page.
    pub fn listWorkspacePages(self: *Self, allocator: std.mem.Allocator, input: list_workspace_pages.ListWorkspacePagesInput, options: CallOptions) !list_workspace_pages.ListWorkspacePagesOutput {
        return list_workspace_pages.execute(self, allocator, input, options);
    }

    /// Lists the workspaces in an Amazon Connect instance.
    pub fn listWorkspaces(self: *Self, allocator: std.mem.Allocator, input: list_workspaces.ListWorkspacesInput, options: CallOptions) !list_workspaces.ListWorkspacesOutput {
        return list_workspaces.execute(self, allocator, input, options);
    }

    /// Initiates silent monitoring of a contact. The Contact Control Panel (CCP) of
    /// the user specified by
    /// *userId* will be set to silent monitoring mode on the contact.
    pub fn monitorContact(self: *Self, allocator: std.mem.Allocator, input: monitor_contact.MonitorContactInput, options: CallOptions) !monitor_contact.MonitorContactOutput {
        return monitor_contact.execute(self, allocator, input, options);
    }

    /// Allows pausing an ongoing task contact.
    pub fn pauseContact(self: *Self, allocator: std.mem.Allocator, input: pause_contact.PauseContactInput, options: CallOptions) !pause_contact.PauseContactOutput {
        return pause_contact.execute(self, allocator, input, options);
    }

    /// Changes the current status of a user or agent in Amazon Connect. If the
    /// agent is currently handling a
    /// contact, this sets the agent's next status.
    ///
    /// For more information, see [Agent
    /// status](https://docs.aws.amazon.com/connect/latest/adminguide/metrics-agent-status.html) and [Set your
    /// next
    /// status](https://docs.aws.amazon.com/connect/latest/adminguide/set-next-status.html) in the *Amazon Connect Administrator Guide*.
    pub fn putUserStatus(self: *Self, allocator: std.mem.Allocator, input: put_user_status.PutUserStatusInput, options: CallOptions) !put_user_status.PutUserStatusOutput {
        return put_user_status.execute(self, allocator, input, options);
    }

    /// Releases a phone number previously claimed to an Amazon Connect instance or
    /// traffic distribution group. You can call this API
    /// only in the Amazon Web Services Region where the number was claimed.
    ///
    /// To release phone numbers from a traffic distribution group, use the
    /// `ReleasePhoneNumber` API, not the Amazon Connect admin website.
    ///
    /// After releasing a phone number, the phone number enters into a cooldown
    /// period for up to 180 days. It cannot be
    /// searched for or claimed again until the period has ended. If you
    /// accidentally release a phone number, contact
    /// Amazon Web Services Support.
    ///
    /// If you plan to claim and release numbers frequently,
    /// contact us for a service quota exception. Otherwise, it is possible you will
    /// be blocked from
    /// claiming and releasing any more numbers until up to 180 days past the oldest
    /// number
    /// released has expired.
    ///
    /// By default you can claim and release up to 200% of your maximum number of
    /// active
    /// phone numbers. If you claim and release phone numbers using
    /// the UI or API during a rolling 180 day cycle that exceeds 200% of your phone
    /// number
    /// service level quota, you will be blocked from claiming any more numbers
    /// until 180
    /// days past the oldest number released has expired.
    ///
    /// For example, if you already have 99 claimed numbers and a service level
    /// quota of 99 phone numbers, and in any 180
    /// day period you release 99, claim 99, and then release 99, you will have
    /// exceeded the
    /// 200% limit. At that point you are blocked from claiming any more numbers
    /// until you
    /// open an Amazon Web Services support ticket.
    pub fn releasePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: release_phone_number.ReleasePhoneNumberInput, options: CallOptions) !release_phone_number.ReleasePhoneNumberOutput {
        return release_phone_number.execute(self, allocator, input, options);
    }

    /// Replicates an Amazon Connect instance in the specified Amazon Web Services
    /// Region and copies configuration
    /// information for Amazon Connect resources across Amazon Web Services Regions.
    ///
    /// For more information about replicating an Amazon Connect instance, see
    /// [Create a replica of your existing Amazon Connect
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/create-replica-connect-instance.html) in the *Amazon Connect Administrator Guide*.
    pub fn replicateInstance(self: *Self, allocator: std.mem.Allocator, input: replicate_instance.ReplicateInstanceInput, options: CallOptions) !replicate_instance.ReplicateInstanceOutput {
        return replicate_instance.execute(self, allocator, input, options);
    }

    /// Allows resuming a task contact in a paused state.
    pub fn resumeContact(self: *Self, allocator: std.mem.Allocator, input: resume_contact.ResumeContactInput, options: CallOptions) !resume_contact.ResumeContactOutput {
        return resume_contact.execute(self, allocator, input, options);
    }

    /// When a contact is being recorded, and the recording has been suspended using
    /// SuspendContactRecording, this API
    /// resumes recording whatever recording is selected in the flow configuration:
    /// call, screen, or both. If only call
    /// recording or only screen recording is enabled, then it would resume.
    ///
    /// Voice and screen recordings are supported.
    pub fn resumeContactRecording(self: *Self, allocator: std.mem.Allocator, input: resume_contact_recording.ResumeContactRecordingInput, options: CallOptions) !resume_contact_recording.ResumeContactRecordingOutput {
        return resume_contact_recording.execute(self, allocator, input, options);
    }

    /// Searches AgentStatuses in an Amazon Connect instance, with optional
    /// filtering.
    pub fn searchAgentStatuses(self: *Self, allocator: std.mem.Allocator, input: search_agent_statuses.SearchAgentStatusesInput, options: CallOptions) !search_agent_statuses.SearchAgentStatusesOutput {
        return search_agent_statuses.execute(self, allocator, input, options);
    }

    /// Searches for available phone numbers that you can claim to your Amazon
    /// Connect instance or traffic distribution group. If the
    /// provided `TargetArn` is a traffic distribution group, you can call this API
    /// in both Amazon Web Services Regions associated with
    /// the traffic distribution group.
    pub fn searchAvailablePhoneNumbers(self: *Self, allocator: std.mem.Allocator, input: search_available_phone_numbers.SearchAvailablePhoneNumbersInput, options: CallOptions) !search_available_phone_numbers.SearchAvailablePhoneNumbersOutput {
        return search_available_phone_numbers.execute(self, allocator, input, options);
    }

    /// Searches contact evaluations in an Amazon Connect instance, with optional
    /// filtering.
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * Find contact evaluations by using specific search criteria.
    ///
    /// * Find contact evaluations that are tagged with a specific set of tags.
    ///
    /// **Important things to know**
    ///
    /// * A Search operation, unlike a List operation, takes time to index changes
    ///   to resource (create, update or
    /// delete). If you don't see updated information for recently changed contact
    /// evaluations, try calling the API again
    /// in a few seconds. Contact Evaluations may not be fully backfilled with
    /// historical data in all regions yet, however
    /// all recently created Contact Evaluations should be available for search.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn searchContactEvaluations(self: *Self, allocator: std.mem.Allocator, input: search_contact_evaluations.SearchContactEvaluationsInput, options: CallOptions) !search_contact_evaluations.SearchContactEvaluationsOutput {
        return search_contact_evaluations.execute(self, allocator, input, options);
    }

    /// Searches the flow modules in an Amazon Connect instance, with optional
    /// filtering.
    pub fn searchContactFlowModules(self: *Self, allocator: std.mem.Allocator, input: search_contact_flow_modules.SearchContactFlowModulesInput, options: CallOptions) !search_contact_flow_modules.SearchContactFlowModulesOutput {
        return search_contact_flow_modules.execute(self, allocator, input, options);
    }

    /// Searches the flows in an Amazon Connect instance, with optional filtering.
    pub fn searchContactFlows(self: *Self, allocator: std.mem.Allocator, input: search_contact_flows.SearchContactFlowsInput, options: CallOptions) !search_contact_flows.SearchContactFlowsOutput {
        return search_contact_flows.execute(self, allocator, input, options);
    }

    /// Searches contacts in an Amazon Connect instance.
    pub fn searchContacts(self: *Self, allocator: std.mem.Allocator, input: search_contacts.SearchContactsInput, options: CallOptions) !search_contacts.SearchContactsOutput {
        return search_contacts.execute(self, allocator, input, options);
    }

    /// Searches for data tables based on the table's ID, name, and description. In
    /// the future, this operation can
    /// support searching on attribute names and possibly primary values. Follows
    /// other search operations closely and
    /// supports both search criteria and filters.
    pub fn searchDataTables(self: *Self, allocator: std.mem.Allocator, input: search_data_tables.SearchDataTablesInput, options: CallOptions) !search_data_tables.SearchDataTablesOutput {
        return search_data_tables.execute(self, allocator, input, options);
    }

    /// Searches email address in an instance, with optional filtering.
    pub fn searchEmailAddresses(self: *Self, allocator: std.mem.Allocator, input: search_email_addresses.SearchEmailAddressesInput, options: CallOptions) !search_email_addresses.SearchEmailAddressesOutput {
        return search_email_addresses.execute(self, allocator, input, options);
    }

    /// Searches evaluation forms in an Amazon Connect instance, with optional
    /// filtering.
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * List all evaluation forms in an instance.
    ///
    /// * Find all evaluation forms that meet specific criteria, such as Title,
    ///   Description, Status, and more.
    ///
    /// * Find all evaluation forms that are tagged with a specific set of tags.
    ///
    /// **Important things to know**
    ///
    /// * A Search operation, unlike a List operation, takes time to index changes
    ///   to resource (create, update or
    /// delete). If you don't see updated information for recently changed contact
    /// evaluations, try calling the API again
    /// in a few seconds.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn searchEvaluationForms(self: *Self, allocator: std.mem.Allocator, input: search_evaluation_forms.SearchEvaluationFormsInput, options: CallOptions) !search_evaluation_forms.SearchEvaluationFormsOutput {
        return search_evaluation_forms.execute(self, allocator, input, options);
    }

    /// Searches the hours of operation overrides.
    pub fn searchHoursOfOperationOverrides(self: *Self, allocator: std.mem.Allocator, input: search_hours_of_operation_overrides.SearchHoursOfOperationOverridesInput, options: CallOptions) !search_hours_of_operation_overrides.SearchHoursOfOperationOverridesOutput {
        return search_hours_of_operation_overrides.execute(self, allocator, input, options);
    }

    /// Searches the hours of operation in an Amazon Connect instance, with optional
    /// filtering.
    pub fn searchHoursOfOperations(self: *Self, allocator: std.mem.Allocator, input: search_hours_of_operations.SearchHoursOfOperationsInput, options: CallOptions) !search_hours_of_operations.SearchHoursOfOperationsOutput {
        return search_hours_of_operations.execute(self, allocator, input, options);
    }

    /// Searches predefined attributes that meet certain criteria. A *predefined
    /// attribute* is made
    /// up of a name and a value. You can use predefined attributes for:
    ///
    /// * Routing proficiency (for example, agent certification) that has predefined
    ///   values (for example, a list of
    /// possible certifications). For more information, see [Create predefined
    /// attributes for routing contacts to
    /// agents](https://docs.aws.amazon.com/connect/latest/adminguide/predefined-attributes.html).
    ///
    /// * Contact information that varies between transfers or conferences, such as
    ///   the name of the business unit
    /// handling the contact. For more information, see [Use contact segment
    /// attributes](https://docs.aws.amazon.com/connect/latest/adminguide/use-contact-segment-attributes.html).
    ///
    /// For the predefined attributes per instance quota, see [Amazon Connect
    /// quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#connect-quotas).
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn searchPredefinedAttributes(self: *Self, allocator: std.mem.Allocator, input: search_predefined_attributes.SearchPredefinedAttributesInput, options: CallOptions) !search_predefined_attributes.SearchPredefinedAttributesOutput {
        return search_predefined_attributes.execute(self, allocator, input, options);
    }

    /// Searches prompts in an Amazon Connect instance, with optional filtering.
    pub fn searchPrompts(self: *Self, allocator: std.mem.Allocator, input: search_prompts.SearchPromptsInput, options: CallOptions) !search_prompts.SearchPromptsOutput {
        return search_prompts.execute(self, allocator, input, options);
    }

    /// Searches queues in an Amazon Connect instance, with optional filtering.
    pub fn searchQueues(self: *Self, allocator: std.mem.Allocator, input: search_queues.SearchQueuesInput, options: CallOptions) !search_queues.SearchQueuesOutput {
        return search_queues.execute(self, allocator, input, options);
    }

    /// Searches quick connects in an Amazon Connect instance, with optional
    /// filtering.
    pub fn searchQuickConnects(self: *Self, allocator: std.mem.Allocator, input: search_quick_connects.SearchQuickConnectsInput, options: CallOptions) !search_quick_connects.SearchQuickConnectsOutput {
        return search_quick_connects.execute(self, allocator, input, options);
    }

    /// Searches tags used in an Amazon Connect instance using optional search
    /// criteria.
    pub fn searchResourceTags(self: *Self, allocator: std.mem.Allocator, input: search_resource_tags.SearchResourceTagsInput, options: CallOptions) !search_resource_tags.SearchResourceTagsOutput {
        return search_resource_tags.execute(self, allocator, input, options);
    }

    /// Searches routing profiles in an Amazon Connect instance, with optional
    /// filtering.
    ///
    /// `SearchRoutingProfiles` does not populate LastModifiedRegion,
    /// LastModifiedTime,
    /// MediaConcurrencies.CrossChannelBehavior, and AgentAvailabilityTimer in its
    /// response, but
    /// [DescribeRoutingProfile](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeRoutingProfile.html) does.
    pub fn searchRoutingProfiles(self: *Self, allocator: std.mem.Allocator, input: search_routing_profiles.SearchRoutingProfilesInput, options: CallOptions) !search_routing_profiles.SearchRoutingProfilesOutput {
        return search_routing_profiles.execute(self, allocator, input, options);
    }

    /// Searches security profiles in an Amazon Connect instance, with optional
    /// filtering.
    ///
    /// For information about security profiles, see [Security
    /// Profiles](https://docs.aws.amazon.com/connect/latest/adminguide/connect-security-profiles.html) in the *Amazon Connect Administrator Guide*. For a mapping of the API name and user interface name of the security
    /// profile permissions, see [List
    /// of security profile
    /// permissions](https://docs.aws.amazon.com/connect/latest/adminguide/security-profile-list.html).
    pub fn searchSecurityProfiles(self: *Self, allocator: std.mem.Allocator, input: search_security_profiles.SearchSecurityProfilesInput, options: CallOptions) !search_security_profiles.SearchSecurityProfilesOutput {
        return search_security_profiles.execute(self, allocator, input, options);
    }

    /// Searches for test cases in the specified Amazon Connect instance, with
    /// optional filtering.
    pub fn searchTestCases(self: *Self, allocator: std.mem.Allocator, input: search_test_cases.SearchTestCasesInput, options: CallOptions) !search_test_cases.SearchTestCasesOutput {
        return search_test_cases.execute(self, allocator, input, options);
    }

    /// Searches UserHierarchyGroups in an Amazon Connect instance, with optional
    /// filtering.
    ///
    /// The UserHierarchyGroup with `"LevelId": "0"` is the foundation for building
    /// levels on top of an
    /// instance. It is not user-definable, nor is it visible in the UI.
    pub fn searchUserHierarchyGroups(self: *Self, allocator: std.mem.Allocator, input: search_user_hierarchy_groups.SearchUserHierarchyGroupsInput, options: CallOptions) !search_user_hierarchy_groups.SearchUserHierarchyGroupsOutput {
        return search_user_hierarchy_groups.execute(self, allocator, input, options);
    }

    /// Searches users in an Amazon Connect instance, with optional filtering.
    ///
    /// `AfterContactWorkTimeLimit` is returned in milliseconds.
    pub fn searchUsers(self: *Self, allocator: std.mem.Allocator, input: search_users.SearchUsersInput, options: CallOptions) !search_users.SearchUsersOutput {
        return search_users.execute(self, allocator, input, options);
    }

    /// Searches views based on name, description, or tags.
    pub fn searchViews(self: *Self, allocator: std.mem.Allocator, input: search_views.SearchViewsInput, options: CallOptions) !search_views.SearchViewsOutput {
        return search_views.execute(self, allocator, input, options);
    }

    /// Searches for vocabularies within a specific Amazon Connect instance using
    /// `State`,
    /// `NameStartsWith`, and `LanguageCode`.
    pub fn searchVocabularies(self: *Self, allocator: std.mem.Allocator, input: search_vocabularies.SearchVocabulariesInput, options: CallOptions) !search_vocabularies.SearchVocabulariesOutput {
        return search_vocabularies.execute(self, allocator, input, options);
    }

    /// Searches for workspace associations with users or routing profiles based on
    /// various criteria.
    pub fn searchWorkspaceAssociations(self: *Self, allocator: std.mem.Allocator, input: search_workspace_associations.SearchWorkspaceAssociationsInput, options: CallOptions) !search_workspace_associations.SearchWorkspaceAssociationsOutput {
        return search_workspace_associations.execute(self, allocator, input, options);
    }

    /// Searches workspaces based on name, description, visibility, or tags.
    pub fn searchWorkspaces(self: *Self, allocator: std.mem.Allocator, input: search_workspaces.SearchWorkspacesInput, options: CallOptions) !search_workspaces.SearchWorkspacesOutput {
        return search_workspaces.execute(self, allocator, input, options);
    }

    /// Processes chat integration events from Amazon Web Services or external
    /// integrations to Amazon Connect. A chat
    /// integration event includes:
    ///
    /// * SourceId, DestinationId, and Subtype: a set of identifiers, uniquely
    ///   representing a chat
    ///
    /// * ChatEvent: details of the chat action to perform such as sending a
    ///   message, event, or disconnecting from a
    /// chat
    ///
    /// When a chat integration event is sent with chat identifiers that do not map
    /// to an active chat contact, a new
    /// chat contact is also created before handling chat action.
    ///
    /// Access to this API is currently restricted to Amazon Web Services End User
    /// Messaging for supporting SMS
    /// integration.
    pub fn sendChatIntegrationEvent(self: *Self, allocator: std.mem.Allocator, input: send_chat_integration_event.SendChatIntegrationEventInput, options: CallOptions) !send_chat_integration_event.SendChatIntegrationEventOutput {
        return send_chat_integration_event.execute(self, allocator, input, options);
    }

    /// Send outbound email for outbound campaigns. For more information about
    /// outbound campaigns, see [Set up Amazon Connect
    /// outbound
    /// campaigns](https://docs.aws.amazon.com/connect/latest/adminguide/enable-outbound-campaigns.html).
    ///
    /// Only the Amazon Connect outbound campaigns service principal is allowed to
    /// assume a role in your account
    /// and call this API.
    pub fn sendOutboundEmail(self: *Self, allocator: std.mem.Allocator, input: send_outbound_email.SendOutboundEmailInput, options: CallOptions) !send_outbound_email.SendOutboundEmailOutput {
        return send_outbound_email.execute(self, allocator, input, options);
    }

    /// Provides a pre-signed Amazon S3 URL in response for uploading your content.
    ///
    /// You may only use this API to upload attachments to an [Amazon Connect
    /// Case](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_CreateCase.html) or [Amazon Connect Email](https://docs.aws.amazon.com/connect/latest/adminguide/setup-email-channel.html).
    pub fn startAttachedFileUpload(self: *Self, allocator: std.mem.Allocator, input: start_attached_file_upload.StartAttachedFileUploadInput, options: CallOptions) !start_attached_file_upload.StartAttachedFileUploadOutput {
        return start_attached_file_upload.execute(self, allocator, input, options);
    }

    /// Initiates a flow to start a new chat for the customer. Response of this API
    /// provides a token required to obtain
    /// credentials from the
    /// [CreateParticipantConnection](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_CreateParticipantConnection.html) API in the Amazon Connect Participant Service.
    ///
    /// When a new chat contact is successfully created, clients must subscribe to
    /// the participant’s connection for the
    /// created chat within 5 minutes. This is achieved by invoking
    /// [CreateParticipantConnection](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_CreateParticipantConnection.html) with WEBSOCKET and CONNECTION_CREDENTIALS.
    ///
    /// A 429 error occurs in the following situations:
    ///
    /// * API rate limit is exceeded. API TPS throttling returns a `TooManyRequests`
    ///   exception.
    ///
    /// * The [quota for
    /// concurrent active
    /// chats](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html) is exceeded. Active chat throttling returns a
    /// `LimitExceededException`.
    ///
    /// If you use the `ChatDurationInMinutes` parameter and receive a 400 error,
    /// your account may not
    /// support the ability to configure custom chat durations. For more
    /// information, contact Amazon Web Services Support.
    ///
    /// For more information about chat, see the following topics in the *Amazon
    /// Connect
    /// Administrator Guide*:
    ///
    /// * [Concepts: Web and mobile messaging capabilities in Amazon
    ///   Connect](https://docs.aws.amazon.com/connect/latest/adminguide/web-and-mobile-chat.html)
    ///
    /// * [Amazon Connect Chat security best
    ///   practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat)
    pub fn startChatContact(self: *Self, allocator: std.mem.Allocator, input: start_chat_contact.StartChatContactInput, options: CallOptions) !start_chat_contact.StartChatContactOutput {
        return start_chat_contact.execute(self, allocator, input, options);
    }

    /// Starts an empty evaluation in the specified Amazon Connect instance, using
    /// the given evaluation form for the
    /// particular contact. The evaluation form version used for the contact
    /// evaluation corresponds to the currently
    /// activated version. If no version is activated for the evaluation form, the
    /// contact evaluation cannot be started.
    ///
    /// Evaluations created through the public API do not contain answer values
    /// suggested from automation.
    pub fn startContactEvaluation(self: *Self, allocator: std.mem.Allocator, input: start_contact_evaluation.StartContactEvaluationInput, options: CallOptions) !start_contact_evaluation.StartContactEvaluationOutput {
        return start_contact_evaluation.execute(self, allocator, input, options);
    }

    /// Enables in-flight message processing for an ongoing chat session. Message
    /// processing will stay active for the
    /// rest of the chat, even if an individual contact segment ends.
    pub fn startContactMediaProcessing(self: *Self, allocator: std.mem.Allocator, input: start_contact_media_processing.StartContactMediaProcessingInput, options: CallOptions) !start_contact_media_processing.StartContactMediaProcessingOutput {
        return start_contact_media_processing.execute(self, allocator, input, options);
    }

    /// Starts recording the contact:
    ///
    /// * If the API is called *before* the agent joins the call, recording starts
    ///   when the agent
    /// joins the call.
    ///
    /// * If the API is called *after* the agent joins the call, recording starts at
    ///   the time of the
    /// API call.
    ///
    /// StartContactRecording is a one-time action. For example, if you use
    /// StopContactRecording to stop recording an
    /// ongoing call, you can't use StartContactRecording to restart it. For
    /// scenarios where the recording has started and
    /// you want to suspend and resume it, such as when collecting sensitive
    /// information (for example, a credit card number),
    /// use SuspendContactRecording and ResumeContactRecording.
    ///
    /// You can use this API to override the recording behavior configured in the
    /// [Set recording
    /// behavior](https://docs.aws.amazon.com/connect/latest/adminguide/set-recording-behavior.html) block.
    ///
    /// Only voice recordings are supported at this time.
    pub fn startContactRecording(self: *Self, allocator: std.mem.Allocator, input: start_contact_recording.StartContactRecordingInput, options: CallOptions) !start_contact_recording.StartContactRecordingOutput {
        return start_contact_recording.execute(self, allocator, input, options);
    }

    /// Initiates real-time message streaming for a new chat contact.
    ///
    /// For more information about message streaming, see [Enable real-time chat
    /// message
    /// streaming](https://docs.aws.amazon.com/connect/latest/adminguide/chat-message-streaming.html) in the
    /// *Amazon Connect Administrator Guide*.
    ///
    /// For more information about chat, see the following topics in the *Amazon
    /// Connect
    /// Administrator Guide*:
    ///
    /// * [Concepts: Web and mobile messaging capabilities in Amazon
    ///   Connect](https://docs.aws.amazon.com/connect/latest/adminguide/web-and-mobile-chat.html)
    ///
    /// * [Amazon Connect Chat security best
    ///   practices](https://docs.aws.amazon.com/connect/latest/adminguide/security-best-practices.html#bp-security-chat)
    pub fn startContactStreaming(self: *Self, allocator: std.mem.Allocator, input: start_contact_streaming.StartContactStreamingInput, options: CallOptions) !start_contact_streaming.StartContactStreamingOutput {
        return start_contact_streaming.execute(self, allocator, input, options);
    }

    /// Creates an inbound email contact and initiates a flow to start the email
    /// contact for the customer. Response of
    /// this API provides the ContactId of the email contact created.
    pub fn startEmailContact(self: *Self, allocator: std.mem.Allocator, input: start_email_contact.StartEmailContactInput, options: CallOptions) !start_email_contact.StartEmailContactOutput {
        return start_email_contact.execute(self, allocator, input, options);
    }

    /// Initiates a new outbound SMS or WhatsApp contact to a customer. Response of
    /// this API provides the
    /// `ContactId` of the outbound SMS or WhatsApp contact created.
    ///
    /// **SourceEndpoint** only supports Endpoints with
    /// `CONNECT_PHONENUMBER_ARN` as Type and **DestinationEndpoint** only supports
    /// Endpoints with `TELEPHONE_NUMBER` as Type. **ContactFlowId** initiates the
    /// flow to manage the new contact created.
    ///
    /// This API can be used to initiate outbound SMS or WhatsApp contacts for an
    /// agent, or it can also deflect
    /// an ongoing contact to an outbound SMS or WhatsApp contact by using the
    /// [StartOutboundChatContact](https://docs.aws.amazon.com/connect/latest/APIReference/API_StartOutboundChatContact.html) Flow
    /// Action.
    ///
    /// For more information about using SMS or WhatsApp in Amazon Connect, see the
    /// following topics in
    /// the *Amazon Connect Administrator Guide*:
    ///
    /// * [Set up SMS
    /// messaging](https://docs.aws.amazon.com/connect/latest/adminguide/setup-sms-messaging.html)
    ///
    /// * [Request an SMS-enabled phone
    /// number through Amazon Web Services End User Messaging
    /// SMS](https://docs.aws.amazon.com/connect/latest/adminguide/sms-number.html)
    ///
    /// * [Set up WhatsApp
    /// Business
    /// messaging](https://docs.aws.amazon.com/connect/latest/adminguide/whatsapp-integration.html)
    pub fn startOutboundChatContact(self: *Self, allocator: std.mem.Allocator, input: start_outbound_chat_contact.StartOutboundChatContactInput, options: CallOptions) !start_outbound_chat_contact.StartOutboundChatContactOutput {
        return start_outbound_chat_contact.execute(self, allocator, input, options);
    }

    /// Initiates a flow to send an agent reply or outbound email contact (created
    /// from the CreateContact API) to a
    /// customer.
    pub fn startOutboundEmailContact(self: *Self, allocator: std.mem.Allocator, input: start_outbound_email_contact.StartOutboundEmailContactInput, options: CallOptions) !start_outbound_email_contact.StartOutboundEmailContactOutput {
        return start_outbound_email_contact.execute(self, allocator, input, options);
    }

    /// Places an outbound call to a contact, and then initiates the flow. It
    /// performs the actions in the flow that's
    /// specified (in `ContactFlowId`).
    ///
    /// Agents do not initiate the outbound API, which means that they do not dial
    /// the contact. If the flow places an
    /// outbound call to a contact, and then puts the contact in queue, the call is
    /// then routed to the agent, like any other
    /// inbound case.
    ///
    /// Dialing timeout for this operation can be configured with the
    /// “RingTimeoutInSeconds” parameter. If not
    /// specified, the default dialing timeout will be 60 seconds which means if the
    /// call is not connected within 60 seconds,
    /// it fails.
    ///
    /// UK numbers with a 447 prefix are not allowed by default. Before you can dial
    /// these UK mobile numbers, you must
    /// submit a service quota increase request. For more information, see [Amazon
    /// Connect Service
    /// Quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html) in the
    /// *Amazon Connect Administrator Guide*.
    ///
    /// Campaign calls are not allowed by default. Before you can make a call with
    /// `TrafficType` =
    /// `CAMPAIGN`, you must submit a service quota increase request to the quota
    /// [Amazon Connect
    /// campaigns](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#outbound-communications-quotas).
    ///
    /// For Preview dialing mode, only the Amazon Connect outbound campaigns service
    /// principal is allowed to assume a
    /// role in your account and call this API with OutboundStrategy.
    pub fn startOutboundVoiceContact(self: *Self, allocator: std.mem.Allocator, input: start_outbound_voice_contact.StartOutboundVoiceContactInput, options: CallOptions) !start_outbound_voice_contact.StartOutboundVoiceContactOutput {
        return start_outbound_voice_contact.execute(self, allocator, input, options);
    }

    /// Starts screen sharing for a contact. For more information about screen
    /// sharing, see [Set up in-app, web, video calling, and screen sharing
    /// capabilities](https://docs.aws.amazon.com/connect/latest/adminguide/inapp-calling.html) in the *Amazon Connect Administrator Guide*.
    pub fn startScreenSharing(self: *Self, allocator: std.mem.Allocator, input: start_screen_sharing.StartScreenSharingInput, options: CallOptions) !start_screen_sharing.StartScreenSharingOutput {
        return start_screen_sharing.execute(self, allocator, input, options);
    }

    /// Initiates a flow to start a new task contact. For more information about
    /// task contacts, see [Concepts: Tasks in Amazon
    /// Connect](https://docs.aws.amazon.com/connect/latest/adminguide/tasks.html)
    /// in the
    /// *Amazon Connect Administrator Guide*.
    ///
    /// When using `PreviousContactId` and `RelatedContactId` input parameters, note
    /// the
    /// following:
    ///
    /// * `PreviousContactId`
    ///
    /// * Any updates to user-defined task contact attributes on any contact linked
    ///   through the same
    /// `PreviousContactId` will affect every contact in the chain.
    ///
    /// * There can be a maximum of 12 linked task contacts in a chain. That is, 12
    ///   task contacts can be created that
    /// share the same `PreviousContactId`.
    ///
    /// * `RelatedContactId`
    ///
    /// * Copies contact attributes from the related task contact to the new
    ///   contact.
    ///
    /// * Any update on attributes in a new task contact does not update attributes
    ///   on previous contact.
    ///
    /// * There’s no limit on the number of task contacts that can be created that
    ///   use the same
    /// `RelatedContactId`.
    ///
    /// In addition, when calling StartTaskContact include only one of these
    /// parameters: `ContactFlowID`,
    /// `QuickConnectID`, or `TaskTemplateID`. Only one parameter is required as
    /// long as the task
    /// template has a flow configured to run it. If more than one parameter is
    /// specified, or only the
    /// `TaskTemplateID` is specified but it does not have a flow configured, the
    /// request returns an error
    /// because Amazon Connect cannot identify the unique flow to run when the task
    /// is created.
    ///
    /// A `ServiceQuotaExceededException` occurs when the number of open tasks
    /// exceeds the active tasks quota
    /// or there are already 12 tasks referencing the same `PreviousContactId`. For
    /// more information about service
    /// quotas for task contacts, see [Amazon Connect service
    /// quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html) in the
    /// *Amazon Connect Administrator Guide*.
    pub fn startTaskContact(self: *Self, allocator: std.mem.Allocator, input: start_task_contact.StartTaskContactInput, options: CallOptions) !start_task_contact.StartTaskContactOutput {
        return start_task_contact.execute(self, allocator, input, options);
    }

    /// Starts executing a published test case.
    pub fn startTestCaseExecution(self: *Self, allocator: std.mem.Allocator, input: start_test_case_execution.StartTestCaseExecutionInput, options: CallOptions) !start_test_case_execution.StartTestCaseExecutionOutput {
        return start_test_case_execution.execute(self, allocator, input, options);
    }

    /// Places an inbound in-app, web, or video call to a contact, and then
    /// initiates the flow. It performs the actions
    /// in the flow that are specified (in ContactFlowId) and present in the Amazon
    /// Connect instance (specified as
    /// InstanceId).
    pub fn startWebRtcContact(self: *Self, allocator: std.mem.Allocator, input: start_web_rtc_contact.StartWebRTCContactInput, options: CallOptions) !start_web_rtc_contact.StartWebRTCContactOutput {
        return start_web_rtc_contact.execute(self, allocator, input, options);
    }

    /// Ends the specified contact. Use this API to stop queued callbacks. It does
    /// not work for voice contacts that use
    /// the following initiation methods:
    ///
    /// * DISCONNECT
    ///
    /// * TRANSFER
    ///
    /// * QUEUE_TRANSFER
    ///
    /// * EXTERNAL_OUTBOUND
    ///
    /// * MONITOR
    ///
    /// Chat and task contacts can be terminated in any state, regardless of
    /// initiation method.
    pub fn stopContact(self: *Self, allocator: std.mem.Allocator, input: stop_contact.StopContactInput, options: CallOptions) !stop_contact.StopContactOutput {
        return stop_contact.execute(self, allocator, input, options);
    }

    /// Stops in-flight message processing for an ongoing chat session.
    pub fn stopContactMediaProcessing(self: *Self, allocator: std.mem.Allocator, input: stop_contact_media_processing.StopContactMediaProcessingInput, options: CallOptions) !stop_contact_media_processing.StopContactMediaProcessingOutput {
        return stop_contact_media_processing.execute(self, allocator, input, options);
    }

    /// Stops recording a call when a contact is being recorded.
    /// StopContactRecording is a one-time action. If you use
    /// StopContactRecording to stop recording an ongoing call, you can't use
    /// StartContactRecording to restart it. For
    /// scenarios where the recording has started and you want to suspend it for
    /// sensitive information (for example, to
    /// collect a credit card number), and then restart it, use
    /// SuspendContactRecording and ResumeContactRecording.
    ///
    /// Only voice recordings are supported at this time.
    pub fn stopContactRecording(self: *Self, allocator: std.mem.Allocator, input: stop_contact_recording.StopContactRecordingInput, options: CallOptions) !stop_contact_recording.StopContactRecordingOutput {
        return stop_contact_recording.execute(self, allocator, input, options);
    }

    /// Ends message streaming on a specified contact. To restart message streaming
    /// on that contact, call the
    /// [StartContactStreaming](https://docs.aws.amazon.com/connect/latest/APIReference/API_StartContactStreaming.html)
    /// API.
    pub fn stopContactStreaming(self: *Self, allocator: std.mem.Allocator, input: stop_contact_streaming.StopContactStreamingInput, options: CallOptions) !stop_contact_streaming.StopContactStreamingOutput {
        return stop_contact_streaming.execute(self, allocator, input, options);
    }

    /// Stops a running test execution.
    pub fn stopTestCaseExecution(self: *Self, allocator: std.mem.Allocator, input: stop_test_case_execution.StopTestCaseExecutionInput, options: CallOptions) !stop_test_case_execution.StopTestCaseExecutionOutput {
        return stop_test_case_execution.execute(self, allocator, input, options);
    }

    /// Submits a contact evaluation in the specified Amazon Connect instance.
    /// Answers included in the request are
    /// merged with existing answers for the given evaluation. If no answers or
    /// notes are passed, the evaluation is submitted
    /// with the existing answers and notes. You can delete an answer or note by
    /// passing an empty object (`{}`) to
    /// the question identifier.
    ///
    /// If a contact evaluation is already in submitted state, this operation will
    /// trigger a resubmission.
    pub fn submitContactEvaluation(self: *Self, allocator: std.mem.Allocator, input: submit_contact_evaluation.SubmitContactEvaluationInput, options: CallOptions) !submit_contact_evaluation.SubmitContactEvaluationOutput {
        return submit_contact_evaluation.execute(self, allocator, input, options);
    }

    /// When a contact is being recorded, this API suspends recording whatever is
    /// selected in the flow configuration:
    /// call (IVR or agent), screen, or both. If only call recording or only screen
    /// recording is enabled, then it would be
    /// suspended. For example, you might suspend the screen recording while
    /// collecting sensitive information, such as a
    /// credit card number. Then use
    /// [ResumeContactRecording](https://docs.aws.amazon.com/connect/latest/APIReference/API_ResumeContactRecording.html) to restart
    /// recording the screen.
    ///
    /// The period of time that the recording is suspended is filled with silence in
    /// the final recording.
    ///
    /// Voice (IVR, agent) and screen recordings are supported.
    pub fn suspendContactRecording(self: *Self, allocator: std.mem.Allocator, input: suspend_contact_recording.SuspendContactRecordingInput, options: CallOptions) !suspend_contact_recording.SuspendContactRecordingOutput {
        return suspend_contact_recording.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the contact resource. For more information about
    /// this API is used, see [Set up granular billing for a detailed
    /// view of your Amazon Connect
    /// usage](https://docs.aws.amazon.com/connect/latest/adminguide/granular-billing.html).
    pub fn tagContact(self: *Self, allocator: std.mem.Allocator, input: tag_contact.TagContactInput, options: CallOptions) !tag_contact.TagContactOutput {
        return tag_contact.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource.
    ///
    /// Some of the supported resource types are agents, routing profiles, queues,
    /// quick connects, flows, agent
    /// statuses, hours of operation, phone numbers, security profiles, and task
    /// templates. For a complete list, see [Tagging resources in Amazon
    /// Connect](https://docs.aws.amazon.com/connect/latest/adminguide/tagging.html).
    ///
    /// For sample policies that use tags, see [Amazon Connect Identity-Based Policy
    /// Examples](https://docs.aws.amazon.com/connect/latest/adminguide/security_iam_id-based-policy-examples.html) in the *Amazon Connect Administrator Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Transfers `TASK` or `EMAIL`
    /// contacts from one agent or queue to another agent or queue at any point
    /// after a contact is
    /// created. You can transfer a contact to another queue by providing the flow
    /// which orchestrates the contact to the
    /// destination queue. This gives you more control over contact handling and
    /// helps you adhere to the service level
    /// agreement (SLA) guaranteed to your customers.
    ///
    /// Note the following requirements:
    ///
    /// * Transfer is only supported for `TASK` and `EMAIL` contacts.
    ///
    /// * Do not use both `QueueId` and `UserId` in the same call.
    ///
    /// * The following flow types are supported: Inbound flow, Transfer to agent
    ///   flow, and Transfer to queue
    /// flow.
    ///
    /// * The `TransferContact` API can be called only on active contacts.
    ///
    /// * A contact cannot be transferred more than 11 times.
    pub fn transferContact(self: *Self, allocator: std.mem.Allocator, input: transfer_contact.TransferContactInput, options: CallOptions) !transfer_contact.TransferContactOutput {
        return transfer_contact.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the contact resource. For more information
    /// about this API is used, see [Set up granular billing for a detailed
    /// view of your Amazon Connect
    /// usage](https://docs.aws.amazon.com/connect/latest/adminguide/granular-billing.html).
    pub fn untagContact(self: *Self, allocator: std.mem.Allocator, input: untag_contact.UntagContactInput, options: CallOptions) !untag_contact.UntagContactOutput {
        return untag_contact.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates agent status.
    pub fn updateAgentStatus(self: *Self, allocator: std.mem.Allocator, input: update_agent_status.UpdateAgentStatusInput, options: CallOptions) !update_agent_status.UpdateAgentStatusOutput {
        return update_agent_status.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    /// To
    /// request access to this API, contact Amazon Web Services Support.
    ///
    /// Updates the selected authentication profile.
    pub fn updateAuthenticationProfile(self: *Self, allocator: std.mem.Allocator, input: update_authentication_profile.UpdateAuthenticationProfileInput, options: CallOptions) !update_authentication_profile.UpdateAuthenticationProfileOutput {
        return update_authentication_profile.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Adds or updates user-defined contact information associated with the
    /// specified contact. At least one field to be
    /// updated must be present in the request.
    ///
    /// You can add or update user-defined contact information for both ongoing and
    /// completed contacts.
    pub fn updateContact(self: *Self, allocator: std.mem.Allocator, input: update_contact.UpdateContactInput, options: CallOptions) !update_contact.UpdateContactOutput {
        return update_contact.execute(self, allocator, input, options);
    }

    /// Creates or updates user-defined contact
    /// attributes associated with the specified contact.
    ///
    /// You can create or update user-defined attributes for both ongoing and
    /// completed contacts. For example, while the
    /// call is active, you can update the customer's name or the reason the
    /// customer called. You can add notes about steps
    /// that the agent took during the call that display to the next agent that
    /// takes the call. You can also update
    /// attributes for a contact using data from your CRM application and save the
    /// data with the contact in Amazon Connect. You could also flag calls for
    /// additional analysis, such as legal review or to identify abusive callers.
    ///
    /// Contact attributes are available in Amazon Connect for 24 months, and are
    /// then deleted. For information
    /// about contact record retention and the maximum size of the contact record
    /// attributes section, see [Feature
    /// specifications](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#feature-limits) in the *Amazon Connect Administrator Guide*.
    pub fn updateContactAttributes(self: *Self, allocator: std.mem.Allocator, input: update_contact_attributes.UpdateContactAttributesInput, options: CallOptions) !update_contact_attributes.UpdateContactAttributesOutput {
        return update_contact_attributes.execute(self, allocator, input, options);
    }

    /// Updates details about a contact evaluation in the specified Amazon Connect
    /// instance. A contact evaluation
    /// must be in draft state. Answers included in the request are merged with
    /// existing answers for the given evaluation. An
    /// answer or note can be deleted by passing an empty object (`{}`) to the
    /// question identifier.
    pub fn updateContactEvaluation(self: *Self, allocator: std.mem.Allocator, input: update_contact_evaluation.UpdateContactEvaluationInput, options: CallOptions) !update_contact_evaluation.UpdateContactEvaluationOutput {
        return update_contact_evaluation.execute(self, allocator, input, options);
    }

    /// Updates the specified flow.
    ///
    /// You can also create and update flows using the [Amazon Connect
    /// Flow
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/flow-language.html).
    ///
    /// Use the `$SAVED` alias in the request to describe the `SAVED` content of a
    /// Flow. For
    /// example, `arn:aws:.../contact-flow/{id}:$SAVED`. After a flow is published,
    /// `$SAVED` needs to
    /// be supplied to view saved content that has not been published.
    pub fn updateContactFlowContent(self: *Self, allocator: std.mem.Allocator, input: update_contact_flow_content.UpdateContactFlowContentInput, options: CallOptions) !update_contact_flow_content.UpdateContactFlowContentOutput {
        return update_contact_flow_content.execute(self, allocator, input, options);
    }

    /// Updates metadata about specified flow.
    pub fn updateContactFlowMetadata(self: *Self, allocator: std.mem.Allocator, input: update_contact_flow_metadata.UpdateContactFlowMetadataInput, options: CallOptions) !update_contact_flow_metadata.UpdateContactFlowMetadataOutput {
        return update_contact_flow_metadata.execute(self, allocator, input, options);
    }

    /// Updates a specific Aliases metadata, including the version it’s tied to,
    /// it’s name, and description.
    pub fn updateContactFlowModuleAlias(self: *Self, allocator: std.mem.Allocator, input: update_contact_flow_module_alias.UpdateContactFlowModuleAliasInput, options: CallOptions) !update_contact_flow_module_alias.UpdateContactFlowModuleAliasOutput {
        return update_contact_flow_module_alias.execute(self, allocator, input, options);
    }

    /// Updates specified flow module for the specified Amazon Connect instance.
    ///
    /// Use the `$SAVED` alias in the request to describe the `SAVED` content of a
    /// Flow. For
    /// example, `arn:aws:.../contact-flow/{id}:$SAVED`. After a flow is published,
    /// `$SAVED` needs to
    /// be supplied to view saved content that has not been published.
    pub fn updateContactFlowModuleContent(self: *Self, allocator: std.mem.Allocator, input: update_contact_flow_module_content.UpdateContactFlowModuleContentInput, options: CallOptions) !update_contact_flow_module_content.UpdateContactFlowModuleContentOutput {
        return update_contact_flow_module_content.execute(self, allocator, input, options);
    }

    /// Updates metadata about specified flow module.
    pub fn updateContactFlowModuleMetadata(self: *Self, allocator: std.mem.Allocator, input: update_contact_flow_module_metadata.UpdateContactFlowModuleMetadataInput, options: CallOptions) !update_contact_flow_module_metadata.UpdateContactFlowModuleMetadataOutput {
        return update_contact_flow_module_metadata.execute(self, allocator, input, options);
    }

    /// The name of the flow.
    ///
    /// You can also create and update flows using the [Amazon Connect
    /// Flow
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/flow-language.html).
    pub fn updateContactFlowName(self: *Self, allocator: std.mem.Allocator, input: update_contact_flow_name.UpdateContactFlowNameInput, options: CallOptions) !update_contact_flow_name.UpdateContactFlowNameOutput {
        return update_contact_flow_name.execute(self, allocator, input, options);
    }

    /// Updates routing priority and age on the contact (**QueuePriority** and
    /// **QueueTimeAdjustmentInSeconds**). These properties can be used to change a
    /// customer's position
    /// in the queue. For example, you can move a contact to the back of the queue
    /// by setting a lower routing priority
    /// relative to other contacts in queue; or you can move a contact to the front
    /// of the queue by increasing the routing
    /// age which will make the contact look artificially older and therefore higher
    /// up in the first-in-first-out routing
    /// order. Note that adjusting the routing age of a contact affects only its
    /// position in queue, and not its actual queue
    /// wait time as reported through metrics. These properties can also be updated
    /// by using [the Set routing priority / age flow
    /// block](https://docs.aws.amazon.com/connect/latest/adminguide/change-routing-priority.html).
    ///
    /// Either **QueuePriority** or **QueueTimeAdjustmentInSeconds** should be
    /// provided within the request body, but not both.
    pub fn updateContactRoutingData(self: *Self, allocator: std.mem.Allocator, input: update_contact_routing_data.UpdateContactRoutingDataInput, options: CallOptions) !update_contact_routing_data.UpdateContactRoutingDataOutput {
        return update_contact_routing_data.execute(self, allocator, input, options);
    }

    /// Updates the scheduled time of a task contact that is already scheduled.
    pub fn updateContactSchedule(self: *Self, allocator: std.mem.Allocator, input: update_contact_schedule.UpdateContactScheduleInput, options: CallOptions) !update_contact_schedule.UpdateContactScheduleOutput {
        return update_contact_schedule.execute(self, allocator, input, options);
    }

    /// Updates all properties for an attribute using all properties from
    /// CreateDataTableAttribute. There are no other
    /// granular update endpoints. It does not act as a patch operation - all
    /// properties must be provided. System managed
    /// attributes are not mutable by customers. Changing an attribute's validation
    /// does not invalidate existing values since
    /// validation only runs when values are created or updated.
    pub fn updateDataTableAttribute(self: *Self, allocator: std.mem.Allocator, input: update_data_table_attribute.UpdateDataTableAttributeInput, options: CallOptions) !update_data_table_attribute.UpdateDataTableAttributeOutput {
        return update_data_table_attribute.execute(self, allocator, input, options);
    }

    /// Updates the metadata properties of a data table. Accepts all fields similar
    /// to CreateDataTable, except for
    /// fields and tags. There are no other granular update endpoints. It does not
    /// act as a patch operation - all properties
    /// must be provided or defaults will be used. Fields follow the same
    /// requirements as CreateDataTable.
    pub fn updateDataTableMetadata(self: *Self, allocator: std.mem.Allocator, input: update_data_table_metadata.UpdateDataTableMetadataInput, options: CallOptions) !update_data_table_metadata.UpdateDataTableMetadataOutput {
        return update_data_table_metadata.execute(self, allocator, input, options);
    }

    /// Updates the primary values for a record. This operation affects all existing
    /// values that are currently
    /// associated to the record and its primary values. Users that have
    /// restrictions on attributes and/or primary values are
    /// not authorized to use this endpoint. The combination of new primary values
    /// must be unique within the table.
    pub fn updateDataTablePrimaryValues(self: *Self, allocator: std.mem.Allocator, input: update_data_table_primary_values.UpdateDataTablePrimaryValuesInput, options: CallOptions) !update_data_table_primary_values.UpdateDataTablePrimaryValuesOutput {
        return update_data_table_primary_values.execute(self, allocator, input, options);
    }

    /// Updates an email address metadata. For more information about email
    /// addresses, see [Create email
    /// addresses](https://docs.aws.amazon.com/connect/latest/adminguide/create-email-address1.html) in the Amazon Connect
    /// Administrator Guide.
    pub fn updateEmailAddressMetadata(self: *Self, allocator: std.mem.Allocator, input: update_email_address_metadata.UpdateEmailAddressMetadataInput, options: CallOptions) !update_email_address_metadata.UpdateEmailAddressMetadataOutput {
        return update_email_address_metadata.execute(self, allocator, input, options);
    }

    /// Updates details about a specific evaluation form version in the specified
    /// Amazon Connect instance. Question
    /// and section identifiers cannot be duplicated within the same evaluation
    /// form.
    ///
    /// This operation does not support partial updates. Instead it does a full
    /// update of evaluation form
    /// content.
    pub fn updateEvaluationForm(self: *Self, allocator: std.mem.Allocator, input: update_evaluation_form.UpdateEvaluationFormInput, options: CallOptions) !update_evaluation_form.UpdateEvaluationFormOutput {
        return update_evaluation_form.execute(self, allocator, input, options);
    }

    /// Updates the hours of operation.
    pub fn updateHoursOfOperation(self: *Self, allocator: std.mem.Allocator, input: update_hours_of_operation.UpdateHoursOfOperationInput, options: CallOptions) !update_hours_of_operation.UpdateHoursOfOperationOutput {
        return update_hours_of_operation.execute(self, allocator, input, options);
    }

    /// Update the hours of operation override.
    pub fn updateHoursOfOperationOverride(self: *Self, allocator: std.mem.Allocator, input: update_hours_of_operation_override.UpdateHoursOfOperationOverrideInput, options: CallOptions) !update_hours_of_operation_override.UpdateHoursOfOperationOverrideOutput {
        return update_hours_of_operation_override.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Updates the value for the specified attribute type.
    pub fn updateInstanceAttribute(self: *Self, allocator: std.mem.Allocator, input: update_instance_attribute.UpdateInstanceAttributeInput, options: CallOptions) !update_instance_attribute.UpdateInstanceAttributeOutput {
        return update_instance_attribute.execute(self, allocator, input, options);
    }

    /// This API is in preview release for Amazon Connect and is subject to change.
    ///
    /// Updates an existing configuration for a resource type. This API is
    /// idempotent.
    pub fn updateInstanceStorageConfig(self: *Self, allocator: std.mem.Allocator, input: update_instance_storage_config.UpdateInstanceStorageConfigInput, options: CallOptions) !update_instance_storage_config.UpdateInstanceStorageConfigOutput {
        return update_instance_storage_config.execute(self, allocator, input, options);
    }

    /// Instructs Amazon Connect to resume the authentication process. The
    /// subsequent actions depend on the request
    /// body contents:
    ///
    /// * **If a code is provided**: Connect retrieves the identity information from
    ///   Amazon
    /// Cognito and imports it into Connect Customer Profiles.
    ///
    /// * **If an error is provided**: The error branch of the Authenticate Customer
    ///   block
    /// is executed.
    ///
    /// The API returns a success response to acknowledge the request. However, the
    /// interaction and exchange of
    /// identity information occur asynchronously after the response is returned.
    pub fn updateParticipantAuthentication(self: *Self, allocator: std.mem.Allocator, input: update_participant_authentication.UpdateParticipantAuthenticationInput, options: CallOptions) !update_participant_authentication.UpdateParticipantAuthenticationOutput {
        return update_participant_authentication.execute(self, allocator, input, options);
    }

    /// Updates timeouts for when human chat participants are to be considered idle,
    /// and when agents are automatically
    /// disconnected from a chat due to idleness. You can set four timers:
    ///
    /// * Customer idle timeout
    ///
    /// * Customer auto-disconnect timeout
    ///
    /// * Agent idle timeout
    ///
    /// * Agent auto-disconnect timeout
    ///
    /// For more information about how chat timeouts work, see
    /// [Set up chat timeouts for human
    /// participants](https://docs.aws.amazon.com/connect/latest/adminguide/setup-chat-timeouts.html).
    pub fn updateParticipantRoleConfig(self: *Self, allocator: std.mem.Allocator, input: update_participant_role_config.UpdateParticipantRoleConfigInput, options: CallOptions) !update_participant_role_config.UpdateParticipantRoleConfigOutput {
        return update_participant_role_config.execute(self, allocator, input, options);
    }

    /// Updates your claimed phone number from its current Amazon Connect instance
    /// or traffic distribution group to another Amazon Connect instance or traffic
    /// distribution group in the same Amazon Web Services Region.
    ///
    /// After using this API, you must verify that the phone number is attached to
    /// the correct flow in the target
    /// instance or traffic distribution group. You need to do this because the API
    /// switches only the phone number to a new
    /// instance or traffic distribution group. It doesn't migrate the flow
    /// configuration of the phone number, too.
    ///
    /// You can call
    /// [DescribePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribePhoneNumber.html) API to verify the status of a previous [UpdatePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdatePhoneNumber.html) operation.
    pub fn updatePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: update_phone_number.UpdatePhoneNumberInput, options: CallOptions) !update_phone_number.UpdatePhoneNumberOutput {
        return update_phone_number.execute(self, allocator, input, options);
    }

    /// Updates a phone number’s metadata.
    ///
    /// To verify the status of a previous UpdatePhoneNumberMetadata operation, call
    /// the
    /// [DescribePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribePhoneNumber.html) API.
    pub fn updatePhoneNumberMetadata(self: *Self, allocator: std.mem.Allocator, input: update_phone_number_metadata.UpdatePhoneNumberMetadataInput, options: CallOptions) !update_phone_number_metadata.UpdatePhoneNumberMetadataOutput {
        return update_phone_number_metadata.execute(self, allocator, input, options);
    }

    /// Updates a predefined attribute for the specified Amazon Connect instance. A
    /// *predefined attribute* is
    /// made up of a name and a value.
    ///
    /// For the predefined attributes per instance quota, see [Amazon Connect
    /// quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#connect-quotas).
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * Update routing proficiency (for example, agent certification) that has
    ///   predefined values (for example, a list
    /// of possible certifications). For more information, see [Create predefined
    /// attributes for routing contacts to
    /// agents](https://docs.aws.amazon.com/connect/latest/adminguide/predefined-attributes.html).
    ///
    /// * Update an attribute for business unit name that has a list of predefined
    ///   business unit names used in your
    /// organization. This is a use case where information for a contact varies
    /// between transfers or conferences. For more
    /// information, see [Use contact segment
    /// attributes](https://docs.aws.amazon.com/connect/latest/adminguide/use-contact-segment-attributes.html).
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn updatePredefinedAttribute(self: *Self, allocator: std.mem.Allocator, input: update_predefined_attribute.UpdatePredefinedAttributeInput, options: CallOptions) !update_predefined_attribute.UpdatePredefinedAttributeOutput {
        return update_predefined_attribute.execute(self, allocator, input, options);
    }

    /// Updates a prompt.
    pub fn updatePrompt(self: *Self, allocator: std.mem.Allocator, input: update_prompt.UpdatePromptInput, options: CallOptions) !update_prompt.UpdatePromptOutput {
        return update_prompt.execute(self, allocator, input, options);
    }

    /// Updates the hours of operation for the specified queue.
    pub fn updateQueueHoursOfOperation(self: *Self, allocator: std.mem.Allocator, input: update_queue_hours_of_operation.UpdateQueueHoursOfOperationInput, options: CallOptions) !update_queue_hours_of_operation.UpdateQueueHoursOfOperationOutput {
        return update_queue_hours_of_operation.execute(self, allocator, input, options);
    }

    /// Updates the maximum number of contacts allowed in a queue before it is
    /// considered full.
    pub fn updateQueueMaxContacts(self: *Self, allocator: std.mem.Allocator, input: update_queue_max_contacts.UpdateQueueMaxContactsInput, options: CallOptions) !update_queue_max_contacts.UpdateQueueMaxContactsOutput {
        return update_queue_max_contacts.execute(self, allocator, input, options);
    }

    /// Updates the name and description of a queue. At least `Name` or
    /// `Description` must be provided.
    pub fn updateQueueName(self: *Self, allocator: std.mem.Allocator, input: update_queue_name.UpdateQueueNameInput, options: CallOptions) !update_queue_name.UpdateQueueNameOutput {
        return update_queue_name.execute(self, allocator, input, options);
    }

    /// Updates the outbound caller ID name, number, and outbound whisper flow for a
    /// specified queue.
    ///
    /// * If the phone number is claimed to a traffic distribution group that was
    ///   created in the
    /// same Region as the Amazon Connect instance where you are calling this API,
    /// then you can use a
    /// full phone number ARN or a UUID for `OutboundCallerIdNumberId`. However, if
    /// the phone number is claimed
    /// to a traffic distribution group that is in one Region, and you are calling
    /// this API from an instance in another Amazon Web Services Region that is
    /// associated with the traffic distribution group, you must provide a full
    /// phone number ARN. If a
    /// UUID is provided in this scenario, you will receive a
    /// `ResourceNotFoundException`.
    ///
    /// * Only use the phone number ARN format that doesn't contain `instance` in
    ///   the path, for example,
    /// `arn:aws:connect:us-east-1:1234567890:phone-number/uuid`. This is the same
    /// ARN format that is returned
    /// when you call the
    /// [ListPhoneNumbersV2](https://docs.aws.amazon.com/connect/latest/APIReference/API_ListPhoneNumbersV2.html) API.
    ///
    /// * If you plan to use IAM policies to allow/deny access to this API for phone
    ///   number resources
    /// claimed to a traffic distribution group, see [Allow or Deny queue API
    /// actions for phone numbers in a replica
    /// Region](https://docs.aws.amazon.com/connect/latest/adminguide/security_iam_resource-level-policy-examples.html#allow-deny-queue-actions-replica-region).
    pub fn updateQueueOutboundCallerConfig(self: *Self, allocator: std.mem.Allocator, input: update_queue_outbound_caller_config.UpdateQueueOutboundCallerConfigInput, options: CallOptions) !update_queue_outbound_caller_config.UpdateQueueOutboundCallerConfigOutput {
        return update_queue_outbound_caller_config.execute(self, allocator, input, options);
    }

    /// Updates the outbound email address Id for a specified queue.
    pub fn updateQueueOutboundEmailConfig(self: *Self, allocator: std.mem.Allocator, input: update_queue_outbound_email_config.UpdateQueueOutboundEmailConfigInput, options: CallOptions) !update_queue_outbound_email_config.UpdateQueueOutboundEmailConfigOutput {
        return update_queue_outbound_email_config.execute(self, allocator, input, options);
    }

    /// Updates the status of the queue.
    pub fn updateQueueStatus(self: *Self, allocator: std.mem.Allocator, input: update_queue_status.UpdateQueueStatusInput, options: CallOptions) !update_queue_status.UpdateQueueStatusOutput {
        return update_queue_status.execute(self, allocator, input, options);
    }

    /// Updates the configuration settings for the specified quick connect.
    pub fn updateQuickConnectConfig(self: *Self, allocator: std.mem.Allocator, input: update_quick_connect_config.UpdateQuickConnectConfigInput, options: CallOptions) !update_quick_connect_config.UpdateQuickConnectConfigOutput {
        return update_quick_connect_config.execute(self, allocator, input, options);
    }

    /// Updates the name and description of a quick connect. The request accepts the
    /// following data in JSON format. At least `Name` or `Description` must be
    /// provided.
    pub fn updateQuickConnectName(self: *Self, allocator: std.mem.Allocator, input: update_quick_connect_name.UpdateQuickConnectNameInput, options: CallOptions) !update_quick_connect_name.UpdateQuickConnectNameOutput {
        return update_quick_connect_name.execute(self, allocator, input, options);
    }

    /// Whether agents with this routing profile will have their routing order
    /// calculated based on *time since
    /// their last inbound contact* or *longest idle time*.
    pub fn updateRoutingProfileAgentAvailabilityTimer(self: *Self, allocator: std.mem.Allocator, input: update_routing_profile_agent_availability_timer.UpdateRoutingProfileAgentAvailabilityTimerInput, options: CallOptions) !update_routing_profile_agent_availability_timer.UpdateRoutingProfileAgentAvailabilityTimerOutput {
        return update_routing_profile_agent_availability_timer.execute(self, allocator, input, options);
    }

    /// Updates the channels that agents can handle in the Contact Control Panel
    /// (CCP) for a routing profile.
    pub fn updateRoutingProfileConcurrency(self: *Self, allocator: std.mem.Allocator, input: update_routing_profile_concurrency.UpdateRoutingProfileConcurrencyInput, options: CallOptions) !update_routing_profile_concurrency.UpdateRoutingProfileConcurrencyOutput {
        return update_routing_profile_concurrency.execute(self, allocator, input, options);
    }

    /// Updates the default outbound queue of a routing profile.
    pub fn updateRoutingProfileDefaultOutboundQueue(self: *Self, allocator: std.mem.Allocator, input: update_routing_profile_default_outbound_queue.UpdateRoutingProfileDefaultOutboundQueueInput, options: CallOptions) !update_routing_profile_default_outbound_queue.UpdateRoutingProfileDefaultOutboundQueueOutput {
        return update_routing_profile_default_outbound_queue.execute(self, allocator, input, options);
    }

    /// Updates the name and description of a routing profile. The request accepts
    /// the following data in JSON format. At least `Name` or `Description` must be
    /// provided.
    pub fn updateRoutingProfileName(self: *Self, allocator: std.mem.Allocator, input: update_routing_profile_name.UpdateRoutingProfileNameInput, options: CallOptions) !update_routing_profile_name.UpdateRoutingProfileNameOutput {
        return update_routing_profile_name.execute(self, allocator, input, options);
    }

    /// Updates the properties associated with a set of queues for a routing
    /// profile.
    pub fn updateRoutingProfileQueues(self: *Self, allocator: std.mem.Allocator, input: update_routing_profile_queues.UpdateRoutingProfileQueuesInput, options: CallOptions) !update_routing_profile_queues.UpdateRoutingProfileQueuesOutput {
        return update_routing_profile_queues.execute(self, allocator, input, options);
    }

    /// Updates a rule for the specified Amazon Connect instance.
    ///
    /// Use the [Rules Function
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/connect-rules-language.html) to code conditions for the rule.
    pub fn updateRule(self: *Self, allocator: std.mem.Allocator, input: update_rule.UpdateRuleInput, options: CallOptions) !update_rule.UpdateRuleOutput {
        return update_rule.execute(self, allocator, input, options);
    }

    /// Updates a security profile.
    ///
    /// For information about security profiles, see [Security
    /// Profiles](https://docs.aws.amazon.com/connect/latest/adminguide/connect-security-profiles.html) in the *Amazon Connect Administrator Guide*. For a mapping of the API name and user interface name of the security
    /// profile permissions, see [List
    /// of security profile
    /// permissions](https://docs.aws.amazon.com/connect/latest/adminguide/security-profile-list.html).
    pub fn updateSecurityProfile(self: *Self, allocator: std.mem.Allocator, input: update_security_profile.UpdateSecurityProfileInput, options: CallOptions) !update_security_profile.UpdateSecurityProfileOutput {
        return update_security_profile.execute(self, allocator, input, options);
    }

    /// Updates details about a specific task template in the specified Amazon
    /// Connect instance. This operation does
    /// not support partial updates. Instead it does a full update of template
    /// content.
    pub fn updateTaskTemplate(self: *Self, allocator: std.mem.Allocator, input: update_task_template.UpdateTaskTemplateInput, options: CallOptions) !update_task_template.UpdateTaskTemplateOutput {
        return update_task_template.execute(self, allocator, input, options);
    }

    /// Updates any of the metadata for a test case, such as the name, description,
    /// and status or content of an existing test case. This API doesn't allow
    /// customers to update the tags of the test case resource for the specified
    /// Amazon Connect instance.
    pub fn updateTestCase(self: *Self, allocator: std.mem.Allocator, input: update_test_case.UpdateTestCaseInput, options: CallOptions) !update_test_case.UpdateTestCaseOutput {
        return update_test_case.execute(self, allocator, input, options);
    }

    /// Updates the traffic distribution for a given traffic distribution group.
    ///
    /// When you shift telephony traffic, also shift agents and/or agent sign-ins to
    /// ensure they can handle the calls
    /// in the other Region. If you don't shift the agents, voice calls will go to
    /// the shifted Region but there won't be any
    /// agents available to receive the calls.
    ///
    /// The `SignInConfig` distribution is available only on a
    /// default `TrafficDistributionGroup` (see the `IsDefault` parameter in the
    /// [TrafficDistributionGroup](https://docs.aws.amazon.com/connect/latest/APIReference/API_TrafficDistributionGroup.html)
    /// data type). If you call
    /// `UpdateTrafficDistribution` with a modified `SignInConfig` and a non-default
    /// `TrafficDistributionGroup`,
    /// an `InvalidRequestException` is returned.
    ///
    /// For more information about updating a traffic distribution group, see
    /// [Update telephony traffic distribution
    /// across Amazon Web Services Regions
    /// ](https://docs.aws.amazon.com/connect/latest/adminguide/update-telephony-traffic-distribution.html) in the *Amazon Connect Administrator Guide*.
    pub fn updateTrafficDistribution(self: *Self, allocator: std.mem.Allocator, input: update_traffic_distribution.UpdateTrafficDistributionInput, options: CallOptions) !update_traffic_distribution.UpdateTrafficDistributionOutput {
        return update_traffic_distribution.execute(self, allocator, input, options);
    }

    /// Assigns the specified hierarchy group to the specified user.
    pub fn updateUserHierarchy(self: *Self, allocator: std.mem.Allocator, input: update_user_hierarchy.UpdateUserHierarchyInput, options: CallOptions) !update_user_hierarchy.UpdateUserHierarchyOutput {
        return update_user_hierarchy.execute(self, allocator, input, options);
    }

    /// Updates the name of the user hierarchy group.
    pub fn updateUserHierarchyGroupName(self: *Self, allocator: std.mem.Allocator, input: update_user_hierarchy_group_name.UpdateUserHierarchyGroupNameInput, options: CallOptions) !update_user_hierarchy_group_name.UpdateUserHierarchyGroupNameOutput {
        return update_user_hierarchy_group_name.execute(self, allocator, input, options);
    }

    /// Updates the user hierarchy structure: add, remove, and rename user hierarchy
    /// levels.
    pub fn updateUserHierarchyStructure(self: *Self, allocator: std.mem.Allocator, input: update_user_hierarchy_structure.UpdateUserHierarchyStructureInput, options: CallOptions) !update_user_hierarchy_structure.UpdateUserHierarchyStructureOutput {
        return update_user_hierarchy_structure.execute(self, allocator, input, options);
    }

    /// Updates the identity information for the specified user.
    ///
    /// We strongly recommend limiting who has the ability to invoke
    /// `UpdateUserIdentityInfo`. Someone with
    /// that ability can change the login credentials of other users by changing
    /// their email address. This poses a security
    /// risk to your organization. They can change the email address of a user to
    /// the attacker's email address, and then
    /// reset the password through email. For more information, see [Best Practices
    /// for Security
    /// Profiles](https://docs.aws.amazon.com/connect/latest/adminguide/security-profile-best-practices.html)
    /// in the *Amazon Connect Administrator Guide*.
    pub fn updateUserIdentityInfo(self: *Self, allocator: std.mem.Allocator, input: update_user_identity_info.UpdateUserIdentityInfoInput, options: CallOptions) !update_user_identity_info.UpdateUserIdentityInfoOutput {
        return update_user_identity_info.execute(self, allocator, input, options);
    }

    /// Updates the phone configuration settings for the specified user.
    pub fn updateUserPhoneConfig(self: *Self, allocator: std.mem.Allocator, input: update_user_phone_config.UpdateUserPhoneConfigInput, options: CallOptions) !update_user_phone_config.UpdateUserPhoneConfigOutput {
        return update_user_phone_config.execute(self, allocator, input, options);
    }

    /// Updates the properties associated with the proficiencies of a user.
    pub fn updateUserProficiencies(self: *Self, allocator: std.mem.Allocator, input: update_user_proficiencies.UpdateUserProficienciesInput, options: CallOptions) !update_user_proficiencies.UpdateUserProficienciesOutput {
        return update_user_proficiencies.execute(self, allocator, input, options);
    }

    /// Assigns the specified routing profile to the specified user.
    pub fn updateUserRoutingProfile(self: *Self, allocator: std.mem.Allocator, input: update_user_routing_profile.UpdateUserRoutingProfileInput, options: CallOptions) !update_user_routing_profile.UpdateUserRoutingProfileOutput {
        return update_user_routing_profile.execute(self, allocator, input, options);
    }

    /// Assigns the specified security profiles to the specified user.
    pub fn updateUserSecurityProfiles(self: *Self, allocator: std.mem.Allocator, input: update_user_security_profiles.UpdateUserSecurityProfilesInput, options: CallOptions) !update_user_security_profiles.UpdateUserSecurityProfilesOutput {
        return update_user_security_profiles.execute(self, allocator, input, options);
    }

    /// Updates the view content of the given view identifier in the specified
    /// Amazon Connect instance.
    ///
    /// It performs content validation if `Status` is set to `SAVED` and performs
    /// full content
    /// validation if `Status` is `PUBLISHED`. Note that the `$SAVED` alias' content
    /// will
    /// always be updated, but the `$LATEST` alias' content will only be updated if
    /// `Status` is
    /// `PUBLISHED`.
    pub fn updateViewContent(self: *Self, allocator: std.mem.Allocator, input: update_view_content.UpdateViewContentInput, options: CallOptions) !update_view_content.UpdateViewContentOutput {
        return update_view_content.execute(self, allocator, input, options);
    }

    /// Updates the view metadata. Note that either `Name` or `Description` must be
    /// provided.
    pub fn updateViewMetadata(self: *Self, allocator: std.mem.Allocator, input: update_view_metadata.UpdateViewMetadataInput, options: CallOptions) !update_view_metadata.UpdateViewMetadataOutput {
        return update_view_metadata.execute(self, allocator, input, options);
    }

    /// Updates the metadata of a workspace, such as its name and description.
    pub fn updateWorkspaceMetadata(self: *Self, allocator: std.mem.Allocator, input: update_workspace_metadata.UpdateWorkspaceMetadataInput, options: CallOptions) !update_workspace_metadata.UpdateWorkspaceMetadataOutput {
        return update_workspace_metadata.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a page in a workspace, including the associated
    /// view and input data.
    pub fn updateWorkspacePage(self: *Self, allocator: std.mem.Allocator, input: update_workspace_page.UpdateWorkspacePageInput, options: CallOptions) !update_workspace_page.UpdateWorkspacePageOutput {
        return update_workspace_page.execute(self, allocator, input, options);
    }

    /// Updates the theme configuration for a workspace, including colors and
    /// styling.
    pub fn updateWorkspaceTheme(self: *Self, allocator: std.mem.Allocator, input: update_workspace_theme.UpdateWorkspaceThemeInput, options: CallOptions) !update_workspace_theme.UpdateWorkspaceThemeOutput {
        return update_workspace_theme.execute(self, allocator, input, options);
    }

    /// Updates the visibility setting of a workspace, controlling whether it is
    /// available to all users, assigned users
    /// only, or none.
    pub fn updateWorkspaceVisibility(self: *Self, allocator: std.mem.Allocator, input: update_workspace_visibility.UpdateWorkspaceVisibilityInput, options: CallOptions) !update_workspace_visibility.UpdateWorkspaceVisibilityOutput {
        return update_workspace_visibility.execute(self, allocator, input, options);
    }

    pub fn evaluateDataTableValuesPaginator(self: *Self, params: evaluate_data_table_values.EvaluateDataTableValuesInput) paginator.EvaluateDataTableValuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCurrentMetricDataPaginator(self: *Self, params: get_current_metric_data.GetCurrentMetricDataInput) paginator.GetCurrentMetricDataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCurrentUserDataPaginator(self: *Self, params: get_current_user_data.GetCurrentUserDataInput) paginator.GetCurrentUserDataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getMetricDataPaginator(self: *Self, params: get_metric_data.GetMetricDataInput) paginator.GetMetricDataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getMetricDataV2Paginator(self: *Self, params: get_metric_data_v2.GetMetricDataV2Input) paginator.GetMetricDataV2Paginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAgentStatusesPaginator(self: *Self, params: list_agent_statuses.ListAgentStatusesInput) paginator.ListAgentStatusesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApprovedOriginsPaginator(self: *Self, params: list_approved_origins.ListApprovedOriginsInput) paginator.ListApprovedOriginsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAuthenticationProfilesPaginator(self: *Self, params: list_authentication_profiles.ListAuthenticationProfilesInput) paginator.ListAuthenticationProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBotsPaginator(self: *Self, params: list_bots.ListBotsInput) paginator.ListBotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChildHoursOfOperationsPaginator(self: *Self, params: list_child_hours_of_operations.ListChildHoursOfOperationsInput) paginator.ListChildHoursOfOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactEvaluationsPaginator(self: *Self, params: list_contact_evaluations.ListContactEvaluationsInput) paginator.ListContactEvaluationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactFlowModuleAliasesPaginator(self: *Self, params: list_contact_flow_module_aliases.ListContactFlowModuleAliasesInput) paginator.ListContactFlowModuleAliasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactFlowModuleVersionsPaginator(self: *Self, params: list_contact_flow_module_versions.ListContactFlowModuleVersionsInput) paginator.ListContactFlowModuleVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactFlowModulesPaginator(self: *Self, params: list_contact_flow_modules.ListContactFlowModulesInput) paginator.ListContactFlowModulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactFlowVersionsPaginator(self: *Self, params: list_contact_flow_versions.ListContactFlowVersionsInput) paginator.ListContactFlowVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactFlowsPaginator(self: *Self, params: list_contact_flows.ListContactFlowsInput) paginator.ListContactFlowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactReferencesPaginator(self: *Self, params: list_contact_references.ListContactReferencesInput) paginator.ListContactReferencesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataTableAttributesPaginator(self: *Self, params: list_data_table_attributes.ListDataTableAttributesInput) paginator.ListDataTableAttributesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataTablePrimaryValuesPaginator(self: *Self, params: list_data_table_primary_values.ListDataTablePrimaryValuesInput) paginator.ListDataTablePrimaryValuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataTableValuesPaginator(self: *Self, params: list_data_table_values.ListDataTableValuesInput) paginator.ListDataTableValuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataTablesPaginator(self: *Self, params: list_data_tables.ListDataTablesInput) paginator.ListDataTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDefaultVocabulariesPaginator(self: *Self, params: list_default_vocabularies.ListDefaultVocabulariesInput) paginator.ListDefaultVocabulariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntitySecurityProfilesPaginator(self: *Self, params: list_entity_security_profiles.ListEntitySecurityProfilesInput) paginator.ListEntitySecurityProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEvaluationFormVersionsPaginator(self: *Self, params: list_evaluation_form_versions.ListEvaluationFormVersionsInput) paginator.ListEvaluationFormVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEvaluationFormsPaginator(self: *Self, params: list_evaluation_forms.ListEvaluationFormsInput) paginator.ListEvaluationFormsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFlowAssociationsPaginator(self: *Self, params: list_flow_associations.ListFlowAssociationsInput) paginator.ListFlowAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHoursOfOperationOverridesPaginator(self: *Self, params: list_hours_of_operation_overrides.ListHoursOfOperationOverridesInput) paginator.ListHoursOfOperationOverridesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHoursOfOperationsPaginator(self: *Self, params: list_hours_of_operations.ListHoursOfOperationsInput) paginator.ListHoursOfOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstanceAttributesPaginator(self: *Self, params: list_instance_attributes.ListInstanceAttributesInput) paginator.ListInstanceAttributesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstanceStorageConfigsPaginator(self: *Self, params: list_instance_storage_configs.ListInstanceStorageConfigsInput) paginator.ListInstanceStorageConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstancesPaginator(self: *Self, params: list_instances.ListInstancesInput) paginator.ListInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIntegrationAssociationsPaginator(self: *Self, params: list_integration_associations.ListIntegrationAssociationsInput) paginator.ListIntegrationAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLambdaFunctionsPaginator(self: *Self, params: list_lambda_functions.ListLambdaFunctionsInput) paginator.ListLambdaFunctionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLexBotsPaginator(self: *Self, params: list_lex_bots.ListLexBotsInput) paginator.ListLexBotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPhoneNumbersPaginator(self: *Self, params: list_phone_numbers.ListPhoneNumbersInput) paginator.ListPhoneNumbersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPhoneNumbersV2Paginator(self: *Self, params: list_phone_numbers_v2.ListPhoneNumbersV2Input) paginator.ListPhoneNumbersV2Paginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPredefinedAttributesPaginator(self: *Self, params: list_predefined_attributes.ListPredefinedAttributesInput) paginator.ListPredefinedAttributesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPromptsPaginator(self: *Self, params: list_prompts.ListPromptsInput) paginator.ListPromptsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueueQuickConnectsPaginator(self: *Self, params: list_queue_quick_connects.ListQueueQuickConnectsInput) paginator.ListQueueQuickConnectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueuesPaginator(self: *Self, params: list_queues.ListQueuesInput) paginator.ListQueuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQuickConnectsPaginator(self: *Self, params: list_quick_connects.ListQuickConnectsInput) paginator.ListQuickConnectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRealtimeContactAnalysisSegmentsV2Paginator(self: *Self, params: list_realtime_contact_analysis_segments_v2.ListRealtimeContactAnalysisSegmentsV2Input) paginator.ListRealtimeContactAnalysisSegmentsV2Paginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoutingProfileManualAssignmentQueuesPaginator(self: *Self, params: list_routing_profile_manual_assignment_queues.ListRoutingProfileManualAssignmentQueuesInput) paginator.ListRoutingProfileManualAssignmentQueuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoutingProfileQueuesPaginator(self: *Self, params: list_routing_profile_queues.ListRoutingProfileQueuesInput) paginator.ListRoutingProfileQueuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoutingProfilesPaginator(self: *Self, params: list_routing_profiles.ListRoutingProfilesInput) paginator.ListRoutingProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRulesPaginator(self: *Self, params: list_rules.ListRulesInput) paginator.ListRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityKeysPaginator(self: *Self, params: list_security_keys.ListSecurityKeysInput) paginator.ListSecurityKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityProfileApplicationsPaginator(self: *Self, params: list_security_profile_applications.ListSecurityProfileApplicationsInput) paginator.ListSecurityProfileApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityProfileFlowModulesPaginator(self: *Self, params: list_security_profile_flow_modules.ListSecurityProfileFlowModulesInput) paginator.ListSecurityProfileFlowModulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityProfilePermissionsPaginator(self: *Self, params: list_security_profile_permissions.ListSecurityProfilePermissionsInput) paginator.ListSecurityProfilePermissionsPaginator {
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

    pub fn listTaskTemplatesPaginator(self: *Self, params: list_task_templates.ListTaskTemplatesInput) paginator.ListTaskTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTestCasesPaginator(self: *Self, params: list_test_cases.ListTestCasesInput) paginator.ListTestCasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrafficDistributionGroupUsersPaginator(self: *Self, params: list_traffic_distribution_group_users.ListTrafficDistributionGroupUsersInput) paginator.ListTrafficDistributionGroupUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrafficDistributionGroupsPaginator(self: *Self, params: list_traffic_distribution_groups.ListTrafficDistributionGroupsInput) paginator.ListTrafficDistributionGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUseCasesPaginator(self: *Self, params: list_use_cases.ListUseCasesInput) paginator.ListUseCasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUserHierarchyGroupsPaginator(self: *Self, params: list_user_hierarchy_groups.ListUserHierarchyGroupsInput) paginator.ListUserHierarchyGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUserProficienciesPaginator(self: *Self, params: list_user_proficiencies.ListUserProficienciesInput) paginator.ListUserProficienciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUsersPaginator(self: *Self, params: list_users.ListUsersInput) paginator.ListUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listViewVersionsPaginator(self: *Self, params: list_view_versions.ListViewVersionsInput) paginator.ListViewVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listViewsPaginator(self: *Self, params: list_views.ListViewsInput) paginator.ListViewsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkspacePagesPaginator(self: *Self, params: list_workspace_pages.ListWorkspacePagesInput) paginator.ListWorkspacePagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkspacesPaginator(self: *Self, params: list_workspaces.ListWorkspacesInput) paginator.ListWorkspacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchAgentStatusesPaginator(self: *Self, params: search_agent_statuses.SearchAgentStatusesInput) paginator.SearchAgentStatusesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchAvailablePhoneNumbersPaginator(self: *Self, params: search_available_phone_numbers.SearchAvailablePhoneNumbersInput) paginator.SearchAvailablePhoneNumbersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchContactFlowModulesPaginator(self: *Self, params: search_contact_flow_modules.SearchContactFlowModulesInput) paginator.SearchContactFlowModulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchContactFlowsPaginator(self: *Self, params: search_contact_flows.SearchContactFlowsInput) paginator.SearchContactFlowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchContactsPaginator(self: *Self, params: search_contacts.SearchContactsInput) paginator.SearchContactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchDataTablesPaginator(self: *Self, params: search_data_tables.SearchDataTablesInput) paginator.SearchDataTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchHoursOfOperationOverridesPaginator(self: *Self, params: search_hours_of_operation_overrides.SearchHoursOfOperationOverridesInput) paginator.SearchHoursOfOperationOverridesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchHoursOfOperationsPaginator(self: *Self, params: search_hours_of_operations.SearchHoursOfOperationsInput) paginator.SearchHoursOfOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchPredefinedAttributesPaginator(self: *Self, params: search_predefined_attributes.SearchPredefinedAttributesInput) paginator.SearchPredefinedAttributesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchPromptsPaginator(self: *Self, params: search_prompts.SearchPromptsInput) paginator.SearchPromptsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchQueuesPaginator(self: *Self, params: search_queues.SearchQueuesInput) paginator.SearchQueuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchQuickConnectsPaginator(self: *Self, params: search_quick_connects.SearchQuickConnectsInput) paginator.SearchQuickConnectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchResourceTagsPaginator(self: *Self, params: search_resource_tags.SearchResourceTagsInput) paginator.SearchResourceTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchRoutingProfilesPaginator(self: *Self, params: search_routing_profiles.SearchRoutingProfilesInput) paginator.SearchRoutingProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchSecurityProfilesPaginator(self: *Self, params: search_security_profiles.SearchSecurityProfilesInput) paginator.SearchSecurityProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchTestCasesPaginator(self: *Self, params: search_test_cases.SearchTestCasesInput) paginator.SearchTestCasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchUserHierarchyGroupsPaginator(self: *Self, params: search_user_hierarchy_groups.SearchUserHierarchyGroupsInput) paginator.SearchUserHierarchyGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchUsersPaginator(self: *Self, params: search_users.SearchUsersInput) paginator.SearchUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchViewsPaginator(self: *Self, params: search_views.SearchViewsInput) paginator.SearchViewsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchVocabulariesPaginator(self: *Self, params: search_vocabularies.SearchVocabulariesInput) paginator.SearchVocabulariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchWorkspaceAssociationsPaginator(self: *Self, params: search_workspace_associations.SearchWorkspaceAssociationsInput) paginator.SearchWorkspaceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchWorkspacesPaginator(self: *Self, params: search_workspaces.SearchWorkspacesInput) paginator.SearchWorkspacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
