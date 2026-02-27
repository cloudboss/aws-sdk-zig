const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        authorization_already_exists_fault: AuthorizationAlreadyExistsFault,
        authorization_not_found_fault: AuthorizationNotFoundFault,
        authorization_quota_exceeded_fault: AuthorizationQuotaExceededFault,
        backup_policy_not_found_fault: BackupPolicyNotFoundFault,
        blue_green_deployment_already_exists_fault: BlueGreenDeploymentAlreadyExistsFault,
        blue_green_deployment_not_found_fault: BlueGreenDeploymentNotFoundFault,
        certificate_not_found_fault: CertificateNotFoundFault,
        create_custom_db_engine_version_fault: CreateCustomDBEngineVersionFault,
        custom_availability_zone_not_found_fault: CustomAvailabilityZoneNotFoundFault,
        custom_db_engine_version_already_exists_fault: CustomDBEngineVersionAlreadyExistsFault,
        custom_db_engine_version_not_found_fault: CustomDBEngineVersionNotFoundFault,
        custom_db_engine_version_quota_exceeded_fault: CustomDBEngineVersionQuotaExceededFault,
        db_cluster_already_exists_fault: DBClusterAlreadyExistsFault,
        db_cluster_automated_backup_not_found_fault: DBClusterAutomatedBackupNotFoundFault,
        db_cluster_automated_backup_quota_exceeded_fault: DBClusterAutomatedBackupQuotaExceededFault,
        db_cluster_backtrack_not_found_fault: DBClusterBacktrackNotFoundFault,
        db_cluster_endpoint_already_exists_fault: DBClusterEndpointAlreadyExistsFault,
        db_cluster_endpoint_not_found_fault: DBClusterEndpointNotFoundFault,
        db_cluster_endpoint_quota_exceeded_fault: DBClusterEndpointQuotaExceededFault,
        db_cluster_not_found_fault: DBClusterNotFoundFault,
        db_cluster_parameter_group_not_found_fault: DBClusterParameterGroupNotFoundFault,
        db_cluster_quota_exceeded_fault: DBClusterQuotaExceededFault,
        db_cluster_role_already_exists_fault: DBClusterRoleAlreadyExistsFault,
        db_cluster_role_not_found_fault: DBClusterRoleNotFoundFault,
        db_cluster_role_quota_exceeded_fault: DBClusterRoleQuotaExceededFault,
        db_cluster_snapshot_already_exists_fault: DBClusterSnapshotAlreadyExistsFault,
        db_cluster_snapshot_not_found_fault: DBClusterSnapshotNotFoundFault,
        db_instance_already_exists_fault: DBInstanceAlreadyExistsFault,
        db_instance_automated_backup_not_found_fault: DBInstanceAutomatedBackupNotFoundFault,
        db_instance_automated_backup_quota_exceeded_fault: DBInstanceAutomatedBackupQuotaExceededFault,
        db_instance_not_found_fault: DBInstanceNotFoundFault,
        db_instance_not_ready_fault: DBInstanceNotReadyFault,
        db_instance_role_already_exists_fault: DBInstanceRoleAlreadyExistsFault,
        db_instance_role_not_found_fault: DBInstanceRoleNotFoundFault,
        db_instance_role_quota_exceeded_fault: DBInstanceRoleQuotaExceededFault,
        db_log_file_not_found_fault: DBLogFileNotFoundFault,
        db_parameter_group_already_exists_fault: DBParameterGroupAlreadyExistsFault,
        db_parameter_group_not_found_fault: DBParameterGroupNotFoundFault,
        db_parameter_group_quota_exceeded_fault: DBParameterGroupQuotaExceededFault,
        db_proxy_already_exists_fault: DBProxyAlreadyExistsFault,
        db_proxy_endpoint_already_exists_fault: DBProxyEndpointAlreadyExistsFault,
        db_proxy_endpoint_not_found_fault: DBProxyEndpointNotFoundFault,
        db_proxy_endpoint_quota_exceeded_fault: DBProxyEndpointQuotaExceededFault,
        db_proxy_not_found_fault: DBProxyNotFoundFault,
        db_proxy_quota_exceeded_fault: DBProxyQuotaExceededFault,
        db_proxy_target_already_registered_fault: DBProxyTargetAlreadyRegisteredFault,
        db_proxy_target_group_not_found_fault: DBProxyTargetGroupNotFoundFault,
        db_proxy_target_not_found_fault: DBProxyTargetNotFoundFault,
        db_security_group_already_exists_fault: DBSecurityGroupAlreadyExistsFault,
        db_security_group_not_found_fault: DBSecurityGroupNotFoundFault,
        db_security_group_not_supported_fault: DBSecurityGroupNotSupportedFault,
        db_security_group_quota_exceeded_fault: DBSecurityGroupQuotaExceededFault,
        db_shard_group_already_exists_fault: DBShardGroupAlreadyExistsFault,
        db_shard_group_not_found_fault: DBShardGroupNotFoundFault,
        db_snapshot_already_exists_fault: DBSnapshotAlreadyExistsFault,
        db_snapshot_not_found_fault: DBSnapshotNotFoundFault,
        db_snapshot_tenant_database_not_found_fault: DBSnapshotTenantDatabaseNotFoundFault,
        db_subnet_group_already_exists_fault: DBSubnetGroupAlreadyExistsFault,
        db_subnet_group_does_not_cover_enough_a_zs: DBSubnetGroupDoesNotCoverEnoughAZs,
        db_subnet_group_not_allowed_fault: DBSubnetGroupNotAllowedFault,
        db_subnet_group_not_found_fault: DBSubnetGroupNotFoundFault,
        db_subnet_group_quota_exceeded_fault: DBSubnetGroupQuotaExceededFault,
        db_subnet_quota_exceeded_fault: DBSubnetQuotaExceededFault,
        db_upgrade_dependency_failure_fault: DBUpgradeDependencyFailureFault,
        domain_not_found_fault: DomainNotFoundFault,
        ec_2_image_properties_not_supported_fault: Ec2ImagePropertiesNotSupportedFault,
        event_subscription_quota_exceeded_fault: EventSubscriptionQuotaExceededFault,
        export_task_already_exists_fault: ExportTaskAlreadyExistsFault,
        export_task_not_found_fault: ExportTaskNotFoundFault,
        global_cluster_already_exists_fault: GlobalClusterAlreadyExistsFault,
        global_cluster_not_found_fault: GlobalClusterNotFoundFault,
        global_cluster_quota_exceeded_fault: GlobalClusterQuotaExceededFault,
        iam_role_missing_permissions_fault: IamRoleMissingPermissionsFault,
        iam_role_not_found_fault: IamRoleNotFoundFault,
        instance_quota_exceeded_fault: InstanceQuotaExceededFault,
        insufficient_available_i_ps_in_subnet_fault: InsufficientAvailableIPsInSubnetFault,
        insufficient_db_cluster_capacity_fault: InsufficientDBClusterCapacityFault,
        insufficient_db_instance_capacity_fault: InsufficientDBInstanceCapacityFault,
        insufficient_storage_cluster_capacity_fault: InsufficientStorageClusterCapacityFault,
        integration_already_exists_fault: IntegrationAlreadyExistsFault,
        integration_conflict_operation_fault: IntegrationConflictOperationFault,
        integration_not_found_fault: IntegrationNotFoundFault,
        integration_quota_exceeded_fault: IntegrationQuotaExceededFault,
        invalid_blue_green_deployment_state_fault: InvalidBlueGreenDeploymentStateFault,
        invalid_custom_db_engine_version_state_fault: InvalidCustomDBEngineVersionStateFault,
        invalid_db_cluster_automated_backup_state_fault: InvalidDBClusterAutomatedBackupStateFault,
        invalid_db_cluster_capacity_fault: InvalidDBClusterCapacityFault,
        invalid_db_cluster_endpoint_state_fault: InvalidDBClusterEndpointStateFault,
        invalid_db_cluster_snapshot_state_fault: InvalidDBClusterSnapshotStateFault,
        invalid_db_cluster_state_fault: InvalidDBClusterStateFault,
        invalid_db_instance_automated_backup_state_fault: InvalidDBInstanceAutomatedBackupStateFault,
        invalid_db_instance_state_fault: InvalidDBInstanceStateFault,
        invalid_db_parameter_group_state_fault: InvalidDBParameterGroupStateFault,
        invalid_db_proxy_endpoint_state_fault: InvalidDBProxyEndpointStateFault,
        invalid_db_proxy_state_fault: InvalidDBProxyStateFault,
        invalid_db_security_group_state_fault: InvalidDBSecurityGroupStateFault,
        invalid_db_shard_group_state_fault: InvalidDBShardGroupStateFault,
        invalid_db_snapshot_state_fault: InvalidDBSnapshotStateFault,
        invalid_db_subnet_group_fault: InvalidDBSubnetGroupFault,
        invalid_db_subnet_group_state_fault: InvalidDBSubnetGroupStateFault,
        invalid_db_subnet_state_fault: InvalidDBSubnetStateFault,
        invalid_event_subscription_state_fault: InvalidEventSubscriptionStateFault,
        invalid_export_only_fault: InvalidExportOnlyFault,
        invalid_export_source_state_fault: InvalidExportSourceStateFault,
        invalid_export_task_state_fault: InvalidExportTaskStateFault,
        invalid_global_cluster_state_fault: InvalidGlobalClusterStateFault,
        invalid_integration_state_fault: InvalidIntegrationStateFault,
        invalid_option_group_state_fault: InvalidOptionGroupStateFault,
        invalid_resource_state_fault: InvalidResourceStateFault,
        invalid_restore_fault: InvalidRestoreFault,
        invalid_s3_bucket_fault: InvalidS3BucketFault,
        invalid_subnet: InvalidSubnet,
        invalid_vpc_network_state_fault: InvalidVPCNetworkStateFault,
        kms_key_not_accessible_fault: KMSKeyNotAccessibleFault,
        max_db_shard_group_limit_reached: MaxDBShardGroupLimitReached,
        network_type_not_supported: NetworkTypeNotSupported,
        option_group_already_exists_fault: OptionGroupAlreadyExistsFault,
        option_group_not_found_fault: OptionGroupNotFoundFault,
        option_group_quota_exceeded_fault: OptionGroupQuotaExceededFault,
        point_in_time_restore_not_enabled_fault: PointInTimeRestoreNotEnabledFault,
        provisioned_iops_not_available_in_az_fault: ProvisionedIopsNotAvailableInAZFault,
        reserved_db_instance_already_exists_fault: ReservedDBInstanceAlreadyExistsFault,
        reserved_db_instance_not_found_fault: ReservedDBInstanceNotFoundFault,
        reserved_db_instance_quota_exceeded_fault: ReservedDBInstanceQuotaExceededFault,
        reserved_db_instances_offering_not_found_fault: ReservedDBInstancesOfferingNotFoundFault,
        resource_not_found_fault: ResourceNotFoundFault,
        shared_snapshot_quota_exceeded_fault: SharedSnapshotQuotaExceededFault,
        snapshot_quota_exceeded_fault: SnapshotQuotaExceededFault,
        sns_invalid_topic_fault: SNSInvalidTopicFault,
        sns_no_authorization_fault: SNSNoAuthorizationFault,
        sns_topic_arn_not_found_fault: SNSTopicArnNotFoundFault,
        source_cluster_not_supported_fault: SourceClusterNotSupportedFault,
        source_database_not_supported_fault: SourceDatabaseNotSupportedFault,
        source_not_found_fault: SourceNotFoundFault,
        storage_quota_exceeded_fault: StorageQuotaExceededFault,
        storage_type_not_available_fault: StorageTypeNotAvailableFault,
        storage_type_not_supported_fault: StorageTypeNotSupportedFault,
        subnet_already_in_use: SubnetAlreadyInUse,
        subscription_already_exist_fault: SubscriptionAlreadyExistFault,
        subscription_category_not_found_fault: SubscriptionCategoryNotFoundFault,
        subscription_not_found_fault: SubscriptionNotFoundFault,
        tenant_database_already_exists_fault: TenantDatabaseAlreadyExistsFault,
        tenant_database_not_found_fault: TenantDatabaseNotFoundFault,
        tenant_database_quota_exceeded_fault: TenantDatabaseQuotaExceededFault,
        unsupported_db_engine_version_fault: UnsupportedDBEngineVersionFault,
        vpc_encryption_control_violation_exception: VpcEncryptionControlViolationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .authorization_already_exists_fault => "AuthorizationAlreadyExistsFault",
                .authorization_not_found_fault => "AuthorizationNotFoundFault",
                .authorization_quota_exceeded_fault => "AuthorizationQuotaExceededFault",
                .backup_policy_not_found_fault => "BackupPolicyNotFoundFault",
                .blue_green_deployment_already_exists_fault => "BlueGreenDeploymentAlreadyExistsFault",
                .blue_green_deployment_not_found_fault => "BlueGreenDeploymentNotFoundFault",
                .certificate_not_found_fault => "CertificateNotFoundFault",
                .create_custom_db_engine_version_fault => "CreateCustomDBEngineVersionFault",
                .custom_availability_zone_not_found_fault => "CustomAvailabilityZoneNotFoundFault",
                .custom_db_engine_version_already_exists_fault => "CustomDBEngineVersionAlreadyExistsFault",
                .custom_db_engine_version_not_found_fault => "CustomDBEngineVersionNotFoundFault",
                .custom_db_engine_version_quota_exceeded_fault => "CustomDBEngineVersionQuotaExceededFault",
                .db_cluster_already_exists_fault => "DBClusterAlreadyExistsFault",
                .db_cluster_automated_backup_not_found_fault => "DBClusterAutomatedBackupNotFoundFault",
                .db_cluster_automated_backup_quota_exceeded_fault => "DBClusterAutomatedBackupQuotaExceededFault",
                .db_cluster_backtrack_not_found_fault => "DBClusterBacktrackNotFoundFault",
                .db_cluster_endpoint_already_exists_fault => "DBClusterEndpointAlreadyExistsFault",
                .db_cluster_endpoint_not_found_fault => "DBClusterEndpointNotFoundFault",
                .db_cluster_endpoint_quota_exceeded_fault => "DBClusterEndpointQuotaExceededFault",
                .db_cluster_not_found_fault => "DBClusterNotFoundFault",
                .db_cluster_parameter_group_not_found_fault => "DBClusterParameterGroupNotFoundFault",
                .db_cluster_quota_exceeded_fault => "DBClusterQuotaExceededFault",
                .db_cluster_role_already_exists_fault => "DBClusterRoleAlreadyExistsFault",
                .db_cluster_role_not_found_fault => "DBClusterRoleNotFoundFault",
                .db_cluster_role_quota_exceeded_fault => "DBClusterRoleQuotaExceededFault",
                .db_cluster_snapshot_already_exists_fault => "DBClusterSnapshotAlreadyExistsFault",
                .db_cluster_snapshot_not_found_fault => "DBClusterSnapshotNotFoundFault",
                .db_instance_already_exists_fault => "DBInstanceAlreadyExistsFault",
                .db_instance_automated_backup_not_found_fault => "DBInstanceAutomatedBackupNotFoundFault",
                .db_instance_automated_backup_quota_exceeded_fault => "DBInstanceAutomatedBackupQuotaExceededFault",
                .db_instance_not_found_fault => "DBInstanceNotFoundFault",
                .db_instance_not_ready_fault => "DBInstanceNotReadyFault",
                .db_instance_role_already_exists_fault => "DBInstanceRoleAlreadyExistsFault",
                .db_instance_role_not_found_fault => "DBInstanceRoleNotFoundFault",
                .db_instance_role_quota_exceeded_fault => "DBInstanceRoleQuotaExceededFault",
                .db_log_file_not_found_fault => "DBLogFileNotFoundFault",
                .db_parameter_group_already_exists_fault => "DBParameterGroupAlreadyExistsFault",
                .db_parameter_group_not_found_fault => "DBParameterGroupNotFoundFault",
                .db_parameter_group_quota_exceeded_fault => "DBParameterGroupQuotaExceededFault",
                .db_proxy_already_exists_fault => "DBProxyAlreadyExistsFault",
                .db_proxy_endpoint_already_exists_fault => "DBProxyEndpointAlreadyExistsFault",
                .db_proxy_endpoint_not_found_fault => "DBProxyEndpointNotFoundFault",
                .db_proxy_endpoint_quota_exceeded_fault => "DBProxyEndpointQuotaExceededFault",
                .db_proxy_not_found_fault => "DBProxyNotFoundFault",
                .db_proxy_quota_exceeded_fault => "DBProxyQuotaExceededFault",
                .db_proxy_target_already_registered_fault => "DBProxyTargetAlreadyRegisteredFault",
                .db_proxy_target_group_not_found_fault => "DBProxyTargetGroupNotFoundFault",
                .db_proxy_target_not_found_fault => "DBProxyTargetNotFoundFault",
                .db_security_group_already_exists_fault => "DBSecurityGroupAlreadyExistsFault",
                .db_security_group_not_found_fault => "DBSecurityGroupNotFoundFault",
                .db_security_group_not_supported_fault => "DBSecurityGroupNotSupportedFault",
                .db_security_group_quota_exceeded_fault => "DBSecurityGroupQuotaExceededFault",
                .db_shard_group_already_exists_fault => "DBShardGroupAlreadyExistsFault",
                .db_shard_group_not_found_fault => "DBShardGroupNotFoundFault",
                .db_snapshot_already_exists_fault => "DBSnapshotAlreadyExistsFault",
                .db_snapshot_not_found_fault => "DBSnapshotNotFoundFault",
                .db_snapshot_tenant_database_not_found_fault => "DBSnapshotTenantDatabaseNotFoundFault",
                .db_subnet_group_already_exists_fault => "DBSubnetGroupAlreadyExistsFault",
                .db_subnet_group_does_not_cover_enough_a_zs => "DBSubnetGroupDoesNotCoverEnoughAZs",
                .db_subnet_group_not_allowed_fault => "DBSubnetGroupNotAllowedFault",
                .db_subnet_group_not_found_fault => "DBSubnetGroupNotFoundFault",
                .db_subnet_group_quota_exceeded_fault => "DBSubnetGroupQuotaExceededFault",
                .db_subnet_quota_exceeded_fault => "DBSubnetQuotaExceededFault",
                .db_upgrade_dependency_failure_fault => "DBUpgradeDependencyFailureFault",
                .domain_not_found_fault => "DomainNotFoundFault",
                .ec_2_image_properties_not_supported_fault => "Ec2ImagePropertiesNotSupportedFault",
                .event_subscription_quota_exceeded_fault => "EventSubscriptionQuotaExceededFault",
                .export_task_already_exists_fault => "ExportTaskAlreadyExistsFault",
                .export_task_not_found_fault => "ExportTaskNotFoundFault",
                .global_cluster_already_exists_fault => "GlobalClusterAlreadyExistsFault",
                .global_cluster_not_found_fault => "GlobalClusterNotFoundFault",
                .global_cluster_quota_exceeded_fault => "GlobalClusterQuotaExceededFault",
                .iam_role_missing_permissions_fault => "IamRoleMissingPermissionsFault",
                .iam_role_not_found_fault => "IamRoleNotFoundFault",
                .instance_quota_exceeded_fault => "InstanceQuotaExceededFault",
                .insufficient_available_i_ps_in_subnet_fault => "InsufficientAvailableIPsInSubnetFault",
                .insufficient_db_cluster_capacity_fault => "InsufficientDBClusterCapacityFault",
                .insufficient_db_instance_capacity_fault => "InsufficientDBInstanceCapacityFault",
                .insufficient_storage_cluster_capacity_fault => "InsufficientStorageClusterCapacityFault",
                .integration_already_exists_fault => "IntegrationAlreadyExistsFault",
                .integration_conflict_operation_fault => "IntegrationConflictOperationFault",
                .integration_not_found_fault => "IntegrationNotFoundFault",
                .integration_quota_exceeded_fault => "IntegrationQuotaExceededFault",
                .invalid_blue_green_deployment_state_fault => "InvalidBlueGreenDeploymentStateFault",
                .invalid_custom_db_engine_version_state_fault => "InvalidCustomDBEngineVersionStateFault",
                .invalid_db_cluster_automated_backup_state_fault => "InvalidDBClusterAutomatedBackupStateFault",
                .invalid_db_cluster_capacity_fault => "InvalidDBClusterCapacityFault",
                .invalid_db_cluster_endpoint_state_fault => "InvalidDBClusterEndpointStateFault",
                .invalid_db_cluster_snapshot_state_fault => "InvalidDBClusterSnapshotStateFault",
                .invalid_db_cluster_state_fault => "InvalidDBClusterStateFault",
                .invalid_db_instance_automated_backup_state_fault => "InvalidDBInstanceAutomatedBackupStateFault",
                .invalid_db_instance_state_fault => "InvalidDBInstanceStateFault",
                .invalid_db_parameter_group_state_fault => "InvalidDBParameterGroupStateFault",
                .invalid_db_proxy_endpoint_state_fault => "InvalidDBProxyEndpointStateFault",
                .invalid_db_proxy_state_fault => "InvalidDBProxyStateFault",
                .invalid_db_security_group_state_fault => "InvalidDBSecurityGroupStateFault",
                .invalid_db_shard_group_state_fault => "InvalidDBShardGroupStateFault",
                .invalid_db_snapshot_state_fault => "InvalidDBSnapshotStateFault",
                .invalid_db_subnet_group_fault => "InvalidDBSubnetGroupFault",
                .invalid_db_subnet_group_state_fault => "InvalidDBSubnetGroupStateFault",
                .invalid_db_subnet_state_fault => "InvalidDBSubnetStateFault",
                .invalid_event_subscription_state_fault => "InvalidEventSubscriptionStateFault",
                .invalid_export_only_fault => "InvalidExportOnlyFault",
                .invalid_export_source_state_fault => "InvalidExportSourceStateFault",
                .invalid_export_task_state_fault => "InvalidExportTaskStateFault",
                .invalid_global_cluster_state_fault => "InvalidGlobalClusterStateFault",
                .invalid_integration_state_fault => "InvalidIntegrationStateFault",
                .invalid_option_group_state_fault => "InvalidOptionGroupStateFault",
                .invalid_resource_state_fault => "InvalidResourceStateFault",
                .invalid_restore_fault => "InvalidRestoreFault",
                .invalid_s3_bucket_fault => "InvalidS3BucketFault",
                .invalid_subnet => "InvalidSubnet",
                .invalid_vpc_network_state_fault => "InvalidVPCNetworkStateFault",
                .kms_key_not_accessible_fault => "KMSKeyNotAccessibleFault",
                .max_db_shard_group_limit_reached => "MaxDBShardGroupLimitReached",
                .network_type_not_supported => "NetworkTypeNotSupported",
                .option_group_already_exists_fault => "OptionGroupAlreadyExistsFault",
                .option_group_not_found_fault => "OptionGroupNotFoundFault",
                .option_group_quota_exceeded_fault => "OptionGroupQuotaExceededFault",
                .point_in_time_restore_not_enabled_fault => "PointInTimeRestoreNotEnabledFault",
                .provisioned_iops_not_available_in_az_fault => "ProvisionedIopsNotAvailableInAZFault",
                .reserved_db_instance_already_exists_fault => "ReservedDBInstanceAlreadyExistsFault",
                .reserved_db_instance_not_found_fault => "ReservedDBInstanceNotFoundFault",
                .reserved_db_instance_quota_exceeded_fault => "ReservedDBInstanceQuotaExceededFault",
                .reserved_db_instances_offering_not_found_fault => "ReservedDBInstancesOfferingNotFoundFault",
                .resource_not_found_fault => "ResourceNotFoundFault",
                .shared_snapshot_quota_exceeded_fault => "SharedSnapshotQuotaExceededFault",
                .snapshot_quota_exceeded_fault => "SnapshotQuotaExceededFault",
                .sns_invalid_topic_fault => "SNSInvalidTopicFault",
                .sns_no_authorization_fault => "SNSNoAuthorizationFault",
                .sns_topic_arn_not_found_fault => "SNSTopicArnNotFoundFault",
                .source_cluster_not_supported_fault => "SourceClusterNotSupportedFault",
                .source_database_not_supported_fault => "SourceDatabaseNotSupportedFault",
                .source_not_found_fault => "SourceNotFoundFault",
                .storage_quota_exceeded_fault => "StorageQuotaExceededFault",
                .storage_type_not_available_fault => "StorageTypeNotAvailableFault",
                .storage_type_not_supported_fault => "StorageTypeNotSupportedFault",
                .subnet_already_in_use => "SubnetAlreadyInUse",
                .subscription_already_exist_fault => "SubscriptionAlreadyExistFault",
                .subscription_category_not_found_fault => "SubscriptionCategoryNotFoundFault",
                .subscription_not_found_fault => "SubscriptionNotFoundFault",
                .tenant_database_already_exists_fault => "TenantDatabaseAlreadyExistsFault",
                .tenant_database_not_found_fault => "TenantDatabaseNotFoundFault",
                .tenant_database_quota_exceeded_fault => "TenantDatabaseQuotaExceededFault",
                .unsupported_db_engine_version_fault => "UnsupportedDBEngineVersionFault",
                .vpc_encryption_control_violation_exception => "VpcEncryptionControlViolationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .authorization_already_exists_fault => |e| e.message,
                .authorization_not_found_fault => |e| e.message,
                .authorization_quota_exceeded_fault => |e| e.message,
                .backup_policy_not_found_fault => |e| e.message,
                .blue_green_deployment_already_exists_fault => |e| e.message,
                .blue_green_deployment_not_found_fault => |e| e.message,
                .certificate_not_found_fault => |e| e.message,
                .create_custom_db_engine_version_fault => |e| e.message,
                .custom_availability_zone_not_found_fault => |e| e.message,
                .custom_db_engine_version_already_exists_fault => |e| e.message,
                .custom_db_engine_version_not_found_fault => |e| e.message,
                .custom_db_engine_version_quota_exceeded_fault => |e| e.message,
                .db_cluster_already_exists_fault => |e| e.message,
                .db_cluster_automated_backup_not_found_fault => |e| e.message,
                .db_cluster_automated_backup_quota_exceeded_fault => |e| e.message,
                .db_cluster_backtrack_not_found_fault => |e| e.message,
                .db_cluster_endpoint_already_exists_fault => |e| e.message,
                .db_cluster_endpoint_not_found_fault => |e| e.message,
                .db_cluster_endpoint_quota_exceeded_fault => |e| e.message,
                .db_cluster_not_found_fault => |e| e.message,
                .db_cluster_parameter_group_not_found_fault => |e| e.message,
                .db_cluster_quota_exceeded_fault => |e| e.message,
                .db_cluster_role_already_exists_fault => |e| e.message,
                .db_cluster_role_not_found_fault => |e| e.message,
                .db_cluster_role_quota_exceeded_fault => |e| e.message,
                .db_cluster_snapshot_already_exists_fault => |e| e.message,
                .db_cluster_snapshot_not_found_fault => |e| e.message,
                .db_instance_already_exists_fault => |e| e.message,
                .db_instance_automated_backup_not_found_fault => |e| e.message,
                .db_instance_automated_backup_quota_exceeded_fault => |e| e.message,
                .db_instance_not_found_fault => |e| e.message,
                .db_instance_not_ready_fault => |e| e.message,
                .db_instance_role_already_exists_fault => |e| e.message,
                .db_instance_role_not_found_fault => |e| e.message,
                .db_instance_role_quota_exceeded_fault => |e| e.message,
                .db_log_file_not_found_fault => |e| e.message,
                .db_parameter_group_already_exists_fault => |e| e.message,
                .db_parameter_group_not_found_fault => |e| e.message,
                .db_parameter_group_quota_exceeded_fault => |e| e.message,
                .db_proxy_already_exists_fault => |e| e.message,
                .db_proxy_endpoint_already_exists_fault => |e| e.message,
                .db_proxy_endpoint_not_found_fault => |e| e.message,
                .db_proxy_endpoint_quota_exceeded_fault => |e| e.message,
                .db_proxy_not_found_fault => |e| e.message,
                .db_proxy_quota_exceeded_fault => |e| e.message,
                .db_proxy_target_already_registered_fault => |e| e.message,
                .db_proxy_target_group_not_found_fault => |e| e.message,
                .db_proxy_target_not_found_fault => |e| e.message,
                .db_security_group_already_exists_fault => |e| e.message,
                .db_security_group_not_found_fault => |e| e.message,
                .db_security_group_not_supported_fault => |e| e.message,
                .db_security_group_quota_exceeded_fault => |e| e.message,
                .db_shard_group_already_exists_fault => |e| e.message,
                .db_shard_group_not_found_fault => |e| e.message,
                .db_snapshot_already_exists_fault => |e| e.message,
                .db_snapshot_not_found_fault => |e| e.message,
                .db_snapshot_tenant_database_not_found_fault => |e| e.message,
                .db_subnet_group_already_exists_fault => |e| e.message,
                .db_subnet_group_does_not_cover_enough_a_zs => |e| e.message,
                .db_subnet_group_not_allowed_fault => |e| e.message,
                .db_subnet_group_not_found_fault => |e| e.message,
                .db_subnet_group_quota_exceeded_fault => |e| e.message,
                .db_subnet_quota_exceeded_fault => |e| e.message,
                .db_upgrade_dependency_failure_fault => |e| e.message,
                .domain_not_found_fault => |e| e.message,
                .ec_2_image_properties_not_supported_fault => |e| e.message,
                .event_subscription_quota_exceeded_fault => |e| e.message,
                .export_task_already_exists_fault => |e| e.message,
                .export_task_not_found_fault => |e| e.message,
                .global_cluster_already_exists_fault => |e| e.message,
                .global_cluster_not_found_fault => |e| e.message,
                .global_cluster_quota_exceeded_fault => |e| e.message,
                .iam_role_missing_permissions_fault => |e| e.message,
                .iam_role_not_found_fault => |e| e.message,
                .instance_quota_exceeded_fault => |e| e.message,
                .insufficient_available_i_ps_in_subnet_fault => |e| e.message,
                .insufficient_db_cluster_capacity_fault => |e| e.message,
                .insufficient_db_instance_capacity_fault => |e| e.message,
                .insufficient_storage_cluster_capacity_fault => |e| e.message,
                .integration_already_exists_fault => |e| e.message,
                .integration_conflict_operation_fault => |e| e.message,
                .integration_not_found_fault => |e| e.message,
                .integration_quota_exceeded_fault => |e| e.message,
                .invalid_blue_green_deployment_state_fault => |e| e.message,
                .invalid_custom_db_engine_version_state_fault => |e| e.message,
                .invalid_db_cluster_automated_backup_state_fault => |e| e.message,
                .invalid_db_cluster_capacity_fault => |e| e.message,
                .invalid_db_cluster_endpoint_state_fault => |e| e.message,
                .invalid_db_cluster_snapshot_state_fault => |e| e.message,
                .invalid_db_cluster_state_fault => |e| e.message,
                .invalid_db_instance_automated_backup_state_fault => |e| e.message,
                .invalid_db_instance_state_fault => |e| e.message,
                .invalid_db_parameter_group_state_fault => |e| e.message,
                .invalid_db_proxy_endpoint_state_fault => |e| e.message,
                .invalid_db_proxy_state_fault => |e| e.message,
                .invalid_db_security_group_state_fault => |e| e.message,
                .invalid_db_shard_group_state_fault => |e| e.message,
                .invalid_db_snapshot_state_fault => |e| e.message,
                .invalid_db_subnet_group_fault => |e| e.message,
                .invalid_db_subnet_group_state_fault => |e| e.message,
                .invalid_db_subnet_state_fault => |e| e.message,
                .invalid_event_subscription_state_fault => |e| e.message,
                .invalid_export_only_fault => |e| e.message,
                .invalid_export_source_state_fault => |e| e.message,
                .invalid_export_task_state_fault => |e| e.message,
                .invalid_global_cluster_state_fault => |e| e.message,
                .invalid_integration_state_fault => |e| e.message,
                .invalid_option_group_state_fault => |e| e.message,
                .invalid_resource_state_fault => |e| e.message,
                .invalid_restore_fault => |e| e.message,
                .invalid_s3_bucket_fault => |e| e.message,
                .invalid_subnet => |e| e.message,
                .invalid_vpc_network_state_fault => |e| e.message,
                .kms_key_not_accessible_fault => |e| e.message,
                .max_db_shard_group_limit_reached => |e| e.message,
                .network_type_not_supported => |e| e.message,
                .option_group_already_exists_fault => |e| e.message,
                .option_group_not_found_fault => |e| e.message,
                .option_group_quota_exceeded_fault => |e| e.message,
                .point_in_time_restore_not_enabled_fault => |e| e.message,
                .provisioned_iops_not_available_in_az_fault => |e| e.message,
                .reserved_db_instance_already_exists_fault => |e| e.message,
                .reserved_db_instance_not_found_fault => |e| e.message,
                .reserved_db_instance_quota_exceeded_fault => |e| e.message,
                .reserved_db_instances_offering_not_found_fault => |e| e.message,
                .resource_not_found_fault => |e| e.message,
                .shared_snapshot_quota_exceeded_fault => |e| e.message,
                .snapshot_quota_exceeded_fault => |e| e.message,
                .sns_invalid_topic_fault => |e| e.message,
                .sns_no_authorization_fault => |e| e.message,
                .sns_topic_arn_not_found_fault => |e| e.message,
                .source_cluster_not_supported_fault => |e| e.message,
                .source_database_not_supported_fault => |e| e.message,
                .source_not_found_fault => |e| e.message,
                .storage_quota_exceeded_fault => |e| e.message,
                .storage_type_not_available_fault => |e| e.message,
                .storage_type_not_supported_fault => |e| e.message,
                .subnet_already_in_use => |e| e.message,
                .subscription_already_exist_fault => |e| e.message,
                .subscription_category_not_found_fault => |e| e.message,
                .subscription_not_found_fault => |e| e.message,
                .tenant_database_already_exists_fault => |e| e.message,
                .tenant_database_not_found_fault => |e| e.message,
                .tenant_database_quota_exceeded_fault => |e| e.message,
                .unsupported_db_engine_version_fault => |e| e.message,
                .vpc_encryption_control_violation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .authorization_already_exists_fault => 400,
                .authorization_not_found_fault => 404,
                .authorization_quota_exceeded_fault => 400,
                .backup_policy_not_found_fault => 404,
                .blue_green_deployment_already_exists_fault => 400,
                .blue_green_deployment_not_found_fault => 404,
                .certificate_not_found_fault => 404,
                .create_custom_db_engine_version_fault => 400,
                .custom_availability_zone_not_found_fault => 404,
                .custom_db_engine_version_already_exists_fault => 400,
                .custom_db_engine_version_not_found_fault => 404,
                .custom_db_engine_version_quota_exceeded_fault => 400,
                .db_cluster_already_exists_fault => 400,
                .db_cluster_automated_backup_not_found_fault => 404,
                .db_cluster_automated_backup_quota_exceeded_fault => 400,
                .db_cluster_backtrack_not_found_fault => 404,
                .db_cluster_endpoint_already_exists_fault => 400,
                .db_cluster_endpoint_not_found_fault => 400,
                .db_cluster_endpoint_quota_exceeded_fault => 403,
                .db_cluster_not_found_fault => 404,
                .db_cluster_parameter_group_not_found_fault => 404,
                .db_cluster_quota_exceeded_fault => 403,
                .db_cluster_role_already_exists_fault => 400,
                .db_cluster_role_not_found_fault => 404,
                .db_cluster_role_quota_exceeded_fault => 400,
                .db_cluster_snapshot_already_exists_fault => 400,
                .db_cluster_snapshot_not_found_fault => 404,
                .db_instance_already_exists_fault => 400,
                .db_instance_automated_backup_not_found_fault => 404,
                .db_instance_automated_backup_quota_exceeded_fault => 400,
                .db_instance_not_found_fault => 404,
                .db_instance_not_ready_fault => 400,
                .db_instance_role_already_exists_fault => 400,
                .db_instance_role_not_found_fault => 404,
                .db_instance_role_quota_exceeded_fault => 400,
                .db_log_file_not_found_fault => 404,
                .db_parameter_group_already_exists_fault => 400,
                .db_parameter_group_not_found_fault => 404,
                .db_parameter_group_quota_exceeded_fault => 400,
                .db_proxy_already_exists_fault => 400,
                .db_proxy_endpoint_already_exists_fault => 400,
                .db_proxy_endpoint_not_found_fault => 404,
                .db_proxy_endpoint_quota_exceeded_fault => 400,
                .db_proxy_not_found_fault => 404,
                .db_proxy_quota_exceeded_fault => 400,
                .db_proxy_target_already_registered_fault => 400,
                .db_proxy_target_group_not_found_fault => 404,
                .db_proxy_target_not_found_fault => 404,
                .db_security_group_already_exists_fault => 400,
                .db_security_group_not_found_fault => 404,
                .db_security_group_not_supported_fault => 400,
                .db_security_group_quota_exceeded_fault => 400,
                .db_shard_group_already_exists_fault => 400,
                .db_shard_group_not_found_fault => 404,
                .db_snapshot_already_exists_fault => 400,
                .db_snapshot_not_found_fault => 404,
                .db_snapshot_tenant_database_not_found_fault => 404,
                .db_subnet_group_already_exists_fault => 400,
                .db_subnet_group_does_not_cover_enough_a_zs => 400,
                .db_subnet_group_not_allowed_fault => 400,
                .db_subnet_group_not_found_fault => 404,
                .db_subnet_group_quota_exceeded_fault => 400,
                .db_subnet_quota_exceeded_fault => 400,
                .db_upgrade_dependency_failure_fault => 400,
                .domain_not_found_fault => 404,
                .ec_2_image_properties_not_supported_fault => 400,
                .event_subscription_quota_exceeded_fault => 400,
                .export_task_already_exists_fault => 400,
                .export_task_not_found_fault => 404,
                .global_cluster_already_exists_fault => 400,
                .global_cluster_not_found_fault => 404,
                .global_cluster_quota_exceeded_fault => 400,
                .iam_role_missing_permissions_fault => 400,
                .iam_role_not_found_fault => 404,
                .instance_quota_exceeded_fault => 400,
                .insufficient_available_i_ps_in_subnet_fault => 400,
                .insufficient_db_cluster_capacity_fault => 403,
                .insufficient_db_instance_capacity_fault => 400,
                .insufficient_storage_cluster_capacity_fault => 400,
                .integration_already_exists_fault => 400,
                .integration_conflict_operation_fault => 400,
                .integration_not_found_fault => 404,
                .integration_quota_exceeded_fault => 400,
                .invalid_blue_green_deployment_state_fault => 400,
                .invalid_custom_db_engine_version_state_fault => 400,
                .invalid_db_cluster_automated_backup_state_fault => 400,
                .invalid_db_cluster_capacity_fault => 400,
                .invalid_db_cluster_endpoint_state_fault => 400,
                .invalid_db_cluster_snapshot_state_fault => 400,
                .invalid_db_cluster_state_fault => 400,
                .invalid_db_instance_automated_backup_state_fault => 400,
                .invalid_db_instance_state_fault => 400,
                .invalid_db_parameter_group_state_fault => 400,
                .invalid_db_proxy_endpoint_state_fault => 400,
                .invalid_db_proxy_state_fault => 400,
                .invalid_db_security_group_state_fault => 400,
                .invalid_db_shard_group_state_fault => 400,
                .invalid_db_snapshot_state_fault => 400,
                .invalid_db_subnet_group_fault => 400,
                .invalid_db_subnet_group_state_fault => 400,
                .invalid_db_subnet_state_fault => 400,
                .invalid_event_subscription_state_fault => 400,
                .invalid_export_only_fault => 400,
                .invalid_export_source_state_fault => 400,
                .invalid_export_task_state_fault => 400,
                .invalid_global_cluster_state_fault => 400,
                .invalid_integration_state_fault => 400,
                .invalid_option_group_state_fault => 400,
                .invalid_resource_state_fault => 400,
                .invalid_restore_fault => 400,
                .invalid_s3_bucket_fault => 400,
                .invalid_subnet => 400,
                .invalid_vpc_network_state_fault => 400,
                .kms_key_not_accessible_fault => 400,
                .max_db_shard_group_limit_reached => 400,
                .network_type_not_supported => 400,
                .option_group_already_exists_fault => 400,
                .option_group_not_found_fault => 404,
                .option_group_quota_exceeded_fault => 400,
                .point_in_time_restore_not_enabled_fault => 400,
                .provisioned_iops_not_available_in_az_fault => 400,
                .reserved_db_instance_already_exists_fault => 404,
                .reserved_db_instance_not_found_fault => 404,
                .reserved_db_instance_quota_exceeded_fault => 400,
                .reserved_db_instances_offering_not_found_fault => 404,
                .resource_not_found_fault => 404,
                .shared_snapshot_quota_exceeded_fault => 400,
                .snapshot_quota_exceeded_fault => 400,
                .sns_invalid_topic_fault => 400,
                .sns_no_authorization_fault => 400,
                .sns_topic_arn_not_found_fault => 404,
                .source_cluster_not_supported_fault => 400,
                .source_database_not_supported_fault => 400,
                .source_not_found_fault => 404,
                .storage_quota_exceeded_fault => 400,
                .storage_type_not_available_fault => 400,
                .storage_type_not_supported_fault => 400,
                .subnet_already_in_use => 400,
                .subscription_already_exist_fault => 400,
                .subscription_category_not_found_fault => 404,
                .subscription_not_found_fault => 404,
                .tenant_database_already_exists_fault => 400,
                .tenant_database_not_found_fault => 404,
                .tenant_database_quota_exceeded_fault => 400,
                .unsupported_db_engine_version_fault => 400,
                .vpc_encryption_control_violation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .authorization_already_exists_fault => |e| e.request_id,
                .authorization_not_found_fault => |e| e.request_id,
                .authorization_quota_exceeded_fault => |e| e.request_id,
                .backup_policy_not_found_fault => |e| e.request_id,
                .blue_green_deployment_already_exists_fault => |e| e.request_id,
                .blue_green_deployment_not_found_fault => |e| e.request_id,
                .certificate_not_found_fault => |e| e.request_id,
                .create_custom_db_engine_version_fault => |e| e.request_id,
                .custom_availability_zone_not_found_fault => |e| e.request_id,
                .custom_db_engine_version_already_exists_fault => |e| e.request_id,
                .custom_db_engine_version_not_found_fault => |e| e.request_id,
                .custom_db_engine_version_quota_exceeded_fault => |e| e.request_id,
                .db_cluster_already_exists_fault => |e| e.request_id,
                .db_cluster_automated_backup_not_found_fault => |e| e.request_id,
                .db_cluster_automated_backup_quota_exceeded_fault => |e| e.request_id,
                .db_cluster_backtrack_not_found_fault => |e| e.request_id,
                .db_cluster_endpoint_already_exists_fault => |e| e.request_id,
                .db_cluster_endpoint_not_found_fault => |e| e.request_id,
                .db_cluster_endpoint_quota_exceeded_fault => |e| e.request_id,
                .db_cluster_not_found_fault => |e| e.request_id,
                .db_cluster_parameter_group_not_found_fault => |e| e.request_id,
                .db_cluster_quota_exceeded_fault => |e| e.request_id,
                .db_cluster_role_already_exists_fault => |e| e.request_id,
                .db_cluster_role_not_found_fault => |e| e.request_id,
                .db_cluster_role_quota_exceeded_fault => |e| e.request_id,
                .db_cluster_snapshot_already_exists_fault => |e| e.request_id,
                .db_cluster_snapshot_not_found_fault => |e| e.request_id,
                .db_instance_already_exists_fault => |e| e.request_id,
                .db_instance_automated_backup_not_found_fault => |e| e.request_id,
                .db_instance_automated_backup_quota_exceeded_fault => |e| e.request_id,
                .db_instance_not_found_fault => |e| e.request_id,
                .db_instance_not_ready_fault => |e| e.request_id,
                .db_instance_role_already_exists_fault => |e| e.request_id,
                .db_instance_role_not_found_fault => |e| e.request_id,
                .db_instance_role_quota_exceeded_fault => |e| e.request_id,
                .db_log_file_not_found_fault => |e| e.request_id,
                .db_parameter_group_already_exists_fault => |e| e.request_id,
                .db_parameter_group_not_found_fault => |e| e.request_id,
                .db_parameter_group_quota_exceeded_fault => |e| e.request_id,
                .db_proxy_already_exists_fault => |e| e.request_id,
                .db_proxy_endpoint_already_exists_fault => |e| e.request_id,
                .db_proxy_endpoint_not_found_fault => |e| e.request_id,
                .db_proxy_endpoint_quota_exceeded_fault => |e| e.request_id,
                .db_proxy_not_found_fault => |e| e.request_id,
                .db_proxy_quota_exceeded_fault => |e| e.request_id,
                .db_proxy_target_already_registered_fault => |e| e.request_id,
                .db_proxy_target_group_not_found_fault => |e| e.request_id,
                .db_proxy_target_not_found_fault => |e| e.request_id,
                .db_security_group_already_exists_fault => |e| e.request_id,
                .db_security_group_not_found_fault => |e| e.request_id,
                .db_security_group_not_supported_fault => |e| e.request_id,
                .db_security_group_quota_exceeded_fault => |e| e.request_id,
                .db_shard_group_already_exists_fault => |e| e.request_id,
                .db_shard_group_not_found_fault => |e| e.request_id,
                .db_snapshot_already_exists_fault => |e| e.request_id,
                .db_snapshot_not_found_fault => |e| e.request_id,
                .db_snapshot_tenant_database_not_found_fault => |e| e.request_id,
                .db_subnet_group_already_exists_fault => |e| e.request_id,
                .db_subnet_group_does_not_cover_enough_a_zs => |e| e.request_id,
                .db_subnet_group_not_allowed_fault => |e| e.request_id,
                .db_subnet_group_not_found_fault => |e| e.request_id,
                .db_subnet_group_quota_exceeded_fault => |e| e.request_id,
                .db_subnet_quota_exceeded_fault => |e| e.request_id,
                .db_upgrade_dependency_failure_fault => |e| e.request_id,
                .domain_not_found_fault => |e| e.request_id,
                .ec_2_image_properties_not_supported_fault => |e| e.request_id,
                .event_subscription_quota_exceeded_fault => |e| e.request_id,
                .export_task_already_exists_fault => |e| e.request_id,
                .export_task_not_found_fault => |e| e.request_id,
                .global_cluster_already_exists_fault => |e| e.request_id,
                .global_cluster_not_found_fault => |e| e.request_id,
                .global_cluster_quota_exceeded_fault => |e| e.request_id,
                .iam_role_missing_permissions_fault => |e| e.request_id,
                .iam_role_not_found_fault => |e| e.request_id,
                .instance_quota_exceeded_fault => |e| e.request_id,
                .insufficient_available_i_ps_in_subnet_fault => |e| e.request_id,
                .insufficient_db_cluster_capacity_fault => |e| e.request_id,
                .insufficient_db_instance_capacity_fault => |e| e.request_id,
                .insufficient_storage_cluster_capacity_fault => |e| e.request_id,
                .integration_already_exists_fault => |e| e.request_id,
                .integration_conflict_operation_fault => |e| e.request_id,
                .integration_not_found_fault => |e| e.request_id,
                .integration_quota_exceeded_fault => |e| e.request_id,
                .invalid_blue_green_deployment_state_fault => |e| e.request_id,
                .invalid_custom_db_engine_version_state_fault => |e| e.request_id,
                .invalid_db_cluster_automated_backup_state_fault => |e| e.request_id,
                .invalid_db_cluster_capacity_fault => |e| e.request_id,
                .invalid_db_cluster_endpoint_state_fault => |e| e.request_id,
                .invalid_db_cluster_snapshot_state_fault => |e| e.request_id,
                .invalid_db_cluster_state_fault => |e| e.request_id,
                .invalid_db_instance_automated_backup_state_fault => |e| e.request_id,
                .invalid_db_instance_state_fault => |e| e.request_id,
                .invalid_db_parameter_group_state_fault => |e| e.request_id,
                .invalid_db_proxy_endpoint_state_fault => |e| e.request_id,
                .invalid_db_proxy_state_fault => |e| e.request_id,
                .invalid_db_security_group_state_fault => |e| e.request_id,
                .invalid_db_shard_group_state_fault => |e| e.request_id,
                .invalid_db_snapshot_state_fault => |e| e.request_id,
                .invalid_db_subnet_group_fault => |e| e.request_id,
                .invalid_db_subnet_group_state_fault => |e| e.request_id,
                .invalid_db_subnet_state_fault => |e| e.request_id,
                .invalid_event_subscription_state_fault => |e| e.request_id,
                .invalid_export_only_fault => |e| e.request_id,
                .invalid_export_source_state_fault => |e| e.request_id,
                .invalid_export_task_state_fault => |e| e.request_id,
                .invalid_global_cluster_state_fault => |e| e.request_id,
                .invalid_integration_state_fault => |e| e.request_id,
                .invalid_option_group_state_fault => |e| e.request_id,
                .invalid_resource_state_fault => |e| e.request_id,
                .invalid_restore_fault => |e| e.request_id,
                .invalid_s3_bucket_fault => |e| e.request_id,
                .invalid_subnet => |e| e.request_id,
                .invalid_vpc_network_state_fault => |e| e.request_id,
                .kms_key_not_accessible_fault => |e| e.request_id,
                .max_db_shard_group_limit_reached => |e| e.request_id,
                .network_type_not_supported => |e| e.request_id,
                .option_group_already_exists_fault => |e| e.request_id,
                .option_group_not_found_fault => |e| e.request_id,
                .option_group_quota_exceeded_fault => |e| e.request_id,
                .point_in_time_restore_not_enabled_fault => |e| e.request_id,
                .provisioned_iops_not_available_in_az_fault => |e| e.request_id,
                .reserved_db_instance_already_exists_fault => |e| e.request_id,
                .reserved_db_instance_not_found_fault => |e| e.request_id,
                .reserved_db_instance_quota_exceeded_fault => |e| e.request_id,
                .reserved_db_instances_offering_not_found_fault => |e| e.request_id,
                .resource_not_found_fault => |e| e.request_id,
                .shared_snapshot_quota_exceeded_fault => |e| e.request_id,
                .snapshot_quota_exceeded_fault => |e| e.request_id,
                .sns_invalid_topic_fault => |e| e.request_id,
                .sns_no_authorization_fault => |e| e.request_id,
                .sns_topic_arn_not_found_fault => |e| e.request_id,
                .source_cluster_not_supported_fault => |e| e.request_id,
                .source_database_not_supported_fault => |e| e.request_id,
                .source_not_found_fault => |e| e.request_id,
                .storage_quota_exceeded_fault => |e| e.request_id,
                .storage_type_not_available_fault => |e| e.request_id,
                .storage_type_not_supported_fault => |e| e.request_id,
                .subnet_already_in_use => |e| e.request_id,
                .subscription_already_exist_fault => |e| e.request_id,
                .subscription_category_not_found_fault => |e| e.request_id,
                .subscription_not_found_fault => |e| e.request_id,
                .tenant_database_already_exists_fault => |e| e.request_id,
                .tenant_database_not_found_fault => |e| e.request_id,
                .tenant_database_quota_exceeded_fault => |e| e.request_id,
                .unsupported_db_engine_version_fault => |e| e.request_id,
                .vpc_encryption_control_violation_exception => |e| e.request_id,
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

pub const BackupPolicyNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BlueGreenDeploymentAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BlueGreenDeploymentNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CreateCustomDBEngineVersionFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomAvailabilityZoneNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomDBEngineVersionAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomDBEngineVersionNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomDBEngineVersionQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterAutomatedBackupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterAutomatedBackupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterBacktrackNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterEndpointAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterEndpointNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterEndpointQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterRoleAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterRoleNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterRoleQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterSnapshotAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterSnapshotNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceAutomatedBackupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceAutomatedBackupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceNotReadyFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceRoleAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceRoleNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceRoleQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBLogFileNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBParameterGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBParameterGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBProxyAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBProxyEndpointAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBProxyEndpointNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBProxyEndpointQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBProxyNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBProxyQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBProxyTargetAlreadyRegisteredFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBProxyTargetGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBProxyTargetNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSecurityGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSecurityGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSecurityGroupNotSupportedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSecurityGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBShardGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBShardGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSnapshotAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSnapshotNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSnapshotTenantDatabaseNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetGroupDoesNotCoverEnoughAZs = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetGroupNotAllowedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBUpgradeDependencyFailureFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DomainNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const Ec2ImagePropertiesNotSupportedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventSubscriptionQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExportTaskAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExportTaskNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalClusterQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IamRoleMissingPermissionsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IamRoleNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientAvailableIPsInSubnetFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientDBClusterCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientDBInstanceCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientStorageClusterCapacityFault = struct {
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

pub const IntegrationNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IntegrationQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidBlueGreenDeploymentStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCustomDBEngineVersionStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBClusterAutomatedBackupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBClusterCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBClusterEndpointStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBClusterSnapshotStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBInstanceAutomatedBackupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBInstanceStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBParameterGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBProxyEndpointStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBProxyStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBSecurityGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBShardGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBSnapshotStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBSubnetGroupFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBSubnetGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBSubnetStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEventSubscriptionStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidExportOnlyFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidExportSourceStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidExportTaskStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGlobalClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidIntegrationStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOptionGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRestoreFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3BucketFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSubnet = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidVPCNetworkStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSKeyNotAccessibleFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxDBShardGroupLimitReached = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NetworkTypeNotSupported = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OptionGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OptionGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OptionGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PointInTimeRestoreNotEnabledFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ProvisionedIopsNotAvailableInAZFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedDBInstanceAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedDBInstanceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedDBInstanceQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedDBInstancesOfferingNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SharedSnapshotQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotQuotaExceededFault = struct {
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

pub const SourceClusterNotSupportedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SourceDatabaseNotSupportedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SourceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StorageQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StorageTypeNotAvailableFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StorageTypeNotSupportedFault = struct {
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

pub const SubscriptionNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TenantDatabaseAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TenantDatabaseNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TenantDatabaseQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedDBEngineVersionFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VpcEncryptionControlViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
