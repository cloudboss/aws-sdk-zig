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

pub fn deserializeAccountQuotaList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AccountQuota {
    var list: std.ArrayList(AccountQuota) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAccountQuota(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeActivityStreamModeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAdditionalStorageVolumesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AdditionalStorageVolume {
    var list: std.ArrayList(AdditionalStorageVolume) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAdditionalStorageVolume(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAdditionalStorageVolumesOutputList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AdditionalStorageVolumeOutput {
    var list: std.ArrayList(AdditionalStorageVolumeOutput) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAdditionalStorageVolumeOutput(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAttributeValueList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAvailabilityZoneList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AvailabilityZone {
    var list: std.ArrayList(AvailabilityZone) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAvailabilityZone(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAvailabilityZones(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAvailableAdditionalStorageVolumesOptionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AvailableAdditionalStorageVolumesOption {
    var list: std.ArrayList(AvailableAdditionalStorageVolumesOption) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAvailableAdditionalStorageVolumesOption(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAvailableProcessorFeatureList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AvailableProcessorFeature {
    var list: std.ArrayList(AvailableProcessorFeature) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAvailableProcessorFeature(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeBlueGreenDeploymentList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const BlueGreenDeployment {
    var list: std.ArrayList(BlueGreenDeployment) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeBlueGreenDeployment(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeBlueGreenDeploymentTaskList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const BlueGreenDeploymentTask {
    var list: std.ArrayList(BlueGreenDeploymentTask) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeBlueGreenDeploymentTask(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCACertificateIdentifiersList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCertificateList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Certificate {
    var list: std.ArrayList(Certificate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCertificate(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeContextAttributeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ContextAttribute {
    var list: std.ArrayList(ContextAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeContextAttribute(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterAutomatedBackupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterAutomatedBackup {
    var list: std.ArrayList(DBClusterAutomatedBackup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterAutomatedBackup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterBacktrackList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterBacktrack {
    var list: std.ArrayList(DBClusterBacktrack) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterBacktrack(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterEndpointList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterEndpoint {
    var list: std.ArrayList(DBClusterEndpoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterEndpoint(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBCluster {
    var list: std.ArrayList(DBCluster) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBCluster(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterMemberList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterMember {
    var list: std.ArrayList(DBClusterMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterMember(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterOptionGroupMemberships(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterOptionGroupStatus {
    var list: std.ArrayList(DBClusterOptionGroupStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterOptionGroupStatus(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterParameterGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterParameterGroup {
    var list: std.ArrayList(DBClusterParameterGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterParameterGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterRoles(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterRole {
    var list: std.ArrayList(DBClusterRole) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterRole(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterSnapshotAttributeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterSnapshotAttribute {
    var list: std.ArrayList(DBClusterSnapshotAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterSnapshotAttribute(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterSnapshotList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterSnapshot {
    var list: std.ArrayList(DBClusterSnapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterSnapshot(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBClusterStatusInfoList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBClusterStatusInfo {
    var list: std.ArrayList(DBClusterStatusInfo) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBClusterStatusInfo(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBEngineVersionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBEngineVersion {
    var list: std.ArrayList(DBEngineVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBEngineVersion(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBInstanceAutomatedBackupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBInstanceAutomatedBackup {
    var list: std.ArrayList(DBInstanceAutomatedBackup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBInstanceAutomatedBackup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBInstanceAutomatedBackupsReplicationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBInstanceAutomatedBackupsReplication {
    var list: std.ArrayList(DBInstanceAutomatedBackupsReplication) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBInstanceAutomatedBackupsReplication(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBInstanceList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBInstance {
    var list: std.ArrayList(DBInstance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBInstance(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBInstanceRoles(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBInstanceRole {
    var list: std.ArrayList(DBInstanceRole) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBInstanceRole(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBInstanceStatusInfoList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBInstanceStatusInfo {
    var list: std.ArrayList(DBInstanceStatusInfo) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBInstanceStatusInfo(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBMajorEngineVersionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBMajorEngineVersion {
    var list: std.ArrayList(DBMajorEngineVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBMajorEngineVersion(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBParameterGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBParameterGroup {
    var list: std.ArrayList(DBParameterGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBParameterGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBParameterGroupStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBParameterGroupStatus {
    var list: std.ArrayList(DBParameterGroupStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBParameterGroupStatus(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBProxyEndpointList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBProxyEndpoint {
    var list: std.ArrayList(DBProxyEndpoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBProxyEndpoint(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBProxyList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBProxy {
    var list: std.ArrayList(DBProxy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBProxy(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBRecommendationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBRecommendation {
    var list: std.ArrayList(DBRecommendation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBRecommendation(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBSecurityGroupMembershipList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBSecurityGroupMembership {
    var list: std.ArrayList(DBSecurityGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBSecurityGroupMembership(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBSecurityGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBSecurityGroup {
    var list: std.ArrayList(DBSecurityGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBSecurityGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBShardGroupsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBShardGroup {
    var list: std.ArrayList(DBShardGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBShardGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBSnapshotAttributeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBSnapshotAttribute {
    var list: std.ArrayList(DBSnapshotAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBSnapshotAttribute(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBSnapshotList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBSnapshot {
    var list: std.ArrayList(DBSnapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBSnapshot(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBSnapshotTenantDatabasesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBSnapshotTenantDatabase {
    var list: std.ArrayList(DBSnapshotTenantDatabase) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBSnapshotTenantDatabase(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDBSubnetGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBSubnetGroup {
    var list: std.ArrayList(DBSubnetGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBSubnetGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDescribeDBLogFilesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DescribeDBLogFilesDetails {
    var list: std.ArrayList(DescribeDBLogFilesDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDescribeDBLogFilesDetails(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDocLinkList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DocLink {
    var list: std.ArrayList(DocLink) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDocLink(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDomainMembershipList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DomainMembership {
    var list: std.ArrayList(DomainMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDomainMembership(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDoubleRangeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DoubleRange {
    var list: std.ArrayList(DoubleRange) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDoubleRange(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEC2SecurityGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EC2SecurityGroup {
    var list: std.ArrayList(EC2SecurityGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEC2SecurityGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEngineModeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEventCategoriesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEventCategoriesMapList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EventCategoriesMap {
    var list: std.ArrayList(EventCategoriesMap) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEventCategoriesMap(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEventList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Event {
    var list: std.ArrayList(Event) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEvent(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEventSubscriptionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EventSubscription {
    var list: std.ArrayList(EventSubscription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEventSubscription(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeExportTasksList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ExportTask {
    var list: std.ArrayList(ExportTask) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeExportTask(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFeatureNameList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeGlobalClusterList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const GlobalCluster {
    var list: std.ArrayList(GlobalCluster) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeGlobalCluster(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeGlobalClusterMemberList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const GlobalClusterMember {
    var list: std.ArrayList(GlobalClusterMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeGlobalClusterMember(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeIPRangeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const IPRange {
    var list: std.ArrayList(IPRange) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeIPRange(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeIntegrationErrorList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const IntegrationError {
    var list: std.ArrayList(IntegrationError) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeIntegrationError(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeIntegrationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Integration {
    var list: std.ArrayList(Integration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeIntegration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeLogTypeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Metric {
    var list: std.ArrayList(Metric) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetric(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricReferenceList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricReference {
    var list: std.ArrayList(MetricReference) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricReference(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMinimumEngineVersionPerAllowedValueList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MinimumEngineVersionPerAllowedValue {
    var list: std.ArrayList(MinimumEngineVersionPerAllowedValue) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMinimumEngineVersionPerAllowedValue(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOptionGroupMembershipList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OptionGroupMembership {
    var list: std.ArrayList(OptionGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOptionGroupMembership(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOptionGroupOptionSettingsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OptionGroupOptionSetting {
    var list: std.ArrayList(OptionGroupOptionSetting) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOptionGroupOptionSetting(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOptionGroupOptionVersionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OptionVersion {
    var list: std.ArrayList(OptionVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOptionVersion(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOptionGroupOptionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OptionGroupOption {
    var list: std.ArrayList(OptionGroupOption) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOptionGroupOption(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOptionGroupsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OptionGroup {
    var list: std.ArrayList(OptionGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOptionGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOptionSettingConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OptionSetting {
    var list: std.ArrayList(OptionSetting) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOptionSetting(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOptionsConflictsWith(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOptionsDependedOn(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOptionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Option {
    var list: std.ArrayList(Option) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOption(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOrderableDBInstanceOptionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OrderableDBInstanceOption {
    var list: std.ArrayList(OrderableDBInstanceOption) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOrderableDBInstanceOption(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeParametersList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Parameter {
    var list: std.ArrayList(Parameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeParameter(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePendingMaintenanceActionDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PendingMaintenanceAction {
    var list: std.ArrayList(PendingMaintenanceAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePendingMaintenanceAction(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePendingMaintenanceActions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourcePendingMaintenanceActions {
    var list: std.ArrayList(ResourcePendingMaintenanceActions) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourcePendingMaintenanceActions(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeProcessorFeatureList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ProcessorFeature {
    var list: std.ArrayList(ProcessorFeature) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeProcessorFeature(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeRangeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Range {
    var list: std.ArrayList(Range) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRange(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReadReplicaDBClusterIdentifierList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReadReplicaDBInstanceIdentifierList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReadReplicaIdentifierList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReadersArnList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeRecommendedActionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RecommendedAction {
    var list: std.ArrayList(RecommendedAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRecommendedAction(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeRecommendedActionParameterList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RecommendedActionParameter {
    var list: std.ArrayList(RecommendedActionParameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRecommendedActionParameter(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeRecurringChargeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RecurringCharge {
    var list: std.ArrayList(RecurringCharge) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRecurringCharge(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReservedDBInstanceList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReservedDBInstance {
    var list: std.ArrayList(ReservedDBInstance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReservedDBInstance(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeReservedDBInstancesOfferingList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReservedDBInstancesOffering {
    var list: std.ArrayList(ReservedDBInstancesOffering) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReservedDBInstancesOffering(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSourceIdsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSourceRegionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SourceRegion {
    var list: std.ArrayList(SourceRegion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSourceRegion(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeStringList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSubnetList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Subnet {
    var list: std.ArrayList(Subnet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSubnet(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSupportedCharacterSetsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CharacterSet {
    var list: std.ArrayList(CharacterSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCharacterSet(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSupportedEngineLifecycleList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SupportedEngineLifecycle {
    var list: std.ArrayList(SupportedEngineLifecycle) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSupportedEngineLifecycle(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSupportedTimezonesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Timezone {
    var list: std.ArrayList(Timezone) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTimezone(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSwitchoverDetailList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SwitchoverDetail {
    var list: std.ArrayList(SwitchoverDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSwitchoverDetail(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTagList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTag(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTargetGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBProxyTargetGroup {
    var list: std.ArrayList(DBProxyTargetGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBProxyTargetGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTargetList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DBProxyTarget {
    var list: std.ArrayList(DBProxyTarget) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDBProxyTarget(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTenantDatabasesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TenantDatabase {
    var list: std.ArrayList(TenantDatabase) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTenantDatabase(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeUserAuthConfigInfoList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const UserAuthConfigInfo {
    var list: std.ArrayList(UserAuthConfigInfo) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeUserAuthConfigInfo(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeValidStorageOptionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ValidStorageOptions {
    var list: std.ArrayList(ValidStorageOptions) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeValidStorageOptions(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeValidUpgradeTargetList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const UpgradeTarget {
    var list: std.ArrayList(UpgradeTarget) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeUpgradeTarget(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeValidVolumeOptionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ValidVolumeOptions {
    var list: std.ArrayList(ValidVolumeOptions) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeValidVolumeOptions(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeVpcSecurityGroupMembershipList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const VpcSecurityGroupMembership {
    var list: std.ArrayList(VpcSecurityGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeVpcSecurityGroupMembership(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEncryptionContextMap(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try alloc.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAccountQuota(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccountQuota {
    var result: AccountQuota = undefined;
    result.account_quota_name = null;
    result.max = null;
    result.used = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountQuotaName")) {
                    result.account_quota_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAdditionalStorageVolume(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AdditionalStorageVolume {
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
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VolumeName")) {
                    result.volume_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAdditionalStorageVolumeOutput(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AdditionalStorageVolumeOutput {
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
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageVolumeStatus")) {
                    result.storage_volume_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VolumeName")) {
                    result.volume_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAvailabilityZone(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AvailabilityZone {
    var result: AvailabilityZone = undefined;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAvailableAdditionalStorageVolumesOption(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AvailableAdditionalStorageVolumesOption {
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
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAvailableProcessorFeature(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AvailableProcessorFeature {
    var result: AvailableProcessorFeature = undefined;
    result.allowed_values = null;
    result.default_value = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValues")) {
                    result.allowed_values = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeBlueGreenDeployment(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BlueGreenDeployment {
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
                    result.blue_green_deployment_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BlueGreenDeploymentName")) {
                    result.blue_green_deployment_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DeleteTime")) {
                    result.delete_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Source")) {
                    result.source = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusDetails")) {
                    result.status_details = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SwitchoverDetails")) {
                    result.switchover_details = try deserializeSwitchoverDetailList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "Target")) {
                    result.target = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tasks")) {
                    result.tasks = try deserializeBlueGreenDeploymentTaskList(reader, alloc, "member");
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

pub fn deserializeBlueGreenDeploymentTask(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BlueGreenDeploymentTask {
    var result: BlueGreenDeploymentTask = undefined;
    result.name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCertificate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Certificate {
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
                    result.certificate_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateIdentifier")) {
                    result.certificate_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateType")) {
                    result.certificate_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomerOverride")) {
                    result.customer_override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CustomerOverrideValidTill")) {
                    result.customer_override_valid_till = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Thumbprint")) {
                    result.thumbprint = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCertificateDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CertificateDetails {
    var result: CertificateDetails = undefined;
    result.ca_identifier = null;
    result.valid_till = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CAIdentifier")) {
                    result.ca_identifier = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCharacterSet(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CharacterSet {
    var result: CharacterSet = undefined;
    result.character_set_description = null;
    result.character_set_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CharacterSetDescription")) {
                    result.character_set_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeClusterPendingModifiedValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ClusterPendingModifiedValues {
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
                    result.certificate_details = try deserializeCertificateDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MasterUserPassword")) {
                    result.master_user_password = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingCloudwatchLogsExports")) {
                    result.pending_cloudwatch_logs_exports = try deserializePendingCloudwatchLogsExports(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RdsCustomClusterConfiguration")) {
                    result.rds_custom_cluster_configuration = try deserializeRdsCustomClusterConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeConnectionPoolConfigurationInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConnectionPoolConfigurationInfo {
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
                    result.init_query = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxConnectionsPercent")) {
                    result.max_connections_percent = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxIdleConnectionsPercent")) {
                    result.max_idle_connections_percent = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SessionPinningFilters")) {
                    result.session_pinning_filters = try deserializeStringList(reader, alloc, "member");
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

pub fn deserializeContextAttribute(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContextAttribute {
    var result: ContextAttribute = undefined;
    result.key = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCustomDBEngineVersionAMI(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CustomDBEngineVersionAMI {
    var result: CustomDBEngineVersionAMI = undefined;
    result.image_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBCluster(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBCluster {
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
                    result.activity_stream_kinesis_stream_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamKmsKeyId")) {
                    result.activity_stream_kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamMode")) {
                    result.activity_stream_mode = std.meta.stringToEnum(ActivityStreamMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamStatus")) {
                    result.activity_stream_status = std.meta.stringToEnum(ActivityStreamStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AssociatedRoles")) {
                    result.associated_roles = try deserializeDBClusterRoles(reader, alloc, "DBClusterRole");
                } else if (std.mem.eql(u8, e.local, "AutomaticRestartTime")) {
                    result.automatic_restart_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(reader, alloc, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "AwsBackupRecoveryPointArn")) {
                    result.aws_backup_recovery_point_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BacktrackConsumedChangeRecords")) {
                    result.backtrack_consumed_change_records = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BacktrackWindow")) {
                    result.backtrack_window = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Capacity")) {
                    result.capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CertificateDetails")) {
                    result.certificate_details = try deserializeCertificateDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CloneGroupId")) {
                    result.clone_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterScalabilityType")) {
                    result.cluster_scalability_type = std.meta.stringToEnum(ClusterScalabilityType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CopyTagsToSnapshot")) {
                    result.copy_tags_to_snapshot = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CrossAccountClone")) {
                    result.cross_account_clone = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CustomEndpoints")) {
                    result.custom_endpoints = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "DatabaseInsightsMode")) {
                    result.database_insights_mode = std.meta.stringToEnum(DatabaseInsightsMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseName")) {
                    result.database_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterArn")) {
                    result.db_cluster_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterInstanceClass")) {
                    result.db_cluster_instance_class = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterMembers")) {
                    result.db_cluster_members = try deserializeDBClusterMemberList(reader, alloc, "DBClusterMember");
                } else if (std.mem.eql(u8, e.local, "DBClusterOptionGroupMemberships")) {
                    result.db_cluster_option_group_memberships = try deserializeDBClusterOptionGroupMemberships(reader, alloc, "DBClusterOptionGroup");
                } else if (std.mem.eql(u8, e.local, "DBClusterParameterGroup")) {
                    result.db_cluster_parameter_group = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbClusterResourceId")) {
                    result.db_cluster_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroup")) {
                    result.db_subnet_group = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSystemId")) {
                    result.db_system_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DomainMemberships")) {
                    result.domain_memberships = try deserializeDomainMembershipList(reader, alloc, "DomainMembership");
                } else if (std.mem.eql(u8, e.local, "EarliestBacktrackTime")) {
                    result.earliest_backtrack_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EarliestRestorableTime")) {
                    result.earliest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EnabledCloudwatchLogsExports")) {
                    result.enabled_cloudwatch_logs_exports = try deserializeLogTypeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineLifecycleSupport")) {
                    result.engine_lifecycle_support = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineMode")) {
                    result.engine_mode = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalClusterIdentifier")) {
                    result.global_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalWriteForwardingRequested")) {
                    result.global_write_forwarding_requested = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "GlobalWriteForwardingStatus")) {
                    result.global_write_forwarding_status = std.meta.stringToEnum(WriteForwardingStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpEndpointEnabled")) {
                    result.http_endpoint_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IOOptimizedNextAllowedModificationTime")) {
                    result.io_optimized_next_allowed_modification_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestRestorableTime")) {
                    result.latest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LimitlessDatabase")) {
                    result.limitless_database = try deserializeLimitlessDatabase(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LocalWriteForwardingStatus")) {
                    result.local_write_forwarding_status = std.meta.stringToEnum(LocalWriteForwardingStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserSecret")) {
                    result.master_user_secret = try deserializeMasterUserSecret(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MonitoringInterval")) {
                    result.monitoring_interval = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MonitoringRoleArn")) {
                    result.monitoring_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "NetworkType")) {
                    result.network_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializeClusterPendingModifiedValues(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsEnabled")) {
                    result.performance_insights_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsKMSKeyId")) {
                    result.performance_insights_kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsRetentionPeriod")) {
                    result.performance_insights_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PreferredBackupWindow")) {
                    result.preferred_backup_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RdsCustomClusterConfiguration")) {
                    result.rds_custom_cluster_configuration = try deserializeRdsCustomClusterConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ReaderEndpoint")) {
                    result.reader_endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReadReplicaIdentifiers")) {
                    result.read_replica_identifiers = try deserializeReadReplicaIdentifierList(reader, alloc, "ReadReplicaIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReplicationSourceIdentifier")) {
                    result.replication_source_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScalingConfigurationInfo")) {
                    result.scaling_configuration_info = try deserializeScalingConfigurationInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ServerlessV2PlatformVersion")) {
                    result.serverless_v2_platform_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessV2ScalingConfiguration")) {
                    result.serverless_v2_scaling_configuration = try deserializeServerlessV2ScalingConfigurationInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusInfos")) {
                    result.status_infos = try deserializeDBClusterStatusInfoList(reader, alloc, "DBClusterStatusInfo");
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "UpgradeRolloutOrder")) {
                    result.upgrade_rollout_order = std.meta.stringToEnum(UpgradeRolloutOrder, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroups")) {
                    result.vpc_security_groups = try deserializeVpcSecurityGroupMembershipList(reader, alloc, "VpcSecurityGroupMembership");
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

pub fn deserializeDBClusterAutomatedBackup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterAutomatedBackup {
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
                    result.availability_zones = try deserializeAvailabilityZones(reader, alloc, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "AwsBackupRecoveryPointArn")) {
                    result.aws_backup_recovery_point_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterArn")) {
                    result.db_cluster_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterAutomatedBackupsArn")) {
                    result.db_cluster_automated_backups_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbClusterResourceId")) {
                    result.db_cluster_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineMode")) {
                    result.engine_mode = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RestoreWindow")) {
                    result.restore_window = try deserializeRestoreWindow(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBClusterBacktrack(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterBacktrack {
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
                    result.backtrack_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BacktrackRequestCreationTime")) {
                    result.backtrack_request_creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "BacktrackTo")) {
                    result.backtrack_to = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBClusterEndpoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterEndpoint {
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
                    result.custom_endpoint_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterEndpointArn")) {
                    result.db_cluster_endpoint_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterEndpointIdentifier")) {
                    result.db_cluster_endpoint_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterEndpointResourceIdentifier")) {
                    result.db_cluster_endpoint_resource_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointType")) {
                    result.endpoint_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExcludedMembers")) {
                    result.excluded_members = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "StaticMembers")) {
                    result.static_members = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBClusterMember(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterMember {
    var result: DBClusterMember = undefined;
    result.db_cluster_parameter_group_status = null;
    result.db_instance_identifier = null;
    result.is_cluster_writer = null;
    result.promotion_tier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterParameterGroupStatus")) {
                    result.db_cluster_parameter_group_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBClusterOptionGroupStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterOptionGroupStatus {
    var result: DBClusterOptionGroupStatus = undefined;
    result.db_cluster_option_group_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterOptionGroupName")) {
                    result.db_cluster_option_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBClusterParameterGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterParameterGroup {
    var result: DBClusterParameterGroup = undefined;
    result.db_cluster_parameter_group_arn = null;
    result.db_cluster_parameter_group_name = null;
    result.db_parameter_group_family = null;
    result.description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterParameterGroupArn")) {
                    result.db_cluster_parameter_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterParameterGroupName")) {
                    result.db_cluster_parameter_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBClusterRole(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterRole {
    var result: DBClusterRole = undefined;
    result.feature_name = null;
    result.role_arn = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FeatureName")) {
                    result.feature_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleArn")) {
                    result.role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBClusterSnapshot(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterSnapshot {
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
                    result.availability_zones = try deserializeAvailabilityZones(reader, alloc, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbClusterResourceId")) {
                    result.db_cluster_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotArn")) {
                    result.db_cluster_snapshot_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotIdentifier")) {
                    result.db_cluster_snapshot_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSystemId")) {
                    result.db_system_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineMode")) {
                    result.engine_mode = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotCreateTime")) {
                    result.snapshot_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotType")) {
                    result.snapshot_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceDBClusterSnapshotArn")) {
                    result.source_db_cluster_snapshot_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBClusterSnapshotAttribute(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterSnapshotAttribute {
    var result: DBClusterSnapshotAttribute = undefined;
    result.attribute_name = null;
    result.attribute_values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AttributeName")) {
                    result.attribute_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeValues")) {
                    result.attribute_values = try deserializeAttributeValueList(reader, alloc, "AttributeValue");
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

pub fn deserializeDBClusterSnapshotAttributesResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterSnapshotAttributesResult {
    var result: DBClusterSnapshotAttributesResult = undefined;
    result.db_cluster_snapshot_attributes = null;
    result.db_cluster_snapshot_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterSnapshotAttributes")) {
                    result.db_cluster_snapshot_attributes = try deserializeDBClusterSnapshotAttributeList(reader, alloc, "DBClusterSnapshotAttribute");
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotIdentifier")) {
                    result.db_cluster_snapshot_identifier = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBClusterStatusInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBClusterStatusInfo {
    var result: DBClusterStatusInfo = undefined;
    result.message = null;
    result.normal = null;
    result.status = null;
    result.status_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Normal")) {
                    result.normal = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusType")) {
                    result.status_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBEngineVersion(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBEngineVersion {
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
                    result.custom_db_engine_version_manifest = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseInstallationFiles")) {
                    result.database_installation_files = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "DatabaseInstallationFilesS3BucketName")) {
                    result.database_installation_files_s3_bucket_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseInstallationFilesS3Prefix")) {
                    result.database_installation_files_s3_prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineDescription")) {
                    result.db_engine_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineMediaType")) {
                    result.db_engine_media_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineVersionArn")) {
                    result.db_engine_version_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineVersionDescription")) {
                    result.db_engine_version_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultCharacterSet")) {
                    result.default_character_set = try deserializeCharacterSet(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExportableLogTypes")) {
                    result.exportable_log_types = try deserializeLogTypeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "FailureReason")) {
                    result.failure_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Image")) {
                    result.image = try deserializeCustomDBEngineVersionAMI(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "KMSKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessV2FeaturesSupport")) {
                    result.serverless_v2_features_support = try deserializeServerlessV2FeaturesSupport(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedCACertificateIdentifiers")) {
                    result.supported_ca_certificate_identifiers = try deserializeCACertificateIdentifiersList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedCharacterSets")) {
                    result.supported_character_sets = try deserializeSupportedCharacterSetsList(reader, alloc, "CharacterSet");
                } else if (std.mem.eql(u8, e.local, "SupportedEngineModes")) {
                    result.supported_engine_modes = try deserializeEngineModeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedFeatureNames")) {
                    result.supported_feature_names = try deserializeFeatureNameList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedNcharCharacterSets")) {
                    result.supported_nchar_character_sets = try deserializeSupportedCharacterSetsList(reader, alloc, "CharacterSet");
                } else if (std.mem.eql(u8, e.local, "SupportedTimezones")) {
                    result.supported_timezones = try deserializeSupportedTimezonesList(reader, alloc, "Timezone");
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
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "ValidUpgradeTarget")) {
                    result.valid_upgrade_target = try deserializeValidUpgradeTargetList(reader, alloc, "UpgradeTarget");
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

pub fn deserializeDBInstance(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBInstance {
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
                    result.activity_stream_kinesis_stream_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamKmsKeyId")) {
                    result.activity_stream_kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamMode")) {
                    result.activity_stream_mode = std.meta.stringToEnum(ActivityStreamMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamPolicyStatus")) {
                    result.activity_stream_policy_status = std.meta.stringToEnum(ActivityStreamPolicyStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActivityStreamStatus")) {
                    result.activity_stream_status = std.meta.stringToEnum(ActivityStreamStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AdditionalStorageVolumes")) {
                    result.additional_storage_volumes = try deserializeAdditionalStorageVolumesOutputList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AssociatedRoles")) {
                    result.associated_roles = try deserializeDBInstanceRoles(reader, alloc, "DBInstanceRole");
                } else if (std.mem.eql(u8, e.local, "AutomaticRestartTime")) {
                    result.automatic_restart_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AutomationMode")) {
                    result.automation_mode = std.meta.stringToEnum(AutomationMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AwsBackupRecoveryPointArn")) {
                    result.aws_backup_recovery_point_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BackupTarget")) {
                    result.backup_target = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CACertificateIdentifier")) {
                    result.ca_certificate_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateDetails")) {
                    result.certificate_details = try deserializeCertificateDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CopyTagsToSnapshot")) {
                    result.copy_tags_to_snapshot = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CustomerOwnedIpEnabled")) {
                    result.customer_owned_ip_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CustomIamInstanceProfile")) {
                    result.custom_iam_instance_profile = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseInsightsMode")) {
                    result.database_insights_mode = std.meta.stringToEnum(DatabaseInsightsMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceArn")) {
                    result.db_instance_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackupsReplications")) {
                    result.db_instance_automated_backups_replications = try deserializeDBInstanceAutomatedBackupsReplicationList(reader, alloc, "DBInstanceAutomatedBackupsReplication");
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbInstancePort")) {
                    result.db_instance_port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DBInstanceStatus")) {
                    result.db_instance_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBName")) {
                    result.db_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroups")) {
                    result.db_parameter_groups = try deserializeDBParameterGroupStatusList(reader, alloc, "DBParameterGroup");
                } else if (std.mem.eql(u8, e.local, "DBSecurityGroups")) {
                    result.db_security_groups = try deserializeDBSecurityGroupMembershipList(reader, alloc, "DBSecurityGroup");
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroup")) {
                    result.db_subnet_group = try deserializeDBSubnetGroup(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DBSystemId")) {
                    result.db_system_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DedicatedLogVolume")) {
                    result.dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DomainMemberships")) {
                    result.domain_memberships = try deserializeDomainMembershipList(reader, alloc, "DomainMembership");
                } else if (std.mem.eql(u8, e.local, "EnabledCloudwatchLogsExports")) {
                    result.enabled_cloudwatch_logs_exports = try deserializeLogTypeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try deserializeEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineLifecycleSupport")) {
                    result.engine_lifecycle_support = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnhancedMonitoringResourceArn")) {
                    result.enhanced_monitoring_resource_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "InstanceCreateTime")) {
                    result.instance_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "IsStorageConfigUpgradeAvailable")) {
                    result.is_storage_config_upgrade_available = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestRestorableTime")) {
                    result.latest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ListenerEndpoint")) {
                    result.listener_endpoint = try deserializeEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserSecret")) {
                    result.master_user_secret = try deserializeMasterUserSecret(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MaxAllocatedStorage")) {
                    result.max_allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MonitoringInterval")) {
                    result.monitoring_interval = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MonitoringRoleArn")) {
                    result.monitoring_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MultiTenant")) {
                    result.multi_tenant = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "NcharCharacterSetName")) {
                    result.nchar_character_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NetworkType")) {
                    result.network_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupMemberships")) {
                    result.option_group_memberships = try deserializeOptionGroupMembershipList(reader, alloc, "OptionGroupMembership");
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializePendingModifiedValues(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsEnabled")) {
                    result.performance_insights_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsKMSKeyId")) {
                    result.performance_insights_kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsRetentionPeriod")) {
                    result.performance_insights_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PreferredBackupWindow")) {
                    result.preferred_backup_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProcessorFeatures")) {
                    result.processor_features = try deserializeProcessorFeatureList(reader, alloc, "ProcessorFeature");
                } else if (std.mem.eql(u8, e.local, "PromotionTier")) {
                    result.promotion_tier = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaDBClusterIdentifiers")) {
                    result.read_replica_db_cluster_identifiers = try deserializeReadReplicaDBClusterIdentifierList(reader, alloc, "ReadReplicaDBClusterIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaDBInstanceIdentifiers")) {
                    result.read_replica_db_instance_identifiers = try deserializeReadReplicaDBInstanceIdentifierList(reader, alloc, "ReadReplicaDBInstanceIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaSourceDBClusterIdentifier")) {
                    result.read_replica_source_db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReadReplicaSourceDBInstanceIdentifier")) {
                    result.read_replica_source_db_instance_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicaMode")) {
                    result.replica_mode = std.meta.stringToEnum(ReplicaMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResumeFullAutomationModeTime")) {
                    result.resume_full_automation_mode_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SecondaryAvailabilityZone")) {
                    result.secondary_availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusInfos")) {
                    result.status_infos = try deserializeDBInstanceStatusInfoList(reader, alloc, "DBInstanceStatusInfo");
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageVolumeStatus")) {
                    result.storage_volume_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "TdeCredentialArn")) {
                    result.tde_credential_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timezone")) {
                    result.timezone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpgradeRolloutOrder")) {
                    result.upgrade_rollout_order = std.meta.stringToEnum(UpgradeRolloutOrder, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroups")) {
                    result.vpc_security_groups = try deserializeVpcSecurityGroupMembershipList(reader, alloc, "VpcSecurityGroupMembership");
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

pub fn deserializeDBInstanceAutomatedBackup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBInstanceAutomatedBackup {
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
                    result.additional_storage_volumes = try deserializeAdditionalStorageVolumesList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AwsBackupRecoveryPointArn")) {
                    result.aws_backup_recovery_point_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BackupTarget")) {
                    result.backup_target = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceArn")) {
                    result.db_instance_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackupsArn")) {
                    result.db_instance_automated_backups_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackupsReplications")) {
                    result.db_instance_automated_backups_replications = try deserializeDBInstanceAutomatedBackupsReplicationList(reader, alloc, "DBInstanceAutomatedBackupsReplication");
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DedicatedLogVolume")) {
                    result.dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "InstanceCreateTime")) {
                    result.instance_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiTenant")) {
                    result.multi_tenant = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OptionGroupName")) {
                    result.option_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RestoreWindow")) {
                    result.restore_window = try deserializeRestoreWindow(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "TdeCredentialArn")) {
                    result.tde_credential_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timezone")) {
                    result.timezone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBInstanceAutomatedBackupsReplication(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBInstanceAutomatedBackupsReplication {
    var result: DBInstanceAutomatedBackupsReplication = undefined;
    result.db_instance_automated_backups_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackupsArn")) {
                    result.db_instance_automated_backups_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBInstanceRole(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBInstanceRole {
    var result: DBInstanceRole = undefined;
    result.feature_name = null;
    result.role_arn = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FeatureName")) {
                    result.feature_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleArn")) {
                    result.role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBInstanceStatusInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBInstanceStatusInfo {
    var result: DBInstanceStatusInfo = undefined;
    result.message = null;
    result.normal = null;
    result.status = null;
    result.status_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Normal")) {
                    result.normal = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusType")) {
                    result.status_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBMajorEngineVersion(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBMajorEngineVersion {
    var result: DBMajorEngineVersion = undefined;
    result.engine = null;
    result.major_engine_version = null;
    result.supported_engine_lifecycles = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedEngineLifecycles")) {
                    result.supported_engine_lifecycles = try deserializeSupportedEngineLifecycleList(reader, alloc, "SupportedEngineLifecycle");
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

pub fn deserializeDBParameterGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBParameterGroup {
    var result: DBParameterGroup = undefined;
    result.db_parameter_group_arn = null;
    result.db_parameter_group_family = null;
    result.db_parameter_group_name = null;
    result.description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBParameterGroupArn")) {
                    result.db_parameter_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupName")) {
                    result.db_parameter_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBParameterGroupStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBParameterGroupStatus {
    var result: DBParameterGroupStatus = undefined;
    result.db_parameter_group_name = null;
    result.parameter_apply_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBParameterGroupName")) {
                    result.db_parameter_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterApplyStatus")) {
                    result.parameter_apply_status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBProxy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBProxy {
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
                    result.auth = try deserializeUserAuthConfigInfoList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "CreatedDate")) {
                    result.created_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBProxyArn")) {
                    result.db_proxy_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBProxyName")) {
                    result.db_proxy_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DebugLogging")) {
                    result.debug_logging = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DefaultAuthScheme")) {
                    result.default_auth_scheme = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointNetworkType")) {
                    result.endpoint_network_type = std.meta.stringToEnum(EndpointNetworkType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineFamily")) {
                    result.engine_family = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdleClientTimeout")) {
                    result.idle_client_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RequireTLS")) {
                    result.require_tls = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RoleArn")) {
                    result.role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(DBProxyStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetConnectionNetworkType")) {
                    result.target_connection_network_type = std.meta.stringToEnum(TargetConnectionNetworkType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdatedDate")) {
                    result.updated_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroupIds")) {
                    result.vpc_security_group_ids = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "VpcSubnetIds")) {
                    result.vpc_subnet_ids = try deserializeStringList(reader, alloc, "member");
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

pub fn deserializeDBProxyEndpoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBProxyEndpoint {
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
                    result.db_proxy_endpoint_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBProxyEndpointName")) {
                    result.db_proxy_endpoint_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBProxyName")) {
                    result.db_proxy_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointNetworkType")) {
                    result.endpoint_network_type = std.meta.stringToEnum(EndpointNetworkType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(DBProxyEndpointStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetRole")) {
                    result.target_role = std.meta.stringToEnum(DBProxyEndpointTargetRole, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroupIds")) {
                    result.vpc_security_group_ids = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "VpcSubnetIds")) {
                    result.vpc_subnet_ids = try deserializeStringList(reader, alloc, "member");
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

pub fn deserializeDBProxyTarget(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBProxyTarget {
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
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RdsResourceId")) {
                    result.rds_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Role")) {
                    result.role = std.meta.stringToEnum(TargetRole, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetArn")) {
                    result.target_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetHealth")) {
                    result.target_health = try deserializeTargetHealth(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TrackedClusterId")) {
                    result.tracked_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(TargetType, try reader.readElementText());
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

pub fn deserializeDBProxyTargetGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBProxyTargetGroup {
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
                    result.connection_pool_config = try deserializeConnectionPoolConfigurationInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CreatedDate")) {
                    result.created_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBProxyName")) {
                    result.db_proxy_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetGroupArn")) {
                    result.target_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetGroupName")) {
                    result.target_group_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBRecommendation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBRecommendation {
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
                    result.additional_info = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Category")) {
                    result.category = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Detection")) {
                    result.detection = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Impact")) {
                    result.impact = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IssueDetails")) {
                    result.issue_details = try deserializeIssueDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Links")) {
                    result.links = try deserializeDocLinkList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Recommendation")) {
                    result.recommendation = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecommendationId")) {
                    result.recommendation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecommendedActions")) {
                    result.recommended_actions = try deserializeRecommendedActionList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceArn")) {
                    result.resource_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Severity")) {
                    result.severity = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Source")) {
                    result.source = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeDetection")) {
                    result.type_detection = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeId")) {
                    result.type_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeRecommendation")) {
                    result.type_recommendation = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBSecurityGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBSecurityGroup {
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
                    result.db_security_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSecurityGroupDescription")) {
                    result.db_security_group_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSecurityGroupName")) {
                    result.db_security_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroups")) {
                    result.ec2_security_groups = try deserializeEC2SecurityGroupList(reader, alloc, "EC2SecurityGroup");
                } else if (std.mem.eql(u8, e.local, "IPRanges")) {
                    result.ip_ranges = try deserializeIPRangeList(reader, alloc, "IPRange");
                } else if (std.mem.eql(u8, e.local, "OwnerId")) {
                    result.owner_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBSecurityGroupMembership(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBSecurityGroupMembership {
    var result: DBSecurityGroupMembership = undefined;
    result.db_security_group_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSecurityGroupName")) {
                    result.db_security_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBShardGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBShardGroup {
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
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBShardGroupArn")) {
                    result.db_shard_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBShardGroupIdentifier")) {
                    result.db_shard_group_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBShardGroupResourceId")) {
                    result.db_shard_group_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxACU")) {
                    result.max_acu = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinACU")) {
                    result.min_acu = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
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

pub fn deserializeDBSnapshot(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBSnapshot {
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
                    result.additional_storage_volumes = try deserializeAdditionalStorageVolumesList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSnapshotArn")) {
                    result.db_snapshot_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSnapshotIdentifier")) {
                    result.db_snapshot_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSystemId")) {
                    result.db_system_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DedicatedLogVolume")) {
                    result.dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "InstanceCreateTime")) {
                    result.instance_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiTenant")) {
                    result.multi_tenant = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OptionGroupName")) {
                    result.option_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginalSnapshotCreateTime")) {
                    result.original_snapshot_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProcessorFeatures")) {
                    result.processor_features = try deserializeProcessorFeatureList(reader, alloc, "ProcessorFeature");
                } else if (std.mem.eql(u8, e.local, "SnapshotAvailabilityZone")) {
                    result.snapshot_availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotCreateTime")) {
                    result.snapshot_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotDatabaseTime")) {
                    result.snapshot_database_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotTarget")) {
                    result.snapshot_target = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotType")) {
                    result.snapshot_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceDBSnapshotIdentifier")) {
                    result.source_db_snapshot_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceRegion")) {
                    result.source_region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "TdeCredentialArn")) {
                    result.tde_credential_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timezone")) {
                    result.timezone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBSnapshotAttribute(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBSnapshotAttribute {
    var result: DBSnapshotAttribute = undefined;
    result.attribute_name = null;
    result.attribute_values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AttributeName")) {
                    result.attribute_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeValues")) {
                    result.attribute_values = try deserializeAttributeValueList(reader, alloc, "AttributeValue");
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

pub fn deserializeDBSnapshotAttributesResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBSnapshotAttributesResult {
    var result: DBSnapshotAttributesResult = undefined;
    result.db_snapshot_attributes = null;
    result.db_snapshot_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSnapshotAttributes")) {
                    result.db_snapshot_attributes = try deserializeDBSnapshotAttributeList(reader, alloc, "DBSnapshotAttribute");
                } else if (std.mem.eql(u8, e.local, "DBSnapshotIdentifier")) {
                    result.db_snapshot_identifier = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBSnapshotTenantDatabase(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBSnapshotTenantDatabase {
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
                    result.character_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSnapshotIdentifier")) {
                    result.db_snapshot_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSnapshotTenantDatabaseARN")) {
                    result.db_snapshot_tenant_database_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineName")) {
                    result.engine_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NcharCharacterSetName")) {
                    result.nchar_character_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotType")) {
                    result.snapshot_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseCreateTime")) {
                    result.tenant_database_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseResourceId")) {
                    result.tenant_database_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TenantDBName")) {
                    result.tenant_db_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBSubnetGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBSubnetGroup {
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
                    result.db_subnet_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroupDescription")) {
                    result.db_subnet_group_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroupName")) {
                    result.db_subnet_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetGroupStatus")) {
                    result.subnet_group_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Subnets")) {
                    result.subnets = try deserializeSubnetList(reader, alloc, "Subnet");
                } else if (std.mem.eql(u8, e.local, "SupportedNetworkTypes")) {
                    result.supported_network_types = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDescribeDBLogFilesDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DescribeDBLogFilesDetails {
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
                    result.log_file_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDocLink(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DocLink {
    var result: DocLink = undefined;
    result.text = null;
    result.url = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Text")) {
                    result.text = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Url")) {
                    result.url = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDomainMembership(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DomainMembership {
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
                    result.auth_secret_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DnsIps")) {
                    result.dns_ips = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FQDN")) {
                    result.fqdn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMRoleName")) {
                    result.iam_role_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OU")) {
                    result.ou = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDoubleRange(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DoubleRange {
    _ = alloc;
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

pub fn deserializeEC2SecurityGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EC2SecurityGroup {
    var result: EC2SecurityGroup = undefined;
    result.ec2_security_group_id = null;
    result.ec2_security_group_name = null;
    result.ec2_security_group_owner_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EC2SecurityGroupId")) {
                    result.ec2_security_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroupName")) {
                    result.ec2_security_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroupOwnerId")) {
                    result.ec2_security_group_owner_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeEndpoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Endpoint {
    var result: Endpoint = undefined;
    result.address = null;
    result.hosted_zone_id = null;
    result.port = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Address")) {
                    result.address = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeEngineDefaults(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EngineDefaults {
    var result: EngineDefaults = undefined;
    result.db_parameter_group_family = null;
    result.marker = null;
    result.parameters = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeParametersList(reader, alloc, "Parameter");
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

pub fn deserializeEvent(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Event {
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
                    result.event_categories = try deserializeEventCategoriesList(reader, alloc, "EventCategory");
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceArn")) {
                    result.source_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceIdentifier")) {
                    result.source_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = std.meta.stringToEnum(SourceType, try reader.readElementText());
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

pub fn deserializeEventCategoriesMap(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EventCategoriesMap {
    var result: EventCategoriesMap = undefined;
    result.event_categories = null;
    result.source_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventCategories")) {
                    result.event_categories = try deserializeEventCategoriesList(reader, alloc, "EventCategory");
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeEventSubscription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EventSubscription {
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
                    result.customer_aws_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustSubscriptionId")) {
                    result.cust_subscription_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EventCategoriesList")) {
                    result.event_categories_list = try deserializeEventCategoriesList(reader, alloc, "EventCategory");
                } else if (std.mem.eql(u8, e.local, "EventSubscriptionArn")) {
                    result.event_subscription_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnsTopicArn")) {
                    result.sns_topic_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceIdsList")) {
                    result.source_ids_list = try deserializeSourceIdsList(reader, alloc, "SourceId");
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubscriptionCreationTime")) {
                    result.subscription_creation_time = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeExportTask(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ExportTask {
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
                    result.export_only = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ExportTaskIdentifier")) {
                    result.export_task_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureCause")) {
                    result.failure_cause = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IamRoleArn")) {
                    result.iam_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "S3Bucket")) {
                    result.s3_bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3Prefix")) {
                    result.s3_prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotTime")) {
                    result.snapshot_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SourceArn")) {
                    result.source_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = std.meta.stringToEnum(ExportSourceType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TaskEndTime")) {
                    result.task_end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TaskStartTime")) {
                    result.task_start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TotalExtractedDataInGB")) {
                    result.total_extracted_data_in_gb = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "WarningMessage")) {
                    result.warning_message = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeFailoverState(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FailoverState {
    var result: FailoverState = undefined;
    result.from_db_cluster_arn = null;
    result.is_data_loss_allowed = null;
    result.status = null;
    result.to_db_cluster_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FromDbClusterArn")) {
                    result.from_db_cluster_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDataLossAllowed")) {
                    result.is_data_loss_allowed = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(FailoverStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ToDbClusterArn")) {
                    result.to_db_cluster_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeGlobalCluster(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GlobalCluster {
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
                    result.database_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineLifecycleSupport")) {
                    result.engine_lifecycle_support = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailoverState")) {
                    result.failover_state = try deserializeFailoverState(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "GlobalClusterArn")) {
                    result.global_cluster_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalClusterIdentifier")) {
                    result.global_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalClusterMembers")) {
                    result.global_cluster_members = try deserializeGlobalClusterMemberList(reader, alloc, "GlobalClusterMember");
                } else if (std.mem.eql(u8, e.local, "GlobalClusterResourceId")) {
                    result.global_cluster_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
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

pub fn deserializeGlobalClusterMember(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GlobalClusterMember {
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
                    result.db_cluster_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalWriteForwardingStatus")) {
                    result.global_write_forwarding_status = std.meta.stringToEnum(WriteForwardingStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsWriter")) {
                    result.is_writer = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Readers")) {
                    result.readers = try deserializeReadersArnList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SynchronizationStatus")) {
                    result.synchronization_status = std.meta.stringToEnum(GlobalClusterMemberSynchronizationStatus, try reader.readElementText());
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

pub fn deserializeIPRange(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IPRange {
    var result: IPRange = undefined;
    result.cidrip = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CIDRIP")) {
                    result.cidrip = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeIntegration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Integration {
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
                    result.additional_encryption_context = try deserializeEncryptionContextMap(reader, alloc, "entry");
                } else if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DataFilter")) {
                    result.data_filter = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Errors")) {
                    result.errors = try deserializeIntegrationErrorList(reader, alloc, "IntegrationError");
                } else if (std.mem.eql(u8, e.local, "IntegrationArn")) {
                    result.integration_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IntegrationName")) {
                    result.integration_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KMSKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceArn")) {
                    result.source_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(IntegrationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "TargetArn")) {
                    result.target_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeIntegrationError(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IntegrationError {
    var result: IntegrationError = undefined;
    result.error_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeIssueDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IssueDetails {
    var result: IssueDetails = undefined;
    result.performance_issue_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PerformanceIssueDetails")) {
                    result.performance_issue_details = try deserializePerformanceIssueDetails(reader, alloc);
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

pub fn deserializeLimitlessDatabase(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LimitlessDatabase {
    _ = alloc;
    var result: LimitlessDatabase = undefined;
    result.min_required_acu = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MinRequiredACU")) {
                    result.min_required_acu = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(LimitlessDatabaseStatus, try reader.readElementText());
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

pub fn deserializeMasterUserSecret(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MasterUserSecret {
    var result: MasterUserSecret = undefined;
    result.kms_key_id = null;
    result.secret_arn = null;
    result.secret_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretArn")) {
                    result.secret_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretStatus")) {
                    result.secret_status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Metric {
    var result: Metric = undefined;
    result.metric_query = null;
    result.name = null;
    result.references = null;
    result.statistics_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricQuery")) {
                    result.metric_query = try deserializeMetricQuery(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "References")) {
                    result.references = try deserializeMetricReferenceList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "StatisticsDetails")) {
                    result.statistics_details = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeMetricQuery(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricQuery {
    var result: MetricQuery = undefined;
    result.performance_insights_metric_query = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PerformanceInsightsMetricQuery")) {
                    result.performance_insights_metric_query = try deserializePerformanceInsightsMetricQuery(reader, alloc);
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

pub fn deserializeMetricReference(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricReference {
    var result: MetricReference = undefined;
    result.name = null;
    result.reference_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReferenceDetails")) {
                    result.reference_details = try deserializeReferenceDetails(reader, alloc);
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

pub fn deserializeMinimumEngineVersionPerAllowedValue(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MinimumEngineVersionPerAllowedValue {
    var result: MinimumEngineVersionPerAllowedValue = undefined;
    result.allowed_value = null;
    result.minimum_engine_version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValue")) {
                    result.allowed_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOption(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Option {
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
                    result.db_security_group_memberships = try deserializeDBSecurityGroupMembershipList(reader, alloc, "DBSecurityGroup");
                } else if (std.mem.eql(u8, e.local, "OptionDescription")) {
                    result.option_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionName")) {
                    result.option_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionSettings")) {
                    result.option_settings = try deserializeOptionSettingConfigurationList(reader, alloc, "OptionSetting");
                } else if (std.mem.eql(u8, e.local, "OptionVersion")) {
                    result.option_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Permanent")) {
                    result.permanent = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Persistent")) {
                    result.persistent = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroupMemberships")) {
                    result.vpc_security_group_memberships = try deserializeVpcSecurityGroupMembershipList(reader, alloc, "VpcSecurityGroupMembership");
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

pub fn deserializeOptionGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OptionGroup {
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
                    result.engine_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupArn")) {
                    result.option_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupDescription")) {
                    result.option_group_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupName")) {
                    result.option_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeOptionsList(reader, alloc, "Option");
                } else if (std.mem.eql(u8, e.local, "SourceAccountId")) {
                    result.source_account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceOptionGroup")) {
                    result.source_option_group = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOptionGroupMembership(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OptionGroupMembership {
    var result: OptionGroupMembership = undefined;
    result.option_group_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OptionGroupName")) {
                    result.option_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOptionGroupOption(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OptionGroupOption {
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
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineName")) {
                    result.engine_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumRequiredMinorEngineVersion")) {
                    result.minimum_required_minor_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionGroupOptionSettings")) {
                    result.option_group_option_settings = try deserializeOptionGroupOptionSettingsList(reader, alloc, "OptionGroupOptionSetting");
                } else if (std.mem.eql(u8, e.local, "OptionGroupOptionVersions")) {
                    result.option_group_option_versions = try deserializeOptionGroupOptionVersionsList(reader, alloc, "OptionVersion");
                } else if (std.mem.eql(u8, e.local, "OptionsConflictsWith")) {
                    result.options_conflicts_with = try deserializeOptionsConflictsWith(reader, alloc, "OptionConflictName");
                } else if (std.mem.eql(u8, e.local, "OptionsDependedOn")) {
                    result.options_depended_on = try deserializeOptionsDependedOn(reader, alloc, "OptionName");
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

pub fn deserializeOptionGroupOptionSetting(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OptionGroupOptionSetting {
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
                    result.allowed_values = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyType")) {
                    result.apply_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsModifiable")) {
                    result.is_modifiable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IsRequired")) {
                    result.is_required = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersionPerAllowedValue")) {
                    result.minimum_engine_version_per_allowed_value = try deserializeMinimumEngineVersionPerAllowedValueList(reader, alloc, "MinimumEngineVersionPerAllowedValue");
                } else if (std.mem.eql(u8, e.local, "SettingDescription")) {
                    result.setting_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SettingName")) {
                    result.setting_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOptionSetting(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OptionSetting {
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
                    result.allowed_values = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyType")) {
                    result.apply_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataType")) {
                    result.data_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsCollection")) {
                    result.is_collection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IsModifiable")) {
                    result.is_modifiable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOptionVersion(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OptionVersion {
    var result: OptionVersion = undefined;
    result.is_default = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Version")) {
                    result.version = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOrderableDBInstanceOption(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OrderableDBInstanceOption {
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
                    result.availability_zone_group = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZoneList(reader, alloc, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "AvailableAdditionalStorageVolumesOptions")) {
                    result.available_additional_storage_volumes_options = try deserializeAvailableAdditionalStorageVolumesOptionList(reader, alloc, "AvailableAdditionalStorageVolumesOption");
                } else if (std.mem.eql(u8, e.local, "AvailableProcessorFeatures")) {
                    result.available_processor_features = try deserializeAvailableProcessorFeatureList(reader, alloc, "AvailableProcessorFeature");
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try alloc.dupe(u8, try reader.readElementText());
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
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedActivityStreamModes")) {
                    result.supported_activity_stream_modes = try deserializeActivityStreamModeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedEngineModes")) {
                    result.supported_engine_modes = try deserializeEngineModeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedNetworkTypes")) {
                    result.supported_network_types = try deserializeStringList(reader, alloc, "member");
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

pub fn deserializeOutpost(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Outpost {
    var result: Outpost = undefined;
    result.arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeParameter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Parameter {
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
                    result.allowed_values = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyMethod")) {
                    result.apply_method = std.meta.stringToEnum(ApplyMethod, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyType")) {
                    result.apply_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataType")) {
                    result.data_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsModifiable")) {
                    result.is_modifiable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterName")) {
                    result.parameter_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterValue")) {
                    result.parameter_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Source")) {
                    result.source = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedEngineModes")) {
                    result.supported_engine_modes = try deserializeEngineModeList(reader, alloc, "member");
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

pub fn deserializePendingCloudwatchLogsExports(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PendingCloudwatchLogsExports {
    var result: PendingCloudwatchLogsExports = undefined;
    result.log_types_to_disable = null;
    result.log_types_to_enable = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogTypesToDisable")) {
                    result.log_types_to_disable = try deserializeLogTypeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LogTypesToEnable")) {
                    result.log_types_to_enable = try deserializeLogTypeList(reader, alloc, "member");
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

pub fn deserializePendingMaintenanceAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PendingMaintenanceAction {
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
                    result.action = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoAppliedAfterDate")) {
                    result.auto_applied_after_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CurrentApplyDate")) {
                    result.current_apply_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ForcedApplyDate")) {
                    result.forced_apply_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "OptInStatus")) {
                    result.opt_in_status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePendingModifiedValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PendingModifiedValues {
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
                    result.additional_storage_volumes = try deserializeAdditionalStorageVolumesList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AutomationMode")) {
                    result.automation_mode = std.meta.stringToEnum(AutomationMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CACertificateIdentifier")) {
                    result.ca_certificate_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroupName")) {
                    result.db_subnet_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DedicatedLogVolume")) {
                    result.dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserPassword")) {
                    result.master_user_password = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MultiTenant")) {
                    result.multi_tenant = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PendingCloudwatchLogsExports")) {
                    result.pending_cloudwatch_logs_exports = try deserializePendingCloudwatchLogsExports(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProcessorFeatures")) {
                    result.processor_features = try deserializeProcessorFeatureList(reader, alloc, "ProcessorFeature");
                } else if (std.mem.eql(u8, e.local, "ResumeFullAutomationModeTime")) {
                    result.resume_full_automation_mode_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageThroughput")) {
                    result.storage_throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePerformanceInsightsMetricDimensionGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PerformanceInsightsMetricDimensionGroup {
    var result: PerformanceInsightsMetricDimensionGroup = undefined;
    result.dimensions = null;
    result.group = null;
    result.limit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Group")) {
                    result.group = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePerformanceInsightsMetricQuery(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PerformanceInsightsMetricQuery {
    var result: PerformanceInsightsMetricQuery = undefined;
    result.group_by = null;
    result.metric = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GroupBy")) {
                    result.group_by = try deserializePerformanceInsightsMetricDimensionGroup(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Metric")) {
                    result.metric = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePerformanceIssueDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PerformanceIssueDetails {
    var result: PerformanceIssueDetails = undefined;
    result.analysis = null;
    result.end_time = null;
    result.metrics = null;
    result.start_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Analysis")) {
                    result.analysis = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try deserializeMetricList(reader, alloc, "member");
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

pub fn deserializeProcessorFeature(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ProcessorFeature {
    var result: ProcessorFeature = undefined;
    result.name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRange(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Range {
    _ = alloc;
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

pub fn deserializeRdsCustomClusterConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RdsCustomClusterConfiguration {
    var result: RdsCustomClusterConfiguration = undefined;
    result.interconnect_subnet_id = null;
    result.replica_mode = null;
    result.transit_gateway_multicast_domain_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InterconnectSubnetId")) {
                    result.interconnect_subnet_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicaMode")) {
                    result.replica_mode = std.meta.stringToEnum(ReplicaMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TransitGatewayMulticastDomainId")) {
                    result.transit_gateway_multicast_domain_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRecommendedAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RecommendedAction {
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
                    result.action_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplyModes")) {
                    result.apply_modes = try deserializeStringList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ContextAttributes")) {
                    result.context_attributes = try deserializeContextAttributeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IssueDetails")) {
                    result.issue_details = try deserializeIssueDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Operation")) {
                    result.operation = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeRecommendedActionParameterList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Title")) {
                    result.title = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRecommendedActionParameter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RecommendedActionParameter {
    var result: RecommendedActionParameter = undefined;
    result.key = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRecurringCharge(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RecurringCharge {
    var result: RecurringCharge = undefined;
    result.recurring_charge_amount = null;
    result.recurring_charge_frequency = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RecurringChargeAmount")) {
                    result.recurring_charge_amount = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "RecurringChargeFrequency")) {
                    result.recurring_charge_frequency = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeReferenceDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReferenceDetails {
    var result: ReferenceDetails = undefined;
    result.scalar_reference_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ScalarReferenceDetails")) {
                    result.scalar_reference_details = try deserializeScalarReferenceDetails(reader, alloc);
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

pub fn deserializeReservedDBInstance(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReservedDBInstance {
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
                    result.currency_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceCount")) {
                    result.db_instance_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LeaseId")) {
                    result.lease_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProductDescription")) {
                    result.product_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(reader, alloc, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstanceArn")) {
                    result.reserved_db_instance_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstanceId")) {
                    result.reserved_db_instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstancesOfferingId")) {
                    result.reserved_db_instances_offering_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeReservedDBInstancesOffering(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReservedDBInstancesOffering {
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
                    result.currency_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProductDescription")) {
                    result.product_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(reader, alloc, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstancesOfferingId")) {
                    result.reserved_db_instances_offering_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourcePendingMaintenanceActions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourcePendingMaintenanceActions {
    var result: ResourcePendingMaintenanceActions = undefined;
    result.pending_maintenance_action_details = null;
    result.resource_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PendingMaintenanceActionDetails")) {
                    result.pending_maintenance_action_details = try deserializePendingMaintenanceActionDetails(reader, alloc, "PendingMaintenanceAction");
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifier")) {
                    result.resource_identifier = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRestoreWindow(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RestoreWindow {
    _ = alloc;
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

pub fn deserializeScalarReferenceDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ScalarReferenceDetails {
    _ = alloc;
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

pub fn deserializeScalingConfigurationInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ScalingConfigurationInfo {
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
                    result.timeout_action = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeServerlessV2FeaturesSupport(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerlessV2FeaturesSupport {
    _ = alloc;
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

pub fn deserializeServerlessV2ScalingConfigurationInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerlessV2ScalingConfigurationInfo {
    _ = alloc;
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

pub fn deserializeSourceRegion(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SourceRegion {
    var result: SourceRegion = undefined;
    result.endpoint = null;
    result.region_name = null;
    result.status = null;
    result.supports_db_instance_automated_backups_replication = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RegionName")) {
                    result.region_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSubnet(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Subnet {
    var result: Subnet = undefined;
    result.subnet_availability_zone = null;
    result.subnet_identifier = null;
    result.subnet_outpost = null;
    result.subnet_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubnetAvailabilityZone")) {
                    result.subnet_availability_zone = try deserializeAvailabilityZone(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SubnetIdentifier")) {
                    result.subnet_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetOutpost")) {
                    result.subnet_outpost = try deserializeOutpost(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SubnetStatus")) {
                    result.subnet_status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSupportedEngineLifecycle(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SupportedEngineLifecycle {
    _ = alloc;
    var result: SupportedEngineLifecycle = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LifecycleSupportEndDate")) {
                    result.lifecycle_support_end_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LifecycleSupportName")) {
                    result.lifecycle_support_name = std.meta.stringToEnum(LifecycleSupportName, try reader.readElementText());
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

pub fn deserializeSwitchoverDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SwitchoverDetail {
    var result: SwitchoverDetail = undefined;
    result.source_member = null;
    result.status = null;
    result.target_member = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SourceMember")) {
                    result.source_member = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetMember")) {
                    result.target_member = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTag(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Tag {
    var result: Tag = undefined;
    result.key = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTargetHealth(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetHealth {
    var result: TargetHealth = undefined;
    result.description = null;
    result.reason = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = std.meta.stringToEnum(TargetHealthReason, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = std.meta.stringToEnum(TargetState, try reader.readElementText());
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

pub fn deserializeTenantDatabase(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TenantDatabase {
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
                    result.character_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserSecret")) {
                    result.master_user_secret = try deserializeMasterUserSecret(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "NcharCharacterSetName")) {
                    result.nchar_character_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializeTenantDatabasePendingModifiedValues(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try deserializeTagList(reader, alloc, "Tag");
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseARN")) {
                    result.tenant_database_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseCreateTime")) {
                    result.tenant_database_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TenantDatabaseResourceId")) {
                    result.tenant_database_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TenantDBName")) {
                    result.tenant_db_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTenantDatabasePendingModifiedValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TenantDatabasePendingModifiedValues {
    var result: TenantDatabasePendingModifiedValues = undefined;
    result.master_user_password = null;
    result.tenant_db_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MasterUserPassword")) {
                    result.master_user_password = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TenantDBName")) {
                    result.tenant_db_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTimezone(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Timezone {
    var result: Timezone = undefined;
    result.timezone_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TimezoneName")) {
                    result.timezone_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeUpgradeTarget(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !UpgradeTarget {
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
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsMajorVersionUpgrade")) {
                    result.is_major_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportedEngineModes")) {
                    result.supported_engine_modes = try deserializeEngineModeList(reader, alloc, "member");
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

pub fn deserializeUserAuthConfigInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !UserAuthConfigInfo {
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
                    result.auth_scheme = std.meta.stringToEnum(AuthScheme, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClientPasswordAuthType")) {
                    result.client_password_auth_type = std.meta.stringToEnum(ClientPasswordAuthType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMAuth")) {
                    result.iam_auth = std.meta.stringToEnum(IAMAuthMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecretArn")) {
                    result.secret_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeValidAdditionalStorageOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ValidAdditionalStorageOptions {
    var result: ValidAdditionalStorageOptions = undefined;
    result.supports_additional_storage_volumes = null;
    result.volumes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SupportsAdditionalStorageVolumes")) {
                    result.supports_additional_storage_volumes = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Volumes")) {
                    result.volumes = try deserializeValidVolumeOptionsList(reader, alloc, "member");
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

pub fn deserializeValidDBInstanceModificationsMessage(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ValidDBInstanceModificationsMessage {
    var result: ValidDBInstanceModificationsMessage = undefined;
    result.additional_storage = null;
    result.storage = null;
    result.supports_dedicated_log_volume = null;
    result.valid_processor_features = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalStorage")) {
                    result.additional_storage = try deserializeValidAdditionalStorageOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Storage")) {
                    result.storage = try deserializeValidStorageOptionsList(reader, alloc, "ValidStorageOptions");
                } else if (std.mem.eql(u8, e.local, "SupportsDedicatedLogVolume")) {
                    result.supports_dedicated_log_volume = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ValidProcessorFeatures")) {
                    result.valid_processor_features = try deserializeAvailableProcessorFeatureList(reader, alloc, "AvailableProcessorFeature");
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

pub fn deserializeValidStorageOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ValidStorageOptions {
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
                    result.iops_to_storage_ratio = try deserializeDoubleRangeList(reader, alloc, "DoubleRange");
                } else if (std.mem.eql(u8, e.local, "ProvisionedIops")) {
                    result.provisioned_iops = try deserializeRangeList(reader, alloc, "Range");
                } else if (std.mem.eql(u8, e.local, "ProvisionedStorageThroughput")) {
                    result.provisioned_storage_throughput = try deserializeRangeList(reader, alloc, "Range");
                } else if (std.mem.eql(u8, e.local, "StorageSize")) {
                    result.storage_size = try deserializeRangeList(reader, alloc, "Range");
                } else if (std.mem.eql(u8, e.local, "StorageThroughputToIopsRatio")) {
                    result.storage_throughput_to_iops_ratio = try deserializeDoubleRangeList(reader, alloc, "DoubleRange");
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeValidVolumeOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ValidVolumeOptions {
    var result: ValidVolumeOptions = undefined;
    result.storage = null;
    result.volume_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Storage")) {
                    result.storage = try deserializeValidStorageOptionsList(reader, alloc, "ValidStorageOptions");
                } else if (std.mem.eql(u8, e.local, "VolumeName")) {
                    result.volume_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeVpcSecurityGroupMembership(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VpcSecurityGroupMembership {
    var result: VpcSecurityGroupMembership = undefined;
    result.status = null;
    result.vpc_security_group_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroupId")) {
                    result.vpc_security_group_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn serializeAdditionalStorageVolumesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AdditionalStorageVolume, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeAdditionalStorageVolume(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAttributeValueList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAvailabilityZones(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeDBSecurityGroupNameList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEngineModeList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEventCategoriesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeFilterList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Filter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeFilter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeFilterValueList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeKeyList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeLogTypeList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeModifyAdditionalStorageVolumesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ModifyAdditionalStorageVolume, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeModifyAdditionalStorageVolume(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeOptionConfigurationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OptionConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeOptionConfiguration(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeOptionNamesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeOptionSettingsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OptionSetting, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeOptionSetting(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeParametersList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Parameter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeParameter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeProcessorFeatureList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ProcessorFeature, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeProcessorFeature(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRecommendedActionUpdateList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RecommendedActionUpdate, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRecommendedActionUpdate(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeSourceIdsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStringList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeSubnetIdentifierList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTag(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagSpecificationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TagSpecification, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTagSpecification(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeUserAuthConfigList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const UserAuthConfig, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeUserAuthConfig(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeVpcSecurityGroupIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEncryptionContextMap(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, "<key>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.key);
        try buf.appendSlice(alloc, "</key>");
        try buf.appendSlice(alloc, "<value>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.value);
        try buf.appendSlice(alloc, "</value>");
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAdditionalStorageVolume(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AdditionalStorageVolume) !void {
    if (value.allocated_storage) |v| {
        try buf.appendSlice(alloc, "<AllocatedStorage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</AllocatedStorage>");
    }
    if (value.iops) |v| {
        try buf.appendSlice(alloc, "<IOPS>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</IOPS>");
    }
    if (value.max_allocated_storage) |v| {
        try buf.appendSlice(alloc, "<MaxAllocatedStorage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxAllocatedStorage>");
    }
    if (value.storage_throughput) |v| {
        try buf.appendSlice(alloc, "<StorageThroughput>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</StorageThroughput>");
    }
    if (value.storage_type) |v| {
        try buf.appendSlice(alloc, "<StorageType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</StorageType>");
    }
    try buf.appendSlice(alloc, "<VolumeName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.volume_name);
    try buf.appendSlice(alloc, "</VolumeName>");
}

pub fn serializeCloudwatchLogsExportConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudwatchLogsExportConfiguration) !void {
    if (value.disable_log_types) |v| {
        try buf.appendSlice(alloc, "<DisableLogTypes>");
        try serializeLogTypeList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</DisableLogTypes>");
    }
    if (value.enable_log_types) |v| {
        try buf.appendSlice(alloc, "<EnableLogTypes>");
        try serializeLogTypeList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</EnableLogTypes>");
    }
}

pub fn serializeConnectionPoolConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionPoolConfiguration) !void {
    if (value.connection_borrow_timeout) |v| {
        try buf.appendSlice(alloc, "<ConnectionBorrowTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ConnectionBorrowTimeout>");
    }
    if (value.init_query) |v| {
        try buf.appendSlice(alloc, "<InitQuery>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</InitQuery>");
    }
    if (value.max_connections_percent) |v| {
        try buf.appendSlice(alloc, "<MaxConnectionsPercent>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxConnectionsPercent>");
    }
    if (value.max_idle_connections_percent) |v| {
        try buf.appendSlice(alloc, "<MaxIdleConnectionsPercent>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxIdleConnectionsPercent>");
    }
    if (value.session_pinning_filters) |v| {
        try buf.appendSlice(alloc, "<SessionPinningFilters>");
        try serializeStringList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</SessionPinningFilters>");
    }
}

pub fn serializeFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Filter) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Values>");
    try serializeFilterValueList(alloc, buf, value.values, "Value");
    try buf.appendSlice(alloc, "</Values>");
}

pub fn serializeModifyAdditionalStorageVolume(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ModifyAdditionalStorageVolume) !void {
    if (value.allocated_storage) |v| {
        try buf.appendSlice(alloc, "<AllocatedStorage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</AllocatedStorage>");
    }
    if (value.iops) |v| {
        try buf.appendSlice(alloc, "<IOPS>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</IOPS>");
    }
    if (value.max_allocated_storage) |v| {
        try buf.appendSlice(alloc, "<MaxAllocatedStorage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxAllocatedStorage>");
    }
    if (value.set_for_delete) |v| {
        try buf.appendSlice(alloc, "<SetForDelete>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SetForDelete>");
    }
    if (value.storage_throughput) |v| {
        try buf.appendSlice(alloc, "<StorageThroughput>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</StorageThroughput>");
    }
    if (value.storage_type) |v| {
        try buf.appendSlice(alloc, "<StorageType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</StorageType>");
    }
    try buf.appendSlice(alloc, "<VolumeName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.volume_name);
    try buf.appendSlice(alloc, "</VolumeName>");
}

pub fn serializeOptionConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OptionConfiguration) !void {
    if (value.db_security_group_memberships) |v| {
        try buf.appendSlice(alloc, "<DBSecurityGroupMemberships>");
        try serializeDBSecurityGroupNameList(alloc, buf, v, "DBSecurityGroupName");
        try buf.appendSlice(alloc, "</DBSecurityGroupMemberships>");
    }
    try buf.appendSlice(alloc, "<OptionName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.option_name);
    try buf.appendSlice(alloc, "</OptionName>");
    if (value.option_settings) |v| {
        try buf.appendSlice(alloc, "<OptionSettings>");
        try serializeOptionSettingsList(alloc, buf, v, "OptionSetting");
        try buf.appendSlice(alloc, "</OptionSettings>");
    }
    if (value.option_version) |v| {
        try buf.appendSlice(alloc, "<OptionVersion>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OptionVersion>");
    }
    if (value.port) |v| {
        try buf.appendSlice(alloc, "<Port>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Port>");
    }
    if (value.vpc_security_group_memberships) |v| {
        try buf.appendSlice(alloc, "<VpcSecurityGroupMemberships>");
        try serializeVpcSecurityGroupIdList(alloc, buf, v, "VpcSecurityGroupId");
        try buf.appendSlice(alloc, "</VpcSecurityGroupMemberships>");
    }
}

pub fn serializeOptionSetting(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OptionSetting) !void {
    if (value.allowed_values) |v| {
        try buf.appendSlice(alloc, "<AllowedValues>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AllowedValues>");
    }
    if (value.apply_type) |v| {
        try buf.appendSlice(alloc, "<ApplyType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ApplyType>");
    }
    if (value.data_type) |v| {
        try buf.appendSlice(alloc, "<DataType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DataType>");
    }
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.description) |v| {
        try buf.appendSlice(alloc, "<Description>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Description>");
    }
    if (value.is_collection) |v| {
        try buf.appendSlice(alloc, "<IsCollection>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsCollection>");
    }
    if (value.is_modifiable) |v| {
        try buf.appendSlice(alloc, "<IsModifiable>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsModifiable>");
    }
    if (value.name) |v| {
        try buf.appendSlice(alloc, "<Name>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Name>");
    }
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeParameter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Parameter) !void {
    if (value.allowed_values) |v| {
        try buf.appendSlice(alloc, "<AllowedValues>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AllowedValues>");
    }
    if (value.apply_method) |v| {
        try buf.appendSlice(alloc, "<ApplyMethod>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ApplyMethod>");
    }
    if (value.apply_type) |v| {
        try buf.appendSlice(alloc, "<ApplyType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ApplyType>");
    }
    if (value.data_type) |v| {
        try buf.appendSlice(alloc, "<DataType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DataType>");
    }
    if (value.description) |v| {
        try buf.appendSlice(alloc, "<Description>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Description>");
    }
    if (value.is_modifiable) |v| {
        try buf.appendSlice(alloc, "<IsModifiable>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsModifiable>");
    }
    if (value.minimum_engine_version) |v| {
        try buf.appendSlice(alloc, "<MinimumEngineVersion>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</MinimumEngineVersion>");
    }
    if (value.parameter_name) |v| {
        try buf.appendSlice(alloc, "<ParameterName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ParameterName>");
    }
    if (value.parameter_value) |v| {
        try buf.appendSlice(alloc, "<ParameterValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ParameterValue>");
    }
    if (value.source) |v| {
        try buf.appendSlice(alloc, "<Source>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Source>");
    }
    if (value.supported_engine_modes) |v| {
        try buf.appendSlice(alloc, "<SupportedEngineModes>");
        try serializeEngineModeList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</SupportedEngineModes>");
    }
}

pub fn serializeProcessorFeature(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ProcessorFeature) !void {
    if (value.name) |v| {
        try buf.appendSlice(alloc, "<Name>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Name>");
    }
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeRdsCustomClusterConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RdsCustomClusterConfiguration) !void {
    if (value.interconnect_subnet_id) |v| {
        try buf.appendSlice(alloc, "<InterconnectSubnetId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</InterconnectSubnetId>");
    }
    if (value.replica_mode) |v| {
        try buf.appendSlice(alloc, "<ReplicaMode>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ReplicaMode>");
    }
    if (value.transit_gateway_multicast_domain_id) |v| {
        try buf.appendSlice(alloc, "<TransitGatewayMulticastDomainId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TransitGatewayMulticastDomainId>");
    }
}

pub fn serializeRecommendedActionUpdate(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RecommendedActionUpdate) !void {
    try buf.appendSlice(alloc, "<ActionId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.action_id);
    try buf.appendSlice(alloc, "</ActionId>");
    try buf.appendSlice(alloc, "<Status>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.status);
    try buf.appendSlice(alloc, "</Status>");
}

pub fn serializeScalingConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScalingConfiguration) !void {
    if (value.auto_pause) |v| {
        try buf.appendSlice(alloc, "<AutoPause>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</AutoPause>");
    }
    if (value.max_capacity) |v| {
        try buf.appendSlice(alloc, "<MaxCapacity>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxCapacity>");
    }
    if (value.min_capacity) |v| {
        try buf.appendSlice(alloc, "<MinCapacity>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MinCapacity>");
    }
    if (value.seconds_before_timeout) |v| {
        try buf.appendSlice(alloc, "<SecondsBeforeTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</SecondsBeforeTimeout>");
    }
    if (value.seconds_until_auto_pause) |v| {
        try buf.appendSlice(alloc, "<SecondsUntilAutoPause>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</SecondsUntilAutoPause>");
    }
    if (value.timeout_action) |v| {
        try buf.appendSlice(alloc, "<TimeoutAction>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TimeoutAction>");
    }
}

pub fn serializeServerlessV2ScalingConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ServerlessV2ScalingConfiguration) !void {
    if (value.max_capacity) |v| {
        try buf.appendSlice(alloc, "<MaxCapacity>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxCapacity>");
    }
    if (value.min_capacity) |v| {
        try buf.appendSlice(alloc, "<MinCapacity>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MinCapacity>");
    }
    if (value.seconds_until_auto_pause) |v| {
        try buf.appendSlice(alloc, "<SecondsUntilAutoPause>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</SecondsUntilAutoPause>");
    }
}

pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    if (value.key) |v| {
        try buf.appendSlice(alloc, "<Key>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Key>");
    }
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeTagSpecification(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TagSpecification) !void {
    if (value.resource_type) |v| {
        try buf.appendSlice(alloc, "<ResourceType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourceType>");
    }
    if (value.tags) |v| {
        try buf.appendSlice(alloc, "<Tags>");
        try serializeTagList(alloc, buf, v, "Tag");
        try buf.appendSlice(alloc, "</Tags>");
    }
}

pub fn serializeUserAuthConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: UserAuthConfig) !void {
    if (value.auth_scheme) |v| {
        try buf.appendSlice(alloc, "<AuthScheme>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</AuthScheme>");
    }
    if (value.client_password_auth_type) |v| {
        try buf.appendSlice(alloc, "<ClientPasswordAuthType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ClientPasswordAuthType>");
    }
    if (value.description) |v| {
        try buf.appendSlice(alloc, "<Description>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Description>");
    }
    if (value.iam_auth) |v| {
        try buf.appendSlice(alloc, "<IAMAuth>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</IAMAuth>");
    }
    if (value.secret_arn) |v| {
        try buf.appendSlice(alloc, "<SecretArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SecretArn>");
    }
    if (value.user_name) |v| {
        try buf.appendSlice(alloc, "<UserName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</UserName>");
    }
}

