const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        alarms_limit_exceeded_exception: AlarmsLimitExceededException,
        application_already_exists_exception: ApplicationAlreadyExistsException,
        application_does_not_exist_exception: ApplicationDoesNotExistException,
        application_limit_exceeded_exception: ApplicationLimitExceededException,
        application_name_required_exception: ApplicationNameRequiredException,
        arn_not_supported_exception: ArnNotSupportedException,
        batch_limit_exceeded_exception: BatchLimitExceededException,
        bucket_name_filter_required_exception: BucketNameFilterRequiredException,
        deployment_already_completed_exception: DeploymentAlreadyCompletedException,
        deployment_config_already_exists_exception: DeploymentConfigAlreadyExistsException,
        deployment_config_does_not_exist_exception: DeploymentConfigDoesNotExistException,
        deployment_config_in_use_exception: DeploymentConfigInUseException,
        deployment_config_limit_exceeded_exception: DeploymentConfigLimitExceededException,
        deployment_config_name_required_exception: DeploymentConfigNameRequiredException,
        deployment_does_not_exist_exception: DeploymentDoesNotExistException,
        deployment_group_already_exists_exception: DeploymentGroupAlreadyExistsException,
        deployment_group_does_not_exist_exception: DeploymentGroupDoesNotExistException,
        deployment_group_limit_exceeded_exception: DeploymentGroupLimitExceededException,
        deployment_group_name_required_exception: DeploymentGroupNameRequiredException,
        deployment_id_required_exception: DeploymentIdRequiredException,
        deployment_is_not_in_ready_state_exception: DeploymentIsNotInReadyStateException,
        deployment_limit_exceeded_exception: DeploymentLimitExceededException,
        deployment_not_started_exception: DeploymentNotStartedException,
        deployment_target_does_not_exist_exception: DeploymentTargetDoesNotExistException,
        deployment_target_id_required_exception: DeploymentTargetIdRequiredException,
        deployment_target_list_size_exceeded_exception: DeploymentTargetListSizeExceededException,
        description_too_long_exception: DescriptionTooLongException,
        ecs_service_mapping_limit_exceeded_exception: ECSServiceMappingLimitExceededException,
        git_hub_account_token_does_not_exist_exception: GitHubAccountTokenDoesNotExistException,
        git_hub_account_token_name_required_exception: GitHubAccountTokenNameRequiredException,
        iam_arn_required_exception: IamArnRequiredException,
        iam_session_arn_already_registered_exception: IamSessionArnAlreadyRegisteredException,
        iam_user_arn_already_registered_exception: IamUserArnAlreadyRegisteredException,
        iam_user_arn_required_exception: IamUserArnRequiredException,
        instance_does_not_exist_exception: InstanceDoesNotExistException,
        instance_id_required_exception: InstanceIdRequiredException,
        instance_limit_exceeded_exception: InstanceLimitExceededException,
        instance_name_already_registered_exception: InstanceNameAlreadyRegisteredException,
        instance_name_required_exception: InstanceNameRequiredException,
        instance_not_registered_exception: InstanceNotRegisteredException,
        invalid_alarm_config_exception: InvalidAlarmConfigException,
        invalid_application_name_exception: InvalidApplicationNameException,
        invalid_arn_exception: InvalidArnException,
        invalid_auto_rollback_config_exception: InvalidAutoRollbackConfigException,
        invalid_auto_scaling_group_exception: InvalidAutoScalingGroupException,
        invalid_blue_green_deployment_configuration_exception: InvalidBlueGreenDeploymentConfigurationException,
        invalid_bucket_name_filter_exception: InvalidBucketNameFilterException,
        invalid_compute_platform_exception: InvalidComputePlatformException,
        invalid_deployed_state_filter_exception: InvalidDeployedStateFilterException,
        invalid_deployment_config_name_exception: InvalidDeploymentConfigNameException,
        invalid_deployment_group_name_exception: InvalidDeploymentGroupNameException,
        invalid_deployment_id_exception: InvalidDeploymentIdException,
        invalid_deployment_instance_type_exception: InvalidDeploymentInstanceTypeException,
        invalid_deployment_status_exception: InvalidDeploymentStatusException,
        invalid_deployment_style_exception: InvalidDeploymentStyleException,
        invalid_deployment_target_id_exception: InvalidDeploymentTargetIdException,
        invalid_deployment_wait_type_exception: InvalidDeploymentWaitTypeException,
        invalid_ec2_tag_combination_exception: InvalidEC2TagCombinationException,
        invalid_ec2_tag_exception: InvalidEC2TagException,
        invalid_ecs_service_exception: InvalidECSServiceException,
        invalid_external_id_exception: InvalidExternalIdException,
        invalid_file_exists_behavior_exception: InvalidFileExistsBehaviorException,
        invalid_git_hub_account_token_exception: InvalidGitHubAccountTokenException,
        invalid_git_hub_account_token_name_exception: InvalidGitHubAccountTokenNameException,
        invalid_iam_session_arn_exception: InvalidIamSessionArnException,
        invalid_iam_user_arn_exception: InvalidIamUserArnException,
        invalid_ignore_application_stop_failures_value_exception: InvalidIgnoreApplicationStopFailuresValueException,
        invalid_input_exception: InvalidInputException,
        invalid_instance_name_exception: InvalidInstanceNameException,
        invalid_instance_status_exception: InvalidInstanceStatusException,
        invalid_instance_type_exception: InvalidInstanceTypeException,
        invalid_key_prefix_filter_exception: InvalidKeyPrefixFilterException,
        invalid_lifecycle_event_hook_execution_id_exception: InvalidLifecycleEventHookExecutionIdException,
        invalid_lifecycle_event_hook_execution_status_exception: InvalidLifecycleEventHookExecutionStatusException,
        invalid_load_balancer_info_exception: InvalidLoadBalancerInfoException,
        invalid_minimum_healthy_host_value_exception: InvalidMinimumHealthyHostValueException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_on_premises_tag_combination_exception: InvalidOnPremisesTagCombinationException,
        invalid_operation_exception: InvalidOperationException,
        invalid_registration_status_exception: InvalidRegistrationStatusException,
        invalid_revision_exception: InvalidRevisionException,
        invalid_role_exception: InvalidRoleException,
        invalid_sort_by_exception: InvalidSortByException,
        invalid_sort_order_exception: InvalidSortOrderException,
        invalid_tag_exception: InvalidTagException,
        invalid_tag_filter_exception: InvalidTagFilterException,
        invalid_tags_to_add_exception: InvalidTagsToAddException,
        invalid_target_filter_name_exception: InvalidTargetFilterNameException,
        invalid_target_group_pair_exception: InvalidTargetGroupPairException,
        invalid_target_instances_exception: InvalidTargetInstancesException,
        invalid_time_range_exception: InvalidTimeRangeException,
        invalid_traffic_routing_configuration_exception: InvalidTrafficRoutingConfigurationException,
        invalid_trigger_config_exception: InvalidTriggerConfigException,
        invalid_update_outdated_instances_only_value_exception: InvalidUpdateOutdatedInstancesOnlyValueException,
        invalid_zonal_deployment_configuration_exception: InvalidZonalDeploymentConfigurationException,
        lifecycle_event_already_completed_exception: LifecycleEventAlreadyCompletedException,
        lifecycle_hook_limit_exceeded_exception: LifecycleHookLimitExceededException,
        multiple_iam_arns_provided_exception: MultipleIamArnsProvidedException,
        operation_not_supported_exception: OperationNotSupportedException,
        resource_arn_required_exception: ResourceArnRequiredException,
        resource_validation_exception: ResourceValidationException,
        revision_does_not_exist_exception: RevisionDoesNotExistException,
        revision_required_exception: RevisionRequiredException,
        role_required_exception: RoleRequiredException,
        tag_limit_exceeded_exception: TagLimitExceededException,
        tag_required_exception: TagRequiredException,
        tag_set_list_limit_exceeded_exception: TagSetListLimitExceededException,
        throttling_exception: ThrottlingException,
        trigger_targets_limit_exceeded_exception: TriggerTargetsLimitExceededException,
        unsupported_action_for_deployment_type_exception: UnsupportedActionForDeploymentTypeException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .alarms_limit_exceeded_exception => "AlarmsLimitExceededException",
                .application_already_exists_exception => "ApplicationAlreadyExistsException",
                .application_does_not_exist_exception => "ApplicationDoesNotExistException",
                .application_limit_exceeded_exception => "ApplicationLimitExceededException",
                .application_name_required_exception => "ApplicationNameRequiredException",
                .arn_not_supported_exception => "ArnNotSupportedException",
                .batch_limit_exceeded_exception => "BatchLimitExceededException",
                .bucket_name_filter_required_exception => "BucketNameFilterRequiredException",
                .deployment_already_completed_exception => "DeploymentAlreadyCompletedException",
                .deployment_config_already_exists_exception => "DeploymentConfigAlreadyExistsException",
                .deployment_config_does_not_exist_exception => "DeploymentConfigDoesNotExistException",
                .deployment_config_in_use_exception => "DeploymentConfigInUseException",
                .deployment_config_limit_exceeded_exception => "DeploymentConfigLimitExceededException",
                .deployment_config_name_required_exception => "DeploymentConfigNameRequiredException",
                .deployment_does_not_exist_exception => "DeploymentDoesNotExistException",
                .deployment_group_already_exists_exception => "DeploymentGroupAlreadyExistsException",
                .deployment_group_does_not_exist_exception => "DeploymentGroupDoesNotExistException",
                .deployment_group_limit_exceeded_exception => "DeploymentGroupLimitExceededException",
                .deployment_group_name_required_exception => "DeploymentGroupNameRequiredException",
                .deployment_id_required_exception => "DeploymentIdRequiredException",
                .deployment_is_not_in_ready_state_exception => "DeploymentIsNotInReadyStateException",
                .deployment_limit_exceeded_exception => "DeploymentLimitExceededException",
                .deployment_not_started_exception => "DeploymentNotStartedException",
                .deployment_target_does_not_exist_exception => "DeploymentTargetDoesNotExistException",
                .deployment_target_id_required_exception => "DeploymentTargetIdRequiredException",
                .deployment_target_list_size_exceeded_exception => "DeploymentTargetListSizeExceededException",
                .description_too_long_exception => "DescriptionTooLongException",
                .ecs_service_mapping_limit_exceeded_exception => "ECSServiceMappingLimitExceededException",
                .git_hub_account_token_does_not_exist_exception => "GitHubAccountTokenDoesNotExistException",
                .git_hub_account_token_name_required_exception => "GitHubAccountTokenNameRequiredException",
                .iam_arn_required_exception => "IamArnRequiredException",
                .iam_session_arn_already_registered_exception => "IamSessionArnAlreadyRegisteredException",
                .iam_user_arn_already_registered_exception => "IamUserArnAlreadyRegisteredException",
                .iam_user_arn_required_exception => "IamUserArnRequiredException",
                .instance_does_not_exist_exception => "InstanceDoesNotExistException",
                .instance_id_required_exception => "InstanceIdRequiredException",
                .instance_limit_exceeded_exception => "InstanceLimitExceededException",
                .instance_name_already_registered_exception => "InstanceNameAlreadyRegisteredException",
                .instance_name_required_exception => "InstanceNameRequiredException",
                .instance_not_registered_exception => "InstanceNotRegisteredException",
                .invalid_alarm_config_exception => "InvalidAlarmConfigException",
                .invalid_application_name_exception => "InvalidApplicationNameException",
                .invalid_arn_exception => "InvalidArnException",
                .invalid_auto_rollback_config_exception => "InvalidAutoRollbackConfigException",
                .invalid_auto_scaling_group_exception => "InvalidAutoScalingGroupException",
                .invalid_blue_green_deployment_configuration_exception => "InvalidBlueGreenDeploymentConfigurationException",
                .invalid_bucket_name_filter_exception => "InvalidBucketNameFilterException",
                .invalid_compute_platform_exception => "InvalidComputePlatformException",
                .invalid_deployed_state_filter_exception => "InvalidDeployedStateFilterException",
                .invalid_deployment_config_name_exception => "InvalidDeploymentConfigNameException",
                .invalid_deployment_group_name_exception => "InvalidDeploymentGroupNameException",
                .invalid_deployment_id_exception => "InvalidDeploymentIdException",
                .invalid_deployment_instance_type_exception => "InvalidDeploymentInstanceTypeException",
                .invalid_deployment_status_exception => "InvalidDeploymentStatusException",
                .invalid_deployment_style_exception => "InvalidDeploymentStyleException",
                .invalid_deployment_target_id_exception => "InvalidDeploymentTargetIdException",
                .invalid_deployment_wait_type_exception => "InvalidDeploymentWaitTypeException",
                .invalid_ec2_tag_combination_exception => "InvalidEC2TagCombinationException",
                .invalid_ec2_tag_exception => "InvalidEC2TagException",
                .invalid_ecs_service_exception => "InvalidECSServiceException",
                .invalid_external_id_exception => "InvalidExternalIdException",
                .invalid_file_exists_behavior_exception => "InvalidFileExistsBehaviorException",
                .invalid_git_hub_account_token_exception => "InvalidGitHubAccountTokenException",
                .invalid_git_hub_account_token_name_exception => "InvalidGitHubAccountTokenNameException",
                .invalid_iam_session_arn_exception => "InvalidIamSessionArnException",
                .invalid_iam_user_arn_exception => "InvalidIamUserArnException",
                .invalid_ignore_application_stop_failures_value_exception => "InvalidIgnoreApplicationStopFailuresValueException",
                .invalid_input_exception => "InvalidInputException",
                .invalid_instance_name_exception => "InvalidInstanceNameException",
                .invalid_instance_status_exception => "InvalidInstanceStatusException",
                .invalid_instance_type_exception => "InvalidInstanceTypeException",
                .invalid_key_prefix_filter_exception => "InvalidKeyPrefixFilterException",
                .invalid_lifecycle_event_hook_execution_id_exception => "InvalidLifecycleEventHookExecutionIdException",
                .invalid_lifecycle_event_hook_execution_status_exception => "InvalidLifecycleEventHookExecutionStatusException",
                .invalid_load_balancer_info_exception => "InvalidLoadBalancerInfoException",
                .invalid_minimum_healthy_host_value_exception => "InvalidMinimumHealthyHostValueException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_on_premises_tag_combination_exception => "InvalidOnPremisesTagCombinationException",
                .invalid_operation_exception => "InvalidOperationException",
                .invalid_registration_status_exception => "InvalidRegistrationStatusException",
                .invalid_revision_exception => "InvalidRevisionException",
                .invalid_role_exception => "InvalidRoleException",
                .invalid_sort_by_exception => "InvalidSortByException",
                .invalid_sort_order_exception => "InvalidSortOrderException",
                .invalid_tag_exception => "InvalidTagException",
                .invalid_tag_filter_exception => "InvalidTagFilterException",
                .invalid_tags_to_add_exception => "InvalidTagsToAddException",
                .invalid_target_filter_name_exception => "InvalidTargetFilterNameException",
                .invalid_target_group_pair_exception => "InvalidTargetGroupPairException",
                .invalid_target_instances_exception => "InvalidTargetInstancesException",
                .invalid_time_range_exception => "InvalidTimeRangeException",
                .invalid_traffic_routing_configuration_exception => "InvalidTrafficRoutingConfigurationException",
                .invalid_trigger_config_exception => "InvalidTriggerConfigException",
                .invalid_update_outdated_instances_only_value_exception => "InvalidUpdateOutdatedInstancesOnlyValueException",
                .invalid_zonal_deployment_configuration_exception => "InvalidZonalDeploymentConfigurationException",
                .lifecycle_event_already_completed_exception => "LifecycleEventAlreadyCompletedException",
                .lifecycle_hook_limit_exceeded_exception => "LifecycleHookLimitExceededException",
                .multiple_iam_arns_provided_exception => "MultipleIamArnsProvidedException",
                .operation_not_supported_exception => "OperationNotSupportedException",
                .resource_arn_required_exception => "ResourceArnRequiredException",
                .resource_validation_exception => "ResourceValidationException",
                .revision_does_not_exist_exception => "RevisionDoesNotExistException",
                .revision_required_exception => "RevisionRequiredException",
                .role_required_exception => "RoleRequiredException",
                .tag_limit_exceeded_exception => "TagLimitExceededException",
                .tag_required_exception => "TagRequiredException",
                .tag_set_list_limit_exceeded_exception => "TagSetListLimitExceededException",
                .throttling_exception => "ThrottlingException",
                .trigger_targets_limit_exceeded_exception => "TriggerTargetsLimitExceededException",
                .unsupported_action_for_deployment_type_exception => "UnsupportedActionForDeploymentTypeException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .alarms_limit_exceeded_exception => |e| e.message,
                .application_already_exists_exception => |e| e.message,
                .application_does_not_exist_exception => |e| e.message,
                .application_limit_exceeded_exception => |e| e.message,
                .application_name_required_exception => |e| e.message,
                .arn_not_supported_exception => |e| e.message,
                .batch_limit_exceeded_exception => |e| e.message,
                .bucket_name_filter_required_exception => |e| e.message,
                .deployment_already_completed_exception => |e| e.message,
                .deployment_config_already_exists_exception => |e| e.message,
                .deployment_config_does_not_exist_exception => |e| e.message,
                .deployment_config_in_use_exception => |e| e.message,
                .deployment_config_limit_exceeded_exception => |e| e.message,
                .deployment_config_name_required_exception => |e| e.message,
                .deployment_does_not_exist_exception => |e| e.message,
                .deployment_group_already_exists_exception => |e| e.message,
                .deployment_group_does_not_exist_exception => |e| e.message,
                .deployment_group_limit_exceeded_exception => |e| e.message,
                .deployment_group_name_required_exception => |e| e.message,
                .deployment_id_required_exception => |e| e.message,
                .deployment_is_not_in_ready_state_exception => |e| e.message,
                .deployment_limit_exceeded_exception => |e| e.message,
                .deployment_not_started_exception => |e| e.message,
                .deployment_target_does_not_exist_exception => |e| e.message,
                .deployment_target_id_required_exception => |e| e.message,
                .deployment_target_list_size_exceeded_exception => |e| e.message,
                .description_too_long_exception => |e| e.message,
                .ecs_service_mapping_limit_exceeded_exception => |e| e.message,
                .git_hub_account_token_does_not_exist_exception => |e| e.message,
                .git_hub_account_token_name_required_exception => |e| e.message,
                .iam_arn_required_exception => |e| e.message,
                .iam_session_arn_already_registered_exception => |e| e.message,
                .iam_user_arn_already_registered_exception => |e| e.message,
                .iam_user_arn_required_exception => |e| e.message,
                .instance_does_not_exist_exception => |e| e.message,
                .instance_id_required_exception => |e| e.message,
                .instance_limit_exceeded_exception => |e| e.message,
                .instance_name_already_registered_exception => |e| e.message,
                .instance_name_required_exception => |e| e.message,
                .instance_not_registered_exception => |e| e.message,
                .invalid_alarm_config_exception => |e| e.message,
                .invalid_application_name_exception => |e| e.message,
                .invalid_arn_exception => |e| e.message,
                .invalid_auto_rollback_config_exception => |e| e.message,
                .invalid_auto_scaling_group_exception => |e| e.message,
                .invalid_blue_green_deployment_configuration_exception => |e| e.message,
                .invalid_bucket_name_filter_exception => |e| e.message,
                .invalid_compute_platform_exception => |e| e.message,
                .invalid_deployed_state_filter_exception => |e| e.message,
                .invalid_deployment_config_name_exception => |e| e.message,
                .invalid_deployment_group_name_exception => |e| e.message,
                .invalid_deployment_id_exception => |e| e.message,
                .invalid_deployment_instance_type_exception => |e| e.message,
                .invalid_deployment_status_exception => |e| e.message,
                .invalid_deployment_style_exception => |e| e.message,
                .invalid_deployment_target_id_exception => |e| e.message,
                .invalid_deployment_wait_type_exception => |e| e.message,
                .invalid_ec2_tag_combination_exception => |e| e.message,
                .invalid_ec2_tag_exception => |e| e.message,
                .invalid_ecs_service_exception => |e| e.message,
                .invalid_external_id_exception => |e| e.message,
                .invalid_file_exists_behavior_exception => |e| e.message,
                .invalid_git_hub_account_token_exception => |e| e.message,
                .invalid_git_hub_account_token_name_exception => |e| e.message,
                .invalid_iam_session_arn_exception => |e| e.message,
                .invalid_iam_user_arn_exception => |e| e.message,
                .invalid_ignore_application_stop_failures_value_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .invalid_instance_name_exception => |e| e.message,
                .invalid_instance_status_exception => |e| e.message,
                .invalid_instance_type_exception => |e| e.message,
                .invalid_key_prefix_filter_exception => |e| e.message,
                .invalid_lifecycle_event_hook_execution_id_exception => |e| e.message,
                .invalid_lifecycle_event_hook_execution_status_exception => |e| e.message,
                .invalid_load_balancer_info_exception => |e| e.message,
                .invalid_minimum_healthy_host_value_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_on_premises_tag_combination_exception => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .invalid_registration_status_exception => |e| e.message,
                .invalid_revision_exception => |e| e.message,
                .invalid_role_exception => |e| e.message,
                .invalid_sort_by_exception => |e| e.message,
                .invalid_sort_order_exception => |e| e.message,
                .invalid_tag_exception => |e| e.message,
                .invalid_tag_filter_exception => |e| e.message,
                .invalid_tags_to_add_exception => |e| e.message,
                .invalid_target_filter_name_exception => |e| e.message,
                .invalid_target_group_pair_exception => |e| e.message,
                .invalid_target_instances_exception => |e| e.message,
                .invalid_time_range_exception => |e| e.message,
                .invalid_traffic_routing_configuration_exception => |e| e.message,
                .invalid_trigger_config_exception => |e| e.message,
                .invalid_update_outdated_instances_only_value_exception => |e| e.message,
                .invalid_zonal_deployment_configuration_exception => |e| e.message,
                .lifecycle_event_already_completed_exception => |e| e.message,
                .lifecycle_hook_limit_exceeded_exception => |e| e.message,
                .multiple_iam_arns_provided_exception => |e| e.message,
                .operation_not_supported_exception => |e| e.message,
                .resource_arn_required_exception => |e| e.message,
                .resource_validation_exception => |e| e.message,
                .revision_does_not_exist_exception => |e| e.message,
                .revision_required_exception => |e| e.message,
                .role_required_exception => |e| e.message,
                .tag_limit_exceeded_exception => |e| e.message,
                .tag_required_exception => |e| e.message,
                .tag_set_list_limit_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .trigger_targets_limit_exceeded_exception => |e| e.message,
                .unsupported_action_for_deployment_type_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .alarms_limit_exceeded_exception => 400,
                .application_already_exists_exception => 400,
                .application_does_not_exist_exception => 400,
                .application_limit_exceeded_exception => 400,
                .application_name_required_exception => 400,
                .arn_not_supported_exception => 400,
                .batch_limit_exceeded_exception => 400,
                .bucket_name_filter_required_exception => 400,
                .deployment_already_completed_exception => 400,
                .deployment_config_already_exists_exception => 400,
                .deployment_config_does_not_exist_exception => 400,
                .deployment_config_in_use_exception => 400,
                .deployment_config_limit_exceeded_exception => 400,
                .deployment_config_name_required_exception => 400,
                .deployment_does_not_exist_exception => 400,
                .deployment_group_already_exists_exception => 400,
                .deployment_group_does_not_exist_exception => 400,
                .deployment_group_limit_exceeded_exception => 400,
                .deployment_group_name_required_exception => 400,
                .deployment_id_required_exception => 400,
                .deployment_is_not_in_ready_state_exception => 400,
                .deployment_limit_exceeded_exception => 400,
                .deployment_not_started_exception => 400,
                .deployment_target_does_not_exist_exception => 400,
                .deployment_target_id_required_exception => 400,
                .deployment_target_list_size_exceeded_exception => 400,
                .description_too_long_exception => 400,
                .ecs_service_mapping_limit_exceeded_exception => 400,
                .git_hub_account_token_does_not_exist_exception => 400,
                .git_hub_account_token_name_required_exception => 400,
                .iam_arn_required_exception => 400,
                .iam_session_arn_already_registered_exception => 400,
                .iam_user_arn_already_registered_exception => 400,
                .iam_user_arn_required_exception => 400,
                .instance_does_not_exist_exception => 400,
                .instance_id_required_exception => 400,
                .instance_limit_exceeded_exception => 400,
                .instance_name_already_registered_exception => 400,
                .instance_name_required_exception => 400,
                .instance_not_registered_exception => 400,
                .invalid_alarm_config_exception => 400,
                .invalid_application_name_exception => 400,
                .invalid_arn_exception => 400,
                .invalid_auto_rollback_config_exception => 400,
                .invalid_auto_scaling_group_exception => 400,
                .invalid_blue_green_deployment_configuration_exception => 400,
                .invalid_bucket_name_filter_exception => 400,
                .invalid_compute_platform_exception => 400,
                .invalid_deployed_state_filter_exception => 400,
                .invalid_deployment_config_name_exception => 400,
                .invalid_deployment_group_name_exception => 400,
                .invalid_deployment_id_exception => 400,
                .invalid_deployment_instance_type_exception => 400,
                .invalid_deployment_status_exception => 400,
                .invalid_deployment_style_exception => 400,
                .invalid_deployment_target_id_exception => 400,
                .invalid_deployment_wait_type_exception => 400,
                .invalid_ec2_tag_combination_exception => 400,
                .invalid_ec2_tag_exception => 400,
                .invalid_ecs_service_exception => 400,
                .invalid_external_id_exception => 400,
                .invalid_file_exists_behavior_exception => 400,
                .invalid_git_hub_account_token_exception => 400,
                .invalid_git_hub_account_token_name_exception => 400,
                .invalid_iam_session_arn_exception => 400,
                .invalid_iam_user_arn_exception => 400,
                .invalid_ignore_application_stop_failures_value_exception => 400,
                .invalid_input_exception => 400,
                .invalid_instance_name_exception => 400,
                .invalid_instance_status_exception => 400,
                .invalid_instance_type_exception => 400,
                .invalid_key_prefix_filter_exception => 400,
                .invalid_lifecycle_event_hook_execution_id_exception => 400,
                .invalid_lifecycle_event_hook_execution_status_exception => 400,
                .invalid_load_balancer_info_exception => 400,
                .invalid_minimum_healthy_host_value_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_on_premises_tag_combination_exception => 400,
                .invalid_operation_exception => 400,
                .invalid_registration_status_exception => 400,
                .invalid_revision_exception => 400,
                .invalid_role_exception => 400,
                .invalid_sort_by_exception => 400,
                .invalid_sort_order_exception => 400,
                .invalid_tag_exception => 400,
                .invalid_tag_filter_exception => 400,
                .invalid_tags_to_add_exception => 400,
                .invalid_target_filter_name_exception => 400,
                .invalid_target_group_pair_exception => 400,
                .invalid_target_instances_exception => 400,
                .invalid_time_range_exception => 400,
                .invalid_traffic_routing_configuration_exception => 400,
                .invalid_trigger_config_exception => 400,
                .invalid_update_outdated_instances_only_value_exception => 400,
                .invalid_zonal_deployment_configuration_exception => 400,
                .lifecycle_event_already_completed_exception => 400,
                .lifecycle_hook_limit_exceeded_exception => 400,
                .multiple_iam_arns_provided_exception => 400,
                .operation_not_supported_exception => 400,
                .resource_arn_required_exception => 400,
                .resource_validation_exception => 400,
                .revision_does_not_exist_exception => 400,
                .revision_required_exception => 400,
                .role_required_exception => 400,
                .tag_limit_exceeded_exception => 400,
                .tag_required_exception => 400,
                .tag_set_list_limit_exceeded_exception => 400,
                .throttling_exception => 400,
                .trigger_targets_limit_exceeded_exception => 400,
                .unsupported_action_for_deployment_type_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .alarms_limit_exceeded_exception => |e| e.request_id,
                .application_already_exists_exception => |e| e.request_id,
                .application_does_not_exist_exception => |e| e.request_id,
                .application_limit_exceeded_exception => |e| e.request_id,
                .application_name_required_exception => |e| e.request_id,
                .arn_not_supported_exception => |e| e.request_id,
                .batch_limit_exceeded_exception => |e| e.request_id,
                .bucket_name_filter_required_exception => |e| e.request_id,
                .deployment_already_completed_exception => |e| e.request_id,
                .deployment_config_already_exists_exception => |e| e.request_id,
                .deployment_config_does_not_exist_exception => |e| e.request_id,
                .deployment_config_in_use_exception => |e| e.request_id,
                .deployment_config_limit_exceeded_exception => |e| e.request_id,
                .deployment_config_name_required_exception => |e| e.request_id,
                .deployment_does_not_exist_exception => |e| e.request_id,
                .deployment_group_already_exists_exception => |e| e.request_id,
                .deployment_group_does_not_exist_exception => |e| e.request_id,
                .deployment_group_limit_exceeded_exception => |e| e.request_id,
                .deployment_group_name_required_exception => |e| e.request_id,
                .deployment_id_required_exception => |e| e.request_id,
                .deployment_is_not_in_ready_state_exception => |e| e.request_id,
                .deployment_limit_exceeded_exception => |e| e.request_id,
                .deployment_not_started_exception => |e| e.request_id,
                .deployment_target_does_not_exist_exception => |e| e.request_id,
                .deployment_target_id_required_exception => |e| e.request_id,
                .deployment_target_list_size_exceeded_exception => |e| e.request_id,
                .description_too_long_exception => |e| e.request_id,
                .ecs_service_mapping_limit_exceeded_exception => |e| e.request_id,
                .git_hub_account_token_does_not_exist_exception => |e| e.request_id,
                .git_hub_account_token_name_required_exception => |e| e.request_id,
                .iam_arn_required_exception => |e| e.request_id,
                .iam_session_arn_already_registered_exception => |e| e.request_id,
                .iam_user_arn_already_registered_exception => |e| e.request_id,
                .iam_user_arn_required_exception => |e| e.request_id,
                .instance_does_not_exist_exception => |e| e.request_id,
                .instance_id_required_exception => |e| e.request_id,
                .instance_limit_exceeded_exception => |e| e.request_id,
                .instance_name_already_registered_exception => |e| e.request_id,
                .instance_name_required_exception => |e| e.request_id,
                .instance_not_registered_exception => |e| e.request_id,
                .invalid_alarm_config_exception => |e| e.request_id,
                .invalid_application_name_exception => |e| e.request_id,
                .invalid_arn_exception => |e| e.request_id,
                .invalid_auto_rollback_config_exception => |e| e.request_id,
                .invalid_auto_scaling_group_exception => |e| e.request_id,
                .invalid_blue_green_deployment_configuration_exception => |e| e.request_id,
                .invalid_bucket_name_filter_exception => |e| e.request_id,
                .invalid_compute_platform_exception => |e| e.request_id,
                .invalid_deployed_state_filter_exception => |e| e.request_id,
                .invalid_deployment_config_name_exception => |e| e.request_id,
                .invalid_deployment_group_name_exception => |e| e.request_id,
                .invalid_deployment_id_exception => |e| e.request_id,
                .invalid_deployment_instance_type_exception => |e| e.request_id,
                .invalid_deployment_status_exception => |e| e.request_id,
                .invalid_deployment_style_exception => |e| e.request_id,
                .invalid_deployment_target_id_exception => |e| e.request_id,
                .invalid_deployment_wait_type_exception => |e| e.request_id,
                .invalid_ec2_tag_combination_exception => |e| e.request_id,
                .invalid_ec2_tag_exception => |e| e.request_id,
                .invalid_ecs_service_exception => |e| e.request_id,
                .invalid_external_id_exception => |e| e.request_id,
                .invalid_file_exists_behavior_exception => |e| e.request_id,
                .invalid_git_hub_account_token_exception => |e| e.request_id,
                .invalid_git_hub_account_token_name_exception => |e| e.request_id,
                .invalid_iam_session_arn_exception => |e| e.request_id,
                .invalid_iam_user_arn_exception => |e| e.request_id,
                .invalid_ignore_application_stop_failures_value_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .invalid_instance_name_exception => |e| e.request_id,
                .invalid_instance_status_exception => |e| e.request_id,
                .invalid_instance_type_exception => |e| e.request_id,
                .invalid_key_prefix_filter_exception => |e| e.request_id,
                .invalid_lifecycle_event_hook_execution_id_exception => |e| e.request_id,
                .invalid_lifecycle_event_hook_execution_status_exception => |e| e.request_id,
                .invalid_load_balancer_info_exception => |e| e.request_id,
                .invalid_minimum_healthy_host_value_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_on_premises_tag_combination_exception => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .invalid_registration_status_exception => |e| e.request_id,
                .invalid_revision_exception => |e| e.request_id,
                .invalid_role_exception => |e| e.request_id,
                .invalid_sort_by_exception => |e| e.request_id,
                .invalid_sort_order_exception => |e| e.request_id,
                .invalid_tag_exception => |e| e.request_id,
                .invalid_tag_filter_exception => |e| e.request_id,
                .invalid_tags_to_add_exception => |e| e.request_id,
                .invalid_target_filter_name_exception => |e| e.request_id,
                .invalid_target_group_pair_exception => |e| e.request_id,
                .invalid_target_instances_exception => |e| e.request_id,
                .invalid_time_range_exception => |e| e.request_id,
                .invalid_traffic_routing_configuration_exception => |e| e.request_id,
                .invalid_trigger_config_exception => |e| e.request_id,
                .invalid_update_outdated_instances_only_value_exception => |e| e.request_id,
                .invalid_zonal_deployment_configuration_exception => |e| e.request_id,
                .lifecycle_event_already_completed_exception => |e| e.request_id,
                .lifecycle_hook_limit_exceeded_exception => |e| e.request_id,
                .multiple_iam_arns_provided_exception => |e| e.request_id,
                .operation_not_supported_exception => |e| e.request_id,
                .resource_arn_required_exception => |e| e.request_id,
                .resource_validation_exception => |e| e.request_id,
                .revision_does_not_exist_exception => |e| e.request_id,
                .revision_required_exception => |e| e.request_id,
                .role_required_exception => |e| e.request_id,
                .tag_limit_exceeded_exception => |e| e.request_id,
                .tag_required_exception => |e| e.request_id,
                .tag_set_list_limit_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .trigger_targets_limit_exceeded_exception => |e| e.request_id,
                .unsupported_action_for_deployment_type_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

/// The maximum number of alarms for a deployment group (10) was exceeded.
pub const AlarmsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An application with the specified name with the user or Amazon Web Services
/// account
/// already exists.
pub const ApplicationAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The application does not exist with the user or Amazon Web Services account.
pub const ApplicationDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// More applications were attempted to be created than are allowed.
pub const ApplicationLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The minimum number of required application names was not specified.
pub const ApplicationNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified ARN is not supported. For example, it might be an ARN for a
/// resource
/// that is not expected.
pub const ArnNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of names or IDs allowed for this request (100) was
/// exceeded.
pub const BatchLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A bucket name is required, but was not provided.
pub const BucketNameFilterRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment is already complete.
pub const DeploymentAlreadyCompletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A deployment configuration with the specified name with the user or Amazon
/// Web Services account already exists.
pub const DeploymentConfigAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment configuration does not exist with the user or Amazon Web
/// Services account.
pub const DeploymentConfigDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment configuration is still in use.
pub const DeploymentConfigInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment configurations limit was exceeded.
pub const DeploymentConfigLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment configuration name was not specified.
pub const DeploymentConfigNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment with the user or Amazon Web Services account does not exist.
pub const DeploymentDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A deployment group with the specified name with the user or Amazon Web
/// Services account
/// already exists.
pub const DeploymentGroupAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The named deployment group with the user or Amazon Web Services account does
/// not
/// exist.
pub const DeploymentGroupDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment groups limit was exceeded.
pub const DeploymentGroupLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment group name was not specified.
pub const DeploymentGroupNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// At least one deployment ID must be specified.
pub const DeploymentIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment does not have a status of Ready and can't continue yet.
pub const DeploymentIsNotInReadyStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of allowed deployments was exceeded.
pub const DeploymentLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified deployment has not started.
pub const DeploymentNotStartedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided target ID does not belong to the attempted deployment.
pub const DeploymentTargetDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A deployment target ID was not provided.
pub const DeploymentTargetIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of targets that can be associated with an Amazon ECS or
/// Lambda deployment was exceeded. The target list of both types of
/// deployments must have exactly one item. This exception does not apply to
/// EC2/On-premises
/// deployments.
pub const DeploymentTargetListSizeExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The description is too long.
pub const DescriptionTooLongException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon ECS service is associated with more than one deployment groups.
/// An
/// Amazon ECS service can be associated with only one deployment group.
pub const ECSServiceMappingLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// No GitHub account connection exists with the named specified in the call.
pub const GitHubAccountTokenDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The call is missing a required GitHub account connection name.
pub const GitHubAccountTokenNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// No IAM ARN was included in the request. You must use an IAM session ARN or
/// user ARN in the request.
pub const IamArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request included an IAM session ARN that has already been used to
/// register a different instance.
pub const IamSessionArnAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified user ARN is already registered with an on-premises instance.
pub const IamUserArnAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An user ARN was not specified.
pub const IamUserArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified instance does not exist in the deployment group.
pub const InstanceDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The instance ID was not specified.
pub const InstanceIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum number of allowed on-premises instances in a single call was
/// exceeded.
pub const InstanceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified on-premises instance name is already registered.
pub const InstanceNameAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An on-premises instance name was not specified.
pub const InstanceNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified on-premises instance is not registered.
pub const InstanceNotRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The format of the alarm configuration is invalid. Possible causes include:
///
/// * The alarm list is null.
///
/// * The alarm object is null.
///
/// * The alarm name is empty or null or exceeds the limit of 255 characters.
///
/// * Two alarms with the same name have been specified.
///
/// * The alarm configuration is enabled, but the alarm list is empty.
pub const InvalidAlarmConfigException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The application name was specified in an invalid format.
pub const InvalidApplicationNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified ARN is not in a valid format.
pub const InvalidArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The automatic rollback configuration was specified in an invalid format. For
/// example,
/// automatic rollback is enabled, but an invalid triggering event type or no
/// event types
/// were listed.
pub const InvalidAutoRollbackConfigException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Auto Scaling group was specified in an invalid format or does not
/// exist.
pub const InvalidAutoScalingGroupException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The configuration for the blue/green deployment group was provided in an
/// invalid
/// format. For information about deployment configuration format, see
/// CreateDeploymentConfig.
pub const InvalidBlueGreenDeploymentConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The bucket name either doesn't exist or was specified in an invalid format.
pub const InvalidBucketNameFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The computePlatform is invalid. The computePlatform should be `Lambda`,
/// `Server`, or `ECS`.
pub const InvalidComputePlatformException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployed state filter was specified in an invalid format.
pub const InvalidDeployedStateFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment configuration name was specified in an invalid format.
pub const InvalidDeploymentConfigNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The deployment group name was specified in an invalid format.
pub const InvalidDeploymentGroupNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// At least one of the deployment IDs was specified in an invalid format.
pub const InvalidDeploymentIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An instance type was specified for an in-place deployment. Instance types
/// are
/// supported for blue/green deployments only.
pub const InvalidDeploymentInstanceTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified deployment status doesn't exist or cannot be determined.
pub const InvalidDeploymentStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An invalid deployment style was specified. Valid deployment types include
/// "IN_PLACE"
/// and "BLUE_GREEN." Valid deployment options include "WITH_TRAFFIC_CONTROL"
/// and
/// "WITHOUT_TRAFFIC_CONTROL."
pub const InvalidDeploymentStyleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The target ID provided was not valid.
pub const InvalidDeploymentTargetIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The wait type is invalid.
pub const InvalidDeploymentWaitTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A call was submitted that specified both Ec2TagFilters and Ec2TagSet, but
/// only one of
/// these data types can be used in a single call.
pub const InvalidEC2TagCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The tag was specified in an invalid format.
pub const InvalidEC2TagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon ECS service identifier is not valid.
pub const InvalidECSServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The external ID was specified in an invalid format.
pub const InvalidExternalIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An invalid fileExistsBehavior option was specified to determine how
/// CodeDeploy handles files or directories that already exist in a deployment
/// target location, but weren't part of the previous successful deployment.
/// Valid values
/// include "DISALLOW," "OVERWRITE," and "RETAIN."
pub const InvalidFileExistsBehaviorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The GitHub token is not valid.
pub const InvalidGitHubAccountTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The format of the specified GitHub account connection name is invalid.
pub const InvalidGitHubAccountTokenNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The IAM session ARN was specified in an invalid format.
pub const InvalidIamSessionArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The user ARN was specified in an invalid format.
pub const InvalidIamUserArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The IgnoreApplicationStopFailures value is invalid. For Lambda
/// deployments, `false` is expected. For EC2/On-premises deployments,
/// `true` or `false` is expected.
pub const InvalidIgnoreApplicationStopFailuresValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The input was specified in an invalid format.
pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The on-premises instance name was specified in an invalid format.
pub const InvalidInstanceNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified instance status does not exist.
pub const InvalidInstanceStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An invalid instance type was specified for instances in a blue/green
/// deployment. Valid
/// values include "Blue" for an original environment and "Green" for a
/// replacement
/// environment.
pub const InvalidInstanceTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified key prefix filter was specified in an invalid format.
pub const InvalidKeyPrefixFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A lifecycle event hook is invalid. Review the `hooks` section in your
/// AppSpec file to ensure the lifecycle events and `hooks` functions are
/// valid.
pub const InvalidLifecycleEventHookExecutionIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The result of a Lambda validation function that verifies a lifecycle event
/// is invalid. It should return `Succeeded` or `Failed`.
pub const InvalidLifecycleEventHookExecutionStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An invalid load balancer name, or no load balancer name, was specified.
pub const InvalidLoadBalancerInfoException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The minimum healthy instance value was specified in an invalid format.
pub const InvalidMinimumHealthyHostValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The next token was specified in an invalid format.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A call was submitted that specified both OnPremisesTagFilters and
/// OnPremisesTagSet,
/// but only one of these data types can be used in a single call.
pub const InvalidOnPremisesTagCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An invalid operation was detected.
pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The registration status was specified in an invalid format.
pub const InvalidRegistrationStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The revision was specified in an invalid format.
pub const InvalidRevisionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The service role ARN was specified in an invalid format. Or, if an Auto
/// Scaling
/// group was specified, the specified service role does not grant the
/// appropriate
/// permissions to Amazon EC2 Auto Scaling.
pub const InvalidRoleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The column name to sort by is either not present or was specified in an
/// invalid
/// format.
pub const InvalidSortByException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The sort order was specified in an invalid format.
pub const InvalidSortOrderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The tag was specified in an invalid format.
pub const InvalidTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The tag filter was specified in an invalid format.
pub const InvalidTagFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified tags are not valid.
pub const InvalidTagsToAddException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The target filter name is invalid.
pub const InvalidTargetFilterNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A target group pair associated with this deployment is not valid.
pub const InvalidTargetGroupPairException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The target instance configuration is invalid. Possible causes include:
///
/// * Configuration data for target instances was entered for an in-place
/// deployment.
///
/// * The limit of 10 tags for a tag type was exceeded.
///
/// * The combined length of the tag names exceeded the limit.
///
/// * A specified tag is not currently applied to any instances.
pub const InvalidTargetInstancesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified time range was specified in an invalid format.
pub const InvalidTimeRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The configuration that specifies how traffic is routed during a deployment
/// is
/// invalid.
pub const InvalidTrafficRoutingConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The trigger was specified in an invalid format.
pub const InvalidTriggerConfigException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The UpdateOutdatedInstancesOnly value is invalid. For Lambda
/// deployments, `false` is expected. For EC2/On-premises deployments,
/// `true` or `false` is expected.
pub const InvalidUpdateOutdatedInstancesOnlyValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The `ZonalConfig` object is not valid.
pub const InvalidZonalDeploymentConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An attempt to return the status of an already completed lifecycle event
/// occurred.
pub const LifecycleEventAlreadyCompletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The limit for lifecycle hooks was exceeded.
pub const LifecycleHookLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Both an user ARN and an IAM session ARN were included in the request.
/// Use only one ARN type.
pub const MultipleIamArnsProvidedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The API used does not support the deployment.
pub const OperationNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The ARN of a resource is required, but was not found.
pub const ResourceArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified resource could not be validated.
pub const ResourceValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The named revision does not exist with the user or Amazon Web Services
/// account.
pub const RevisionDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The revision ID was not specified.
pub const RevisionRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The role ID was not specified.
pub const RoleRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum allowed number of tags was exceeded.
pub const TagLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A tag was not specified.
pub const TagRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of tag groups included in the tag set list exceeded the maximum
/// allowed
/// limit of 3.
pub const TagSetListLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An API function was called too frequently.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The maximum allowed number of triggers was exceeded.
pub const TriggerTargetsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A call was submitted that is not supported for the specified deployment
/// type.
pub const UnsupportedActionForDeploymentTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AlarmsLimitExceededException")) {
        const parsed_error: ?AlarmsLimitExceededException = aws.json.parseJsonObject(AlarmsLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .alarms_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApplicationAlreadyExistsException")) {
        const parsed_error: ?ApplicationAlreadyExistsException = aws.json.parseJsonObject(ApplicationAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .application_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApplicationDoesNotExistException")) {
        const parsed_error: ?ApplicationDoesNotExistException = aws.json.parseJsonObject(ApplicationDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .application_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApplicationLimitExceededException")) {
        const parsed_error: ?ApplicationLimitExceededException = aws.json.parseJsonObject(ApplicationLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .application_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApplicationNameRequiredException")) {
        const parsed_error: ?ApplicationNameRequiredException = aws.json.parseJsonObject(ApplicationNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .application_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ArnNotSupportedException")) {
        const parsed_error: ?ArnNotSupportedException = aws.json.parseJsonObject(ArnNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .arn_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BatchLimitExceededException")) {
        const parsed_error: ?BatchLimitExceededException = aws.json.parseJsonObject(BatchLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .batch_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BucketNameFilterRequiredException")) {
        const parsed_error: ?BucketNameFilterRequiredException = aws.json.parseJsonObject(BucketNameFilterRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .bucket_name_filter_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentAlreadyCompletedException")) {
        const parsed_error: ?DeploymentAlreadyCompletedException = aws.json.parseJsonObject(DeploymentAlreadyCompletedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_already_completed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigAlreadyExistsException")) {
        const parsed_error: ?DeploymentConfigAlreadyExistsException = aws.json.parseJsonObject(DeploymentConfigAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigDoesNotExistException")) {
        const parsed_error: ?DeploymentConfigDoesNotExistException = aws.json.parseJsonObject(DeploymentConfigDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigInUseException")) {
        const parsed_error: ?DeploymentConfigInUseException = aws.json.parseJsonObject(DeploymentConfigInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigLimitExceededException")) {
        const parsed_error: ?DeploymentConfigLimitExceededException = aws.json.parseJsonObject(DeploymentConfigLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentConfigNameRequiredException")) {
        const parsed_error: ?DeploymentConfigNameRequiredException = aws.json.parseJsonObject(DeploymentConfigNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_config_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentDoesNotExistException")) {
        const parsed_error: ?DeploymentDoesNotExistException = aws.json.parseJsonObject(DeploymentDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentGroupAlreadyExistsException")) {
        const parsed_error: ?DeploymentGroupAlreadyExistsException = aws.json.parseJsonObject(DeploymentGroupAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_group_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentGroupDoesNotExistException")) {
        const parsed_error: ?DeploymentGroupDoesNotExistException = aws.json.parseJsonObject(DeploymentGroupDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_group_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentGroupLimitExceededException")) {
        const parsed_error: ?DeploymentGroupLimitExceededException = aws.json.parseJsonObject(DeploymentGroupLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_group_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentGroupNameRequiredException")) {
        const parsed_error: ?DeploymentGroupNameRequiredException = aws.json.parseJsonObject(DeploymentGroupNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_group_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentIdRequiredException")) {
        const parsed_error: ?DeploymentIdRequiredException = aws.json.parseJsonObject(DeploymentIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentIsNotInReadyStateException")) {
        const parsed_error: ?DeploymentIsNotInReadyStateException = aws.json.parseJsonObject(DeploymentIsNotInReadyStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_is_not_in_ready_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentLimitExceededException")) {
        const parsed_error: ?DeploymentLimitExceededException = aws.json.parseJsonObject(DeploymentLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentNotStartedException")) {
        const parsed_error: ?DeploymentNotStartedException = aws.json.parseJsonObject(DeploymentNotStartedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_not_started_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentTargetDoesNotExistException")) {
        const parsed_error: ?DeploymentTargetDoesNotExistException = aws.json.parseJsonObject(DeploymentTargetDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_target_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentTargetIdRequiredException")) {
        const parsed_error: ?DeploymentTargetIdRequiredException = aws.json.parseJsonObject(DeploymentTargetIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_target_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeploymentTargetListSizeExceededException")) {
        const parsed_error: ?DeploymentTargetListSizeExceededException = aws.json.parseJsonObject(DeploymentTargetListSizeExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .deployment_target_list_size_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DescriptionTooLongException")) {
        const parsed_error: ?DescriptionTooLongException = aws.json.parseJsonObject(DescriptionTooLongException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .description_too_long_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ECSServiceMappingLimitExceededException")) {
        const parsed_error: ?ECSServiceMappingLimitExceededException = aws.json.parseJsonObject(ECSServiceMappingLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ecs_service_mapping_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GitHubAccountTokenDoesNotExistException")) {
        const parsed_error: ?GitHubAccountTokenDoesNotExistException = aws.json.parseJsonObject(GitHubAccountTokenDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .git_hub_account_token_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GitHubAccountTokenNameRequiredException")) {
        const parsed_error: ?GitHubAccountTokenNameRequiredException = aws.json.parseJsonObject(GitHubAccountTokenNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .git_hub_account_token_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IamArnRequiredException")) {
        const parsed_error: ?IamArnRequiredException = aws.json.parseJsonObject(IamArnRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .iam_arn_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IamSessionArnAlreadyRegisteredException")) {
        const parsed_error: ?IamSessionArnAlreadyRegisteredException = aws.json.parseJsonObject(IamSessionArnAlreadyRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .iam_session_arn_already_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IamUserArnAlreadyRegisteredException")) {
        const parsed_error: ?IamUserArnAlreadyRegisteredException = aws.json.parseJsonObject(IamUserArnAlreadyRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .iam_user_arn_already_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IamUserArnRequiredException")) {
        const parsed_error: ?IamUserArnRequiredException = aws.json.parseJsonObject(IamUserArnRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .iam_user_arn_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceDoesNotExistException")) {
        const parsed_error: ?InstanceDoesNotExistException = aws.json.parseJsonObject(InstanceDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceIdRequiredException")) {
        const parsed_error: ?InstanceIdRequiredException = aws.json.parseJsonObject(InstanceIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceLimitExceededException")) {
        const parsed_error: ?InstanceLimitExceededException = aws.json.parseJsonObject(InstanceLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceNameAlreadyRegisteredException")) {
        const parsed_error: ?InstanceNameAlreadyRegisteredException = aws.json.parseJsonObject(InstanceNameAlreadyRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_name_already_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceNameRequiredException")) {
        const parsed_error: ?InstanceNameRequiredException = aws.json.parseJsonObject(InstanceNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceNotRegisteredException")) {
        const parsed_error: ?InstanceNotRegisteredException = aws.json.parseJsonObject(InstanceNotRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_not_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAlarmConfigException")) {
        const parsed_error: ?InvalidAlarmConfigException = aws.json.parseJsonObject(InvalidAlarmConfigException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_alarm_config_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidApplicationNameException")) {
        const parsed_error: ?InvalidApplicationNameException = aws.json.parseJsonObject(InvalidApplicationNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_application_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidArnException")) {
        const parsed_error: ?InvalidArnException = aws.json.parseJsonObject(InvalidArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutoRollbackConfigException")) {
        const parsed_error: ?InvalidAutoRollbackConfigException = aws.json.parseJsonObject(InvalidAutoRollbackConfigException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_auto_rollback_config_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutoScalingGroupException")) {
        const parsed_error: ?InvalidAutoScalingGroupException = aws.json.parseJsonObject(InvalidAutoScalingGroupException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_auto_scaling_group_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidBlueGreenDeploymentConfigurationException")) {
        const parsed_error: ?InvalidBlueGreenDeploymentConfigurationException = aws.json.parseJsonObject(InvalidBlueGreenDeploymentConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_blue_green_deployment_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidBucketNameFilterException")) {
        const parsed_error: ?InvalidBucketNameFilterException = aws.json.parseJsonObject(InvalidBucketNameFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_bucket_name_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidComputePlatformException")) {
        const parsed_error: ?InvalidComputePlatformException = aws.json.parseJsonObject(InvalidComputePlatformException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_compute_platform_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeployedStateFilterException")) {
        const parsed_error: ?InvalidDeployedStateFilterException = aws.json.parseJsonObject(InvalidDeployedStateFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployed_state_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentConfigNameException")) {
        const parsed_error: ?InvalidDeploymentConfigNameException = aws.json.parseJsonObject(InvalidDeploymentConfigNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_config_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentGroupNameException")) {
        const parsed_error: ?InvalidDeploymentGroupNameException = aws.json.parseJsonObject(InvalidDeploymentGroupNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_group_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentIdException")) {
        const parsed_error: ?InvalidDeploymentIdException = aws.json.parseJsonObject(InvalidDeploymentIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentInstanceTypeException")) {
        const parsed_error: ?InvalidDeploymentInstanceTypeException = aws.json.parseJsonObject(InvalidDeploymentInstanceTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_instance_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentStatusException")) {
        const parsed_error: ?InvalidDeploymentStatusException = aws.json.parseJsonObject(InvalidDeploymentStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentStyleException")) {
        const parsed_error: ?InvalidDeploymentStyleException = aws.json.parseJsonObject(InvalidDeploymentStyleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_style_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentTargetIdException")) {
        const parsed_error: ?InvalidDeploymentTargetIdException = aws.json.parseJsonObject(InvalidDeploymentTargetIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_target_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeploymentWaitTypeException")) {
        const parsed_error: ?InvalidDeploymentWaitTypeException = aws.json.parseJsonObject(InvalidDeploymentWaitTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deployment_wait_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEC2TagCombinationException")) {
        const parsed_error: ?InvalidEC2TagCombinationException = aws.json.parseJsonObject(InvalidEC2TagCombinationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ec2_tag_combination_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEC2TagException")) {
        const parsed_error: ?InvalidEC2TagException = aws.json.parseJsonObject(InvalidEC2TagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ec2_tag_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidECSServiceException")) {
        const parsed_error: ?InvalidECSServiceException = aws.json.parseJsonObject(InvalidECSServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ecs_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidExternalIdException")) {
        const parsed_error: ?InvalidExternalIdException = aws.json.parseJsonObject(InvalidExternalIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_external_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFileExistsBehaviorException")) {
        const parsed_error: ?InvalidFileExistsBehaviorException = aws.json.parseJsonObject(InvalidFileExistsBehaviorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_file_exists_behavior_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGitHubAccountTokenException")) {
        const parsed_error: ?InvalidGitHubAccountTokenException = aws.json.parseJsonObject(InvalidGitHubAccountTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_git_hub_account_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGitHubAccountTokenNameException")) {
        const parsed_error: ?InvalidGitHubAccountTokenNameException = aws.json.parseJsonObject(InvalidGitHubAccountTokenNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_git_hub_account_token_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIamSessionArnException")) {
        const parsed_error: ?InvalidIamSessionArnException = aws.json.parseJsonObject(InvalidIamSessionArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_iam_session_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIamUserArnException")) {
        const parsed_error: ?InvalidIamUserArnException = aws.json.parseJsonObject(InvalidIamUserArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_iam_user_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIgnoreApplicationStopFailuresValueException")) {
        const parsed_error: ?InvalidIgnoreApplicationStopFailuresValueException = aws.json.parseJsonObject(InvalidIgnoreApplicationStopFailuresValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ignore_application_stop_failures_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        const parsed_error: ?InvalidInputException = aws.json.parseJsonObject(InvalidInputException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceNameException")) {
        const parsed_error: ?InvalidInstanceNameException = aws.json.parseJsonObject(InvalidInstanceNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceStatusException")) {
        const parsed_error: ?InvalidInstanceStatusException = aws.json.parseJsonObject(InvalidInstanceStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceTypeException")) {
        const parsed_error: ?InvalidInstanceTypeException = aws.json.parseJsonObject(InvalidInstanceTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyPrefixFilterException")) {
        const parsed_error: ?InvalidKeyPrefixFilterException = aws.json.parseJsonObject(InvalidKeyPrefixFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_key_prefix_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLifecycleEventHookExecutionIdException")) {
        const parsed_error: ?InvalidLifecycleEventHookExecutionIdException = aws.json.parseJsonObject(InvalidLifecycleEventHookExecutionIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_lifecycle_event_hook_execution_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLifecycleEventHookExecutionStatusException")) {
        const parsed_error: ?InvalidLifecycleEventHookExecutionStatusException = aws.json.parseJsonObject(InvalidLifecycleEventHookExecutionStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_lifecycle_event_hook_execution_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLoadBalancerInfoException")) {
        const parsed_error: ?InvalidLoadBalancerInfoException = aws.json.parseJsonObject(InvalidLoadBalancerInfoException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_load_balancer_info_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMinimumHealthyHostValueException")) {
        const parsed_error: ?InvalidMinimumHealthyHostValueException = aws.json.parseJsonObject(InvalidMinimumHealthyHostValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_minimum_healthy_host_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?InvalidNextTokenException = aws.json.parseJsonObject(InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOnPremisesTagCombinationException")) {
        const parsed_error: ?InvalidOnPremisesTagCombinationException = aws.json.parseJsonObject(InvalidOnPremisesTagCombinationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_on_premises_tag_combination_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        const parsed_error: ?InvalidOperationException = aws.json.parseJsonObject(InvalidOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRegistrationStatusException")) {
        const parsed_error: ?InvalidRegistrationStatusException = aws.json.parseJsonObject(InvalidRegistrationStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_registration_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRevisionException")) {
        const parsed_error: ?InvalidRevisionException = aws.json.parseJsonObject(InvalidRevisionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_revision_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRoleException")) {
        const parsed_error: ?InvalidRoleException = aws.json.parseJsonObject(InvalidRoleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_role_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSortByException")) {
        const parsed_error: ?InvalidSortByException = aws.json.parseJsonObject(InvalidSortByException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sort_by_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSortOrderException")) {
        const parsed_error: ?InvalidSortOrderException = aws.json.parseJsonObject(InvalidSortOrderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sort_order_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        const parsed_error: ?InvalidTagException = aws.json.parseJsonObject(InvalidTagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagFilterException")) {
        const parsed_error: ?InvalidTagFilterException = aws.json.parseJsonObject(InvalidTagFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagsToAddException")) {
        const parsed_error: ?InvalidTagsToAddException = aws.json.parseJsonObject(InvalidTagsToAddException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tags_to_add_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetFilterNameException")) {
        const parsed_error: ?InvalidTargetFilterNameException = aws.json.parseJsonObject(InvalidTargetFilterNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_filter_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetGroupPairException")) {
        const parsed_error: ?InvalidTargetGroupPairException = aws.json.parseJsonObject(InvalidTargetGroupPairException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_group_pair_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetInstancesException")) {
        const parsed_error: ?InvalidTargetInstancesException = aws.json.parseJsonObject(InvalidTargetInstancesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_instances_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTimeRangeException")) {
        const parsed_error: ?InvalidTimeRangeException = aws.json.parseJsonObject(InvalidTimeRangeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_time_range_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTrafficRoutingConfigurationException")) {
        const parsed_error: ?InvalidTrafficRoutingConfigurationException = aws.json.parseJsonObject(InvalidTrafficRoutingConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_traffic_routing_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTriggerConfigException")) {
        const parsed_error: ?InvalidTriggerConfigException = aws.json.parseJsonObject(InvalidTriggerConfigException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_trigger_config_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidUpdateOutdatedInstancesOnlyValueException")) {
        const parsed_error: ?InvalidUpdateOutdatedInstancesOnlyValueException = aws.json.parseJsonObject(InvalidUpdateOutdatedInstancesOnlyValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_update_outdated_instances_only_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidZonalDeploymentConfigurationException")) {
        const parsed_error: ?InvalidZonalDeploymentConfigurationException = aws.json.parseJsonObject(InvalidZonalDeploymentConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_zonal_deployment_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LifecycleEventAlreadyCompletedException")) {
        const parsed_error: ?LifecycleEventAlreadyCompletedException = aws.json.parseJsonObject(LifecycleEventAlreadyCompletedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .lifecycle_event_already_completed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LifecycleHookLimitExceededException")) {
        const parsed_error: ?LifecycleHookLimitExceededException = aws.json.parseJsonObject(LifecycleHookLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .lifecycle_hook_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MultipleIamArnsProvidedException")) {
        const parsed_error: ?MultipleIamArnsProvidedException = aws.json.parseJsonObject(MultipleIamArnsProvidedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multiple_iam_arns_provided_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        const parsed_error: ?OperationNotSupportedException = aws.json.parseJsonObject(OperationNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceArnRequiredException")) {
        const parsed_error: ?ResourceArnRequiredException = aws.json.parseJsonObject(ResourceArnRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_arn_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceValidationException")) {
        const parsed_error: ?ResourceValidationException = aws.json.parseJsonObject(ResourceValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RevisionDoesNotExistException")) {
        const parsed_error: ?RevisionDoesNotExistException = aws.json.parseJsonObject(RevisionDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .revision_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RevisionRequiredException")) {
        const parsed_error: ?RevisionRequiredException = aws.json.parseJsonObject(RevisionRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .revision_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RoleRequiredException")) {
        const parsed_error: ?RoleRequiredException = aws.json.parseJsonObject(RoleRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .role_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        const parsed_error: ?TagLimitExceededException = aws.json.parseJsonObject(TagLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagRequiredException")) {
        const parsed_error: ?TagRequiredException = aws.json.parseJsonObject(TagRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagSetListLimitExceededException")) {
        const parsed_error: ?TagSetListLimitExceededException = aws.json.parseJsonObject(TagSetListLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_set_list_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?ThrottlingException = aws.json.parseJsonObject(ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TriggerTargetsLimitExceededException")) {
        const parsed_error: ?TriggerTargetsLimitExceededException = aws.json.parseJsonObject(TriggerTargetsLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .trigger_targets_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedActionForDeploymentTypeException")) {
        const parsed_error: ?UnsupportedActionForDeploymentTypeException = aws.json.parseJsonObject(UnsupportedActionForDeploymentTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_action_for_deployment_type_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
