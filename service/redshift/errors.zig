const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_to_cluster_denied_fault: AccessToClusterDeniedFault,
        access_to_snapshot_denied_fault: AccessToSnapshotDeniedFault,
        authentication_profile_already_exists_fault: AuthenticationProfileAlreadyExistsFault,
        authentication_profile_not_found_fault: AuthenticationProfileNotFoundFault,
        authentication_profile_quota_exceeded_fault: AuthenticationProfileQuotaExceededFault,
        authorization_already_exists_fault: AuthorizationAlreadyExistsFault,
        authorization_not_found_fault: AuthorizationNotFoundFault,
        authorization_quota_exceeded_fault: AuthorizationQuotaExceededFault,
        batch_delete_request_size_exceeded_fault: BatchDeleteRequestSizeExceededFault,
        batch_modify_cluster_snapshots_limit_exceeded_fault: BatchModifyClusterSnapshotsLimitExceededFault,
        bucket_not_found_fault: BucketNotFoundFault,
        cluster_already_exists_fault: ClusterAlreadyExistsFault,
        cluster_not_found_fault: ClusterNotFoundFault,
        cluster_on_latest_revision_fault: ClusterOnLatestRevisionFault,
        cluster_parameter_group_already_exists_fault: ClusterParameterGroupAlreadyExistsFault,
        cluster_parameter_group_not_found_fault: ClusterParameterGroupNotFoundFault,
        cluster_parameter_group_quota_exceeded_fault: ClusterParameterGroupQuotaExceededFault,
        cluster_quota_exceeded_fault: ClusterQuotaExceededFault,
        cluster_security_group_already_exists_fault: ClusterSecurityGroupAlreadyExistsFault,
        cluster_security_group_not_found_fault: ClusterSecurityGroupNotFoundFault,
        cluster_security_group_quota_exceeded_fault: ClusterSecurityGroupQuotaExceededFault,
        cluster_snapshot_already_exists_fault: ClusterSnapshotAlreadyExistsFault,
        cluster_snapshot_not_found_fault: ClusterSnapshotNotFoundFault,
        cluster_snapshot_quota_exceeded_fault: ClusterSnapshotQuotaExceededFault,
        cluster_subnet_group_already_exists_fault: ClusterSubnetGroupAlreadyExistsFault,
        cluster_subnet_group_not_found_fault: ClusterSubnetGroupNotFoundFault,
        cluster_subnet_group_quota_exceeded_fault: ClusterSubnetGroupQuotaExceededFault,
        cluster_subnet_quota_exceeded_fault: ClusterSubnetQuotaExceededFault,
        conflict_policy_update_fault: ConflictPolicyUpdateFault,
        copy_to_region_disabled_fault: CopyToRegionDisabledFault,
        custom_cname_association_fault: CustomCnameAssociationFault,
        custom_domain_association_not_found_fault: CustomDomainAssociationNotFoundFault,
        dependent_service_access_denied_fault: DependentServiceAccessDeniedFault,
        dependent_service_request_throttling_fault: DependentServiceRequestThrottlingFault,
        dependent_service_unavailable_fault: DependentServiceUnavailableFault,
        endpoint_already_exists_fault: EndpointAlreadyExistsFault,
        endpoint_authorization_already_exists_fault: EndpointAuthorizationAlreadyExistsFault,
        endpoint_authorization_not_found_fault: EndpointAuthorizationNotFoundFault,
        endpoint_authorizations_per_cluster_limit_exceeded_fault: EndpointAuthorizationsPerClusterLimitExceededFault,
        endpoint_not_found_fault: EndpointNotFoundFault,
        endpoints_per_authorization_limit_exceeded_fault: EndpointsPerAuthorizationLimitExceededFault,
        endpoints_per_cluster_limit_exceeded_fault: EndpointsPerClusterLimitExceededFault,
        event_subscription_quota_exceeded_fault: EventSubscriptionQuotaExceededFault,
        hsm_client_certificate_already_exists_fault: HsmClientCertificateAlreadyExistsFault,
        hsm_client_certificate_not_found_fault: HsmClientCertificateNotFoundFault,
        hsm_client_certificate_quota_exceeded_fault: HsmClientCertificateQuotaExceededFault,
        hsm_configuration_already_exists_fault: HsmConfigurationAlreadyExistsFault,
        hsm_configuration_not_found_fault: HsmConfigurationNotFoundFault,
        hsm_configuration_quota_exceeded_fault: HsmConfigurationQuotaExceededFault,
        in_progress_table_restore_quota_exceeded_fault: InProgressTableRestoreQuotaExceededFault,
        incompatible_orderable_options: IncompatibleOrderableOptions,
        insufficient_cluster_capacity_fault: InsufficientClusterCapacityFault,
        insufficient_s3_bucket_policy_fault: InsufficientS3BucketPolicyFault,
        integration_already_exists_fault: IntegrationAlreadyExistsFault,
        integration_conflict_operation_fault: IntegrationConflictOperationFault,
        integration_conflict_state_fault: IntegrationConflictStateFault,
        integration_not_found_fault: IntegrationNotFoundFault,
        integration_quota_exceeded_fault: IntegrationQuotaExceededFault,
        integration_source_not_found_fault: IntegrationSourceNotFoundFault,
        integration_target_not_found_fault: IntegrationTargetNotFoundFault,
        invalid_authentication_profile_request_fault: InvalidAuthenticationProfileRequestFault,
        invalid_authorization_state_fault: InvalidAuthorizationStateFault,
        invalid_cluster_parameter_group_state_fault: InvalidClusterParameterGroupStateFault,
        invalid_cluster_security_group_state_fault: InvalidClusterSecurityGroupStateFault,
        invalid_cluster_snapshot_schedule_state_fault: InvalidClusterSnapshotScheduleStateFault,
        invalid_cluster_snapshot_state_fault: InvalidClusterSnapshotStateFault,
        invalid_cluster_state_fault: InvalidClusterStateFault,
        invalid_cluster_subnet_group_state_fault: InvalidClusterSubnetGroupStateFault,
        invalid_cluster_subnet_state_fault: InvalidClusterSubnetStateFault,
        invalid_cluster_track_fault: InvalidClusterTrackFault,
        invalid_data_share_fault: InvalidDataShareFault,
        invalid_elastic_ip_fault: InvalidElasticIpFault,
        invalid_endpoint_state_fault: InvalidEndpointStateFault,
        invalid_hsm_client_certificate_state_fault: InvalidHsmClientCertificateStateFault,
        invalid_hsm_configuration_state_fault: InvalidHsmConfigurationStateFault,
        invalid_namespace_fault: InvalidNamespaceFault,
        invalid_policy_fault: InvalidPolicyFault,
        invalid_reserved_node_state_fault: InvalidReservedNodeStateFault,
        invalid_restore_fault: InvalidRestoreFault,
        invalid_retention_period_fault: InvalidRetentionPeriodFault,
        invalid_s3_bucket_name_fault: InvalidS3BucketNameFault,
        invalid_s3_key_prefix_fault: InvalidS3KeyPrefixFault,
        invalid_schedule_fault: InvalidScheduleFault,
        invalid_scheduled_action_fault: InvalidScheduledActionFault,
        invalid_snapshot_copy_grant_state_fault: InvalidSnapshotCopyGrantStateFault,
        invalid_subnet: InvalidSubnet,
        invalid_subscription_state_fault: InvalidSubscriptionStateFault,
        invalid_table_restore_argument_fault: InvalidTableRestoreArgumentFault,
        invalid_tag_fault: InvalidTagFault,
        invalid_usage_limit_fault: InvalidUsageLimitFault,
        invalid_vpc_network_state_fault: InvalidVPCNetworkStateFault,
        ipv_6_cidr_block_not_found_fault: Ipv6CidrBlockNotFoundFault,
        limit_exceeded_fault: LimitExceededFault,
        number_of_nodes_per_cluster_limit_exceeded_fault: NumberOfNodesPerClusterLimitExceededFault,
        number_of_nodes_quota_exceeded_fault: NumberOfNodesQuotaExceededFault,
        partner_not_found_fault: PartnerNotFoundFault,
        redshift_idc_application_already_exists_fault: RedshiftIdcApplicationAlreadyExistsFault,
        redshift_idc_application_not_exists_fault: RedshiftIdcApplicationNotExistsFault,
        redshift_idc_application_quota_exceeded_fault: RedshiftIdcApplicationQuotaExceededFault,
        redshift_invalid_parameter_fault: RedshiftInvalidParameterFault,
        reserved_node_already_exists_fault: ReservedNodeAlreadyExistsFault,
        reserved_node_already_migrated_fault: ReservedNodeAlreadyMigratedFault,
        reserved_node_exchange_not_found_fault: ReservedNodeExchangeNotFoundFault,
        reserved_node_not_found_fault: ReservedNodeNotFoundFault,
        reserved_node_offering_not_found_fault: ReservedNodeOfferingNotFoundFault,
        reserved_node_quota_exceeded_fault: ReservedNodeQuotaExceededFault,
        resize_not_found_fault: ResizeNotFoundFault,
        resource_not_found_fault: ResourceNotFoundFault,
        schedule_definition_type_unsupported_fault: ScheduleDefinitionTypeUnsupportedFault,
        scheduled_action_already_exists_fault: ScheduledActionAlreadyExistsFault,
        scheduled_action_not_found_fault: ScheduledActionNotFoundFault,
        scheduled_action_quota_exceeded_fault: ScheduledActionQuotaExceededFault,
        scheduled_action_type_unsupported_fault: ScheduledActionTypeUnsupportedFault,
        snapshot_copy_already_disabled_fault: SnapshotCopyAlreadyDisabledFault,
        snapshot_copy_already_enabled_fault: SnapshotCopyAlreadyEnabledFault,
        snapshot_copy_disabled_fault: SnapshotCopyDisabledFault,
        snapshot_copy_grant_already_exists_fault: SnapshotCopyGrantAlreadyExistsFault,
        snapshot_copy_grant_not_found_fault: SnapshotCopyGrantNotFoundFault,
        snapshot_copy_grant_quota_exceeded_fault: SnapshotCopyGrantQuotaExceededFault,
        snapshot_schedule_already_exists_fault: SnapshotScheduleAlreadyExistsFault,
        snapshot_schedule_not_found_fault: SnapshotScheduleNotFoundFault,
        snapshot_schedule_quota_exceeded_fault: SnapshotScheduleQuotaExceededFault,
        snapshot_schedule_update_in_progress_fault: SnapshotScheduleUpdateInProgressFault,
        sns_invalid_topic_fault: SNSInvalidTopicFault,
        sns_no_authorization_fault: SNSNoAuthorizationFault,
        sns_topic_arn_not_found_fault: SNSTopicArnNotFoundFault,
        source_not_found_fault: SourceNotFoundFault,
        subnet_already_in_use: SubnetAlreadyInUse,
        subscription_already_exist_fault: SubscriptionAlreadyExistFault,
        subscription_category_not_found_fault: SubscriptionCategoryNotFoundFault,
        subscription_event_id_not_found_fault: SubscriptionEventIdNotFoundFault,
        subscription_not_found_fault: SubscriptionNotFoundFault,
        subscription_severity_not_found_fault: SubscriptionSeverityNotFoundFault,
        table_limit_exceeded_fault: TableLimitExceededFault,
        table_restore_not_found_fault: TableRestoreNotFoundFault,
        tag_limit_exceeded_fault: TagLimitExceededFault,
        unauthorized_operation: UnauthorizedOperation,
        unauthorized_partner_integration_fault: UnauthorizedPartnerIntegrationFault,
        unknown_snapshot_copy_region_fault: UnknownSnapshotCopyRegionFault,
        unsupported_operation_fault: UnsupportedOperationFault,
        unsupported_option_fault: UnsupportedOptionFault,
        usage_limit_already_exists_fault: UsageLimitAlreadyExistsFault,
        usage_limit_not_found_fault: UsageLimitNotFoundFault,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_to_cluster_denied_fault => "AccessToClusterDeniedFault",
                .access_to_snapshot_denied_fault => "AccessToSnapshotDeniedFault",
                .authentication_profile_already_exists_fault => "AuthenticationProfileAlreadyExistsFault",
                .authentication_profile_not_found_fault => "AuthenticationProfileNotFoundFault",
                .authentication_profile_quota_exceeded_fault => "AuthenticationProfileQuotaExceededFault",
                .authorization_already_exists_fault => "AuthorizationAlreadyExistsFault",
                .authorization_not_found_fault => "AuthorizationNotFoundFault",
                .authorization_quota_exceeded_fault => "AuthorizationQuotaExceededFault",
                .batch_delete_request_size_exceeded_fault => "BatchDeleteRequestSizeExceededFault",
                .batch_modify_cluster_snapshots_limit_exceeded_fault => "BatchModifyClusterSnapshotsLimitExceededFault",
                .bucket_not_found_fault => "BucketNotFoundFault",
                .cluster_already_exists_fault => "ClusterAlreadyExistsFault",
                .cluster_not_found_fault => "ClusterNotFoundFault",
                .cluster_on_latest_revision_fault => "ClusterOnLatestRevisionFault",
                .cluster_parameter_group_already_exists_fault => "ClusterParameterGroupAlreadyExistsFault",
                .cluster_parameter_group_not_found_fault => "ClusterParameterGroupNotFoundFault",
                .cluster_parameter_group_quota_exceeded_fault => "ClusterParameterGroupQuotaExceededFault",
                .cluster_quota_exceeded_fault => "ClusterQuotaExceededFault",
                .cluster_security_group_already_exists_fault => "ClusterSecurityGroupAlreadyExistsFault",
                .cluster_security_group_not_found_fault => "ClusterSecurityGroupNotFoundFault",
                .cluster_security_group_quota_exceeded_fault => "ClusterSecurityGroupQuotaExceededFault",
                .cluster_snapshot_already_exists_fault => "ClusterSnapshotAlreadyExistsFault",
                .cluster_snapshot_not_found_fault => "ClusterSnapshotNotFoundFault",
                .cluster_snapshot_quota_exceeded_fault => "ClusterSnapshotQuotaExceededFault",
                .cluster_subnet_group_already_exists_fault => "ClusterSubnetGroupAlreadyExistsFault",
                .cluster_subnet_group_not_found_fault => "ClusterSubnetGroupNotFoundFault",
                .cluster_subnet_group_quota_exceeded_fault => "ClusterSubnetGroupQuotaExceededFault",
                .cluster_subnet_quota_exceeded_fault => "ClusterSubnetQuotaExceededFault",
                .conflict_policy_update_fault => "ConflictPolicyUpdateFault",
                .copy_to_region_disabled_fault => "CopyToRegionDisabledFault",
                .custom_cname_association_fault => "CustomCnameAssociationFault",
                .custom_domain_association_not_found_fault => "CustomDomainAssociationNotFoundFault",
                .dependent_service_access_denied_fault => "DependentServiceAccessDeniedFault",
                .dependent_service_request_throttling_fault => "DependentServiceRequestThrottlingFault",
                .dependent_service_unavailable_fault => "DependentServiceUnavailableFault",
                .endpoint_already_exists_fault => "EndpointAlreadyExistsFault",
                .endpoint_authorization_already_exists_fault => "EndpointAuthorizationAlreadyExistsFault",
                .endpoint_authorization_not_found_fault => "EndpointAuthorizationNotFoundFault",
                .endpoint_authorizations_per_cluster_limit_exceeded_fault => "EndpointAuthorizationsPerClusterLimitExceededFault",
                .endpoint_not_found_fault => "EndpointNotFoundFault",
                .endpoints_per_authorization_limit_exceeded_fault => "EndpointsPerAuthorizationLimitExceededFault",
                .endpoints_per_cluster_limit_exceeded_fault => "EndpointsPerClusterLimitExceededFault",
                .event_subscription_quota_exceeded_fault => "EventSubscriptionQuotaExceededFault",
                .hsm_client_certificate_already_exists_fault => "HsmClientCertificateAlreadyExistsFault",
                .hsm_client_certificate_not_found_fault => "HsmClientCertificateNotFoundFault",
                .hsm_client_certificate_quota_exceeded_fault => "HsmClientCertificateQuotaExceededFault",
                .hsm_configuration_already_exists_fault => "HsmConfigurationAlreadyExistsFault",
                .hsm_configuration_not_found_fault => "HsmConfigurationNotFoundFault",
                .hsm_configuration_quota_exceeded_fault => "HsmConfigurationQuotaExceededFault",
                .in_progress_table_restore_quota_exceeded_fault => "InProgressTableRestoreQuotaExceededFault",
                .incompatible_orderable_options => "IncompatibleOrderableOptions",
                .insufficient_cluster_capacity_fault => "InsufficientClusterCapacityFault",
                .insufficient_s3_bucket_policy_fault => "InsufficientS3BucketPolicyFault",
                .integration_already_exists_fault => "IntegrationAlreadyExistsFault",
                .integration_conflict_operation_fault => "IntegrationConflictOperationFault",
                .integration_conflict_state_fault => "IntegrationConflictStateFault",
                .integration_not_found_fault => "IntegrationNotFoundFault",
                .integration_quota_exceeded_fault => "IntegrationQuotaExceededFault",
                .integration_source_not_found_fault => "IntegrationSourceNotFoundFault",
                .integration_target_not_found_fault => "IntegrationTargetNotFoundFault",
                .invalid_authentication_profile_request_fault => "InvalidAuthenticationProfileRequestFault",
                .invalid_authorization_state_fault => "InvalidAuthorizationStateFault",
                .invalid_cluster_parameter_group_state_fault => "InvalidClusterParameterGroupStateFault",
                .invalid_cluster_security_group_state_fault => "InvalidClusterSecurityGroupStateFault",
                .invalid_cluster_snapshot_schedule_state_fault => "InvalidClusterSnapshotScheduleStateFault",
                .invalid_cluster_snapshot_state_fault => "InvalidClusterSnapshotStateFault",
                .invalid_cluster_state_fault => "InvalidClusterStateFault",
                .invalid_cluster_subnet_group_state_fault => "InvalidClusterSubnetGroupStateFault",
                .invalid_cluster_subnet_state_fault => "InvalidClusterSubnetStateFault",
                .invalid_cluster_track_fault => "InvalidClusterTrackFault",
                .invalid_data_share_fault => "InvalidDataShareFault",
                .invalid_elastic_ip_fault => "InvalidElasticIpFault",
                .invalid_endpoint_state_fault => "InvalidEndpointStateFault",
                .invalid_hsm_client_certificate_state_fault => "InvalidHsmClientCertificateStateFault",
                .invalid_hsm_configuration_state_fault => "InvalidHsmConfigurationStateFault",
                .invalid_namespace_fault => "InvalidNamespaceFault",
                .invalid_policy_fault => "InvalidPolicyFault",
                .invalid_reserved_node_state_fault => "InvalidReservedNodeStateFault",
                .invalid_restore_fault => "InvalidRestoreFault",
                .invalid_retention_period_fault => "InvalidRetentionPeriodFault",
                .invalid_s3_bucket_name_fault => "InvalidS3BucketNameFault",
                .invalid_s3_key_prefix_fault => "InvalidS3KeyPrefixFault",
                .invalid_schedule_fault => "InvalidScheduleFault",
                .invalid_scheduled_action_fault => "InvalidScheduledActionFault",
                .invalid_snapshot_copy_grant_state_fault => "InvalidSnapshotCopyGrantStateFault",
                .invalid_subnet => "InvalidSubnet",
                .invalid_subscription_state_fault => "InvalidSubscriptionStateFault",
                .invalid_table_restore_argument_fault => "InvalidTableRestoreArgumentFault",
                .invalid_tag_fault => "InvalidTagFault",
                .invalid_usage_limit_fault => "InvalidUsageLimitFault",
                .invalid_vpc_network_state_fault => "InvalidVPCNetworkStateFault",
                .ipv_6_cidr_block_not_found_fault => "Ipv6CidrBlockNotFoundFault",
                .limit_exceeded_fault => "LimitExceededFault",
                .number_of_nodes_per_cluster_limit_exceeded_fault => "NumberOfNodesPerClusterLimitExceededFault",
                .number_of_nodes_quota_exceeded_fault => "NumberOfNodesQuotaExceededFault",
                .partner_not_found_fault => "PartnerNotFoundFault",
                .redshift_idc_application_already_exists_fault => "RedshiftIdcApplicationAlreadyExistsFault",
                .redshift_idc_application_not_exists_fault => "RedshiftIdcApplicationNotExistsFault",
                .redshift_idc_application_quota_exceeded_fault => "RedshiftIdcApplicationQuotaExceededFault",
                .redshift_invalid_parameter_fault => "RedshiftInvalidParameterFault",
                .reserved_node_already_exists_fault => "ReservedNodeAlreadyExistsFault",
                .reserved_node_already_migrated_fault => "ReservedNodeAlreadyMigratedFault",
                .reserved_node_exchange_not_found_fault => "ReservedNodeExchangeNotFoundFault",
                .reserved_node_not_found_fault => "ReservedNodeNotFoundFault",
                .reserved_node_offering_not_found_fault => "ReservedNodeOfferingNotFoundFault",
                .reserved_node_quota_exceeded_fault => "ReservedNodeQuotaExceededFault",
                .resize_not_found_fault => "ResizeNotFoundFault",
                .resource_not_found_fault => "ResourceNotFoundFault",
                .schedule_definition_type_unsupported_fault => "ScheduleDefinitionTypeUnsupportedFault",
                .scheduled_action_already_exists_fault => "ScheduledActionAlreadyExistsFault",
                .scheduled_action_not_found_fault => "ScheduledActionNotFoundFault",
                .scheduled_action_quota_exceeded_fault => "ScheduledActionQuotaExceededFault",
                .scheduled_action_type_unsupported_fault => "ScheduledActionTypeUnsupportedFault",
                .snapshot_copy_already_disabled_fault => "SnapshotCopyAlreadyDisabledFault",
                .snapshot_copy_already_enabled_fault => "SnapshotCopyAlreadyEnabledFault",
                .snapshot_copy_disabled_fault => "SnapshotCopyDisabledFault",
                .snapshot_copy_grant_already_exists_fault => "SnapshotCopyGrantAlreadyExistsFault",
                .snapshot_copy_grant_not_found_fault => "SnapshotCopyGrantNotFoundFault",
                .snapshot_copy_grant_quota_exceeded_fault => "SnapshotCopyGrantQuotaExceededFault",
                .snapshot_schedule_already_exists_fault => "SnapshotScheduleAlreadyExistsFault",
                .snapshot_schedule_not_found_fault => "SnapshotScheduleNotFoundFault",
                .snapshot_schedule_quota_exceeded_fault => "SnapshotScheduleQuotaExceededFault",
                .snapshot_schedule_update_in_progress_fault => "SnapshotScheduleUpdateInProgressFault",
                .sns_invalid_topic_fault => "SNSInvalidTopicFault",
                .sns_no_authorization_fault => "SNSNoAuthorizationFault",
                .sns_topic_arn_not_found_fault => "SNSTopicArnNotFoundFault",
                .source_not_found_fault => "SourceNotFoundFault",
                .subnet_already_in_use => "SubnetAlreadyInUse",
                .subscription_already_exist_fault => "SubscriptionAlreadyExistFault",
                .subscription_category_not_found_fault => "SubscriptionCategoryNotFoundFault",
                .subscription_event_id_not_found_fault => "SubscriptionEventIdNotFoundFault",
                .subscription_not_found_fault => "SubscriptionNotFoundFault",
                .subscription_severity_not_found_fault => "SubscriptionSeverityNotFoundFault",
                .table_limit_exceeded_fault => "TableLimitExceededFault",
                .table_restore_not_found_fault => "TableRestoreNotFoundFault",
                .tag_limit_exceeded_fault => "TagLimitExceededFault",
                .unauthorized_operation => "UnauthorizedOperation",
                .unauthorized_partner_integration_fault => "UnauthorizedPartnerIntegrationFault",
                .unknown_snapshot_copy_region_fault => "UnknownSnapshotCopyRegionFault",
                .unsupported_operation_fault => "UnsupportedOperationFault",
                .unsupported_option_fault => "UnsupportedOptionFault",
                .usage_limit_already_exists_fault => "UsageLimitAlreadyExistsFault",
                .usage_limit_not_found_fault => "UsageLimitNotFoundFault",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_to_cluster_denied_fault => |e| e.message,
                .access_to_snapshot_denied_fault => |e| e.message,
                .authentication_profile_already_exists_fault => |e| e.message,
                .authentication_profile_not_found_fault => |e| e.message,
                .authentication_profile_quota_exceeded_fault => |e| e.message,
                .authorization_already_exists_fault => |e| e.message,
                .authorization_not_found_fault => |e| e.message,
                .authorization_quota_exceeded_fault => |e| e.message,
                .batch_delete_request_size_exceeded_fault => |e| e.message,
                .batch_modify_cluster_snapshots_limit_exceeded_fault => |e| e.message,
                .bucket_not_found_fault => |e| e.message,
                .cluster_already_exists_fault => |e| e.message,
                .cluster_not_found_fault => |e| e.message,
                .cluster_on_latest_revision_fault => |e| e.message,
                .cluster_parameter_group_already_exists_fault => |e| e.message,
                .cluster_parameter_group_not_found_fault => |e| e.message,
                .cluster_parameter_group_quota_exceeded_fault => |e| e.message,
                .cluster_quota_exceeded_fault => |e| e.message,
                .cluster_security_group_already_exists_fault => |e| e.message,
                .cluster_security_group_not_found_fault => |e| e.message,
                .cluster_security_group_quota_exceeded_fault => |e| e.message,
                .cluster_snapshot_already_exists_fault => |e| e.message,
                .cluster_snapshot_not_found_fault => |e| e.message,
                .cluster_snapshot_quota_exceeded_fault => |e| e.message,
                .cluster_subnet_group_already_exists_fault => |e| e.message,
                .cluster_subnet_group_not_found_fault => |e| e.message,
                .cluster_subnet_group_quota_exceeded_fault => |e| e.message,
                .cluster_subnet_quota_exceeded_fault => |e| e.message,
                .conflict_policy_update_fault => |e| e.message,
                .copy_to_region_disabled_fault => |e| e.message,
                .custom_cname_association_fault => |e| e.message,
                .custom_domain_association_not_found_fault => |e| e.message,
                .dependent_service_access_denied_fault => |e| e.message,
                .dependent_service_request_throttling_fault => |e| e.message,
                .dependent_service_unavailable_fault => |e| e.message,
                .endpoint_already_exists_fault => |e| e.message,
                .endpoint_authorization_already_exists_fault => |e| e.message,
                .endpoint_authorization_not_found_fault => |e| e.message,
                .endpoint_authorizations_per_cluster_limit_exceeded_fault => |e| e.message,
                .endpoint_not_found_fault => |e| e.message,
                .endpoints_per_authorization_limit_exceeded_fault => |e| e.message,
                .endpoints_per_cluster_limit_exceeded_fault => |e| e.message,
                .event_subscription_quota_exceeded_fault => |e| e.message,
                .hsm_client_certificate_already_exists_fault => |e| e.message,
                .hsm_client_certificate_not_found_fault => |e| e.message,
                .hsm_client_certificate_quota_exceeded_fault => |e| e.message,
                .hsm_configuration_already_exists_fault => |e| e.message,
                .hsm_configuration_not_found_fault => |e| e.message,
                .hsm_configuration_quota_exceeded_fault => |e| e.message,
                .in_progress_table_restore_quota_exceeded_fault => |e| e.message,
                .incompatible_orderable_options => |e| e.message,
                .insufficient_cluster_capacity_fault => |e| e.message,
                .insufficient_s3_bucket_policy_fault => |e| e.message,
                .integration_already_exists_fault => |e| e.message,
                .integration_conflict_operation_fault => |e| e.message,
                .integration_conflict_state_fault => |e| e.message,
                .integration_not_found_fault => |e| e.message,
                .integration_quota_exceeded_fault => |e| e.message,
                .integration_source_not_found_fault => |e| e.message,
                .integration_target_not_found_fault => |e| e.message,
                .invalid_authentication_profile_request_fault => |e| e.message,
                .invalid_authorization_state_fault => |e| e.message,
                .invalid_cluster_parameter_group_state_fault => |e| e.message,
                .invalid_cluster_security_group_state_fault => |e| e.message,
                .invalid_cluster_snapshot_schedule_state_fault => |e| e.message,
                .invalid_cluster_snapshot_state_fault => |e| e.message,
                .invalid_cluster_state_fault => |e| e.message,
                .invalid_cluster_subnet_group_state_fault => |e| e.message,
                .invalid_cluster_subnet_state_fault => |e| e.message,
                .invalid_cluster_track_fault => |e| e.message,
                .invalid_data_share_fault => |e| e.message,
                .invalid_elastic_ip_fault => |e| e.message,
                .invalid_endpoint_state_fault => |e| e.message,
                .invalid_hsm_client_certificate_state_fault => |e| e.message,
                .invalid_hsm_configuration_state_fault => |e| e.message,
                .invalid_namespace_fault => |e| e.message,
                .invalid_policy_fault => |e| e.message,
                .invalid_reserved_node_state_fault => |e| e.message,
                .invalid_restore_fault => |e| e.message,
                .invalid_retention_period_fault => |e| e.message,
                .invalid_s3_bucket_name_fault => |e| e.message,
                .invalid_s3_key_prefix_fault => |e| e.message,
                .invalid_schedule_fault => |e| e.message,
                .invalid_scheduled_action_fault => |e| e.message,
                .invalid_snapshot_copy_grant_state_fault => |e| e.message,
                .invalid_subnet => |e| e.message,
                .invalid_subscription_state_fault => |e| e.message,
                .invalid_table_restore_argument_fault => |e| e.message,
                .invalid_tag_fault => |e| e.message,
                .invalid_usage_limit_fault => |e| e.message,
                .invalid_vpc_network_state_fault => |e| e.message,
                .ipv_6_cidr_block_not_found_fault => |e| e.message,
                .limit_exceeded_fault => |e| e.message,
                .number_of_nodes_per_cluster_limit_exceeded_fault => |e| e.message,
                .number_of_nodes_quota_exceeded_fault => |e| e.message,
                .partner_not_found_fault => |e| e.message,
                .redshift_idc_application_already_exists_fault => |e| e.message,
                .redshift_idc_application_not_exists_fault => |e| e.message,
                .redshift_idc_application_quota_exceeded_fault => |e| e.message,
                .redshift_invalid_parameter_fault => |e| e.message,
                .reserved_node_already_exists_fault => |e| e.message,
                .reserved_node_already_migrated_fault => |e| e.message,
                .reserved_node_exchange_not_found_fault => |e| e.message,
                .reserved_node_not_found_fault => |e| e.message,
                .reserved_node_offering_not_found_fault => |e| e.message,
                .reserved_node_quota_exceeded_fault => |e| e.message,
                .resize_not_found_fault => |e| e.message,
                .resource_not_found_fault => |e| e.message,
                .schedule_definition_type_unsupported_fault => |e| e.message,
                .scheduled_action_already_exists_fault => |e| e.message,
                .scheduled_action_not_found_fault => |e| e.message,
                .scheduled_action_quota_exceeded_fault => |e| e.message,
                .scheduled_action_type_unsupported_fault => |e| e.message,
                .snapshot_copy_already_disabled_fault => |e| e.message,
                .snapshot_copy_already_enabled_fault => |e| e.message,
                .snapshot_copy_disabled_fault => |e| e.message,
                .snapshot_copy_grant_already_exists_fault => |e| e.message,
                .snapshot_copy_grant_not_found_fault => |e| e.message,
                .snapshot_copy_grant_quota_exceeded_fault => |e| e.message,
                .snapshot_schedule_already_exists_fault => |e| e.message,
                .snapshot_schedule_not_found_fault => |e| e.message,
                .snapshot_schedule_quota_exceeded_fault => |e| e.message,
                .snapshot_schedule_update_in_progress_fault => |e| e.message,
                .sns_invalid_topic_fault => |e| e.message,
                .sns_no_authorization_fault => |e| e.message,
                .sns_topic_arn_not_found_fault => |e| e.message,
                .source_not_found_fault => |e| e.message,
                .subnet_already_in_use => |e| e.message,
                .subscription_already_exist_fault => |e| e.message,
                .subscription_category_not_found_fault => |e| e.message,
                .subscription_event_id_not_found_fault => |e| e.message,
                .subscription_not_found_fault => |e| e.message,
                .subscription_severity_not_found_fault => |e| e.message,
                .table_limit_exceeded_fault => |e| e.message,
                .table_restore_not_found_fault => |e| e.message,
                .tag_limit_exceeded_fault => |e| e.message,
                .unauthorized_operation => |e| e.message,
                .unauthorized_partner_integration_fault => |e| e.message,
                .unknown_snapshot_copy_region_fault => |e| e.message,
                .unsupported_operation_fault => |e| e.message,
                .unsupported_option_fault => |e| e.message,
                .usage_limit_already_exists_fault => |e| e.message,
                .usage_limit_not_found_fault => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_to_cluster_denied_fault => 400,
                .access_to_snapshot_denied_fault => 400,
                .authentication_profile_already_exists_fault => 400,
                .authentication_profile_not_found_fault => 404,
                .authentication_profile_quota_exceeded_fault => 400,
                .authorization_already_exists_fault => 400,
                .authorization_not_found_fault => 404,
                .authorization_quota_exceeded_fault => 400,
                .batch_delete_request_size_exceeded_fault => 400,
                .batch_modify_cluster_snapshots_limit_exceeded_fault => 400,
                .bucket_not_found_fault => 400,
                .cluster_already_exists_fault => 400,
                .cluster_not_found_fault => 404,
                .cluster_on_latest_revision_fault => 400,
                .cluster_parameter_group_already_exists_fault => 400,
                .cluster_parameter_group_not_found_fault => 404,
                .cluster_parameter_group_quota_exceeded_fault => 400,
                .cluster_quota_exceeded_fault => 400,
                .cluster_security_group_already_exists_fault => 400,
                .cluster_security_group_not_found_fault => 404,
                .cluster_security_group_quota_exceeded_fault => 400,
                .cluster_snapshot_already_exists_fault => 400,
                .cluster_snapshot_not_found_fault => 404,
                .cluster_snapshot_quota_exceeded_fault => 400,
                .cluster_subnet_group_already_exists_fault => 400,
                .cluster_subnet_group_not_found_fault => 400,
                .cluster_subnet_group_quota_exceeded_fault => 400,
                .cluster_subnet_quota_exceeded_fault => 400,
                .conflict_policy_update_fault => 409,
                .copy_to_region_disabled_fault => 400,
                .custom_cname_association_fault => 400,
                .custom_domain_association_not_found_fault => 404,
                .dependent_service_access_denied_fault => 403,
                .dependent_service_request_throttling_fault => 400,
                .dependent_service_unavailable_fault => 400,
                .endpoint_already_exists_fault => 400,
                .endpoint_authorization_already_exists_fault => 400,
                .endpoint_authorization_not_found_fault => 404,
                .endpoint_authorizations_per_cluster_limit_exceeded_fault => 400,
                .endpoint_not_found_fault => 404,
                .endpoints_per_authorization_limit_exceeded_fault => 400,
                .endpoints_per_cluster_limit_exceeded_fault => 400,
                .event_subscription_quota_exceeded_fault => 400,
                .hsm_client_certificate_already_exists_fault => 400,
                .hsm_client_certificate_not_found_fault => 400,
                .hsm_client_certificate_quota_exceeded_fault => 400,
                .hsm_configuration_already_exists_fault => 400,
                .hsm_configuration_not_found_fault => 400,
                .hsm_configuration_quota_exceeded_fault => 400,
                .in_progress_table_restore_quota_exceeded_fault => 400,
                .incompatible_orderable_options => 400,
                .insufficient_cluster_capacity_fault => 400,
                .insufficient_s3_bucket_policy_fault => 400,
                .integration_already_exists_fault => 400,
                .integration_conflict_operation_fault => 400,
                .integration_conflict_state_fault => 400,
                .integration_not_found_fault => 404,
                .integration_quota_exceeded_fault => 400,
                .integration_source_not_found_fault => 404,
                .integration_target_not_found_fault => 404,
                .invalid_authentication_profile_request_fault => 400,
                .invalid_authorization_state_fault => 400,
                .invalid_cluster_parameter_group_state_fault => 400,
                .invalid_cluster_security_group_state_fault => 400,
                .invalid_cluster_snapshot_schedule_state_fault => 400,
                .invalid_cluster_snapshot_state_fault => 400,
                .invalid_cluster_state_fault => 400,
                .invalid_cluster_subnet_group_state_fault => 400,
                .invalid_cluster_subnet_state_fault => 400,
                .invalid_cluster_track_fault => 400,
                .invalid_data_share_fault => 400,
                .invalid_elastic_ip_fault => 400,
                .invalid_endpoint_state_fault => 400,
                .invalid_hsm_client_certificate_state_fault => 400,
                .invalid_hsm_configuration_state_fault => 400,
                .invalid_namespace_fault => 400,
                .invalid_policy_fault => 400,
                .invalid_reserved_node_state_fault => 400,
                .invalid_restore_fault => 406,
                .invalid_retention_period_fault => 400,
                .invalid_s3_bucket_name_fault => 400,
                .invalid_s3_key_prefix_fault => 400,
                .invalid_schedule_fault => 400,
                .invalid_scheduled_action_fault => 400,
                .invalid_snapshot_copy_grant_state_fault => 400,
                .invalid_subnet => 400,
                .invalid_subscription_state_fault => 400,
                .invalid_table_restore_argument_fault => 400,
                .invalid_tag_fault => 400,
                .invalid_usage_limit_fault => 400,
                .invalid_vpc_network_state_fault => 400,
                .ipv_6_cidr_block_not_found_fault => 400,
                .limit_exceeded_fault => 400,
                .number_of_nodes_per_cluster_limit_exceeded_fault => 400,
                .number_of_nodes_quota_exceeded_fault => 400,
                .partner_not_found_fault => 404,
                .redshift_idc_application_already_exists_fault => 400,
                .redshift_idc_application_not_exists_fault => 404,
                .redshift_idc_application_quota_exceeded_fault => 400,
                .redshift_invalid_parameter_fault => 400,
                .reserved_node_already_exists_fault => 404,
                .reserved_node_already_migrated_fault => 400,
                .reserved_node_exchange_not_found_fault => 404,
                .reserved_node_not_found_fault => 404,
                .reserved_node_offering_not_found_fault => 404,
                .reserved_node_quota_exceeded_fault => 400,
                .resize_not_found_fault => 404,
                .resource_not_found_fault => 404,
                .schedule_definition_type_unsupported_fault => 400,
                .scheduled_action_already_exists_fault => 400,
                .scheduled_action_not_found_fault => 400,
                .scheduled_action_quota_exceeded_fault => 400,
                .scheduled_action_type_unsupported_fault => 400,
                .snapshot_copy_already_disabled_fault => 400,
                .snapshot_copy_already_enabled_fault => 400,
                .snapshot_copy_disabled_fault => 400,
                .snapshot_copy_grant_already_exists_fault => 400,
                .snapshot_copy_grant_not_found_fault => 400,
                .snapshot_copy_grant_quota_exceeded_fault => 400,
                .snapshot_schedule_already_exists_fault => 400,
                .snapshot_schedule_not_found_fault => 400,
                .snapshot_schedule_quota_exceeded_fault => 400,
                .snapshot_schedule_update_in_progress_fault => 400,
                .sns_invalid_topic_fault => 400,
                .sns_no_authorization_fault => 400,
                .sns_topic_arn_not_found_fault => 404,
                .source_not_found_fault => 404,
                .subnet_already_in_use => 400,
                .subscription_already_exist_fault => 400,
                .subscription_category_not_found_fault => 404,
                .subscription_event_id_not_found_fault => 404,
                .subscription_not_found_fault => 404,
                .subscription_severity_not_found_fault => 404,
                .table_limit_exceeded_fault => 400,
                .table_restore_not_found_fault => 400,
                .tag_limit_exceeded_fault => 400,
                .unauthorized_operation => 400,
                .unauthorized_partner_integration_fault => 401,
                .unknown_snapshot_copy_region_fault => 404,
                .unsupported_operation_fault => 400,
                .unsupported_option_fault => 400,
                .usage_limit_already_exists_fault => 400,
                .usage_limit_not_found_fault => 404,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_to_cluster_denied_fault => |e| e.request_id,
                .access_to_snapshot_denied_fault => |e| e.request_id,
                .authentication_profile_already_exists_fault => |e| e.request_id,
                .authentication_profile_not_found_fault => |e| e.request_id,
                .authentication_profile_quota_exceeded_fault => |e| e.request_id,
                .authorization_already_exists_fault => |e| e.request_id,
                .authorization_not_found_fault => |e| e.request_id,
                .authorization_quota_exceeded_fault => |e| e.request_id,
                .batch_delete_request_size_exceeded_fault => |e| e.request_id,
                .batch_modify_cluster_snapshots_limit_exceeded_fault => |e| e.request_id,
                .bucket_not_found_fault => |e| e.request_id,
                .cluster_already_exists_fault => |e| e.request_id,
                .cluster_not_found_fault => |e| e.request_id,
                .cluster_on_latest_revision_fault => |e| e.request_id,
                .cluster_parameter_group_already_exists_fault => |e| e.request_id,
                .cluster_parameter_group_not_found_fault => |e| e.request_id,
                .cluster_parameter_group_quota_exceeded_fault => |e| e.request_id,
                .cluster_quota_exceeded_fault => |e| e.request_id,
                .cluster_security_group_already_exists_fault => |e| e.request_id,
                .cluster_security_group_not_found_fault => |e| e.request_id,
                .cluster_security_group_quota_exceeded_fault => |e| e.request_id,
                .cluster_snapshot_already_exists_fault => |e| e.request_id,
                .cluster_snapshot_not_found_fault => |e| e.request_id,
                .cluster_snapshot_quota_exceeded_fault => |e| e.request_id,
                .cluster_subnet_group_already_exists_fault => |e| e.request_id,
                .cluster_subnet_group_not_found_fault => |e| e.request_id,
                .cluster_subnet_group_quota_exceeded_fault => |e| e.request_id,
                .cluster_subnet_quota_exceeded_fault => |e| e.request_id,
                .conflict_policy_update_fault => |e| e.request_id,
                .copy_to_region_disabled_fault => |e| e.request_id,
                .custom_cname_association_fault => |e| e.request_id,
                .custom_domain_association_not_found_fault => |e| e.request_id,
                .dependent_service_access_denied_fault => |e| e.request_id,
                .dependent_service_request_throttling_fault => |e| e.request_id,
                .dependent_service_unavailable_fault => |e| e.request_id,
                .endpoint_already_exists_fault => |e| e.request_id,
                .endpoint_authorization_already_exists_fault => |e| e.request_id,
                .endpoint_authorization_not_found_fault => |e| e.request_id,
                .endpoint_authorizations_per_cluster_limit_exceeded_fault => |e| e.request_id,
                .endpoint_not_found_fault => |e| e.request_id,
                .endpoints_per_authorization_limit_exceeded_fault => |e| e.request_id,
                .endpoints_per_cluster_limit_exceeded_fault => |e| e.request_id,
                .event_subscription_quota_exceeded_fault => |e| e.request_id,
                .hsm_client_certificate_already_exists_fault => |e| e.request_id,
                .hsm_client_certificate_not_found_fault => |e| e.request_id,
                .hsm_client_certificate_quota_exceeded_fault => |e| e.request_id,
                .hsm_configuration_already_exists_fault => |e| e.request_id,
                .hsm_configuration_not_found_fault => |e| e.request_id,
                .hsm_configuration_quota_exceeded_fault => |e| e.request_id,
                .in_progress_table_restore_quota_exceeded_fault => |e| e.request_id,
                .incompatible_orderable_options => |e| e.request_id,
                .insufficient_cluster_capacity_fault => |e| e.request_id,
                .insufficient_s3_bucket_policy_fault => |e| e.request_id,
                .integration_already_exists_fault => |e| e.request_id,
                .integration_conflict_operation_fault => |e| e.request_id,
                .integration_conflict_state_fault => |e| e.request_id,
                .integration_not_found_fault => |e| e.request_id,
                .integration_quota_exceeded_fault => |e| e.request_id,
                .integration_source_not_found_fault => |e| e.request_id,
                .integration_target_not_found_fault => |e| e.request_id,
                .invalid_authentication_profile_request_fault => |e| e.request_id,
                .invalid_authorization_state_fault => |e| e.request_id,
                .invalid_cluster_parameter_group_state_fault => |e| e.request_id,
                .invalid_cluster_security_group_state_fault => |e| e.request_id,
                .invalid_cluster_snapshot_schedule_state_fault => |e| e.request_id,
                .invalid_cluster_snapshot_state_fault => |e| e.request_id,
                .invalid_cluster_state_fault => |e| e.request_id,
                .invalid_cluster_subnet_group_state_fault => |e| e.request_id,
                .invalid_cluster_subnet_state_fault => |e| e.request_id,
                .invalid_cluster_track_fault => |e| e.request_id,
                .invalid_data_share_fault => |e| e.request_id,
                .invalid_elastic_ip_fault => |e| e.request_id,
                .invalid_endpoint_state_fault => |e| e.request_id,
                .invalid_hsm_client_certificate_state_fault => |e| e.request_id,
                .invalid_hsm_configuration_state_fault => |e| e.request_id,
                .invalid_namespace_fault => |e| e.request_id,
                .invalid_policy_fault => |e| e.request_id,
                .invalid_reserved_node_state_fault => |e| e.request_id,
                .invalid_restore_fault => |e| e.request_id,
                .invalid_retention_period_fault => |e| e.request_id,
                .invalid_s3_bucket_name_fault => |e| e.request_id,
                .invalid_s3_key_prefix_fault => |e| e.request_id,
                .invalid_schedule_fault => |e| e.request_id,
                .invalid_scheduled_action_fault => |e| e.request_id,
                .invalid_snapshot_copy_grant_state_fault => |e| e.request_id,
                .invalid_subnet => |e| e.request_id,
                .invalid_subscription_state_fault => |e| e.request_id,
                .invalid_table_restore_argument_fault => |e| e.request_id,
                .invalid_tag_fault => |e| e.request_id,
                .invalid_usage_limit_fault => |e| e.request_id,
                .invalid_vpc_network_state_fault => |e| e.request_id,
                .ipv_6_cidr_block_not_found_fault => |e| e.request_id,
                .limit_exceeded_fault => |e| e.request_id,
                .number_of_nodes_per_cluster_limit_exceeded_fault => |e| e.request_id,
                .number_of_nodes_quota_exceeded_fault => |e| e.request_id,
                .partner_not_found_fault => |e| e.request_id,
                .redshift_idc_application_already_exists_fault => |e| e.request_id,
                .redshift_idc_application_not_exists_fault => |e| e.request_id,
                .redshift_idc_application_quota_exceeded_fault => |e| e.request_id,
                .redshift_invalid_parameter_fault => |e| e.request_id,
                .reserved_node_already_exists_fault => |e| e.request_id,
                .reserved_node_already_migrated_fault => |e| e.request_id,
                .reserved_node_exchange_not_found_fault => |e| e.request_id,
                .reserved_node_not_found_fault => |e| e.request_id,
                .reserved_node_offering_not_found_fault => |e| e.request_id,
                .reserved_node_quota_exceeded_fault => |e| e.request_id,
                .resize_not_found_fault => |e| e.request_id,
                .resource_not_found_fault => |e| e.request_id,
                .schedule_definition_type_unsupported_fault => |e| e.request_id,
                .scheduled_action_already_exists_fault => |e| e.request_id,
                .scheduled_action_not_found_fault => |e| e.request_id,
                .scheduled_action_quota_exceeded_fault => |e| e.request_id,
                .scheduled_action_type_unsupported_fault => |e| e.request_id,
                .snapshot_copy_already_disabled_fault => |e| e.request_id,
                .snapshot_copy_already_enabled_fault => |e| e.request_id,
                .snapshot_copy_disabled_fault => |e| e.request_id,
                .snapshot_copy_grant_already_exists_fault => |e| e.request_id,
                .snapshot_copy_grant_not_found_fault => |e| e.request_id,
                .snapshot_copy_grant_quota_exceeded_fault => |e| e.request_id,
                .snapshot_schedule_already_exists_fault => |e| e.request_id,
                .snapshot_schedule_not_found_fault => |e| e.request_id,
                .snapshot_schedule_quota_exceeded_fault => |e| e.request_id,
                .snapshot_schedule_update_in_progress_fault => |e| e.request_id,
                .sns_invalid_topic_fault => |e| e.request_id,
                .sns_no_authorization_fault => |e| e.request_id,
                .sns_topic_arn_not_found_fault => |e| e.request_id,
                .source_not_found_fault => |e| e.request_id,
                .subnet_already_in_use => |e| e.request_id,
                .subscription_already_exist_fault => |e| e.request_id,
                .subscription_category_not_found_fault => |e| e.request_id,
                .subscription_event_id_not_found_fault => |e| e.request_id,
                .subscription_not_found_fault => |e| e.request_id,
                .subscription_severity_not_found_fault => |e| e.request_id,
                .table_limit_exceeded_fault => |e| e.request_id,
                .table_restore_not_found_fault => |e| e.request_id,
                .tag_limit_exceeded_fault => |e| e.request_id,
                .unauthorized_operation => |e| e.request_id,
                .unauthorized_partner_integration_fault => |e| e.request_id,
                .unknown_snapshot_copy_region_fault => |e| e.request_id,
                .unsupported_operation_fault => |e| e.request_id,
                .unsupported_option_fault => |e| e.request_id,
                .usage_limit_already_exists_fault => |e| e.request_id,
                .usage_limit_not_found_fault => |e| e.request_id,
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

pub const AccessToClusterDeniedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccessToSnapshotDeniedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthenticationProfileAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthenticationProfileNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthenticationProfileQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthorizationAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthorizationNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthorizationQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BatchDeleteRequestSizeExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BatchModifyClusterSnapshotsLimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BucketNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterOnLatestRevisionFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterParameterGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterParameterGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSecurityGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSecurityGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSecurityGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSnapshotAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSnapshotNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSnapshotQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSubnetGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSubnetGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSubnetGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterSubnetQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictPolicyUpdateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CopyToRegionDisabledFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomCnameAssociationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomDomainAssociationNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DependentServiceAccessDeniedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DependentServiceRequestThrottlingFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DependentServiceUnavailableFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointAuthorizationAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointAuthorizationNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointAuthorizationsPerClusterLimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointsPerAuthorizationLimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointsPerClusterLimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventSubscriptionQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HsmClientCertificateAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HsmClientCertificateNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HsmClientCertificateQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HsmConfigurationAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HsmConfigurationNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HsmConfigurationQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InProgressTableRestoreQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatibleOrderableOptions = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientClusterCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientS3BucketPolicyFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationConflictOperationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationConflictStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationSourceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationTargetNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAuthenticationProfileRequestFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAuthorizationStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClusterParameterGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClusterSecurityGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClusterSnapshotScheduleStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClusterSnapshotStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClusterSubnetGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClusterSubnetStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClusterTrackFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDataShareFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidElasticIpFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEndpointStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidHsmClientCertificateStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidHsmConfigurationStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNamespaceFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPolicyFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidReservedNodeStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRestoreFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRetentionPeriodFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3BucketNameFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3KeyPrefixFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidScheduleFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidScheduledActionFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSnapshotCopyGrantStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSubnet = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSubscriptionStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTableRestoreArgumentFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidUsageLimitFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidVPCNetworkStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const Ipv6CidrBlockNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NumberOfNodesPerClusterLimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NumberOfNodesQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PartnerNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RedshiftIdcApplicationAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RedshiftIdcApplicationNotExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RedshiftIdcApplicationQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RedshiftInvalidParameterFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodeAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodeAlreadyMigratedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodeExchangeNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodeNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodeOfferingNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodeQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResizeNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ScheduleDefinitionTypeUnsupportedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ScheduledActionAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ScheduledActionNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ScheduledActionQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ScheduledActionTypeUnsupportedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotCopyAlreadyDisabledFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotCopyAlreadyEnabledFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotCopyDisabledFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotCopyGrantAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotCopyGrantNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotCopyGrantQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotScheduleAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotScheduleNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotScheduleQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotScheduleUpdateInProgressFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SNSInvalidTopicFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SNSNoAuthorizationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SNSTopicArnNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SourceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetAlreadyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubscriptionAlreadyExistFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubscriptionCategoryNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubscriptionEventIdNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubscriptionNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubscriptionSeverityNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TableLimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TableRestoreNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagLimitExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedPartnerIntegrationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownSnapshotCopyRegionFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOptionFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UsageLimitAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UsageLimitNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
