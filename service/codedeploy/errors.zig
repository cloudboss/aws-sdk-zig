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

pub const AlarmsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApplicationAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApplicationDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApplicationLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApplicationNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ArnNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BatchLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BucketNameFilterRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentAlreadyCompletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentConfigAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentConfigDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentConfigInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentConfigLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentConfigNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentGroupAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentGroupDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentGroupLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentGroupNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentIsNotInReadyStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentNotStartedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentTargetDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentTargetIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeploymentTargetListSizeExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DescriptionTooLongException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ECSServiceMappingLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GitHubAccountTokenDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GitHubAccountTokenNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IamArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IamSessionArnAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IamUserArnAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IamUserArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceIdRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceNameAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceNameRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceNotRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAlarmConfigException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidApplicationNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAutoRollbackConfigException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAutoScalingGroupException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidBlueGreenDeploymentConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidBucketNameFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidComputePlatformException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeployedStateFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeploymentConfigNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeploymentGroupNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeploymentIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeploymentInstanceTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeploymentStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeploymentStyleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeploymentTargetIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeploymentWaitTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEC2TagCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEC2TagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidECSServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidExternalIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFileExistsBehaviorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGitHubAccountTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGitHubAccountTokenNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidIamSessionArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidIamUserArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidIgnoreApplicationStopFailuresValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInstanceNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInstanceStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInstanceTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidKeyPrefixFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLifecycleEventHookExecutionIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLifecycleEventHookExecutionStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLoadBalancerInfoException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMinimumHealthyHostValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOnPremisesTagCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRegistrationStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRevisionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRoleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSortByException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSortOrderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagsToAddException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTargetFilterNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTargetGroupPairException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTargetInstancesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTimeRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTrafficRoutingConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTriggerConfigException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidUpdateOutdatedInstancesOnlyValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidZonalDeploymentConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LifecycleEventAlreadyCompletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LifecycleHookLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MultipleIamArnsProvidedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceArnRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RevisionDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RevisionRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RoleRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagSetListLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TriggerTargetsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedActionForDeploymentTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
