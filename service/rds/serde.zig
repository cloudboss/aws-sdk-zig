const aws = @import("aws");
const std = @import("std");

const AccountQuota = @import("account_quota.zig").AccountQuota;
const ActivityStreamMode = @import("activity_stream_mode.zig").ActivityStreamMode;
const ActivityStreamPolicyStatus = @import("activity_stream_policy_status.zig").ActivityStreamPolicyStatus;
const ActivityStreamStatus = @import("activity_stream_status.zig").ActivityStreamStatus;
const AdditionalStorageVolume = @import("additional_storage_volume.zig").AdditionalStorageVolume;
const AdditionalStorageVolumeOutput = @import("additional_storage_volume_output.zig").AdditionalStorageVolumeOutput;
const ApplyMethod = @import("apply_method.zig").ApplyMethod;
const AuthScheme = @import("auth_scheme.zig").AuthScheme;
const AutomationMode = @import("automation_mode.zig").AutomationMode;
const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const AvailableAdditionalStorageVolumesOption = @import("available_additional_storage_volumes_option.zig").AvailableAdditionalStorageVolumesOption;
const AvailableProcessorFeature = @import("available_processor_feature.zig").AvailableProcessorFeature;
const BlueGreenDeployment = @import("blue_green_deployment.zig").BlueGreenDeployment;
const BlueGreenDeploymentTask = @import("blue_green_deployment_task.zig").BlueGreenDeploymentTask;
const Certificate = @import("certificate.zig").Certificate;
const CertificateDetails = @import("certificate_details.zig").CertificateDetails;
const CharacterSet = @import("character_set.zig").CharacterSet;
const ClientPasswordAuthType = @import("client_password_auth_type.zig").ClientPasswordAuthType;
const CloudwatchLogsExportConfiguration = @import("cloudwatch_logs_export_configuration.zig").CloudwatchLogsExportConfiguration;
const ClusterPendingModifiedValues = @import("cluster_pending_modified_values.zig").ClusterPendingModifiedValues;
const ClusterScalabilityType = @import("cluster_scalability_type.zig").ClusterScalabilityType;
const ConnectionPoolConfiguration = @import("connection_pool_configuration.zig").ConnectionPoolConfiguration;
const ConnectionPoolConfigurationInfo = @import("connection_pool_configuration_info.zig").ConnectionPoolConfigurationInfo;
const ContextAttribute = @import("context_attribute.zig").ContextAttribute;
const CustomDBEngineVersionAMI = @import("custom_db_engine_version_ami.zig").CustomDBEngineVersionAMI;
const DBCluster = @import("db_cluster.zig").DBCluster;
const DBClusterAutomatedBackup = @import("db_cluster_automated_backup.zig").DBClusterAutomatedBackup;
const DBClusterBacktrack = @import("db_cluster_backtrack.zig").DBClusterBacktrack;
const DBClusterEndpoint = @import("db_cluster_endpoint.zig").DBClusterEndpoint;
const DBClusterMember = @import("db_cluster_member.zig").DBClusterMember;
const DBClusterOptionGroupStatus = @import("db_cluster_option_group_status.zig").DBClusterOptionGroupStatus;
const DBClusterParameterGroup = @import("db_cluster_parameter_group.zig").DBClusterParameterGroup;
const DBClusterRole = @import("db_cluster_role.zig").DBClusterRole;
const DBClusterSnapshot = @import("db_cluster_snapshot.zig").DBClusterSnapshot;
const DBClusterSnapshotAttribute = @import("db_cluster_snapshot_attribute.zig").DBClusterSnapshotAttribute;
const DBClusterSnapshotAttributesResult = @import("db_cluster_snapshot_attributes_result.zig").DBClusterSnapshotAttributesResult;
const DBClusterStatusInfo = @import("db_cluster_status_info.zig").DBClusterStatusInfo;
const DBEngineVersion = @import("db_engine_version.zig").DBEngineVersion;
const DBInstance = @import("db_instance.zig").DBInstance;
const DBInstanceAutomatedBackup = @import("db_instance_automated_backup.zig").DBInstanceAutomatedBackup;
const DBInstanceAutomatedBackupsReplication = @import("db_instance_automated_backups_replication.zig").DBInstanceAutomatedBackupsReplication;
const DBInstanceRole = @import("db_instance_role.zig").DBInstanceRole;
const DBInstanceStatusInfo = @import("db_instance_status_info.zig").DBInstanceStatusInfo;
const DBMajorEngineVersion = @import("db_major_engine_version.zig").DBMajorEngineVersion;
const DBParameterGroup = @import("db_parameter_group.zig").DBParameterGroup;
const DBParameterGroupStatus = @import("db_parameter_group_status.zig").DBParameterGroupStatus;
const DBProxy = @import("db_proxy.zig").DBProxy;
const DBProxyEndpoint = @import("db_proxy_endpoint.zig").DBProxyEndpoint;
const DBProxyEndpointStatus = @import("db_proxy_endpoint_status.zig").DBProxyEndpointStatus;
const DBProxyEndpointTargetRole = @import("db_proxy_endpoint_target_role.zig").DBProxyEndpointTargetRole;
const DBProxyStatus = @import("db_proxy_status.zig").DBProxyStatus;
const DBProxyTarget = @import("db_proxy_target.zig").DBProxyTarget;
const DBProxyTargetGroup = @import("db_proxy_target_group.zig").DBProxyTargetGroup;
const DBRecommendation = @import("db_recommendation.zig").DBRecommendation;
const DBSecurityGroup = @import("db_security_group.zig").DBSecurityGroup;
const DBSecurityGroupMembership = @import("db_security_group_membership.zig").DBSecurityGroupMembership;
const DBShardGroup = @import("db_shard_group.zig").DBShardGroup;
const DBSnapshot = @import("db_snapshot.zig").DBSnapshot;
const DBSnapshotAttribute = @import("db_snapshot_attribute.zig").DBSnapshotAttribute;
const DBSnapshotAttributesResult = @import("db_snapshot_attributes_result.zig").DBSnapshotAttributesResult;
const DBSnapshotTenantDatabase = @import("db_snapshot_tenant_database.zig").DBSnapshotTenantDatabase;
const DBSubnetGroup = @import("db_subnet_group.zig").DBSubnetGroup;
const DatabaseInsightsMode = @import("database_insights_mode.zig").DatabaseInsightsMode;
const DescribeDBLogFilesDetails = @import("describe_db_log_files_details.zig").DescribeDBLogFilesDetails;
const DocLink = @import("doc_link.zig").DocLink;
const DomainMembership = @import("domain_membership.zig").DomainMembership;
const DoubleRange = @import("double_range.zig").DoubleRange;
const EC2SecurityGroup = @import("ec2_security_group.zig").EC2SecurityGroup;
const Endpoint = @import("endpoint.zig").Endpoint;
const EndpointNetworkType = @import("endpoint_network_type.zig").EndpointNetworkType;
const EngineDefaults = @import("engine_defaults.zig").EngineDefaults;
const Event = @import("event.zig").Event;
const EventCategoriesMap = @import("event_categories_map.zig").EventCategoriesMap;
const EventSubscription = @import("event_subscription.zig").EventSubscription;
const ExportSourceType = @import("export_source_type.zig").ExportSourceType;
const ExportTask = @import("export_task.zig").ExportTask;
const FailoverState = @import("failover_state.zig").FailoverState;
const FailoverStatus = @import("failover_status.zig").FailoverStatus;
const Filter = @import("filter.zig").Filter;
const GlobalCluster = @import("global_cluster.zig").GlobalCluster;
const GlobalClusterMember = @import("global_cluster_member.zig").GlobalClusterMember;
const GlobalClusterMemberSynchronizationStatus = @import("global_cluster_member_synchronization_status.zig").GlobalClusterMemberSynchronizationStatus;
const IAMAuthMode = @import("iam_auth_mode.zig").IAMAuthMode;
const IPRange = @import("ip_range.zig").IPRange;
const Integration = @import("integration.zig").Integration;
const IntegrationError = @import("integration_error.zig").IntegrationError;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const IssueDetails = @import("issue_details.zig").IssueDetails;
const LifecycleSupportName = @import("lifecycle_support_name.zig").LifecycleSupportName;
const LimitlessDatabase = @import("limitless_database.zig").LimitlessDatabase;
const LimitlessDatabaseStatus = @import("limitless_database_status.zig").LimitlessDatabaseStatus;
const LocalWriteForwardingStatus = @import("local_write_forwarding_status.zig").LocalWriteForwardingStatus;
const MasterUserSecret = @import("master_user_secret.zig").MasterUserSecret;
const Metric = @import("metric.zig").Metric;
const MetricQuery = @import("metric_query.zig").MetricQuery;
const MetricReference = @import("metric_reference.zig").MetricReference;
const MinimumEngineVersionPerAllowedValue = @import("minimum_engine_version_per_allowed_value.zig").MinimumEngineVersionPerAllowedValue;
const ModifyAdditionalStorageVolume = @import("modify_additional_storage_volume.zig").ModifyAdditionalStorageVolume;
const Option = @import("option.zig").Option;
const OptionConfiguration = @import("option_configuration.zig").OptionConfiguration;
const OptionGroup = @import("option_group.zig").OptionGroup;
const OptionGroupMembership = @import("option_group_membership.zig").OptionGroupMembership;
const OptionGroupOption = @import("option_group_option.zig").OptionGroupOption;
const OptionGroupOptionSetting = @import("option_group_option_setting.zig").OptionGroupOptionSetting;
const OptionSetting = @import("option_setting.zig").OptionSetting;
const OptionVersion = @import("option_version.zig").OptionVersion;
const OrderableDBInstanceOption = @import("orderable_db_instance_option.zig").OrderableDBInstanceOption;
const Outpost = @import("outpost.zig").Outpost;
const Parameter = @import("parameter.zig").Parameter;
const PendingCloudwatchLogsExports = @import("pending_cloudwatch_logs_exports.zig").PendingCloudwatchLogsExports;
const PendingMaintenanceAction = @import("pending_maintenance_action.zig").PendingMaintenanceAction;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const PerformanceInsightsMetricDimensionGroup = @import("performance_insights_metric_dimension_group.zig").PerformanceInsightsMetricDimensionGroup;
const PerformanceInsightsMetricQuery = @import("performance_insights_metric_query.zig").PerformanceInsightsMetricQuery;
const PerformanceIssueDetails = @import("performance_issue_details.zig").PerformanceIssueDetails;
const ProcessorFeature = @import("processor_feature.zig").ProcessorFeature;
const Range = @import("range.zig").Range;
const RdsCustomClusterConfiguration = @import("rds_custom_cluster_configuration.zig").RdsCustomClusterConfiguration;
const RecommendedAction = @import("recommended_action.zig").RecommendedAction;
const RecommendedActionParameter = @import("recommended_action_parameter.zig").RecommendedActionParameter;
const RecommendedActionUpdate = @import("recommended_action_update.zig").RecommendedActionUpdate;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;
const ReferenceDetails = @import("reference_details.zig").ReferenceDetails;
const ReplicaMode = @import("replica_mode.zig").ReplicaMode;
const ReservedDBInstance = @import("reserved_db_instance.zig").ReservedDBInstance;
const ReservedDBInstancesOffering = @import("reserved_db_instances_offering.zig").ReservedDBInstancesOffering;
const ResourcePendingMaintenanceActions = @import("resource_pending_maintenance_actions.zig").ResourcePendingMaintenanceActions;
const RestoreWindow = @import("restore_window.zig").RestoreWindow;
const ScalarReferenceDetails = @import("scalar_reference_details.zig").ScalarReferenceDetails;
const ScalingConfiguration = @import("scaling_configuration.zig").ScalingConfiguration;
const ScalingConfigurationInfo = @import("scaling_configuration_info.zig").ScalingConfigurationInfo;
const ServerlessV2FeaturesSupport = @import("serverless_v2_features_support.zig").ServerlessV2FeaturesSupport;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const ServerlessV2ScalingConfigurationInfo = @import("serverless_v2_scaling_configuration_info.zig").ServerlessV2ScalingConfigurationInfo;
const SourceRegion = @import("source_region.zig").SourceRegion;
const SourceType = @import("source_type.zig").SourceType;
const Subnet = @import("subnet.zig").Subnet;
const SupportedEngineLifecycle = @import("supported_engine_lifecycle.zig").SupportedEngineLifecycle;
const SwitchoverDetail = @import("switchover_detail.zig").SwitchoverDetail;
const Tag = @import("tag.zig").Tag;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TargetConnectionNetworkType = @import("target_connection_network_type.zig").TargetConnectionNetworkType;
const TargetHealth = @import("target_health.zig").TargetHealth;
const TargetHealthReason = @import("target_health_reason.zig").TargetHealthReason;
const TargetRole = @import("target_role.zig").TargetRole;
const TargetState = @import("target_state.zig").TargetState;
const TargetType = @import("target_type.zig").TargetType;
const TenantDatabase = @import("tenant_database.zig").TenantDatabase;
const TenantDatabasePendingModifiedValues = @import("tenant_database_pending_modified_values.zig").TenantDatabasePendingModifiedValues;
const Timezone = @import("timezone.zig").Timezone;
const UpgradeRolloutOrder = @import("upgrade_rollout_order.zig").UpgradeRolloutOrder;
const UpgradeTarget = @import("upgrade_target.zig").UpgradeTarget;
const UserAuthConfig = @import("user_auth_config.zig").UserAuthConfig;
const UserAuthConfigInfo = @import("user_auth_config_info.zig").UserAuthConfigInfo;
const ValidAdditionalStorageOptions = @import("valid_additional_storage_options.zig").ValidAdditionalStorageOptions;
const ValidDBInstanceModificationsMessage = @import("valid_db_instance_modifications_message.zig").ValidDBInstanceModificationsMessage;
const ValidStorageOptions = @import("valid_storage_options.zig").ValidStorageOptions;
const ValidVolumeOptions = @import("valid_volume_options.zig").ValidVolumeOptions;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;
const WriteForwardingStatus = @import("write_forwarding_status.zig").WriteForwardingStatus;

pub fn deserializeAccountQuotaList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AccountQuota {
    var list: std.ArrayList(AccountQuota) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAccountQuota(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeActivityStreamModeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAdditionalStorageVolumesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AdditionalStorageVolume {
    var list: std.ArrayList(AdditionalStorageVolume) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAdditionalStorageVolume(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAdditionalStorageVolumesOutputList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AdditionalStorageVolumeOutput {
    var list: std.ArrayList(AdditionalStorageVolumeOutput) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAdditionalStorageVolumeOutput(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAttributeValueList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAvailabilityZoneList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AvailabilityZone {
    var list: std.ArrayList(AvailabilityZone) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAvailabilityZone(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAvailabilityZones(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAvailableAdditionalStorageVolumesOptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AvailableAdditionalStorageVolumesOption {
    var list: std.ArrayList(AvailableAdditionalStorageVolumesOption) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAvailableAdditionalStorageVolumesOption(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAvailableProcessorFeatureList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AvailableProcessorFeature {
    var list: std.ArrayList(AvailableProcessorFeature) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAvailableProcessorFeature(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeBlueGreenDeploymentList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const BlueGreenDeployment {
    var list: std.ArrayList(BlueGreenDeployment) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeBlueGreenDeployment(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeBlueGreenDeploymentTaskList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const BlueGreenDeploymentTask {
    var list: std.ArrayList(BlueGreenDeploymentTask) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeBlueGreenDeploymentTask(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCACertificateIdentifiersList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCertificateList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Certificate {
    var list: std.ArrayList(Certificate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCertificate(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeContextAttributeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ContextAttribute {
    var list: std.ArrayList(ContextAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeContextAttribute(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterAutomatedBackupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterAutomatedBackup {
    var list: std.ArrayList(DBClusterAutomatedBackup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterAutomatedBackup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterBacktrackList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterBacktrack {
    var list: std.ArrayList(DBClusterBacktrack) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterBacktrack(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterEndpointList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterEndpoint {
    var list: std.ArrayList(DBClusterEndpoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterEndpoint(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBCluster {
    var list: std.ArrayList(DBCluster) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBCluster(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterMemberList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterMember {
    var list: std.ArrayList(DBClusterMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterMember(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterOptionGroupMemberships(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterOptionGroupStatus {
    var list: std.ArrayList(DBClusterOptionGroupStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterOptionGroupStatus(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterParameterGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterParameterGroup {
    var list: std.ArrayList(DBClusterParameterGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterParameterGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterRoles(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterRole {
    var list: std.ArrayList(DBClusterRole) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterRole(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterSnapshotAttributeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterSnapshotAttribute {
    var list: std.ArrayList(DBClusterSnapshotAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterSnapshotAttribute(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterSnapshotList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterSnapshot {
    var list: std.ArrayList(DBClusterSnapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterSnapshot(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBClusterStatusInfoList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBClusterStatusInfo {
    var list: std.ArrayList(DBClusterStatusInfo) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBClusterStatusInfo(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBEngineVersionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBEngineVersion {
    var list: std.ArrayList(DBEngineVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBEngineVersion(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBInstanceAutomatedBackupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBInstanceAutomatedBackup {
    var list: std.ArrayList(DBInstanceAutomatedBackup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBInstanceAutomatedBackup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBInstanceAutomatedBackupsReplicationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBInstanceAutomatedBackupsReplication {
    var list: std.ArrayList(DBInstanceAutomatedBackupsReplication) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBInstanceAutomatedBackupsReplication(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBInstanceList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBInstance {
    var list: std.ArrayList(DBInstance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBInstance(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBInstanceRoles(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBInstanceRole {
    var list: std.ArrayList(DBInstanceRole) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBInstanceRole(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBInstanceStatusInfoList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBInstanceStatusInfo {
    var list: std.ArrayList(DBInstanceStatusInfo) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBInstanceStatusInfo(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBMajorEngineVersionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBMajorEngineVersion {
    var list: std.ArrayList(DBMajorEngineVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBMajorEngineVersion(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBParameterGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBParameterGroup {
    var list: std.ArrayList(DBParameterGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBParameterGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBParameterGroupStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBParameterGroupStatus {
    var list: std.ArrayList(DBParameterGroupStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBParameterGroupStatus(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBProxyEndpointList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBProxyEndpoint {
    var list: std.ArrayList(DBProxyEndpoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBProxyEndpoint(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBProxyList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBProxy {
    var list: std.ArrayList(DBProxy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBProxy(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBRecommendationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBRecommendation {
    var list: std.ArrayList(DBRecommendation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBRecommendation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBSecurityGroupMembershipList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBSecurityGroupMembership {
    var list: std.ArrayList(DBSecurityGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBSecurityGroupMembership(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBSecurityGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBSecurityGroup {
    var list: std.ArrayList(DBSecurityGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBSecurityGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBShardGroupsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBShardGroup {
    var list: std.ArrayList(DBShardGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBShardGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBSnapshotAttributeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBSnapshotAttribute {
    var list: std.ArrayList(DBSnapshotAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBSnapshotAttribute(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBSnapshotList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBSnapshot {
    var list: std.ArrayList(DBSnapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBSnapshot(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBSnapshotTenantDatabasesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBSnapshotTenantDatabase {
    var list: std.ArrayList(DBSnapshotTenantDatabase) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBSnapshotTenantDatabase(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDBSubnetGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBSubnetGroup {
    var list: std.ArrayList(DBSubnetGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBSubnetGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDescribeDBLogFilesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DescribeDBLogFilesDetails {
    var list: std.ArrayList(DescribeDBLogFilesDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDescribeDBLogFilesDetails(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDocLinkList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DocLink {
    var list: std.ArrayList(DocLink) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDocLink(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDomainMembershipList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DomainMembership {
    var list: std.ArrayList(DomainMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDomainMembership(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDoubleRangeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DoubleRange {
    var list: std.ArrayList(DoubleRange) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDoubleRange(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEC2SecurityGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EC2SecurityGroup {
    var list: std.ArrayList(EC2SecurityGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEC2SecurityGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEngineModeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEventCategoriesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEventCategoriesMapList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EventCategoriesMap {
    var list: std.ArrayList(EventCategoriesMap) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEventCategoriesMap(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEventList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Event {
    var list: std.ArrayList(Event) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEvent(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEventSubscriptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EventSubscription {
    var list: std.ArrayList(EventSubscription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEventSubscription(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeExportTasksList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ExportTask {
    var list: std.ArrayList(ExportTask) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeExportTask(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFeatureNameList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeGlobalClusterList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const GlobalCluster {
    var list: std.ArrayList(GlobalCluster) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeGlobalCluster(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeGlobalClusterMemberList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const GlobalClusterMember {
    var list: std.ArrayList(GlobalClusterMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeGlobalClusterMember(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeIPRangeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const IPRange {
    var list: std.ArrayList(IPRange) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeIPRange(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeIntegrationErrorList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const IntegrationError {
    var list: std.ArrayList(IntegrationError) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeIntegrationError(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeIntegrationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Integration {
    var list: std.ArrayList(Integration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeIntegration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeLogTypeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Metric {
    var list: std.ArrayList(Metric) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetric(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricReferenceList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricReference {
    var list: std.ArrayList(MetricReference) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricReference(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMinimumEngineVersionPerAllowedValueList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MinimumEngineVersionPerAllowedValue {
    var list: std.ArrayList(MinimumEngineVersionPerAllowedValue) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMinimumEngineVersionPerAllowedValue(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOptionGroupMembershipList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OptionGroupMembership {
    var list: std.ArrayList(OptionGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOptionGroupMembership(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOptionGroupOptionSettingsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OptionGroupOptionSetting {
    var list: std.ArrayList(OptionGroupOptionSetting) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOptionGroupOptionSetting(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOptionGroupOptionVersionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OptionVersion {
    var list: std.ArrayList(OptionVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOptionVersion(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOptionGroupOptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OptionGroupOption {
    var list: std.ArrayList(OptionGroupOption) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOptionGroupOption(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOptionGroupsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OptionGroup {
    var list: std.ArrayList(OptionGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOptionGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOptionSettingConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OptionSetting {
    var list: std.ArrayList(OptionSetting) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOptionSetting(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOptionsConflictsWith(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOptionsDependedOn(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Option {
    var list: std.ArrayList(Option) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOption(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOrderableDBInstanceOptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OrderableDBInstanceOption {
    var list: std.ArrayList(OrderableDBInstanceOption) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOrderableDBInstanceOption(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeParametersList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Parameter {
    var list: std.ArrayList(Parameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeParameter(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePendingMaintenanceActionDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PendingMaintenanceAction {
    var list: std.ArrayList(PendingMaintenanceAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePendingMaintenanceAction(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePendingMaintenanceActions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourcePendingMaintenanceActions {
    var list: std.ArrayList(ResourcePendingMaintenanceActions) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourcePendingMaintenanceActions(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeProcessorFeatureList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ProcessorFeature {
    var list: std.ArrayList(ProcessorFeature) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeProcessorFeature(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRangeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Range {
    var list: std.ArrayList(Range) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRange(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReadReplicaDBClusterIdentifierList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReadReplicaDBInstanceIdentifierList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReadReplicaIdentifierList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReadersArnList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRecommendedActionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RecommendedAction {
    var list: std.ArrayList(RecommendedAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRecommendedAction(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRecommendedActionParameterList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RecommendedActionParameter {
    var list: std.ArrayList(RecommendedActionParameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRecommendedActionParameter(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRecurringChargeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RecurringCharge {
    var list: std.ArrayList(RecurringCharge) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRecurringCharge(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReservedDBInstanceList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReservedDBInstance {
    var list: std.ArrayList(ReservedDBInstance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReservedDBInstance(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReservedDBInstancesOfferingList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReservedDBInstancesOffering {
    var list: std.ArrayList(ReservedDBInstancesOffering) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReservedDBInstancesOffering(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSourceIdsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSourceRegionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SourceRegion {
    var list: std.ArrayList(SourceRegion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSourceRegion(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStringList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSubnetList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Subnet {
    var list: std.ArrayList(Subnet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSubnet(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSupportedCharacterSetsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CharacterSet {
    var list: std.ArrayList(CharacterSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCharacterSet(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSupportedEngineLifecycleList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SupportedEngineLifecycle {
    var list: std.ArrayList(SupportedEngineLifecycle) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSupportedEngineLifecycle(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSupportedTimezonesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Timezone {
    var list: std.ArrayList(Timezone) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTimezone(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSwitchoverDetailList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SwitchoverDetail {
    var list: std.ArrayList(SwitchoverDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSwitchoverDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTagList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTag(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTargetGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBProxyTargetGroup {
    var list: std.ArrayList(DBProxyTargetGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBProxyTargetGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTargetList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DBProxyTarget {
    var list: std.ArrayList(DBProxyTarget) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDBProxyTarget(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTenantDatabasesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TenantDatabase {
    var list: std.ArrayList(TenantDatabase) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTenantDatabase(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeUserAuthConfigInfoList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const UserAuthConfigInfo {
    var list: std.ArrayList(UserAuthConfigInfo) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUserAuthConfigInfo(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeValidStorageOptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ValidStorageOptions {
    var list: std.ArrayList(ValidStorageOptions) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeValidStorageOptions(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeValidUpgradeTargetList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const UpgradeTarget {
    var list: std.ArrayList(UpgradeTarget) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUpgradeTarget(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeValidVolumeOptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ValidVolumeOptions {
    var list: std.ArrayList(ValidVolumeOptions) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeValidVolumeOptions(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeVpcSecurityGroupMembershipList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const VpcSecurityGroupMembership {
    var list: std.ArrayList(VpcSecurityGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeVpcSecurityGroupMembership(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEncryptionContextMap(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
    var list: std.ArrayList(aws.map.StringMapEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: []const u8 = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try allocator.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAccountQuota(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccountQuota {
    var result: AccountQuota = undefined;
    result.account_quota_name = null;
    result.max = null;
    result.used = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountQuotaName")) {
                    result.account_quota_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Used")) {
                    result.used = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAdditionalStorageVolume(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AdditionalStorageVolume {
    var result: AdditionalStorageVolume = undefined;
    result.allocated_storage = null;
    result.iops = null;
    result.max_allocated_storage = null;
    result.storage_throughput = null;
    result.storage_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "IOPS")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxAllocatedStorage")) {
                    result.max_allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VolumeName")) {
                    result.volume_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAdditionalStorageVolumeOutput(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AdditionalStorageVolumeOutput {
    var result: AdditionalStorageVolumeOutput = undefined;
    result.allocated_storage = null;
    result.iops = null;
    result.max_allocated_storage = null;
    result.storage_throughput = null;
    result.storage_type = null;
    result.storage_volume_status = null;
    result.volume_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "IOPS")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxAllocatedStorage")) {
                    result.max_allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageVolumeStatus")) {
                    result.storage_volume_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VolumeName")) {
                    result.volume_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAvailabilityZone(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AvailabilityZone {
    var result: AvailabilityZone = undefined;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAvailableAdditionalStorageVolumesOption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AvailableAdditionalStorageVolumesOption {
    var result: AvailableAdditionalStorageVolumesOption = undefined;
    result.max_iops = null;
    result.max_iops_per_gib = null;
    result.max_storage_size = null;
    result.max_storage_throughput = null;
    result.min_iops = null;
    result.min_iops_per_gib = null;
    result.min_storage_size = null;
    result.min_storage_throughput = null;
    result.storage_type = null;
    result.supports_iops = null;
    result.supports_storage_autoscaling = null;
    result.supports_storage_throughput = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MaxIops")) {
                    result.max_iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxIopsPerGib")) {
                    result.max_iops_per_gib = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxStorageSize")) {
                    result.max_storage_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxStorageThroughput")) {
                    result.max_storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinIops")) {
                    result.min_iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinIopsPerGib")) {
                    result.min_iops_per_gib = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinStorageSize")) {
                    result.min_storage_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinStorageThroughput")) {
                    result.min_storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportsIops")) {
                    result.supports_iops = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsStorageAutoscaling")) {
                    result.supports_storage_autoscaling = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsStorageThroughput")) {
                    result.supports_storage_throughput = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAvailableProcessorFeature(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AvailableProcessorFeature {
    var result: AvailableProcessorFeature = undefined;
    result.allowed_values = null;
    result.default_value = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValues")) {
                    result.allowed_values = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeBlueGreenDeployment(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BlueGreenDeployment {
    var result: BlueGreenDeployment = undefined;
    result.blue_green_deployment_identifier = null;
    result.blue_green_deployment_name = null;
    result.create_time = null;
    result.delete_time = null;
    result.source = null;
    result.status = null;
    result.status_details = null;
    result.switchover_details = null;
    result.tag_list = null;
    result.target = null;
    result.tasks = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BlueGreenDeploymentIdentifier")) {
                    result.blue_green_deployment_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BlueGreenDeploymentName")) {
                    result.blue_green_deployment_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DeleteTime")) {
                    result.delete_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Source")) {
                    result.source = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusDetails")) {
                    result.status_details = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SwitchoverDetails")) {
                    result.switchover_details = try deserializeSwitchoverDetailList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "Target")) {
                    result.target = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tasks")) {
                    result.tasks = try deserializeBlueGreenDeploymentTaskList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeBlueGreenDeploymentTask(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BlueGreenDeploymentTask {
    var result: BlueGreenDeploymentTask = undefined;
    result.name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCertificate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Certificate {
    var result: Certificate = undefined;
    result.certificate_arn = null;
    result.certificate_identifier = null;
    result.certificate_type = null;
    result.customer_override = null;
    result.customer_override_valid_till = null;
    result.thumbprint = null;
    result.valid_from = null;
    result.valid_till = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateArn")) {
                    result.certificate_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateIdentifier")) {
                    result.certificate_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateType")) {
                    result.certificate_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomerOverride")) {
                    result.customer_override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CustomerOverrideValidTill")) {
                    result.customer_override_valid_till = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Thumbprint")) {
                    result.thumbprint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidFrom")) {
                    result.valid_from = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ValidTill")) {
                    result.valid_till = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCertificateDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CertificateDetails {
    var result: CertificateDetails = undefined;
    result.ca_identifier = null;
    result.valid_till = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CAIdentifier")) {
                    result.ca_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidTill")) {
                    result.valid_till = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCharacterSet(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CharacterSet {
    var result: CharacterSet = undefined;
    result.character_set_description = null;
    result.character_set_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CharacterSetDescription")) {
                    result.character_set_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterPendingModifiedValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterPendingModifiedValues {
    var result: ClusterPendingModifiedValues = undefined;
    result.allocated_storage = null;
    result.backup_retention_period = null;
    result.certificate_details = null;
    result.db_cluster_identifier = null;
    result.engine_version = null;
    result.iam_database_authentication_enabled = null;
    result.iops = null;
    result.master_user_password = null;
    result.pending_cloudwatch_logs_exports = null;
    result.rds_custom_cluster_configuration = null;
    result.storage_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CertificateDetails")) {
                    result.certificate_details = try deserializeCertificateDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MasterUserPassword")) {
                    result.master_user_password = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingCloudwatchLogsExports")) {
                    result.pending_cloudwatch_logs_exports = try deserializePendingCloudwatchLogsExports(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RdsCustomClusterConfiguration")) {
                    result.rds_custom_cluster_configuration = try deserializeRdsCustomClusterConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConnectionPoolConfigurationInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConnectionPoolConfigurationInfo {
    var result: ConnectionPoolConfigurationInfo = undefined;
    result.connection_borrow_timeout = null;
    result.init_query = null;
    result.max_connections_percent = null;
    result.max_idle_connections_percent = null;
    result.session_pinning_filters = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConnectionBorrowTimeout")) {
                    result.connection_borrow_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "InitQuery")) {
                    result.init_query = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxConnectionsPercent")) {
                    result.max_connections_percent = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxIdleConnectionsPercent")) {
                    result.max_idle_connections_percent = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SessionPinningFilters")) {
                    result.session_pinning_filters = try deserializeStringList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContextAttribute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContextAttribute {
    var result: ContextAttribute = undefined;
    result.key = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomDBEngineVersionAMI(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CustomDBEngineVersionAMI {
    var result: CustomDBEngineVersionAMI = undefined;
    result.image_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBCluster(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBCluster {
    var result: DBCluster = undefined;
    result.activity_stream_kinesis_stream_name = null;
    result.activity_stream_kms_key_id = null;
    result.activity_stream_mode = null;
    result.activity_stream_status = null;
    result.allocated_storage = null;
    result.associated_roles = null;
    result.automatic_restart_time = null;
    result.auto_minor_version_upgrade = null;
    result.availability_zones = null;
    result.aws_backup_recovery_point_arn = null;
    result.backtrack_consumed_change_records = null;
    result.backtrack_window = null;
    result.backup_retention_period = null;
    result.capacity = null;
    result.certificate_details = null;
    result.character_set_name = null;
    result.clone_group_id = null;
    result.cluster_create_time = null;
    result.cluster_scalability_type = null;
    result.copy_tags_to_snapshot = null;
    result.cross_account_clone = null;
    result.custom_endpoints = null;
    result.database_insights_mode = null;
    result.database_name = null;
    result.db_cluster_arn = null;
    result.db_cluster_identifier = null;
    result.db_cluster_instance_class = null;
    result.db_cluster_members = null;
    result.db_cluster_option_group_memberships = null;
    result.db_cluster_parameter_group = null;
    result.db_cluster_resource_id = null;
    result.db_subnet_group = null;
    result.db_system_id = null;
    result.deletion_protection = null;
    result.domain_memberships = null;
    result.earliest_backtrack_time = null;
    result.earliest_restorable_time = null;
    result.enabled_cloudwatch_logs_exports = null;
    result.endpoint = null;
    result.engine = null;
    result.engine_lifecycle_support = null;
    result.engine_mode = null;
    result.engine_version = null;
    result.global_cluster_identifier = null;
    result.global_write_forwarding_requested = null;
    result.global_write_forwarding_status = null;
    result.hosted_zone_id = null;
    result.http_endpoint_enabled = null;
    result.iam_database_authentication_enabled = null;
    result.io_optimized_next_allowed_modification_time = null;
    result.iops = null;
    result.kms_key_id = null;
    result.latest_restorable_time = null;
    result.limitless_database = null;
    result.local_write_forwarding_status = null;
    result.master_username = null;
    result.master_user_secret = null;
    result.monitoring_interval = null;
    result.monitoring_role_arn = null;
    result.multi_az = null;
    result.network_type = null;
    result.pending_modified_values = null;
    result.percent_progress = null;
    result.performance_insights_enabled = null;
    result.performance_insights_kms_key_id = null;
    result.performance_insights_retention_period = null;
    result.port = null;
    result.preferred_backup_window = null;
    result.preferred_maintenance_window = null;
    result.publicly_accessible = null;
    result.rds_custom_cluster_configuration = null;
    result.reader_endpoint = null;
    result.read_replica_identifiers = null;
    result.replication_source_identifier = null;
    result.scaling_configuration_info = null;
    result.serverless_v2_platform_version = null;
    result.serverless_v2_scaling_configuration = null;
    result.status = null;
    result.status_infos = null;
    result.storage_encrypted = null;
    result.storage_throughput = null;
    result.storage_type = null;
    result.tag_list = null;
    result.upgrade_rollout_order = null;
    result.vpc_security_groups = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActivityStreamKinesisStreamName")) {
                    result.activity_stream_kinesis_stream_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamKmsKeyId")) {
                    result.activity_stream_kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamMode")) {
                    result.activity_stream_mode = ActivityStreamMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamStatus")) {
                    result.activity_stream_status = ActivityStreamStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AssociatedRoles")) {
                    result.associated_roles = try deserializeDBClusterRoles(allocator, reader, "DBClusterRole");
                } else if (std.mem.eql(u8, e.local, "AutomaticRestartTime")) {
                    result.automatic_restart_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(allocator, reader, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "AwsBackupRecoveryPointArn")) {
                    result.aws_backup_recovery_point_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BacktrackConsumedChangeRecords")) {
                    result.backtrack_consumed_change_records = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BacktrackWindow")) {
                    result.backtrack_window = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Capacity")) {
                    result.capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CertificateDetails")) {
                    result.certificate_details = try deserializeCertificateDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CloneGroupId")) {
                    result.clone_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterScalabilityType")) {
                    result.cluster_scalability_type = ClusterScalabilityType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CopyTagsToSnapshot")) {
                    result.copy_tags_to_snapshot = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CrossAccountClone")) {
                    result.cross_account_clone = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CustomEndpoints")) {
                    result.custom_endpoints = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "DatabaseInsightsMode")) {
                    result.database_insights_mode = DatabaseInsightsMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseName")) {
                    result.database_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterArn")) {
                    result.db_cluster_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterInstanceClass")) {
                    result.db_cluster_instance_class = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterMembers")) {
                    result.db_cluster_members = try deserializeDBClusterMemberList(allocator, reader, "DBClusterMember");
                } else if (std.mem.eql(u8, e.local, "DBClusterOptionGroupMemberships")) {
                    result.db_cluster_option_group_memberships = try deserializeDBClusterOptionGroupMemberships(allocator, reader, "DBClusterOptionGroup");
                } else if (std.mem.eql(u8, e.local, "DBClusterParameterGroup")) {
                    result.db_cluster_parameter_group = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbClusterResourceId")) {
                    result.db_cluster_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroup")) {
                    result.db_subnet_group = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSystemId")) {
                    result.db_system_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DomainMemberships")) {
                    result.domain_memberships = try deserializeDomainMembershipList(allocator, reader, "DomainMembership");
                } else if (std.mem.eql(u8, e.local, "EarliestBacktrackTime")) {
                    result.earliest_backtrack_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EarliestRestorableTime")) {
                    result.earliest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EnabledCloudwatchLogsExports")) {
                    result.enabled_cloudwatch_logs_exports = try deserializeLogTypeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineLifecycleSupport")) {
                    result.engine_lifecycle_support = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineMode")) {
                    result.engine_mode = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalClusterIdentifier")) {
                    result.global_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalWriteForwardingRequested")) {
                    result.global_write_forwarding_requested = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "GlobalWriteForwardingStatus")) {
                    result.global_write_forwarding_status = WriteForwardingStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpEndpointEnabled")) {
                    result.http_endpoint_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IOOptimizedNextAllowedModificationTime")) {
                    result.io_optimized_next_allowed_modification_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestRestorableTime")) {
                    result.latest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LimitlessDatabase")) {
                    result.limitless_database = try deserializeLimitlessDatabase(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LocalWriteForwardingStatus")) {
                    result.local_write_forwarding_status = LocalWriteForwardingStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserSecret")) {
                    result.master_user_secret = try deserializeMasterUserSecret(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MonitoringInterval")) {
                    result.monitoring_interval = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MonitoringRoleArn")) {
                    result.monitoring_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "NetworkType")) {
                    result.network_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializeClusterPendingModifiedValues(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsEnabled")) {
                    result.performance_insights_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsKMSKeyId")) {
                    result.performance_insights_kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsRetentionPeriod")) {
                    result.performance_insights_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PreferredBackupWindow")) {
                    result.preferred_backup_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RdsCustomClusterConfiguration")) {
                    result.rds_custom_cluster_configuration = try deserializeRdsCustomClusterConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ReaderEndpoint")) {
                    result.reader_endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReadReplicaIdentifiers")) {
                    result.read_replica_identifiers = try deserializeReadReplicaIdentifierList(allocator, reader, "ReadReplicaIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReplicationSourceIdentifier")) {
                    result.replication_source_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScalingConfigurationInfo")) {
                    result.scaling_configuration_info = try deserializeScalingConfigurationInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ServerlessV2PlatformVersion")) {
                    result.serverless_v2_platform_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessV2ScalingConfiguration")) {
                    result.serverless_v2_scaling_configuration = try deserializeServerlessV2ScalingConfigurationInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusInfos")) {
                    result.status_infos = try deserializeDBClusterStatusInfoList(allocator, reader, "DBClusterStatusInfo");
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "UpgradeRolloutOrder")) {
                    result.upgrade_rollout_order = UpgradeRolloutOrder.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroups")) {
                    result.vpc_security_groups = try deserializeVpcSecurityGroupMembershipList(allocator, reader, "VpcSecurityGroupMembership");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterAutomatedBackup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterAutomatedBackup {
    var result: DBClusterAutomatedBackup = undefined;
    result.allocated_storage = null;
    result.availability_zones = null;
    result.aws_backup_recovery_point_arn = null;
    result.backup_retention_period = null;
    result.cluster_create_time = null;
    result.db_cluster_arn = null;
    result.db_cluster_automated_backups_arn = null;
    result.db_cluster_identifier = null;
    result.db_cluster_resource_id = null;
    result.engine = null;
    result.engine_mode = null;
    result.engine_version = null;
    result.iam_database_authentication_enabled = null;
    result.iops = null;
    result.kms_key_id = null;
    result.license_model = null;
    result.master_username = null;
    result.port = null;
    result.region = null;
    result.restore_window = null;
    result.status = null;
    result.storage_encrypted = null;
    result.storage_throughput = null;
    result.storage_type = null;
    result.tag_list = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(allocator, reader, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "AwsBackupRecoveryPointArn")) {
                    result.aws_backup_recovery_point_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterArn")) {
                    result.db_cluster_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterAutomatedBackupsArn")) {
                    result.db_cluster_automated_backups_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbClusterResourceId")) {
                    result.db_cluster_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineMode")) {
                    result.engine_mode = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RestoreWindow")) {
                    result.restore_window = try deserializeRestoreWindow(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterBacktrack(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterBacktrack {
    var result: DBClusterBacktrack = undefined;
    result.backtracked_from = null;
    result.backtrack_identifier = null;
    result.backtrack_request_creation_time = null;
    result.backtrack_to = null;
    result.db_cluster_identifier = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BacktrackedFrom")) {
                    result.backtracked_from = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "BacktrackIdentifier")) {
                    result.backtrack_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BacktrackRequestCreationTime")) {
                    result.backtrack_request_creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "BacktrackTo")) {
                    result.backtrack_to = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterEndpoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterEndpoint {
    var result: DBClusterEndpoint = undefined;
    result.custom_endpoint_type = null;
    result.db_cluster_endpoint_arn = null;
    result.db_cluster_endpoint_identifier = null;
    result.db_cluster_endpoint_resource_identifier = null;
    result.db_cluster_identifier = null;
    result.endpoint = null;
    result.endpoint_type = null;
    result.excluded_members = null;
    result.static_members = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CustomEndpointType")) {
                    result.custom_endpoint_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterEndpointArn")) {
                    result.db_cluster_endpoint_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterEndpointIdentifier")) {
                    result.db_cluster_endpoint_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterEndpointResourceIdentifier")) {
                    result.db_cluster_endpoint_resource_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointType")) {
                    result.endpoint_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExcludedMembers")) {
                    result.excluded_members = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "StaticMembers")) {
                    result.static_members = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterMember(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterMember {
    var result: DBClusterMember = undefined;
    result.db_cluster_parameter_group_status = null;
    result.db_instance_identifier = null;
    result.is_cluster_writer = null;
    result.promotion_tier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterParameterGroupStatus")) {
                    result.db_cluster_parameter_group_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsClusterWriter")) {
                    result.is_cluster_writer = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PromotionTier")) {
                    result.promotion_tier = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterOptionGroupStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterOptionGroupStatus {
    var result: DBClusterOptionGroupStatus = undefined;
    result.db_cluster_option_group_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterOptionGroupName")) {
                    result.db_cluster_option_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterParameterGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterParameterGroup {
    var result: DBClusterParameterGroup = undefined;
    result.db_cluster_parameter_group_arn = null;
    result.db_cluster_parameter_group_name = null;
    result.db_parameter_group_family = null;
    result.description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterParameterGroupArn")) {
                    result.db_cluster_parameter_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterParameterGroupName")) {
                    result.db_cluster_parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterRole(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterRole {
    var result: DBClusterRole = undefined;
    result.feature_name = null;
    result.role_arn = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FeatureName")) {
                    result.feature_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleArn")) {
                    result.role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterSnapshot(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterSnapshot {
    var result: DBClusterSnapshot = undefined;
    result.allocated_storage = null;
    result.availability_zones = null;
    result.cluster_create_time = null;
    result.db_cluster_identifier = null;
    result.db_cluster_resource_id = null;
    result.db_cluster_snapshot_arn = null;
    result.db_cluster_snapshot_identifier = null;
    result.db_system_id = null;
    result.engine = null;
    result.engine_mode = null;
    result.engine_version = null;
    result.iam_database_authentication_enabled = null;
    result.kms_key_id = null;
    result.license_model = null;
    result.master_username = null;
    result.percent_progress = null;
    result.port = null;
    result.snapshot_create_time = null;
    result.snapshot_type = null;
    result.source_db_cluster_snapshot_arn = null;
    result.status = null;
    result.storage_encrypted = null;
    result.storage_throughput = null;
    result.storage_type = null;
    result.tag_list = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(allocator, reader, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbClusterResourceId")) {
                    result.db_cluster_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotArn")) {
                    result.db_cluster_snapshot_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotIdentifier")) {
                    result.db_cluster_snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSystemId")) {
                    result.db_system_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineMode")) {
                    result.engine_mode = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotCreateTime")) {
                    result.snapshot_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotType")) {
                    result.snapshot_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceDBClusterSnapshotArn")) {
                    result.source_db_cluster_snapshot_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterSnapshotAttribute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterSnapshotAttribute {
    var result: DBClusterSnapshotAttribute = undefined;
    result.attribute_name = null;
    result.attribute_values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AttributeName")) {
                    result.attribute_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeValues")) {
                    result.attribute_values = try deserializeAttributeValueList(allocator, reader, "AttributeValue");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterSnapshotAttributesResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterSnapshotAttributesResult {
    var result: DBClusterSnapshotAttributesResult = undefined;
    result.db_cluster_snapshot_attributes = null;
    result.db_cluster_snapshot_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterSnapshotAttributes")) {
                    result.db_cluster_snapshot_attributes = try deserializeDBClusterSnapshotAttributeList(allocator, reader, "DBClusterSnapshotAttribute");
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotIdentifier")) {
                    result.db_cluster_snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBClusterStatusInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBClusterStatusInfo {
    var result: DBClusterStatusInfo = undefined;
    result.message = null;
    result.normal = null;
    result.status = null;
    result.status_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Normal")) {
                    result.normal = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusType")) {
                    result.status_type = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBEngineVersion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBEngineVersion {
    var result: DBEngineVersion = undefined;
    result.create_time = null;
    result.custom_db_engine_version_manifest = null;
    result.database_installation_files = null;
    result.database_installation_files_s3_bucket_name = null;
    result.database_installation_files_s3_prefix = null;
    result.db_engine_description = null;
    result.db_engine_media_type = null;
    result.db_engine_version_arn = null;
    result.db_engine_version_description = null;
    result.db_parameter_group_family = null;
    result.default_character_set = null;
    result.engine = null;
    result.engine_version = null;
    result.exportable_log_types = null;
    result.failure_reason = null;
    result.image = null;
    result.kms_key_id = null;
    result.major_engine_version = null;
    result.serverless_v2_features_support = null;
    result.status = null;
    result.supported_ca_certificate_identifiers = null;
    result.supported_character_sets = null;
    result.supported_engine_modes = null;
    result.supported_feature_names = null;
    result.supported_nchar_character_sets = null;
    result.supported_timezones = null;
    result.supports_babelfish = null;
    result.supports_certificate_rotation_without_restart = null;
    result.supports_global_databases = null;
    result.supports_integrations = null;
    result.supports_limitless_database = null;
    result.supports_local_write_forwarding = null;
    result.supports_log_exports_to_cloudwatch_logs = null;
    result.supports_parallel_query = null;
    result.supports_read_replica = null;
    result.tag_list = null;
    result.valid_upgrade_target = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CustomDBEngineVersionManifest")) {
                    result.custom_db_engine_version_manifest = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseInstallationFiles")) {
                    result.database_installation_files = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "DatabaseInstallationFilesS3BucketName")) {
                    result.database_installation_files_s3_bucket_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseInstallationFilesS3Prefix")) {
                    result.database_installation_files_s3_prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineDescription")) {
                    result.db_engine_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineMediaType")) {
                    result.db_engine_media_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineVersionArn")) {
                    result.db_engine_version_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineVersionDescription")) {
                    result.db_engine_version_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultCharacterSet")) {
                    result.default_character_set = try deserializeCharacterSet(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExportableLogTypes")) {
                    result.exportable_log_types = try deserializeLogTypeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "FailureReason")) {
                    result.failure_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Image")) {
                    result.image = try deserializeCustomDBEngineVersionAMI(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "KMSKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessV2FeaturesSupport")) {
                    result.serverless_v2_features_support = try deserializeServerlessV2FeaturesSupport(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedCACertificateIdentifiers")) {
                    result.supported_ca_certificate_identifiers = try deserializeCACertificateIdentifiersList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedCharacterSets")) {
                    result.supported_character_sets = try deserializeSupportedCharacterSetsList(allocator, reader, "CharacterSet");
                } else if (std.mem.eql(u8, e.local, "SupportedEngineModes")) {
                    result.supported_engine_modes = try deserializeEngineModeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedFeatureNames")) {
                    result.supported_feature_names = try deserializeFeatureNameList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedNcharCharacterSets")) {
                    result.supported_nchar_character_sets = try deserializeSupportedCharacterSetsList(allocator, reader, "CharacterSet");
                } else if (std.mem.eql(u8, e.local, "SupportedTimezones")) {
                    result.supported_timezones = try deserializeSupportedTimezonesList(allocator, reader, "Timezone");
                } else if (std.mem.eql(u8, e.local, "SupportsBabelfish")) {
                    result.supports_babelfish = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsCertificateRotationWithoutRestart")) {
                    result.supports_certificate_rotation_without_restart = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsGlobalDatabases")) {
                    result.supports_global_databases = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsIntegrations")) {
                    result.supports_integrations = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLimitlessDatabase")) {
                    result.supports_limitless_database = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLocalWriteForwarding")) {
                    result.supports_local_write_forwarding = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLogExportsToCloudwatchLogs")) {
                    result.supports_log_exports_to_cloudwatch_logs = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsParallelQuery")) {
                    result.supports_parallel_query = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsReadReplica")) {
                    result.supports_read_replica = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "ValidUpgradeTarget")) {
                    result.valid_upgrade_target = try deserializeValidUpgradeTargetList(allocator, reader, "UpgradeTarget");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBInstance(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBInstance {
    var result: DBInstance = undefined;
    result.activity_stream_engine_native_audit_fields_included = null;
    result.activity_stream_kinesis_stream_name = null;
    result.activity_stream_kms_key_id = null;
    result.activity_stream_mode = null;
    result.activity_stream_policy_status = null;
    result.activity_stream_status = null;
    result.additional_storage_volumes = null;
    result.allocated_storage = null;
    result.associated_roles = null;
    result.automatic_restart_time = null;
    result.automation_mode = null;
    result.auto_minor_version_upgrade = null;
    result.availability_zone = null;
    result.aws_backup_recovery_point_arn = null;
    result.backup_retention_period = null;
    result.backup_target = null;
    result.ca_certificate_identifier = null;
    result.certificate_details = null;
    result.character_set_name = null;
    result.copy_tags_to_snapshot = null;
    result.customer_owned_ip_enabled = null;
    result.custom_iam_instance_profile = null;
    result.database_insights_mode = null;
    result.db_cluster_identifier = null;
    result.db_instance_arn = null;
    result.db_instance_automated_backups_replications = null;
    result.db_instance_class = null;
    result.db_instance_identifier = null;
    result.db_instance_port = null;
    result.db_instance_status = null;
    result.dbi_resource_id = null;
    result.db_name = null;
    result.db_parameter_groups = null;
    result.db_security_groups = null;
    result.db_subnet_group = null;
    result.db_system_id = null;
    result.dedicated_log_volume = null;
    result.deletion_protection = null;
    result.domain_memberships = null;
    result.enabled_cloudwatch_logs_exports = null;
    result.endpoint = null;
    result.engine = null;
    result.engine_lifecycle_support = null;
    result.engine_version = null;
    result.enhanced_monitoring_resource_arn = null;
    result.iam_database_authentication_enabled = null;
    result.instance_create_time = null;
    result.iops = null;
    result.is_storage_config_upgrade_available = null;
    result.kms_key_id = null;
    result.latest_restorable_time = null;
    result.license_model = null;
    result.listener_endpoint = null;
    result.master_username = null;
    result.master_user_secret = null;
    result.max_allocated_storage = null;
    result.monitoring_interval = null;
    result.monitoring_role_arn = null;
    result.multi_az = null;
    result.multi_tenant = null;
    result.nchar_character_set_name = null;
    result.network_type = null;
    result.option_group_memberships = null;
    result.pending_modified_values = null;
    result.percent_progress = null;
    result.performance_insights_enabled = null;
    result.performance_insights_kms_key_id = null;
    result.performance_insights_retention_period = null;
    result.preferred_backup_window = null;
    result.preferred_maintenance_window = null;
    result.processor_features = null;
    result.promotion_tier = null;
    result.publicly_accessible = null;
    result.read_replica_db_cluster_identifiers = null;
    result.read_replica_db_instance_identifiers = null;
    result.read_replica_source_db_cluster_identifier = null;
    result.read_replica_source_db_instance_identifier = null;
    result.replica_mode = null;
    result.resume_full_automation_mode_time = null;
    result.secondary_availability_zone = null;
    result.status_infos = null;
    result.storage_encrypted = null;
    result.storage_throughput = null;
    result.storage_type = null;
    result.storage_volume_status = null;
    result.tag_list = null;
    result.tde_credential_arn = null;
    result.timezone = null;
    result.upgrade_rollout_order = null;
    result.vpc_security_groups = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActivityStreamEngineNativeAuditFieldsIncluded")) {
                    result.activity_stream_engine_native_audit_fields_included = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ActivityStreamKinesisStreamName")) {
                    result.activity_stream_kinesis_stream_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamKmsKeyId")) {
                    result.activity_stream_kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamMode")) {
                    result.activity_stream_mode = ActivityStreamMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamPolicyStatus")) {
                    result.activity_stream_policy_status = ActivityStreamPolicyStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamStatus")) {
                    result.activity_stream_status = ActivityStreamStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AdditionalStorageVolumes")) {
                    result.additional_storage_volumes = try deserializeAdditionalStorageVolumesOutputList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AssociatedRoles")) {
                    result.associated_roles = try deserializeDBInstanceRoles(allocator, reader, "DBInstanceRole");
                } else if (std.mem.eql(u8, e.local, "AutomaticRestartTime")) {
                    result.automatic_restart_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AutomationMode")) {
                    result.automation_mode = AutomationMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AwsBackupRecoveryPointArn")) {
                    result.aws_backup_recovery_point_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BackupTarget")) {
                    result.backup_target = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CACertificateIdentifier")) {
                    result.ca_certificate_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateDetails")) {
                    result.certificate_details = try deserializeCertificateDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CopyTagsToSnapshot")) {
                    result.copy_tags_to_snapshot = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CustomerOwnedIpEnabled")) {
                    result.customer_owned_ip_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CustomIamInstanceProfile")) {
                    result.custom_iam_instance_profile = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseInsightsMode")) {
                    result.database_insights_mode = DatabaseInsightsMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceArn")) {
                    result.db_instance_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackupsReplications")) {
                    result.db_instance_automated_backups_replications = try deserializeDBInstanceAutomatedBackupsReplicationList(allocator, reader, "DBInstanceAutomatedBackupsReplication");
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbInstancePort")) {
                    result.db_instance_port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DBInstanceStatus")) {
                    result.db_instance_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBName")) {
                    result.db_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroups")) {
                    result.db_parameter_groups = try deserializeDBParameterGroupStatusList(allocator, reader, "DBParameterGroup");
                } else if (std.mem.eql(u8, e.local, "DBSecurityGroups")) {
                    result.db_security_groups = try deserializeDBSecurityGroupMembershipList(allocator, reader, "DBSecurityGroup");
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroup")) {
                    result.db_subnet_group = try deserializeDBSubnetGroup(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DBSystemId")) {
                    result.db_system_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DedicatedLogVolume")) {
                    result.dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DomainMemberships")) {
                    result.domain_memberships = try deserializeDomainMembershipList(allocator, reader, "DomainMembership");
                } else if (std.mem.eql(u8, e.local, "EnabledCloudwatchLogsExports")) {
                    result.enabled_cloudwatch_logs_exports = try deserializeLogTypeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineLifecycleSupport")) {
                    result.engine_lifecycle_support = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnhancedMonitoringResourceArn")) {
                    result.enhanced_monitoring_resource_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "InstanceCreateTime")) {
                    result.instance_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "IsStorageConfigUpgradeAvailable")) {
                    result.is_storage_config_upgrade_available = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestRestorableTime")) {
                    result.latest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ListenerEndpoint")) {
                    result.listener_endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserSecret")) {
                    result.master_user_secret = try deserializeMasterUserSecret(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MaxAllocatedStorage")) {
                    result.max_allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MonitoringInterval")) {
                    result.monitoring_interval = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MonitoringRoleArn")) {
                    result.monitoring_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MultiTenant")) {
                    result.multi_tenant = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "NcharCharacterSetName")) {
                    result.nchar_character_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NetworkType")) {
                    result.network_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupMemberships")) {
                    result.option_group_memberships = try deserializeOptionGroupMembershipList(allocator, reader, "OptionGroupMembership");
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializePendingModifiedValues(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsEnabled")) {
                    result.performance_insights_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsKMSKeyId")) {
                    result.performance_insights_kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsRetentionPeriod")) {
                    result.performance_insights_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PreferredBackupWindow")) {
                    result.preferred_backup_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProcessorFeatures")) {
                    result.processor_features = try deserializeProcessorFeatureList(allocator, reader, "ProcessorFeature");
                } else if (std.mem.eql(u8, e.local, "PromotionTier")) {
                    result.promotion_tier = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaDBClusterIdentifiers")) {
                    result.read_replica_db_cluster_identifiers = try deserializeReadReplicaDBClusterIdentifierList(allocator, reader, "ReadReplicaDBClusterIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaDBInstanceIdentifiers")) {
                    result.read_replica_db_instance_identifiers = try deserializeReadReplicaDBInstanceIdentifierList(allocator, reader, "ReadReplicaDBInstanceIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaSourceDBClusterIdentifier")) {
                    result.read_replica_source_db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReadReplicaSourceDBInstanceIdentifier")) {
                    result.read_replica_source_db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicaMode")) {
                    result.replica_mode = ReplicaMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResumeFullAutomationModeTime")) {
                    result.resume_full_automation_mode_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SecondaryAvailabilityZone")) {
                    result.secondary_availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusInfos")) {
                    result.status_infos = try deserializeDBInstanceStatusInfoList(allocator, reader, "DBInstanceStatusInfo");
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageVolumeStatus")) {
                    result.storage_volume_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "TdeCredentialArn")) {
                    result.tde_credential_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timezone")) {
                    result.timezone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpgradeRolloutOrder")) {
                    result.upgrade_rollout_order = UpgradeRolloutOrder.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroups")) {
                    result.vpc_security_groups = try deserializeVpcSecurityGroupMembershipList(allocator, reader, "VpcSecurityGroupMembership");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBInstanceAutomatedBackup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBInstanceAutomatedBackup {
    var result: DBInstanceAutomatedBackup = undefined;
    result.additional_storage_volumes = null;
    result.allocated_storage = null;
    result.availability_zone = null;
    result.aws_backup_recovery_point_arn = null;
    result.backup_retention_period = null;
    result.backup_target = null;
    result.db_instance_arn = null;
    result.db_instance_automated_backups_arn = null;
    result.db_instance_automated_backups_replications = null;
    result.db_instance_identifier = null;
    result.dbi_resource_id = null;
    result.dedicated_log_volume = null;
    result.encrypted = null;
    result.engine = null;
    result.engine_version = null;
    result.iam_database_authentication_enabled = null;
    result.instance_create_time = null;
    result.iops = null;
    result.kms_key_id = null;
    result.license_model = null;
    result.master_username = null;
    result.multi_tenant = null;
    result.option_group_name = null;
    result.port = null;
    result.region = null;
    result.restore_window = null;
    result.status = null;
    result.storage_throughput = null;
    result.storage_type = null;
    result.tag_list = null;
    result.tde_credential_arn = null;
    result.timezone = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalStorageVolumes")) {
                    result.additional_storage_volumes = try deserializeAdditionalStorageVolumesList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AwsBackupRecoveryPointArn")) {
                    result.aws_backup_recovery_point_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BackupTarget")) {
                    result.backup_target = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceArn")) {
                    result.db_instance_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackupsArn")) {
                    result.db_instance_automated_backups_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackupsReplications")) {
                    result.db_instance_automated_backups_replications = try deserializeDBInstanceAutomatedBackupsReplicationList(allocator, reader, "DBInstanceAutomatedBackupsReplication");
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DedicatedLogVolume")) {
                    result.dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "InstanceCreateTime")) {
                    result.instance_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiTenant")) {
                    result.multi_tenant = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OptionGroupName")) {
                    result.option_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RestoreWindow")) {
                    result.restore_window = try deserializeRestoreWindow(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "TdeCredentialArn")) {
                    result.tde_credential_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timezone")) {
                    result.timezone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBInstanceAutomatedBackupsReplication(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBInstanceAutomatedBackupsReplication {
    var result: DBInstanceAutomatedBackupsReplication = undefined;
    result.db_instance_automated_backups_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackupsArn")) {
                    result.db_instance_automated_backups_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBInstanceRole(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBInstanceRole {
    var result: DBInstanceRole = undefined;
    result.feature_name = null;
    result.role_arn = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FeatureName")) {
                    result.feature_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleArn")) {
                    result.role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBInstanceStatusInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBInstanceStatusInfo {
    var result: DBInstanceStatusInfo = undefined;
    result.message = null;
    result.normal = null;
    result.status = null;
    result.status_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Normal")) {
                    result.normal = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusType")) {
                    result.status_type = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBMajorEngineVersion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBMajorEngineVersion {
    var result: DBMajorEngineVersion = undefined;
    result.engine = null;
    result.major_engine_version = null;
    result.supported_engine_lifecycles = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedEngineLifecycles")) {
                    result.supported_engine_lifecycles = try deserializeSupportedEngineLifecycleList(allocator, reader, "SupportedEngineLifecycle");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBParameterGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBParameterGroup {
    var result: DBParameterGroup = undefined;
    result.db_parameter_group_arn = null;
    result.db_parameter_group_family = null;
    result.db_parameter_group_name = null;
    result.description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBParameterGroupArn")) {
                    result.db_parameter_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupName")) {
                    result.db_parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBParameterGroupStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBParameterGroupStatus {
    var result: DBParameterGroupStatus = undefined;
    result.db_parameter_group_name = null;
    result.parameter_apply_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBParameterGroupName")) {
                    result.db_parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterApplyStatus")) {
                    result.parameter_apply_status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBProxy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBProxy {
    var result: DBProxy = undefined;
    result.auth = null;
    result.created_date = null;
    result.db_proxy_arn = null;
    result.db_proxy_name = null;
    result.debug_logging = null;
    result.default_auth_scheme = null;
    result.endpoint = null;
    result.endpoint_network_type = null;
    result.engine_family = null;
    result.idle_client_timeout = null;
    result.require_tls = null;
    result.role_arn = null;
    result.status = null;
    result.target_connection_network_type = null;
    result.updated_date = null;
    result.vpc_id = null;
    result.vpc_security_group_ids = null;
    result.vpc_subnet_ids = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Auth")) {
                    result.auth = try deserializeUserAuthConfigInfoList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "CreatedDate")) {
                    result.created_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBProxyArn")) {
                    result.db_proxy_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBProxyName")) {
                    result.db_proxy_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DebugLogging")) {
                    result.debug_logging = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DefaultAuthScheme")) {
                    result.default_auth_scheme = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointNetworkType")) {
                    result.endpoint_network_type = EndpointNetworkType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineFamily")) {
                    result.engine_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdleClientTimeout")) {
                    result.idle_client_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RequireTLS")) {
                    result.require_tls = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RoleArn")) {
                    result.role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = DBProxyStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetConnectionNetworkType")) {
                    result.target_connection_network_type = TargetConnectionNetworkType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdatedDate")) {
                    result.updated_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroupIds")) {
                    result.vpc_security_group_ids = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "VpcSubnetIds")) {
                    result.vpc_subnet_ids = try deserializeStringList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBProxyEndpoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBProxyEndpoint {
    var result: DBProxyEndpoint = undefined;
    result.created_date = null;
    result.db_proxy_endpoint_arn = null;
    result.db_proxy_endpoint_name = null;
    result.db_proxy_name = null;
    result.endpoint = null;
    result.endpoint_network_type = null;
    result.is_default = null;
    result.status = null;
    result.target_role = null;
    result.vpc_id = null;
    result.vpc_security_group_ids = null;
    result.vpc_subnet_ids = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedDate")) {
                    result.created_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBProxyEndpointArn")) {
                    result.db_proxy_endpoint_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBProxyEndpointName")) {
                    result.db_proxy_endpoint_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBProxyName")) {
                    result.db_proxy_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointNetworkType")) {
                    result.endpoint_network_type = EndpointNetworkType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = DBProxyEndpointStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetRole")) {
                    result.target_role = DBProxyEndpointTargetRole.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroupIds")) {
                    result.vpc_security_group_ids = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "VpcSubnetIds")) {
                    result.vpc_subnet_ids = try deserializeStringList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBProxyTarget(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBProxyTarget {
    var result: DBProxyTarget = undefined;
    result.endpoint = null;
    result.port = null;
    result.rds_resource_id = null;
    result.role = null;
    result.target_arn = null;
    result.target_health = null;
    result.tracked_cluster_id = null;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RdsResourceId")) {
                    result.rds_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Role")) {
                    result.role = TargetRole.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetArn")) {
                    result.target_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetHealth")) {
                    result.target_health = try deserializeTargetHealth(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TrackedClusterId")) {
                    result.tracked_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = TargetType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBProxyTargetGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBProxyTargetGroup {
    var result: DBProxyTargetGroup = undefined;
    result.connection_pool_config = null;
    result.created_date = null;
    result.db_proxy_name = null;
    result.is_default = null;
    result.status = null;
    result.target_group_arn = null;
    result.target_group_name = null;
    result.updated_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConnectionPoolConfig")) {
                    result.connection_pool_config = try deserializeConnectionPoolConfigurationInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CreatedDate")) {
                    result.created_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBProxyName")) {
                    result.db_proxy_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetGroupArn")) {
                    result.target_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetGroupName")) {
                    result.target_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdatedDate")) {
                    result.updated_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBRecommendation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBRecommendation {
    var result: DBRecommendation = undefined;
    result.additional_info = null;
    result.category = null;
    result.created_time = null;
    result.description = null;
    result.detection = null;
    result.impact = null;
    result.issue_details = null;
    result.links = null;
    result.reason = null;
    result.recommendation = null;
    result.recommendation_id = null;
    result.recommended_actions = null;
    result.resource_arn = null;
    result.severity = null;
    result.source = null;
    result.status = null;
    result.type_detection = null;
    result.type_id = null;
    result.type_recommendation = null;
    result.updated_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalInfo")) {
                    result.additional_info = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Category")) {
                    result.category = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Detection")) {
                    result.detection = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Impact")) {
                    result.impact = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IssueDetails")) {
                    result.issue_details = try deserializeIssueDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Links")) {
                    result.links = try deserializeDocLinkList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Recommendation")) {
                    result.recommendation = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecommendationId")) {
                    result.recommendation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecommendedActions")) {
                    result.recommended_actions = try deserializeRecommendedActionList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceArn")) {
                    result.resource_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Severity")) {
                    result.severity = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Source")) {
                    result.source = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeDetection")) {
                    result.type_detection = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeId")) {
                    result.type_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeRecommendation")) {
                    result.type_recommendation = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdatedTime")) {
                    result.updated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBSecurityGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBSecurityGroup {
    var result: DBSecurityGroup = undefined;
    result.db_security_group_arn = null;
    result.db_security_group_description = null;
    result.db_security_group_name = null;
    result.ec2_security_groups = null;
    result.ip_ranges = null;
    result.owner_id = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSecurityGroupArn")) {
                    result.db_security_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSecurityGroupDescription")) {
                    result.db_security_group_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSecurityGroupName")) {
                    result.db_security_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroups")) {
                    result.ec2_security_groups = try deserializeEC2SecurityGroupList(allocator, reader, "EC2SecurityGroup");
                } else if (std.mem.eql(u8, e.local, "IPRanges")) {
                    result.ip_ranges = try deserializeIPRangeList(allocator, reader, "IPRange");
                } else if (std.mem.eql(u8, e.local, "OwnerId")) {
                    result.owner_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBSecurityGroupMembership(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBSecurityGroupMembership {
    var result: DBSecurityGroupMembership = undefined;
    result.db_security_group_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSecurityGroupName")) {
                    result.db_security_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBShardGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBShardGroup {
    var result: DBShardGroup = undefined;
    result.compute_redundancy = null;
    result.db_cluster_identifier = null;
    result.db_shard_group_arn = null;
    result.db_shard_group_identifier = null;
    result.db_shard_group_resource_id = null;
    result.endpoint = null;
    result.max_acu = null;
    result.min_acu = null;
    result.publicly_accessible = null;
    result.status = null;
    result.tag_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ComputeRedundancy")) {
                    result.compute_redundancy = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBShardGroupArn")) {
                    result.db_shard_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBShardGroupIdentifier")) {
                    result.db_shard_group_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBShardGroupResourceId")) {
                    result.db_shard_group_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxACU")) {
                    result.max_acu = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinACU")) {
                    result.min_acu = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBSnapshot(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBSnapshot {
    var result: DBSnapshot = undefined;
    result.additional_storage_volumes = null;
    result.allocated_storage = null;
    result.availability_zone = null;
    result.db_instance_identifier = null;
    result.dbi_resource_id = null;
    result.db_snapshot_arn = null;
    result.db_snapshot_identifier = null;
    result.db_system_id = null;
    result.dedicated_log_volume = null;
    result.encrypted = null;
    result.engine = null;
    result.engine_version = null;
    result.iam_database_authentication_enabled = null;
    result.instance_create_time = null;
    result.iops = null;
    result.kms_key_id = null;
    result.license_model = null;
    result.master_username = null;
    result.multi_tenant = null;
    result.option_group_name = null;
    result.original_snapshot_create_time = null;
    result.percent_progress = null;
    result.port = null;
    result.processor_features = null;
    result.snapshot_availability_zone = null;
    result.snapshot_create_time = null;
    result.snapshot_database_time = null;
    result.snapshot_target = null;
    result.snapshot_type = null;
    result.source_db_snapshot_identifier = null;
    result.source_region = null;
    result.status = null;
    result.storage_throughput = null;
    result.storage_type = null;
    result.tag_list = null;
    result.tde_credential_arn = null;
    result.timezone = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalStorageVolumes")) {
                    result.additional_storage_volumes = try deserializeAdditionalStorageVolumesList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSnapshotArn")) {
                    result.db_snapshot_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSnapshotIdentifier")) {
                    result.db_snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSystemId")) {
                    result.db_system_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DedicatedLogVolume")) {
                    result.dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "InstanceCreateTime")) {
                    result.instance_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiTenant")) {
                    result.multi_tenant = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OptionGroupName")) {
                    result.option_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginalSnapshotCreateTime")) {
                    result.original_snapshot_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProcessorFeatures")) {
                    result.processor_features = try deserializeProcessorFeatureList(allocator, reader, "ProcessorFeature");
                } else if (std.mem.eql(u8, e.local, "SnapshotAvailabilityZone")) {
                    result.snapshot_availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotCreateTime")) {
                    result.snapshot_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotDatabaseTime")) {
                    result.snapshot_database_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotTarget")) {
                    result.snapshot_target = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotType")) {
                    result.snapshot_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceDBSnapshotIdentifier")) {
                    result.source_db_snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceRegion")) {
                    result.source_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "TdeCredentialArn")) {
                    result.tde_credential_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timezone")) {
                    result.timezone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBSnapshotAttribute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBSnapshotAttribute {
    var result: DBSnapshotAttribute = undefined;
    result.attribute_name = null;
    result.attribute_values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AttributeName")) {
                    result.attribute_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeValues")) {
                    result.attribute_values = try deserializeAttributeValueList(allocator, reader, "AttributeValue");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBSnapshotAttributesResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBSnapshotAttributesResult {
    var result: DBSnapshotAttributesResult = undefined;
    result.db_snapshot_attributes = null;
    result.db_snapshot_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSnapshotAttributes")) {
                    result.db_snapshot_attributes = try deserializeDBSnapshotAttributeList(allocator, reader, "DBSnapshotAttribute");
                } else if (std.mem.eql(u8, e.local, "DBSnapshotIdentifier")) {
                    result.db_snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBSnapshotTenantDatabase(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBSnapshotTenantDatabase {
    var result: DBSnapshotTenantDatabase = undefined;
    result.character_set_name = null;
    result.db_instance_identifier = null;
    result.dbi_resource_id = null;
    result.db_snapshot_identifier = null;
    result.db_snapshot_tenant_database_arn = null;
    result.engine_name = null;
    result.master_username = null;
    result.nchar_character_set_name = null;
    result.snapshot_type = null;
    result.tag_list = null;
    result.tenant_database_create_time = null;
    result.tenant_database_resource_id = null;
    result.tenant_db_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSnapshotIdentifier")) {
                    result.db_snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSnapshotTenantDatabaseARN")) {
                    result.db_snapshot_tenant_database_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineName")) {
                    result.engine_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NcharCharacterSetName")) {
                    result.nchar_character_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotType")) {
                    result.snapshot_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseCreateTime")) {
                    result.tenant_database_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseResourceId")) {
                    result.tenant_database_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TenantDBName")) {
                    result.tenant_db_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDBSubnetGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBSubnetGroup {
    var result: DBSubnetGroup = undefined;
    result.db_subnet_group_arn = null;
    result.db_subnet_group_description = null;
    result.db_subnet_group_name = null;
    result.subnet_group_status = null;
    result.subnets = null;
    result.supported_network_types = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSubnetGroupArn")) {
                    result.db_subnet_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroupDescription")) {
                    result.db_subnet_group_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroupName")) {
                    result.db_subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetGroupStatus")) {
                    result.subnet_group_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Subnets")) {
                    result.subnets = try deserializeSubnetList(allocator, reader, "Subnet");
                } else if (std.mem.eql(u8, e.local, "SupportedNetworkTypes")) {
                    result.supported_network_types = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDescribeDBLogFilesDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DescribeDBLogFilesDetails {
    var result: DescribeDBLogFilesDetails = undefined;
    result.last_written = null;
    result.log_file_name = null;
    result.size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastWritten")) {
                    result.last_written = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LogFileName")) {
                    result.log_file_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Size")) {
                    result.size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDocLink(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DocLink {
    var result: DocLink = undefined;
    result.text = null;
    result.url = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Text")) {
                    result.text = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Url")) {
                    result.url = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDomainMembership(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DomainMembership {
    var result: DomainMembership = undefined;
    result.auth_secret_arn = null;
    result.dns_ips = null;
    result.domain = null;
    result.fqdn = null;
    result.iam_role_name = null;
    result.ou = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthSecretArn")) {
                    result.auth_secret_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DnsIps")) {
                    result.dns_ips = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FQDN")) {
                    result.fqdn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMRoleName")) {
                    result.iam_role_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OU")) {
                    result.ou = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDoubleRange(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DoubleRange {
    _ = allocator;
    var result: DoubleRange = undefined;
    result.from = null;
    result.to = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "From")) {
                    result.from = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "To")) {
                    result.to = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEC2SecurityGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EC2SecurityGroup {
    var result: EC2SecurityGroup = undefined;
    result.ec2_security_group_id = null;
    result.ec2_security_group_name = null;
    result.ec2_security_group_owner_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EC2SecurityGroupId")) {
                    result.ec2_security_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroupName")) {
                    result.ec2_security_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroupOwnerId")) {
                    result.ec2_security_group_owner_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEndpoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Endpoint {
    var result: Endpoint = undefined;
    result.address = null;
    result.hosted_zone_id = null;
    result.port = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Address")) {
                    result.address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEngineDefaults(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EngineDefaults {
    var result: EngineDefaults = undefined;
    result.db_parameter_group_family = null;
    result.marker = null;
    result.parameters = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeParametersList(allocator, reader, "Parameter");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEvent(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Event {
    var result: Event = undefined;
    result.date = null;
    result.event_categories = null;
    result.message = null;
    result.source_arn = null;
    result.source_identifier = null;
    result.source_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Date")) {
                    result.date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EventCategories")) {
                    result.event_categories = try deserializeEventCategoriesList(allocator, reader, "EventCategory");
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceArn")) {
                    result.source_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceIdentifier")) {
                    result.source_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = SourceType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEventCategoriesMap(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EventCategoriesMap {
    var result: EventCategoriesMap = undefined;
    result.event_categories = null;
    result.source_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventCategories")) {
                    result.event_categories = try deserializeEventCategoriesList(allocator, reader, "EventCategory");
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEventSubscription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EventSubscription {
    var result: EventSubscription = undefined;
    result.customer_aws_id = null;
    result.cust_subscription_id = null;
    result.enabled = null;
    result.event_categories_list = null;
    result.event_subscription_arn = null;
    result.sns_topic_arn = null;
    result.source_ids_list = null;
    result.source_type = null;
    result.status = null;
    result.subscription_creation_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CustomerAwsId")) {
                    result.customer_aws_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustSubscriptionId")) {
                    result.cust_subscription_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EventCategoriesList")) {
                    result.event_categories_list = try deserializeEventCategoriesList(allocator, reader, "EventCategory");
                } else if (std.mem.eql(u8, e.local, "EventSubscriptionArn")) {
                    result.event_subscription_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnsTopicArn")) {
                    result.sns_topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceIdsList")) {
                    result.source_ids_list = try deserializeSourceIdsList(allocator, reader, "SourceId");
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubscriptionCreationTime")) {
                    result.subscription_creation_time = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeExportTask(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ExportTask {
    var result: ExportTask = undefined;
    result.export_only = null;
    result.export_task_identifier = null;
    result.failure_cause = null;
    result.iam_role_arn = null;
    result.kms_key_id = null;
    result.percent_progress = null;
    result.s3_bucket = null;
    result.s3_prefix = null;
    result.snapshot_time = null;
    result.source_arn = null;
    result.source_type = null;
    result.status = null;
    result.task_end_time = null;
    result.task_start_time = null;
    result.total_extracted_data_in_gb = null;
    result.warning_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExportOnly")) {
                    result.export_only = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ExportTaskIdentifier")) {
                    result.export_task_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureCause")) {
                    result.failure_cause = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IamRoleArn")) {
                    result.iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "S3Bucket")) {
                    result.s3_bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3Prefix")) {
                    result.s3_prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotTime")) {
                    result.snapshot_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SourceArn")) {
                    result.source_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = ExportSourceType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TaskEndTime")) {
                    result.task_end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TaskStartTime")) {
                    result.task_start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TotalExtractedDataInGB")) {
                    result.total_extracted_data_in_gb = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "WarningMessage")) {
                    result.warning_message = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFailoverState(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FailoverState {
    var result: FailoverState = undefined;
    result.from_db_cluster_arn = null;
    result.is_data_loss_allowed = null;
    result.status = null;
    result.to_db_cluster_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FromDbClusterArn")) {
                    result.from_db_cluster_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDataLossAllowed")) {
                    result.is_data_loss_allowed = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = FailoverStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ToDbClusterArn")) {
                    result.to_db_cluster_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGlobalCluster(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GlobalCluster {
    var result: GlobalCluster = undefined;
    result.database_name = null;
    result.deletion_protection = null;
    result.endpoint = null;
    result.engine = null;
    result.engine_lifecycle_support = null;
    result.engine_version = null;
    result.failover_state = null;
    result.global_cluster_arn = null;
    result.global_cluster_identifier = null;
    result.global_cluster_members = null;
    result.global_cluster_resource_id = null;
    result.status = null;
    result.storage_encrypted = null;
    result.tag_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DatabaseName")) {
                    result.database_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineLifecycleSupport")) {
                    result.engine_lifecycle_support = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailoverState")) {
                    result.failover_state = try deserializeFailoverState(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "GlobalClusterArn")) {
                    result.global_cluster_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalClusterIdentifier")) {
                    result.global_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalClusterMembers")) {
                    result.global_cluster_members = try deserializeGlobalClusterMemberList(allocator, reader, "GlobalClusterMember");
                } else if (std.mem.eql(u8, e.local, "GlobalClusterResourceId")) {
                    result.global_cluster_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGlobalClusterMember(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GlobalClusterMember {
    var result: GlobalClusterMember = undefined;
    result.db_cluster_arn = null;
    result.global_write_forwarding_status = null;
    result.is_writer = null;
    result.readers = null;
    result.synchronization_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterArn")) {
                    result.db_cluster_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalWriteForwardingStatus")) {
                    result.global_write_forwarding_status = WriteForwardingStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsWriter")) {
                    result.is_writer = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Readers")) {
                    result.readers = try deserializeReadersArnList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SynchronizationStatus")) {
                    result.synchronization_status = GlobalClusterMemberSynchronizationStatus.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIPRange(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IPRange {
    var result: IPRange = undefined;
    result.cidrip = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CIDRIP")) {
                    result.cidrip = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIntegration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Integration {
    var result: Integration = undefined;
    result.additional_encryption_context = null;
    result.create_time = null;
    result.data_filter = null;
    result.description = null;
    result.errors = null;
    result.integration_arn = null;
    result.integration_name = null;
    result.kms_key_id = null;
    result.source_arn = null;
    result.status = null;
    result.tags = null;
    result.target_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalEncryptionContext")) {
                    result.additional_encryption_context = try deserializeEncryptionContextMap(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DataFilter")) {
                    result.data_filter = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Errors")) {
                    result.errors = try deserializeIntegrationErrorList(allocator, reader, "IntegrationError");
                } else if (std.mem.eql(u8, e.local, "IntegrationArn")) {
                    result.integration_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IntegrationName")) {
                    result.integration_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KMSKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceArn")) {
                    result.source_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = IntegrationStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "TargetArn")) {
                    result.target_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIntegrationError(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IntegrationError {
    var result: IntegrationError = undefined;
    result.error_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIssueDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IssueDetails {
    var result: IssueDetails = undefined;
    result.performance_issue_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PerformanceIssueDetails")) {
                    result.performance_issue_details = try deserializePerformanceIssueDetails(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLimitlessDatabase(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LimitlessDatabase {
    _ = allocator;
    var result: LimitlessDatabase = undefined;
    result.min_required_acu = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MinRequiredACU")) {
                    result.min_required_acu = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = LimitlessDatabaseStatus.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMasterUserSecret(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MasterUserSecret {
    var result: MasterUserSecret = undefined;
    result.kms_key_id = null;
    result.secret_arn = null;
    result.secret_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretArn")) {
                    result.secret_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretStatus")) {
                    result.secret_status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetric(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Metric {
    var result: Metric = undefined;
    result.metric_query = null;
    result.name = null;
    result.references = null;
    result.statistics_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricQuery")) {
                    result.metric_query = try deserializeMetricQuery(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "References")) {
                    result.references = try deserializeMetricReferenceList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "StatisticsDetails")) {
                    result.statistics_details = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricQuery(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricQuery {
    var result: MetricQuery = undefined;
    result.performance_insights_metric_query = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PerformanceInsightsMetricQuery")) {
                    result.performance_insights_metric_query = try deserializePerformanceInsightsMetricQuery(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricReference(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricReference {
    var result: MetricReference = undefined;
    result.name = null;
    result.reference_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReferenceDetails")) {
                    result.reference_details = try deserializeReferenceDetails(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMinimumEngineVersionPerAllowedValue(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MinimumEngineVersionPerAllowedValue {
    var result: MinimumEngineVersionPerAllowedValue = undefined;
    result.allowed_value = null;
    result.minimum_engine_version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValue")) {
                    result.allowed_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Option {
    var result: Option = undefined;
    result.db_security_group_memberships = null;
    result.option_description = null;
    result.option_name = null;
    result.option_settings = null;
    result.option_version = null;
    result.permanent = null;
    result.persistent = null;
    result.port = null;
    result.vpc_security_group_memberships = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSecurityGroupMemberships")) {
                    result.db_security_group_memberships = try deserializeDBSecurityGroupMembershipList(allocator, reader, "DBSecurityGroup");
                } else if (std.mem.eql(u8, e.local, "OptionDescription")) {
                    result.option_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionName")) {
                    result.option_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionSettings")) {
                    result.option_settings = try deserializeOptionSettingConfigurationList(allocator, reader, "OptionSetting");
                } else if (std.mem.eql(u8, e.local, "OptionVersion")) {
                    result.option_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Permanent")) {
                    result.permanent = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Persistent")) {
                    result.persistent = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroupMemberships")) {
                    result.vpc_security_group_memberships = try deserializeVpcSecurityGroupMembershipList(allocator, reader, "VpcSecurityGroupMembership");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOptionGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OptionGroup {
    var result: OptionGroup = undefined;
    result.allows_vpc_and_non_vpc_instance_memberships = null;
    result.copy_timestamp = null;
    result.engine_name = null;
    result.major_engine_version = null;
    result.option_group_arn = null;
    result.option_group_description = null;
    result.option_group_name = null;
    result.options = null;
    result.source_account_id = null;
    result.source_option_group = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowsVpcAndNonVpcInstanceMemberships")) {
                    result.allows_vpc_and_non_vpc_instance_memberships = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CopyTimestamp")) {
                    result.copy_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EngineName")) {
                    result.engine_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupArn")) {
                    result.option_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupDescription")) {
                    result.option_group_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupName")) {
                    result.option_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeOptionsList(allocator, reader, "Option");
                } else if (std.mem.eql(u8, e.local, "SourceAccountId")) {
                    result.source_account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceOptionGroup")) {
                    result.source_option_group = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOptionGroupMembership(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OptionGroupMembership {
    var result: OptionGroupMembership = undefined;
    result.option_group_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OptionGroupName")) {
                    result.option_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOptionGroupOption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OptionGroupOption {
    var result: OptionGroupOption = undefined;
    result.copyable_cross_account = null;
    result.default_port = null;
    result.description = null;
    result.engine_name = null;
    result.major_engine_version = null;
    result.minimum_required_minor_engine_version = null;
    result.name = null;
    result.option_group_option_settings = null;
    result.option_group_option_versions = null;
    result.options_conflicts_with = null;
    result.options_depended_on = null;
    result.permanent = null;
    result.persistent = null;
    result.port_required = null;
    result.requires_auto_minor_engine_version_upgrade = null;
    result.supports_option_version_downgrade = null;
    result.vpc_only = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CopyableCrossAccount")) {
                    result.copyable_cross_account = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DefaultPort")) {
                    result.default_port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineName")) {
                    result.engine_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumRequiredMinorEngineVersion")) {
                    result.minimum_required_minor_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupOptionSettings")) {
                    result.option_group_option_settings = try deserializeOptionGroupOptionSettingsList(allocator, reader, "OptionGroupOptionSetting");
                } else if (std.mem.eql(u8, e.local, "OptionGroupOptionVersions")) {
                    result.option_group_option_versions = try deserializeOptionGroupOptionVersionsList(allocator, reader, "OptionVersion");
                } else if (std.mem.eql(u8, e.local, "OptionsConflictsWith")) {
                    result.options_conflicts_with = try deserializeOptionsConflictsWith(allocator, reader, "OptionConflictName");
                } else if (std.mem.eql(u8, e.local, "OptionsDependedOn")) {
                    result.options_depended_on = try deserializeOptionsDependedOn(allocator, reader, "OptionName");
                } else if (std.mem.eql(u8, e.local, "Permanent")) {
                    result.permanent = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Persistent")) {
                    result.persistent = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PortRequired")) {
                    result.port_required = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RequiresAutoMinorEngineVersionUpgrade")) {
                    result.requires_auto_minor_engine_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsOptionVersionDowngrade")) {
                    result.supports_option_version_downgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "VpcOnly")) {
                    result.vpc_only = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOptionGroupOptionSetting(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OptionGroupOptionSetting {
    var result: OptionGroupOptionSetting = undefined;
    result.allowed_values = null;
    result.apply_type = null;
    result.default_value = null;
    result.is_modifiable = null;
    result.is_required = null;
    result.minimum_engine_version_per_allowed_value = null;
    result.setting_description = null;
    result.setting_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValues")) {
                    result.allowed_values = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyType")) {
                    result.apply_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsModifiable")) {
                    result.is_modifiable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IsRequired")) {
                    result.is_required = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersionPerAllowedValue")) {
                    result.minimum_engine_version_per_allowed_value = try deserializeMinimumEngineVersionPerAllowedValueList(allocator, reader, "MinimumEngineVersionPerAllowedValue");
                } else if (std.mem.eql(u8, e.local, "SettingDescription")) {
                    result.setting_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SettingName")) {
                    result.setting_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOptionSetting(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OptionSetting {
    var result: OptionSetting = undefined;
    result.allowed_values = null;
    result.apply_type = null;
    result.data_type = null;
    result.default_value = null;
    result.description = null;
    result.is_collection = null;
    result.is_modifiable = null;
    result.name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValues")) {
                    result.allowed_values = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyType")) {
                    result.apply_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataType")) {
                    result.data_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsCollection")) {
                    result.is_collection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IsModifiable")) {
                    result.is_modifiable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOptionVersion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OptionVersion {
    var result: OptionVersion = undefined;
    result.is_default = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Version")) {
                    result.version = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOrderableDBInstanceOption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OrderableDBInstanceOption {
    var result: OrderableDBInstanceOption = undefined;
    result.availability_zone_group = null;
    result.availability_zones = null;
    result.available_additional_storage_volumes_options = null;
    result.available_processor_features = null;
    result.db_instance_class = null;
    result.engine = null;
    result.engine_version = null;
    result.license_model = null;
    result.max_iops_per_db_instance = null;
    result.max_iops_per_gib = null;
    result.max_storage_size = null;
    result.max_storage_throughput_per_db_instance = null;
    result.max_storage_throughput_per_iops = null;
    result.min_iops_per_db_instance = null;
    result.min_iops_per_gib = null;
    result.min_storage_size = null;
    result.min_storage_throughput_per_db_instance = null;
    result.min_storage_throughput_per_iops = null;
    result.multi_az_capable = null;
    result.outpost_capable = null;
    result.read_replica_capable = null;
    result.storage_type = null;
    result.supported_activity_stream_modes = null;
    result.supported_engine_modes = null;
    result.supported_network_types = null;
    result.supports_additional_storage_volumes = null;
    result.supports_clusters = null;
    result.supports_dedicated_log_volume = null;
    result.supports_enhanced_monitoring = null;
    result.supports_global_databases = null;
    result.supports_http_endpoint = null;
    result.supports_iam_database_authentication = null;
    result.supports_iops = null;
    result.supports_kerberos_authentication = null;
    result.supports_performance_insights = null;
    result.supports_storage_autoscaling = null;
    result.supports_storage_encryption = null;
    result.supports_storage_throughput = null;
    result.vpc = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZoneGroup")) {
                    result.availability_zone_group = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZoneList(allocator, reader, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "AvailableAdditionalStorageVolumesOptions")) {
                    result.available_additional_storage_volumes_options = try deserializeAvailableAdditionalStorageVolumesOptionList(allocator, reader, "AvailableAdditionalStorageVolumesOption");
                } else if (std.mem.eql(u8, e.local, "AvailableProcessorFeatures")) {
                    result.available_processor_features = try deserializeAvailableProcessorFeatureList(allocator, reader, "AvailableProcessorFeature");
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxIopsPerDbInstance")) {
                    result.max_iops_per_db_instance = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxIopsPerGib")) {
                    result.max_iops_per_gib = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxStorageSize")) {
                    result.max_storage_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxStorageThroughputPerDbInstance")) {
                    result.max_storage_throughput_per_db_instance = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxStorageThroughputPerIops")) {
                    result.max_storage_throughput_per_iops = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinIopsPerDbInstance")) {
                    result.min_iops_per_db_instance = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinIopsPerGib")) {
                    result.min_iops_per_gib = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinStorageSize")) {
                    result.min_storage_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinStorageThroughputPerDbInstance")) {
                    result.min_storage_throughput_per_db_instance = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinStorageThroughputPerIops")) {
                    result.min_storage_throughput_per_iops = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MultiAZCapable")) {
                    result.multi_az_capable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OutpostCapable")) {
                    result.outpost_capable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaCapable")) {
                    result.read_replica_capable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedActivityStreamModes")) {
                    result.supported_activity_stream_modes = try deserializeActivityStreamModeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedEngineModes")) {
                    result.supported_engine_modes = try deserializeEngineModeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedNetworkTypes")) {
                    result.supported_network_types = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportsAdditionalStorageVolumes")) {
                    result.supports_additional_storage_volumes = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsClusters")) {
                    result.supports_clusters = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsDedicatedLogVolume")) {
                    result.supports_dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsEnhancedMonitoring")) {
                    result.supports_enhanced_monitoring = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsGlobalDatabases")) {
                    result.supports_global_databases = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsHttpEndpoint")) {
                    result.supports_http_endpoint = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsIAMDatabaseAuthentication")) {
                    result.supports_iam_database_authentication = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsIops")) {
                    result.supports_iops = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsKerberosAuthentication")) {
                    result.supports_kerberos_authentication = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsPerformanceInsights")) {
                    result.supports_performance_insights = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsStorageAutoscaling")) {
                    result.supports_storage_autoscaling = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsStorageEncryption")) {
                    result.supports_storage_encryption = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsStorageThroughput")) {
                    result.supports_storage_throughput = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Vpc")) {
                    result.vpc = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOutpost(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Outpost {
    var result: Outpost = undefined;
    result.arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeParameter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Parameter {
    var result: Parameter = undefined;
    result.allowed_values = null;
    result.apply_method = null;
    result.apply_type = null;
    result.data_type = null;
    result.description = null;
    result.is_modifiable = null;
    result.minimum_engine_version = null;
    result.parameter_name = null;
    result.parameter_value = null;
    result.source = null;
    result.supported_engine_modes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValues")) {
                    result.allowed_values = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyMethod")) {
                    result.apply_method = ApplyMethod.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyType")) {
                    result.apply_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataType")) {
                    result.data_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsModifiable")) {
                    result.is_modifiable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterName")) {
                    result.parameter_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterValue")) {
                    result.parameter_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Source")) {
                    result.source = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedEngineModes")) {
                    result.supported_engine_modes = try deserializeEngineModeList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePendingCloudwatchLogsExports(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PendingCloudwatchLogsExports {
    var result: PendingCloudwatchLogsExports = undefined;
    result.log_types_to_disable = null;
    result.log_types_to_enable = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogTypesToDisable")) {
                    result.log_types_to_disable = try deserializeLogTypeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LogTypesToEnable")) {
                    result.log_types_to_enable = try deserializeLogTypeList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePendingMaintenanceAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PendingMaintenanceAction {
    var result: PendingMaintenanceAction = undefined;
    result.action = null;
    result.auto_applied_after_date = null;
    result.current_apply_date = null;
    result.description = null;
    result.forced_apply_date = null;
    result.opt_in_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Action")) {
                    result.action = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoAppliedAfterDate")) {
                    result.auto_applied_after_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CurrentApplyDate")) {
                    result.current_apply_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ForcedApplyDate")) {
                    result.forced_apply_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "OptInStatus")) {
                    result.opt_in_status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePendingModifiedValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PendingModifiedValues {
    var result: PendingModifiedValues = undefined;
    result.additional_storage_volumes = null;
    result.allocated_storage = null;
    result.automation_mode = null;
    result.backup_retention_period = null;
    result.ca_certificate_identifier = null;
    result.db_instance_class = null;
    result.db_instance_identifier = null;
    result.db_subnet_group_name = null;
    result.dedicated_log_volume = null;
    result.engine = null;
    result.engine_version = null;
    result.iam_database_authentication_enabled = null;
    result.iops = null;
    result.license_model = null;
    result.master_user_password = null;
    result.multi_az = null;
    result.multi_tenant = null;
    result.pending_cloudwatch_logs_exports = null;
    result.port = null;
    result.processor_features = null;
    result.resume_full_automation_mode_time = null;
    result.storage_throughput = null;
    result.storage_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalStorageVolumes")) {
                    result.additional_storage_volumes = try deserializeAdditionalStorageVolumesList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AutomationMode")) {
                    result.automation_mode = AutomationMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CACertificateIdentifier")) {
                    result.ca_certificate_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroupName")) {
                    result.db_subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DedicatedLogVolume")) {
                    result.dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserPassword")) {
                    result.master_user_password = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MultiTenant")) {
                    result.multi_tenant = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PendingCloudwatchLogsExports")) {
                    result.pending_cloudwatch_logs_exports = try deserializePendingCloudwatchLogsExports(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProcessorFeatures")) {
                    result.processor_features = try deserializeProcessorFeatureList(allocator, reader, "ProcessorFeature");
                } else if (std.mem.eql(u8, e.local, "ResumeFullAutomationModeTime")) {
                    result.resume_full_automation_mode_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePerformanceInsightsMetricDimensionGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PerformanceInsightsMetricDimensionGroup {
    var result: PerformanceInsightsMetricDimensionGroup = undefined;
    result.dimensions = null;
    result.group = null;
    result.limit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Group")) {
                    result.group = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Limit")) {
                    result.limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePerformanceInsightsMetricQuery(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PerformanceInsightsMetricQuery {
    var result: PerformanceInsightsMetricQuery = undefined;
    result.group_by = null;
    result.metric = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GroupBy")) {
                    result.group_by = try deserializePerformanceInsightsMetricDimensionGroup(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Metric")) {
                    result.metric = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePerformanceIssueDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PerformanceIssueDetails {
    var result: PerformanceIssueDetails = undefined;
    result.analysis = null;
    result.end_time = null;
    result.metrics = null;
    result.start_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Analysis")) {
                    result.analysis = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try deserializeMetricList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeProcessorFeature(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ProcessorFeature {
    var result: ProcessorFeature = undefined;
    result.name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRange(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Range {
    _ = allocator;
    var result: Range = undefined;
    result.from = null;
    result.step = null;
    result.to = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "From")) {
                    result.from = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Step")) {
                    result.step = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "To")) {
                    result.to = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRdsCustomClusterConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RdsCustomClusterConfiguration {
    var result: RdsCustomClusterConfiguration = undefined;
    result.interconnect_subnet_id = null;
    result.replica_mode = null;
    result.transit_gateway_multicast_domain_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InterconnectSubnetId")) {
                    result.interconnect_subnet_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicaMode")) {
                    result.replica_mode = ReplicaMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TransitGatewayMulticastDomainId")) {
                    result.transit_gateway_multicast_domain_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRecommendedAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RecommendedAction {
    var result: RecommendedAction = undefined;
    result.action_id = null;
    result.apply_modes = null;
    result.context_attributes = null;
    result.description = null;
    result.issue_details = null;
    result.operation = null;
    result.parameters = null;
    result.status = null;
    result.title = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActionId")) {
                    result.action_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyModes")) {
                    result.apply_modes = try deserializeStringList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ContextAttributes")) {
                    result.context_attributes = try deserializeContextAttributeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IssueDetails")) {
                    result.issue_details = try deserializeIssueDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Operation")) {
                    result.operation = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeRecommendedActionParameterList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Title")) {
                    result.title = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRecommendedActionParameter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RecommendedActionParameter {
    var result: RecommendedActionParameter = undefined;
    result.key = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRecurringCharge(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RecurringCharge {
    var result: RecurringCharge = undefined;
    result.recurring_charge_amount = null;
    result.recurring_charge_frequency = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RecurringChargeAmount")) {
                    result.recurring_charge_amount = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "RecurringChargeFrequency")) {
                    result.recurring_charge_frequency = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReferenceDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReferenceDetails {
    var result: ReferenceDetails = undefined;
    result.scalar_reference_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ScalarReferenceDetails")) {
                    result.scalar_reference_details = try deserializeScalarReferenceDetails(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReservedDBInstance(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReservedDBInstance {
    var result: ReservedDBInstance = undefined;
    result.currency_code = null;
    result.db_instance_class = null;
    result.db_instance_count = null;
    result.duration = null;
    result.fixed_price = null;
    result.lease_id = null;
    result.multi_az = null;
    result.offering_type = null;
    result.product_description = null;
    result.recurring_charges = null;
    result.reserved_db_instance_arn = null;
    result.reserved_db_instance_id = null;
    result.reserved_db_instances_offering_id = null;
    result.start_time = null;
    result.state = null;
    result.usage_price = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CurrencyCode")) {
                    result.currency_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceCount")) {
                    result.db_instance_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LeaseId")) {
                    result.lease_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProductDescription")) {
                    result.product_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(allocator, reader, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstanceArn")) {
                    result.reserved_db_instance_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstanceId")) {
                    result.reserved_db_instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstancesOfferingId")) {
                    result.reserved_db_instances_offering_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UsagePrice")) {
                    result.usage_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReservedDBInstancesOffering(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReservedDBInstancesOffering {
    var result: ReservedDBInstancesOffering = undefined;
    result.currency_code = null;
    result.db_instance_class = null;
    result.duration = null;
    result.fixed_price = null;
    result.multi_az = null;
    result.offering_type = null;
    result.product_description = null;
    result.recurring_charges = null;
    result.reserved_db_instances_offering_id = null;
    result.usage_price = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CurrencyCode")) {
                    result.currency_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProductDescription")) {
                    result.product_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(allocator, reader, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstancesOfferingId")) {
                    result.reserved_db_instances_offering_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UsagePrice")) {
                    result.usage_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResourcePendingMaintenanceActions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourcePendingMaintenanceActions {
    var result: ResourcePendingMaintenanceActions = undefined;
    result.pending_maintenance_action_details = null;
    result.resource_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PendingMaintenanceActionDetails")) {
                    result.pending_maintenance_action_details = try deserializePendingMaintenanceActionDetails(allocator, reader, "PendingMaintenanceAction");
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifier")) {
                    result.resource_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRestoreWindow(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RestoreWindow {
    _ = allocator;
    var result: RestoreWindow = undefined;
    result.earliest_time = null;
    result.latest_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EarliestTime")) {
                    result.earliest_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LatestTime")) {
                    result.latest_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeScalarReferenceDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScalarReferenceDetails {
    _ = allocator;
    var result: ScalarReferenceDetails = undefined;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeScalingConfigurationInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScalingConfigurationInfo {
    var result: ScalingConfigurationInfo = undefined;
    result.auto_pause = null;
    result.max_capacity = null;
    result.min_capacity = null;
    result.seconds_before_timeout = null;
    result.seconds_until_auto_pause = null;
    result.timeout_action = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoPause")) {
                    result.auto_pause = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxCapacity")) {
                    result.max_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinCapacity")) {
                    result.min_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SecondsBeforeTimeout")) {
                    result.seconds_before_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SecondsUntilAutoPause")) {
                    result.seconds_until_auto_pause = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TimeoutAction")) {
                    result.timeout_action = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerlessV2FeaturesSupport(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerlessV2FeaturesSupport {
    _ = allocator;
    var result: ServerlessV2FeaturesSupport = undefined;
    result.max_capacity = null;
    result.min_capacity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MaxCapacity")) {
                    result.max_capacity = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinCapacity")) {
                    result.min_capacity = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerlessV2ScalingConfigurationInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerlessV2ScalingConfigurationInfo {
    _ = allocator;
    var result: ServerlessV2ScalingConfigurationInfo = undefined;
    result.max_capacity = null;
    result.min_capacity = null;
    result.seconds_until_auto_pause = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MaxCapacity")) {
                    result.max_capacity = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinCapacity")) {
                    result.min_capacity = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SecondsUntilAutoPause")) {
                    result.seconds_until_auto_pause = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSourceRegion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SourceRegion {
    var result: SourceRegion = undefined;
    result.endpoint = null;
    result.region_name = null;
    result.status = null;
    result.supports_db_instance_automated_backups_replication = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RegionName")) {
                    result.region_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportsDBInstanceAutomatedBackupsReplication")) {
                    result.supports_db_instance_automated_backups_replication = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSubnet(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Subnet {
    var result: Subnet = undefined;
    result.subnet_availability_zone = null;
    result.subnet_identifier = null;
    result.subnet_outpost = null;
    result.subnet_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubnetAvailabilityZone")) {
                    result.subnet_availability_zone = try deserializeAvailabilityZone(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SubnetIdentifier")) {
                    result.subnet_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetOutpost")) {
                    result.subnet_outpost = try deserializeOutpost(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SubnetStatus")) {
                    result.subnet_status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSupportedEngineLifecycle(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SupportedEngineLifecycle {
    _ = allocator;
    var result: SupportedEngineLifecycle = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LifecycleSupportEndDate")) {
                    result.lifecycle_support_end_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LifecycleSupportName")) {
                    result.lifecycle_support_name = LifecycleSupportName.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "LifecycleSupportStartDate")) {
                    result.lifecycle_support_start_date = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSwitchoverDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SwitchoverDetail {
    var result: SwitchoverDetail = undefined;
    result.source_member = null;
    result.status = null;
    result.target_member = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SourceMember")) {
                    result.source_member = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetMember")) {
                    result.target_member = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTag(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Tag {
    var result: Tag = undefined;
    result.key = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetHealth(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetHealth {
    var result: TargetHealth = undefined;
    result.description = null;
    result.reason = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = TargetHealthReason.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = TargetState.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTenantDatabase(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TenantDatabase {
    var result: TenantDatabase = undefined;
    result.character_set_name = null;
    result.db_instance_identifier = null;
    result.dbi_resource_id = null;
    result.deletion_protection = null;
    result.master_username = null;
    result.master_user_secret = null;
    result.nchar_character_set_name = null;
    result.pending_modified_values = null;
    result.status = null;
    result.tag_list = null;
    result.tenant_database_arn = null;
    result.tenant_database_create_time = null;
    result.tenant_database_resource_id = null;
    result.tenant_db_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserSecret")) {
                    result.master_user_secret = try deserializeMasterUserSecret(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NcharCharacterSetName")) {
                    result.nchar_character_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializeTenantDatabasePendingModifiedValues(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseARN")) {
                    result.tenant_database_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseCreateTime")) {
                    result.tenant_database_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseResourceId")) {
                    result.tenant_database_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TenantDBName")) {
                    result.tenant_db_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTenantDatabasePendingModifiedValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TenantDatabasePendingModifiedValues {
    var result: TenantDatabasePendingModifiedValues = undefined;
    result.master_user_password = null;
    result.tenant_db_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MasterUserPassword")) {
                    result.master_user_password = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TenantDBName")) {
                    result.tenant_db_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTimezone(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Timezone {
    var result: Timezone = undefined;
    result.timezone_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TimezoneName")) {
                    result.timezone_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUpgradeTarget(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UpgradeTarget {
    var result: UpgradeTarget = undefined;
    result.auto_upgrade = null;
    result.description = null;
    result.engine = null;
    result.engine_version = null;
    result.is_major_version_upgrade = null;
    result.supported_engine_modes = null;
    result.supports_babelfish = null;
    result.supports_global_databases = null;
    result.supports_integrations = null;
    result.supports_limitless_database = null;
    result.supports_local_write_forwarding = null;
    result.supports_parallel_query = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoUpgrade")) {
                    result.auto_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsMajorVersionUpgrade")) {
                    result.is_major_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportedEngineModes")) {
                    result.supported_engine_modes = try deserializeEngineModeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportsBabelfish")) {
                    result.supports_babelfish = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsGlobalDatabases")) {
                    result.supports_global_databases = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsIntegrations")) {
                    result.supports_integrations = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLimitlessDatabase")) {
                    result.supports_limitless_database = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLocalWriteForwarding")) {
                    result.supports_local_write_forwarding = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsParallelQuery")) {
                    result.supports_parallel_query = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUserAuthConfigInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UserAuthConfigInfo {
    var result: UserAuthConfigInfo = undefined;
    result.auth_scheme = null;
    result.client_password_auth_type = null;
    result.description = null;
    result.iam_auth = null;
    result.secret_arn = null;
    result.user_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthScheme")) {
                    result.auth_scheme = AuthScheme.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClientPasswordAuthType")) {
                    result.client_password_auth_type = ClientPasswordAuthType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMAuth")) {
                    result.iam_auth = IAMAuthMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretArn")) {
                    result.secret_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeValidAdditionalStorageOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ValidAdditionalStorageOptions {
    var result: ValidAdditionalStorageOptions = undefined;
    result.supports_additional_storage_volumes = null;
    result.volumes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SupportsAdditionalStorageVolumes")) {
                    result.supports_additional_storage_volumes = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Volumes")) {
                    result.volumes = try deserializeValidVolumeOptionsList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeValidDBInstanceModificationsMessage(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ValidDBInstanceModificationsMessage {
    var result: ValidDBInstanceModificationsMessage = undefined;
    result.additional_storage = null;
    result.storage = null;
    result.supports_dedicated_log_volume = null;
    result.valid_processor_features = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalStorage")) {
                    result.additional_storage = try deserializeValidAdditionalStorageOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Storage")) {
                    result.storage = try deserializeValidStorageOptionsList(allocator, reader, "ValidStorageOptions");
                } else if (std.mem.eql(u8, e.local, "SupportsDedicatedLogVolume")) {
                    result.supports_dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ValidProcessorFeatures")) {
                    result.valid_processor_features = try deserializeAvailableProcessorFeatureList(allocator, reader, "AvailableProcessorFeature");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeValidStorageOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ValidStorageOptions {
    var result: ValidStorageOptions = undefined;
    result.iops_to_storage_ratio = null;
    result.provisioned_iops = null;
    result.provisioned_storage_throughput = null;
    result.storage_size = null;
    result.storage_throughput_to_iops_ratio = null;
    result.storage_type = null;
    result.supports_storage_autoscaling = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IopsToStorageRatio")) {
                    result.iops_to_storage_ratio = try deserializeDoubleRangeList(allocator, reader, "DoubleRange");
                } else if (std.mem.eql(u8, e.local, "ProvisionedIops")) {
                    result.provisioned_iops = try deserializeRangeList(allocator, reader, "Range");
                } else if (std.mem.eql(u8, e.local, "ProvisionedStorageThroughput")) {
                    result.provisioned_storage_throughput = try deserializeRangeList(allocator, reader, "Range");
                } else if (std.mem.eql(u8, e.local, "StorageSize")) {
                    result.storage_size = try deserializeRangeList(allocator, reader, "Range");
                } else if (std.mem.eql(u8, e.local, "StorageThroughputToIopsRatio")) {
                    result.storage_throughput_to_iops_ratio = try deserializeDoubleRangeList(allocator, reader, "DoubleRange");
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportsStorageAutoscaling")) {
                    result.supports_storage_autoscaling = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeValidVolumeOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ValidVolumeOptions {
    var result: ValidVolumeOptions = undefined;
    result.storage = null;
    result.volume_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Storage")) {
                    result.storage = try deserializeValidStorageOptionsList(allocator, reader, "ValidStorageOptions");
                } else if (std.mem.eql(u8, e.local, "VolumeName")) {
                    result.volume_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVpcSecurityGroupMembership(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VpcSecurityGroupMembership {
    var result: VpcSecurityGroupMembership = undefined;
    result.status = null;
    result.vpc_security_group_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroupId")) {
                    result.vpc_security_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeAdditionalStorageVolumesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AdditionalStorageVolume, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeAdditionalStorageVolume(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAttributeValueList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAvailabilityZones(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeDBSecurityGroupNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEngineModeList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEventCategoriesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeFilterList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Filter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeFilterValueList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeKeyList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLogTypeList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeModifyAdditionalStorageVolumesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ModifyAdditionalStorageVolume, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeModifyAdditionalStorageVolume(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOptionConfigurationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OptionConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeOptionConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOptionNamesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOptionSettingsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OptionSetting, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeOptionSetting(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeParametersList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Parameter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeParameter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeProcessorFeatureList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ProcessorFeature, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeProcessorFeature(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRecommendedActionUpdateList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RecommendedActionUpdate, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRecommendedActionUpdate(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSourceIdsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStringList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSubnetIdentifierList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagSpecificationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TagSpecification, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTagSpecification(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeUserAuthConfigList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const UserAuthConfig, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeUserAuthConfig(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeVpcSecurityGroupIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEncryptionContextMap(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<key>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</key>");
        try buf.appendSlice(allocator, "<value>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAdditionalStorageVolume(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdditionalStorageVolume) !void {
    if (value.allocated_storage) |v| {
        try buf.appendSlice(allocator, "<AllocatedStorage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</AllocatedStorage>");
    }
    if (value.iops) |v| {
        try buf.appendSlice(allocator, "<IOPS>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</IOPS>");
    }
    if (value.max_allocated_storage) |v| {
        try buf.appendSlice(allocator, "<MaxAllocatedStorage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxAllocatedStorage>");
    }
    if (value.storage_throughput) |v| {
        try buf.appendSlice(allocator, "<StorageThroughput>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</StorageThroughput>");
    }
    if (value.storage_type) |v| {
        try buf.appendSlice(allocator, "<StorageType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</StorageType>");
    }
    try buf.appendSlice(allocator, "<VolumeName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.volume_name);
    try buf.appendSlice(allocator, "</VolumeName>");
}

pub fn serializeCloudwatchLogsExportConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudwatchLogsExportConfiguration) !void {
    if (value.disable_log_types) |v| {
        try buf.appendSlice(allocator, "<DisableLogTypes>");
        try serializeLogTypeList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</DisableLogTypes>");
    }
    if (value.enable_log_types) |v| {
        try buf.appendSlice(allocator, "<EnableLogTypes>");
        try serializeLogTypeList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</EnableLogTypes>");
    }
}

pub fn serializeConnectionPoolConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionPoolConfiguration) !void {
    if (value.connection_borrow_timeout) |v| {
        try buf.appendSlice(allocator, "<ConnectionBorrowTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ConnectionBorrowTimeout>");
    }
    if (value.init_query) |v| {
        try buf.appendSlice(allocator, "<InitQuery>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</InitQuery>");
    }
    if (value.max_connections_percent) |v| {
        try buf.appendSlice(allocator, "<MaxConnectionsPercent>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxConnectionsPercent>");
    }
    if (value.max_idle_connections_percent) |v| {
        try buf.appendSlice(allocator, "<MaxIdleConnectionsPercent>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxIdleConnectionsPercent>");
    }
    if (value.session_pinning_filters) |v| {
        try buf.appendSlice(allocator, "<SessionPinningFilters>");
        try serializeStringList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</SessionPinningFilters>");
    }
}

pub fn serializeFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Filter) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Values>");
    try serializeFilterValueList(allocator, buf, value.values, "Value");
    try buf.appendSlice(allocator, "</Values>");
}

pub fn serializeModifyAdditionalStorageVolume(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ModifyAdditionalStorageVolume) !void {
    if (value.allocated_storage) |v| {
        try buf.appendSlice(allocator, "<AllocatedStorage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</AllocatedStorage>");
    }
    if (value.iops) |v| {
        try buf.appendSlice(allocator, "<IOPS>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</IOPS>");
    }
    if (value.max_allocated_storage) |v| {
        try buf.appendSlice(allocator, "<MaxAllocatedStorage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxAllocatedStorage>");
    }
    if (value.set_for_delete) |v| {
        try buf.appendSlice(allocator, "<SetForDelete>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SetForDelete>");
    }
    if (value.storage_throughput) |v| {
        try buf.appendSlice(allocator, "<StorageThroughput>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</StorageThroughput>");
    }
    if (value.storage_type) |v| {
        try buf.appendSlice(allocator, "<StorageType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</StorageType>");
    }
    try buf.appendSlice(allocator, "<VolumeName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.volume_name);
    try buf.appendSlice(allocator, "</VolumeName>");
}

pub fn serializeOptionConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OptionConfiguration) !void {
    if (value.db_security_group_memberships) |v| {
        try buf.appendSlice(allocator, "<DBSecurityGroupMemberships>");
        try serializeDBSecurityGroupNameList(allocator, buf, v, "DBSecurityGroupName");
        try buf.appendSlice(allocator, "</DBSecurityGroupMemberships>");
    }
    try buf.appendSlice(allocator, "<OptionName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.option_name);
    try buf.appendSlice(allocator, "</OptionName>");
    if (value.option_settings) |v| {
        try buf.appendSlice(allocator, "<OptionSettings>");
        try serializeOptionSettingsList(allocator, buf, v, "OptionSetting");
        try buf.appendSlice(allocator, "</OptionSettings>");
    }
    if (value.option_version) |v| {
        try buf.appendSlice(allocator, "<OptionVersion>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OptionVersion>");
    }
    if (value.port) |v| {
        try buf.appendSlice(allocator, "<Port>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Port>");
    }
    if (value.vpc_security_group_memberships) |v| {
        try buf.appendSlice(allocator, "<VpcSecurityGroupMemberships>");
        try serializeVpcSecurityGroupIdList(allocator, buf, v, "VpcSecurityGroupId");
        try buf.appendSlice(allocator, "</VpcSecurityGroupMemberships>");
    }
}

pub fn serializeOptionSetting(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OptionSetting) !void {
    if (value.allowed_values) |v| {
        try buf.appendSlice(allocator, "<AllowedValues>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AllowedValues>");
    }
    if (value.apply_type) |v| {
        try buf.appendSlice(allocator, "<ApplyType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ApplyType>");
    }
    if (value.data_type) |v| {
        try buf.appendSlice(allocator, "<DataType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DataType>");
    }
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.description) |v| {
        try buf.appendSlice(allocator, "<Description>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Description>");
    }
    if (value.is_collection) |v| {
        try buf.appendSlice(allocator, "<IsCollection>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsCollection>");
    }
    if (value.is_modifiable) |v| {
        try buf.appendSlice(allocator, "<IsModifiable>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsModifiable>");
    }
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeParameter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Parameter) !void {
    if (value.allowed_values) |v| {
        try buf.appendSlice(allocator, "<AllowedValues>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AllowedValues>");
    }
    if (value.apply_method) |v| {
        try buf.appendSlice(allocator, "<ApplyMethod>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ApplyMethod>");
    }
    if (value.apply_type) |v| {
        try buf.appendSlice(allocator, "<ApplyType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ApplyType>");
    }
    if (value.data_type) |v| {
        try buf.appendSlice(allocator, "<DataType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DataType>");
    }
    if (value.description) |v| {
        try buf.appendSlice(allocator, "<Description>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Description>");
    }
    if (value.is_modifiable) |v| {
        try buf.appendSlice(allocator, "<IsModifiable>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsModifiable>");
    }
    if (value.minimum_engine_version) |v| {
        try buf.appendSlice(allocator, "<MinimumEngineVersion>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</MinimumEngineVersion>");
    }
    if (value.parameter_name) |v| {
        try buf.appendSlice(allocator, "<ParameterName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ParameterName>");
    }
    if (value.parameter_value) |v| {
        try buf.appendSlice(allocator, "<ParameterValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ParameterValue>");
    }
    if (value.source) |v| {
        try buf.appendSlice(allocator, "<Source>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Source>");
    }
    if (value.supported_engine_modes) |v| {
        try buf.appendSlice(allocator, "<SupportedEngineModes>");
        try serializeEngineModeList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</SupportedEngineModes>");
    }
}

pub fn serializeProcessorFeature(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ProcessorFeature) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeRdsCustomClusterConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RdsCustomClusterConfiguration) !void {
    if (value.interconnect_subnet_id) |v| {
        try buf.appendSlice(allocator, "<InterconnectSubnetId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</InterconnectSubnetId>");
    }
    if (value.replica_mode) |v| {
        try buf.appendSlice(allocator, "<ReplicaMode>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ReplicaMode>");
    }
    if (value.transit_gateway_multicast_domain_id) |v| {
        try buf.appendSlice(allocator, "<TransitGatewayMulticastDomainId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TransitGatewayMulticastDomainId>");
    }
}

pub fn serializeRecommendedActionUpdate(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RecommendedActionUpdate) !void {
    try buf.appendSlice(allocator, "<ActionId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.action_id);
    try buf.appendSlice(allocator, "</ActionId>");
    try buf.appendSlice(allocator, "<Status>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.status);
    try buf.appendSlice(allocator, "</Status>");
}

pub fn serializeScalingConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScalingConfiguration) !void {
    if (value.auto_pause) |v| {
        try buf.appendSlice(allocator, "<AutoPause>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</AutoPause>");
    }
    if (value.max_capacity) |v| {
        try buf.appendSlice(allocator, "<MaxCapacity>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxCapacity>");
    }
    if (value.min_capacity) |v| {
        try buf.appendSlice(allocator, "<MinCapacity>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MinCapacity>");
    }
    if (value.seconds_before_timeout) |v| {
        try buf.appendSlice(allocator, "<SecondsBeforeTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</SecondsBeforeTimeout>");
    }
    if (value.seconds_until_auto_pause) |v| {
        try buf.appendSlice(allocator, "<SecondsUntilAutoPause>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</SecondsUntilAutoPause>");
    }
    if (value.timeout_action) |v| {
        try buf.appendSlice(allocator, "<TimeoutAction>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TimeoutAction>");
    }
}

pub fn serializeServerlessV2ScalingConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ServerlessV2ScalingConfiguration) !void {
    if (value.max_capacity) |v| {
        try buf.appendSlice(allocator, "<MaxCapacity>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxCapacity>");
    }
    if (value.min_capacity) |v| {
        try buf.appendSlice(allocator, "<MinCapacity>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MinCapacity>");
    }
    if (value.seconds_until_auto_pause) |v| {
        try buf.appendSlice(allocator, "<SecondsUntilAutoPause>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</SecondsUntilAutoPause>");
    }
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    if (value.key) |v| {
        try buf.appendSlice(allocator, "<Key>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Key>");
    }
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeTagSpecification(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TagSpecification) !void {
    if (value.resource_type) |v| {
        try buf.appendSlice(allocator, "<ResourceType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourceType>");
    }
    if (value.tags) |v| {
        try buf.appendSlice(allocator, "<Tags>");
        try serializeTagList(allocator, buf, v, "Tag");
        try buf.appendSlice(allocator, "</Tags>");
    }
}

pub fn serializeUserAuthConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: UserAuthConfig) !void {
    if (value.auth_scheme) |v| {
        try buf.appendSlice(allocator, "<AuthScheme>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</AuthScheme>");
    }
    if (value.client_password_auth_type) |v| {
        try buf.appendSlice(allocator, "<ClientPasswordAuthType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ClientPasswordAuthType>");
    }
    if (value.description) |v| {
        try buf.appendSlice(allocator, "<Description>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Description>");
    }
    if (value.iam_auth) |v| {
        try buf.appendSlice(allocator, "<IAMAuth>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</IAMAuth>");
    }
    if (value.secret_arn) |v| {
        try buf.appendSlice(allocator, "<SecretArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SecretArn>");
    }
    if (value.user_name) |v| {
        try buf.appendSlice(allocator, "<UserName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</UserName>");
    }
}

