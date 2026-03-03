const aws = @import("aws");
const std = @import("std");

const AcceleratorCountRequest = @import("accelerator_count_request.zig").AcceleratorCountRequest;
const AcceleratorManufacturer = @import("accelerator_manufacturer.zig").AcceleratorManufacturer;
const AcceleratorName = @import("accelerator_name.zig").AcceleratorName;
const AcceleratorTotalMemoryMiBRequest = @import("accelerator_total_memory_mi_b_request.zig").AcceleratorTotalMemoryMiBRequest;
const AcceleratorType = @import("accelerator_type.zig").AcceleratorType;
const Activity = @import("activity.zig").Activity;
const AdjustmentType = @import("adjustment_type.zig").AdjustmentType;
const Alarm = @import("alarm.zig").Alarm;
const AlarmSpecification = @import("alarm_specification.zig").AlarmSpecification;
const AutoScalingGroup = @import("auto_scaling_group.zig").AutoScalingGroup;
const AutoScalingInstanceDetails = @import("auto_scaling_instance_details.zig").AutoScalingInstanceDetails;
const AvailabilityZoneDistribution = @import("availability_zone_distribution.zig").AvailabilityZoneDistribution;
const AvailabilityZoneImpairmentPolicy = @import("availability_zone_impairment_policy.zig").AvailabilityZoneImpairmentPolicy;
const BareMetal = @import("bare_metal.zig").BareMetal;
const BaselineEbsBandwidthMbpsRequest = @import("baseline_ebs_bandwidth_mbps_request.zig").BaselineEbsBandwidthMbpsRequest;
const BaselinePerformanceFactorsRequest = @import("baseline_performance_factors_request.zig").BaselinePerformanceFactorsRequest;
const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const BurstablePerformance = @import("burstable_performance.zig").BurstablePerformance;
const CapacityDistributionStrategy = @import("capacity_distribution_strategy.zig").CapacityDistributionStrategy;
const CapacityForecast = @import("capacity_forecast.zig").CapacityForecast;
const CapacityReservationPreference = @import("capacity_reservation_preference.zig").CapacityReservationPreference;
const CapacityReservationSpecification = @import("capacity_reservation_specification.zig").CapacityReservationSpecification;
const CapacityReservationTarget = @import("capacity_reservation_target.zig").CapacityReservationTarget;
const CpuManufacturer = @import("cpu_manufacturer.zig").CpuManufacturer;
const CpuPerformanceFactorRequest = @import("cpu_performance_factor_request.zig").CpuPerformanceFactorRequest;
const CustomizedMetricSpecification = @import("customized_metric_specification.zig").CustomizedMetricSpecification;
const DeletionProtection = @import("deletion_protection.zig").DeletionProtection;
const DesiredConfiguration = @import("desired_configuration.zig").DesiredConfiguration;
const Ebs = @import("ebs.zig").Ebs;
const EnabledMetric = @import("enabled_metric.zig").EnabledMetric;
const FailedScheduledUpdateGroupActionRequest = @import("failed_scheduled_update_group_action_request.zig").FailedScheduledUpdateGroupActionRequest;
const Filter = @import("filter.zig").Filter;
const ImpairedZoneHealthCheckBehavior = @import("impaired_zone_health_check_behavior.zig").ImpairedZoneHealthCheckBehavior;
const Instance = @import("instance.zig").Instance;
const InstanceCollection = @import("instance_collection.zig").InstanceCollection;
const InstanceGeneration = @import("instance_generation.zig").InstanceGeneration;
const InstanceLifecyclePolicy = @import("instance_lifecycle_policy.zig").InstanceLifecyclePolicy;
const InstanceMaintenancePolicy = @import("instance_maintenance_policy.zig").InstanceMaintenancePolicy;
const InstanceMetadataEndpointState = @import("instance_metadata_endpoint_state.zig").InstanceMetadataEndpointState;
const InstanceMetadataHttpTokensState = @import("instance_metadata_http_tokens_state.zig").InstanceMetadataHttpTokensState;
const InstanceMetadataOptions = @import("instance_metadata_options.zig").InstanceMetadataOptions;
const InstanceMonitoring = @import("instance_monitoring.zig").InstanceMonitoring;
const InstanceRefresh = @import("instance_refresh.zig").InstanceRefresh;
const InstanceRefreshLivePoolProgress = @import("instance_refresh_live_pool_progress.zig").InstanceRefreshLivePoolProgress;
const InstanceRefreshProgressDetails = @import("instance_refresh_progress_details.zig").InstanceRefreshProgressDetails;
const InstanceRefreshStatus = @import("instance_refresh_status.zig").InstanceRefreshStatus;
const InstanceRefreshWarmPoolProgress = @import("instance_refresh_warm_pool_progress.zig").InstanceRefreshWarmPoolProgress;
const InstanceRequirements = @import("instance_requirements.zig").InstanceRequirements;
const InstanceReusePolicy = @import("instance_reuse_policy.zig").InstanceReusePolicy;
const InstancesDistribution = @import("instances_distribution.zig").InstancesDistribution;
const LaunchConfiguration = @import("launch_configuration.zig").LaunchConfiguration;
const LaunchInstancesError = @import("launch_instances_error.zig").LaunchInstancesError;
const LaunchTemplate = @import("launch_template.zig").LaunchTemplate;
const LaunchTemplateOverrides = @import("launch_template_overrides.zig").LaunchTemplateOverrides;
const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const LifecycleHook = @import("lifecycle_hook.zig").LifecycleHook;
const LifecycleHookSpecification = @import("lifecycle_hook_specification.zig").LifecycleHookSpecification;
const LifecycleState = @import("lifecycle_state.zig").LifecycleState;
const LoadBalancerState = @import("load_balancer_state.zig").LoadBalancerState;
const LoadBalancerTargetGroupState = @import("load_balancer_target_group_state.zig").LoadBalancerTargetGroupState;
const LoadForecast = @import("load_forecast.zig").LoadForecast;
const LocalStorage = @import("local_storage.zig").LocalStorage;
const LocalStorageType = @import("local_storage_type.zig").LocalStorageType;
const MemoryGiBPerVCpuRequest = @import("memory_gi_b_per_v_cpu_request.zig").MemoryGiBPerVCpuRequest;
const MemoryMiBRequest = @import("memory_mi_b_request.zig").MemoryMiBRequest;
const Metric = @import("metric.zig").Metric;
const MetricCollectionType = @import("metric_collection_type.zig").MetricCollectionType;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;
const MetricDimension = @import("metric_dimension.zig").MetricDimension;
const MetricGranularityType = @import("metric_granularity_type.zig").MetricGranularityType;
const MetricStat = @import("metric_stat.zig").MetricStat;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;
const MetricType = @import("metric_type.zig").MetricType;
const MixedInstancesPolicy = @import("mixed_instances_policy.zig").MixedInstancesPolicy;
const NetworkBandwidthGbpsRequest = @import("network_bandwidth_gbps_request.zig").NetworkBandwidthGbpsRequest;
const NetworkInterfaceCountRequest = @import("network_interface_count_request.zig").NetworkInterfaceCountRequest;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;
const PerformanceFactorReferenceRequest = @import("performance_factor_reference_request.zig").PerformanceFactorReferenceRequest;
const PredefinedLoadMetricType = @import("predefined_load_metric_type.zig").PredefinedLoadMetricType;
const PredefinedMetricPairType = @import("predefined_metric_pair_type.zig").PredefinedMetricPairType;
const PredefinedMetricSpecification = @import("predefined_metric_specification.zig").PredefinedMetricSpecification;
const PredefinedScalingMetricType = @import("predefined_scaling_metric_type.zig").PredefinedScalingMetricType;
const PredictiveScalingConfiguration = @import("predictive_scaling_configuration.zig").PredictiveScalingConfiguration;
const PredictiveScalingCustomizedCapacityMetric = @import("predictive_scaling_customized_capacity_metric.zig").PredictiveScalingCustomizedCapacityMetric;
const PredictiveScalingCustomizedLoadMetric = @import("predictive_scaling_customized_load_metric.zig").PredictiveScalingCustomizedLoadMetric;
const PredictiveScalingCustomizedScalingMetric = @import("predictive_scaling_customized_scaling_metric.zig").PredictiveScalingCustomizedScalingMetric;
const PredictiveScalingMaxCapacityBreachBehavior = @import("predictive_scaling_max_capacity_breach_behavior.zig").PredictiveScalingMaxCapacityBreachBehavior;
const PredictiveScalingMetricSpecification = @import("predictive_scaling_metric_specification.zig").PredictiveScalingMetricSpecification;
const PredictiveScalingMode = @import("predictive_scaling_mode.zig").PredictiveScalingMode;
const PredictiveScalingPredefinedLoadMetric = @import("predictive_scaling_predefined_load_metric.zig").PredictiveScalingPredefinedLoadMetric;
const PredictiveScalingPredefinedMetricPair = @import("predictive_scaling_predefined_metric_pair.zig").PredictiveScalingPredefinedMetricPair;
const PredictiveScalingPredefinedScalingMetric = @import("predictive_scaling_predefined_scaling_metric.zig").PredictiveScalingPredefinedScalingMetric;
const ProcessType = @import("process_type.zig").ProcessType;
const RefreshPreferences = @import("refresh_preferences.zig").RefreshPreferences;
const RefreshStrategy = @import("refresh_strategy.zig").RefreshStrategy;
const RetentionAction = @import("retention_action.zig").RetentionAction;
const RetentionTriggers = @import("retention_triggers.zig").RetentionTriggers;
const RollbackDetails = @import("rollback_details.zig").RollbackDetails;
const ScaleInProtectedInstances = @import("scale_in_protected_instances.zig").ScaleInProtectedInstances;
const ScalingActivityStatusCode = @import("scaling_activity_status_code.zig").ScalingActivityStatusCode;
const ScalingPolicy = @import("scaling_policy.zig").ScalingPolicy;
const ScheduledUpdateGroupAction = @import("scheduled_update_group_action.zig").ScheduledUpdateGroupAction;
const ScheduledUpdateGroupActionRequest = @import("scheduled_update_group_action_request.zig").ScheduledUpdateGroupActionRequest;
const StandbyInstances = @import("standby_instances.zig").StandbyInstances;
const StepAdjustment = @import("step_adjustment.zig").StepAdjustment;
const SuspendedProcess = @import("suspended_process.zig").SuspendedProcess;
const Tag = @import("tag.zig").Tag;
const TagDescription = @import("tag_description.zig").TagDescription;
const TargetTrackingConfiguration = @import("target_tracking_configuration.zig").TargetTrackingConfiguration;
const TargetTrackingMetricDataQuery = @import("target_tracking_metric_data_query.zig").TargetTrackingMetricDataQuery;
const TargetTrackingMetricStat = @import("target_tracking_metric_stat.zig").TargetTrackingMetricStat;
const TotalLocalStorageGBRequest = @import("total_local_storage_gb_request.zig").TotalLocalStorageGBRequest;
const TrafficSourceIdentifier = @import("traffic_source_identifier.zig").TrafficSourceIdentifier;
const TrafficSourceState = @import("traffic_source_state.zig").TrafficSourceState;
const VCpuCountRequest = @import("v_cpu_count_request.zig").VCpuCountRequest;
const WarmPoolConfiguration = @import("warm_pool_configuration.zig").WarmPoolConfiguration;
const WarmPoolState = @import("warm_pool_state.zig").WarmPoolState;
const WarmPoolStatus = @import("warm_pool_status.zig").WarmPoolStatus;

pub fn deserializeAcceleratorManufacturers(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AcceleratorManufacturer {
    var list: std.ArrayList(AcceleratorManufacturer) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(AcceleratorManufacturer, try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeAcceleratorNames(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AcceleratorName {
    var list: std.ArrayList(AcceleratorName) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(AcceleratorName, try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeAcceleratorTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AcceleratorType {
    var list: std.ArrayList(AcceleratorType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(AcceleratorType, try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeActivities(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Activity {
    var list: std.ArrayList(Activity) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeActivity(allocator, reader));
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

pub fn deserializeAdjustmentTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AdjustmentType {
    var list: std.ArrayList(AdjustmentType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAdjustmentType(allocator, reader));
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

pub fn deserializeAlarmList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAlarms(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Alarm {
    var list: std.ArrayList(Alarm) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAlarm(allocator, reader));
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

pub fn deserializeAllowedInstanceTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAutoScalingGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AutoScalingGroup {
    var list: std.ArrayList(AutoScalingGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAutoScalingGroup(allocator, reader));
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

pub fn deserializeAutoScalingInstances(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AutoScalingInstanceDetails {
    var list: std.ArrayList(AutoScalingInstanceDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAutoScalingInstanceDetails(allocator, reader));
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

pub fn deserializeAutoScalingNotificationTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeBlockDeviceMappings(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const BlockDeviceMapping {
    var list: std.ArrayList(BlockDeviceMapping) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeBlockDeviceMapping(allocator, reader));
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

pub fn deserializeCapacityReservationIds(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCapacityReservationResourceGroupArns(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCheckpointPercentages(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const i32 {
    var list: std.ArrayList(i32) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null) |v| try list.append(allocator, v);
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

pub fn deserializeClassicLinkVPCSecurityGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCpuManufacturers(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CpuManufacturer {
    var list: std.ArrayList(CpuManufacturer) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(CpuManufacturer, try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeEnabledMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EnabledMetric {
    var list: std.ArrayList(EnabledMetric) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEnabledMetric(allocator, reader));
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

pub fn deserializeExcludedInstanceTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeFailedScheduledUpdateGroupActionRequests(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const FailedScheduledUpdateGroupActionRequest {
    var list: std.ArrayList(FailedScheduledUpdateGroupActionRequest) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeFailedScheduledUpdateGroupActionRequest(allocator, reader));
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

pub fn deserializeInstanceCollections(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InstanceCollection {
    var list: std.ArrayList(InstanceCollection) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInstanceCollection(allocator, reader));
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

pub fn deserializeInstanceGenerations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InstanceGeneration {
    var list: std.ArrayList(InstanceGeneration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(InstanceGeneration, try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeInstanceIds(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeInstanceRefreshes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InstanceRefresh {
    var list: std.ArrayList(InstanceRefresh) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInstanceRefresh(allocator, reader));
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

pub fn deserializeInstances(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Instance {
    var list: std.ArrayList(Instance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInstance(allocator, reader));
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

pub fn deserializeLaunchConfigurations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LaunchConfiguration {
    var list: std.ArrayList(LaunchConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLaunchConfiguration(allocator, reader));
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

pub fn deserializeLaunchInstancesErrors(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LaunchInstancesError {
    var list: std.ArrayList(LaunchInstancesError) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLaunchInstancesError(allocator, reader));
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

pub fn deserializeLifecycleHooks(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LifecycleHook {
    var list: std.ArrayList(LifecycleHook) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLifecycleHook(allocator, reader));
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

pub fn deserializeLoadBalancerNames(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeLoadBalancerStates(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LoadBalancerState {
    var list: std.ArrayList(LoadBalancerState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLoadBalancerState(allocator, reader));
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

pub fn deserializeLoadBalancerTargetGroupStates(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LoadBalancerTargetGroupState {
    var list: std.ArrayList(LoadBalancerTargetGroupState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLoadBalancerTargetGroupState(allocator, reader));
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

pub fn deserializeLoadForecasts(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LoadForecast {
    var list: std.ArrayList(LoadForecast) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLoadForecast(allocator, reader));
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

pub fn deserializeLocalStorageTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LocalStorageType {
    var list: std.ArrayList(LocalStorageType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(LocalStorageType, try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeMetricCollectionTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricCollectionType {
    var list: std.ArrayList(MetricCollectionType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricCollectionType(allocator, reader));
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

pub fn deserializeMetricDataQueries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricDataQuery {
    var list: std.ArrayList(MetricDataQuery) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricDataQuery(allocator, reader));
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

pub fn deserializeMetricDimensions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricDimension {
    var list: std.ArrayList(MetricDimension) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricDimension(allocator, reader));
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

pub fn deserializeMetricGranularityTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricGranularityType {
    var list: std.ArrayList(MetricGranularityType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricGranularityType(allocator, reader));
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

pub fn deserializeNotificationConfigurations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NotificationConfiguration {
    var list: std.ArrayList(NotificationConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeNotificationConfiguration(allocator, reader));
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

pub fn deserializeOverrides(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LaunchTemplateOverrides {
    var list: std.ArrayList(LaunchTemplateOverrides) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLaunchTemplateOverrides(allocator, reader));
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

pub fn deserializePerformanceFactorReferenceSetRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PerformanceFactorReferenceRequest {
    var list: std.ArrayList(PerformanceFactorReferenceRequest) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePerformanceFactorReferenceRequest(allocator, reader));
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

pub fn deserializePredictiveScalingForecastTimestamps(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const i64 {
    var list: std.ArrayList(i64) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (aws.date.parseIso8601(try reader.readElementText()) catch null) |v| try list.append(allocator, v);
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

pub fn deserializePredictiveScalingForecastValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const f64 {
    var list: std.ArrayList(f64) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseFloat(f64, try reader.readElementText()) catch null) |v| try list.append(allocator, v);
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

pub fn deserializePredictiveScalingMetricSpecifications(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PredictiveScalingMetricSpecification {
    var list: std.ArrayList(PredictiveScalingMetricSpecification) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePredictiveScalingMetricSpecification(allocator, reader));
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

pub fn deserializeProcesses(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ProcessType {
    var list: std.ArrayList(ProcessType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeProcessType(allocator, reader));
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

pub fn deserializeScalingPolicies(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ScalingPolicy {
    var list: std.ArrayList(ScalingPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeScalingPolicy(allocator, reader));
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

pub fn deserializeScheduledUpdateGroupActions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ScheduledUpdateGroupAction {
    var list: std.ArrayList(ScheduledUpdateGroupAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeScheduledUpdateGroupAction(allocator, reader));
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

pub fn deserializeSecurityGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeStepAdjustments(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StepAdjustment {
    var list: std.ArrayList(StepAdjustment) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStepAdjustment(allocator, reader));
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

pub fn deserializeSuspendedProcesses(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SuspendedProcess {
    var list: std.ArrayList(SuspendedProcess) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSuspendedProcess(allocator, reader));
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

pub fn deserializeTagDescriptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TagDescription {
    var list: std.ArrayList(TagDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTagDescription(allocator, reader));
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

pub fn deserializeTargetGroupARNs(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTargetTrackingMetricDataQueries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TargetTrackingMetricDataQuery {
    var list: std.ArrayList(TargetTrackingMetricDataQuery) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTargetTrackingMetricDataQuery(allocator, reader));
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

pub fn deserializeTerminationPolicies(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTrafficSourceStates(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrafficSourceState {
    var list: std.ArrayList(TrafficSourceState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrafficSourceState(allocator, reader));
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

pub fn deserializeTrafficSources(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrafficSourceIdentifier {
    var list: std.ArrayList(TrafficSourceIdentifier) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrafficSourceIdentifier(allocator, reader));
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

pub fn deserializeAcceleratorCountRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AcceleratorCountRequest {
    _ = allocator;
    var result: AcceleratorCountRequest = undefined;
    result.max = null;
    result.min = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Min")) {
                    result.min = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeAcceleratorTotalMemoryMiBRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AcceleratorTotalMemoryMiBRequest {
    _ = allocator;
    var result: AcceleratorTotalMemoryMiBRequest = undefined;
    result.max = null;
    result.min = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Min")) {
                    result.min = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeActivity(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Activity {
    var result: Activity = undefined;
    result.auto_scaling_group_arn = null;
    result.auto_scaling_group_state = null;
    result.description = null;
    result.details = null;
    result.end_time = null;
    result.progress = null;
    result.status_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActivityId")) {
                    result.activity_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupARN")) {
                    result.auto_scaling_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupState")) {
                    result.auto_scaling_group_state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cause")) {
                    result.cause = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Details")) {
                    result.details = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Progress")) {
                    result.progress = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = std.meta.stringToEnum(ScalingActivityStatusCode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusMessage")) {
                    result.status_message = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAdjustmentType(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AdjustmentType {
    var result: AdjustmentType = undefined;
    result.adjustment_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdjustmentType")) {
                    result.adjustment_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAlarm(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Alarm {
    var result: Alarm = undefined;
    result.alarm_arn = null;
    result.alarm_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmARN")) {
                    result.alarm_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmName")) {
                    result.alarm_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAlarmSpecification(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AlarmSpecification {
    var result: AlarmSpecification = undefined;
    result.alarms = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Alarms")) {
                    result.alarms = try deserializeAlarmList(allocator, reader, "member");
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

pub fn deserializeAutoScalingGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AutoScalingGroup {
    var result: AutoScalingGroup = undefined;
    result.auto_scaling_group_arn = null;
    result.availability_zone_distribution = null;
    result.availability_zone_impairment_policy = null;
    result.capacity_rebalance = null;
    result.capacity_reservation_specification = null;
    result.context = null;
    result.default_instance_warmup = null;
    result.deletion_protection = null;
    result.desired_capacity_type = null;
    result.enabled_metrics = null;
    result.health_check_grace_period = null;
    result.instance_lifecycle_policy = null;
    result.instance_maintenance_policy = null;
    result.instances = null;
    result.launch_configuration_name = null;
    result.launch_template = null;
    result.load_balancer_names = null;
    result.max_instance_lifetime = null;
    result.mixed_instances_policy = null;
    result.new_instances_protected_from_scale_in = null;
    result.placement_group = null;
    result.predicted_capacity = null;
    result.service_linked_role_arn = null;
    result.status = null;
    result.suspended_processes = null;
    result.tags = null;
    result.target_group_ar_ns = null;
    result.termination_policies = null;
    result.traffic_sources = null;
    result.vpc_zone_identifier = null;
    result.warm_pool_configuration = null;
    result.warm_pool_size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoScalingGroupARN")) {
                    result.auto_scaling_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZoneDistribution")) {
                    result.availability_zone_distribution = try deserializeAvailabilityZoneDistribution(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AvailabilityZoneImpairmentPolicy")) {
                    result.availability_zone_impairment_policy = try deserializeAvailabilityZoneImpairmentPolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "CapacityRebalance")) {
                    result.capacity_rebalance = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CapacityReservationSpecification")) {
                    result.capacity_reservation_specification = try deserializeCapacityReservationSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Context")) {
                    result.context = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultCooldown")) {
                    result.default_cooldown = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "DefaultInstanceWarmup")) {
                    result.default_instance_warmup = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.meta.stringToEnum(DeletionProtection, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DesiredCapacity")) {
                    result.desired_capacity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "DesiredCapacityType")) {
                    result.desired_capacity_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnabledMetrics")) {
                    result.enabled_metrics = try deserializeEnabledMetrics(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "HealthCheckGracePeriod")) {
                    result.health_check_grace_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "HealthCheckType")) {
                    result.health_check_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceLifecyclePolicy")) {
                    result.instance_lifecycle_policy = try deserializeInstanceLifecyclePolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "InstanceMaintenancePolicy")) {
                    result.instance_maintenance_policy = try deserializeInstanceMaintenancePolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Instances")) {
                    result.instances = try deserializeInstances(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationName")) {
                    result.launch_configuration_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplateSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LoadBalancerNames")) {
                    result.load_balancer_names = try deserializeLoadBalancerNames(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MaxInstanceLifetime")) {
                    result.max_instance_lifetime = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxSize")) {
                    result.max_size = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "MinSize")) {
                    result.min_size = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "MixedInstancesPolicy")) {
                    result.mixed_instances_policy = try deserializeMixedInstancesPolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NewInstancesProtectedFromScaleIn")) {
                    result.new_instances_protected_from_scale_in = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PlacementGroup")) {
                    result.placement_group = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PredictedCapacity")) {
                    result.predicted_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceLinkedRoleARN")) {
                    result.service_linked_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuspendedProcesses")) {
                    result.suspended_processes = try deserializeSuspendedProcesses(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagDescriptionList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TargetGroupARNs")) {
                    result.target_group_ar_ns = try deserializeTargetGroupARNs(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TerminationPolicies")) {
                    result.termination_policies = try deserializeTerminationPolicies(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TrafficSources")) {
                    result.traffic_sources = try deserializeTrafficSources(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "VPCZoneIdentifier")) {
                    result.vpc_zone_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "WarmPoolConfiguration")) {
                    result.warm_pool_configuration = try deserializeWarmPoolConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "WarmPoolSize")) {
                    result.warm_pool_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeAutoScalingInstanceDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AutoScalingInstanceDetails {
    var result: AutoScalingInstanceDetails = undefined;
    result.image_id = null;
    result.instance_type = null;
    result.launch_configuration_name = null;
    result.launch_template = null;
    result.weighted_capacity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationName")) {
                    result.launch_configuration_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplateSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LifecycleState")) {
                    result.lifecycle_state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProtectedFromScaleIn")) {
                    result.protected_from_scale_in = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "WeightedCapacity")) {
                    result.weighted_capacity = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAvailabilityZoneDistribution(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AvailabilityZoneDistribution {
    _ = allocator;
    var result: AvailabilityZoneDistribution = undefined;
    result.capacity_distribution_strategy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CapacityDistributionStrategy")) {
                    result.capacity_distribution_strategy = std.meta.stringToEnum(CapacityDistributionStrategy, try reader.readElementText());
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

pub fn deserializeAvailabilityZoneImpairmentPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AvailabilityZoneImpairmentPolicy {
    _ = allocator;
    var result: AvailabilityZoneImpairmentPolicy = undefined;
    result.impaired_zone_health_check_behavior = null;
    result.zonal_shift_enabled = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ImpairedZoneHealthCheckBehavior")) {
                    result.impaired_zone_health_check_behavior = std.meta.stringToEnum(ImpairedZoneHealthCheckBehavior, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ZonalShiftEnabled")) {
                    result.zonal_shift_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeBaselineEbsBandwidthMbpsRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BaselineEbsBandwidthMbpsRequest {
    _ = allocator;
    var result: BaselineEbsBandwidthMbpsRequest = undefined;
    result.max = null;
    result.min = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Min")) {
                    result.min = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeBaselinePerformanceFactorsRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BaselinePerformanceFactorsRequest {
    var result: BaselinePerformanceFactorsRequest = undefined;
    result.cpu = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cpu")) {
                    result.cpu = try deserializeCpuPerformanceFactorRequest(allocator, reader);
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

pub fn deserializeBlockDeviceMapping(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BlockDeviceMapping {
    var result: BlockDeviceMapping = undefined;
    result.ebs = null;
    result.no_device = null;
    result.virtual_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeviceName")) {
                    result.device_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Ebs")) {
                    result.ebs = try deserializeEbs(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NoDevice")) {
                    result.no_device = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "VirtualName")) {
                    result.virtual_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCapacityForecast(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CapacityForecast {
    var result: CapacityForecast = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Timestamps")) {
                    result.timestamps = try deserializePredictiveScalingForecastTimestamps(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializePredictiveScalingForecastValues(allocator, reader, "member");
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

pub fn deserializeCapacityReservationSpecification(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CapacityReservationSpecification {
    var result: CapacityReservationSpecification = undefined;
    result.capacity_reservation_preference = null;
    result.capacity_reservation_target = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CapacityReservationPreference")) {
                    result.capacity_reservation_preference = std.meta.stringToEnum(CapacityReservationPreference, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CapacityReservationTarget")) {
                    result.capacity_reservation_target = try deserializeCapacityReservationTarget(allocator, reader);
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

pub fn deserializeCapacityReservationTarget(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CapacityReservationTarget {
    var result: CapacityReservationTarget = undefined;
    result.capacity_reservation_ids = null;
    result.capacity_reservation_resource_group_arns = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CapacityReservationIds")) {
                    result.capacity_reservation_ids = try deserializeCapacityReservationIds(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "CapacityReservationResourceGroupArns")) {
                    result.capacity_reservation_resource_group_arns = try deserializeCapacityReservationResourceGroupArns(allocator, reader, "member");
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

pub fn deserializeCpuPerformanceFactorRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CpuPerformanceFactorRequest {
    var result: CpuPerformanceFactorRequest = undefined;
    result.references = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Reference")) {
                    result.references = try deserializePerformanceFactorReferenceSetRequest(allocator, reader, "item");
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

pub fn deserializeCustomizedMetricSpecification(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CustomizedMetricSpecification {
    var result: CustomizedMetricSpecification = undefined;
    result.dimensions = null;
    result.metric_name = null;
    result.metrics = null;
    result.namespace = null;
    result.period = null;
    result.statistic = null;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeMetricDimensions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try deserializeTargetTrackingMetricDataQueries(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Statistic")) {
                    result.statistic = std.meta.stringToEnum(MetricStatistic, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDesiredConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DesiredConfiguration {
    var result: DesiredConfiguration = undefined;
    result.launch_template = null;
    result.mixed_instances_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplateSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MixedInstancesPolicy")) {
                    result.mixed_instances_policy = try deserializeMixedInstancesPolicy(allocator, reader);
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

pub fn deserializeEbs(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Ebs {
    var result: Ebs = undefined;
    result.delete_on_termination = null;
    result.encrypted = null;
    result.iops = null;
    result.snapshot_id = null;
    result.throughput = null;
    result.volume_size = null;
    result.volume_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteOnTermination")) {
                    result.delete_on_termination = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotId")) {
                    result.snapshot_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Throughput")) {
                    result.throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "VolumeSize")) {
                    result.volume_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "VolumeType")) {
                    result.volume_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeEnabledMetric(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EnabledMetric {
    var result: EnabledMetric = undefined;
    result.granularity = null;
    result.metric = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Granularity")) {
                    result.granularity = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFailedScheduledUpdateGroupActionRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FailedScheduledUpdateGroupActionRequest {
    var result: FailedScheduledUpdateGroupActionRequest = undefined;
    result.error_code = null;
    result.error_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionName")) {
                    result.scheduled_action_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInstance(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Instance {
    var result: Instance = undefined;
    result.image_id = null;
    result.instance_type = null;
    result.launch_configuration_name = null;
    result.launch_template = null;
    result.weighted_capacity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationName")) {
                    result.launch_configuration_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplateSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LifecycleState")) {
                    result.lifecycle_state = std.meta.stringToEnum(LifecycleState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProtectedFromScaleIn")) {
                    result.protected_from_scale_in = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "WeightedCapacity")) {
                    result.weighted_capacity = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInstanceCollection(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceCollection {
    var result: InstanceCollection = undefined;
    result.availability_zone = null;
    result.availability_zone_id = null;
    result.instance_ids = null;
    result.instance_type = null;
    result.market_type = null;
    result.subnet_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZoneId")) {
                    result.availability_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceIds")) {
                    result.instance_ids = try deserializeInstanceIds(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MarketType")) {
                    result.market_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetId")) {
                    result.subnet_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInstanceLifecyclePolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceLifecyclePolicy {
    var result: InstanceLifecyclePolicy = undefined;
    result.retention_triggers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RetentionTriggers")) {
                    result.retention_triggers = try deserializeRetentionTriggers(allocator, reader);
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

pub fn deserializeInstanceMaintenancePolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceMaintenancePolicy {
    _ = allocator;
    var result: InstanceMaintenancePolicy = undefined;
    result.max_healthy_percentage = null;
    result.min_healthy_percentage = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MaxHealthyPercentage")) {
                    result.max_healthy_percentage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinHealthyPercentage")) {
                    result.min_healthy_percentage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeInstanceMetadataOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceMetadataOptions {
    _ = allocator;
    var result: InstanceMetadataOptions = undefined;
    result.http_endpoint = null;
    result.http_put_response_hop_limit = null;
    result.http_tokens = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HttpEndpoint")) {
                    result.http_endpoint = std.meta.stringToEnum(InstanceMetadataEndpointState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpPutResponseHopLimit")) {
                    result.http_put_response_hop_limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "HttpTokens")) {
                    result.http_tokens = std.meta.stringToEnum(InstanceMetadataHttpTokensState, try reader.readElementText());
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

pub fn deserializeInstanceMonitoring(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceMonitoring {
    _ = allocator;
    var result: InstanceMonitoring = undefined;
    result.enabled = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeInstanceRefresh(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceRefresh {
    var result: InstanceRefresh = undefined;
    result.auto_scaling_group_name = null;
    result.desired_configuration = null;
    result.end_time = null;
    result.instance_refresh_id = null;
    result.instances_to_update = null;
    result.percentage_complete = null;
    result.preferences = null;
    result.progress_details = null;
    result.rollback_details = null;
    result.start_time = null;
    result.status = null;
    result.status_reason = null;
    result.strategy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DesiredConfiguration")) {
                    result.desired_configuration = try deserializeDesiredConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "InstanceRefreshId")) {
                    result.instance_refresh_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstancesToUpdate")) {
                    result.instances_to_update = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PercentageComplete")) {
                    result.percentage_complete = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Preferences")) {
                    result.preferences = try deserializeRefreshPreferences(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ProgressDetails")) {
                    result.progress_details = try deserializeInstanceRefreshProgressDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RollbackDetails")) {
                    result.rollback_details = try deserializeRollbackDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(InstanceRefreshStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Strategy")) {
                    result.strategy = std.meta.stringToEnum(RefreshStrategy, try reader.readElementText());
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

pub fn deserializeInstanceRefreshLivePoolProgress(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceRefreshLivePoolProgress {
    _ = allocator;
    var result: InstanceRefreshLivePoolProgress = undefined;
    result.instances_to_update = null;
    result.percentage_complete = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstancesToUpdate")) {
                    result.instances_to_update = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PercentageComplete")) {
                    result.percentage_complete = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeInstanceRefreshProgressDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceRefreshProgressDetails {
    var result: InstanceRefreshProgressDetails = undefined;
    result.live_pool_progress = null;
    result.warm_pool_progress = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LivePoolProgress")) {
                    result.live_pool_progress = try deserializeInstanceRefreshLivePoolProgress(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "WarmPoolProgress")) {
                    result.warm_pool_progress = try deserializeInstanceRefreshWarmPoolProgress(allocator, reader);
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

pub fn deserializeInstanceRefreshWarmPoolProgress(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceRefreshWarmPoolProgress {
    _ = allocator;
    var result: InstanceRefreshWarmPoolProgress = undefined;
    result.instances_to_update = null;
    result.percentage_complete = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstancesToUpdate")) {
                    result.instances_to_update = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PercentageComplete")) {
                    result.percentage_complete = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeInstanceRequirements(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceRequirements {
    var result: InstanceRequirements = undefined;
    result.accelerator_count = null;
    result.accelerator_manufacturers = null;
    result.accelerator_names = null;
    result.accelerator_total_memory_mi_b = null;
    result.accelerator_types = null;
    result.allowed_instance_types = null;
    result.bare_metal = null;
    result.baseline_ebs_bandwidth_mbps = null;
    result.baseline_performance_factors = null;
    result.burstable_performance = null;
    result.cpu_manufacturers = null;
    result.excluded_instance_types = null;
    result.instance_generations = null;
    result.local_storage = null;
    result.local_storage_types = null;
    result.max_spot_price_as_percentage_of_optimal_on_demand_price = null;
    result.memory_gi_b_per_v_cpu = null;
    result.network_bandwidth_gbps = null;
    result.network_interface_count = null;
    result.on_demand_max_price_percentage_over_lowest_price = null;
    result.require_hibernate_support = null;
    result.spot_max_price_percentage_over_lowest_price = null;
    result.total_local_storage_gb = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AcceleratorCount")) {
                    result.accelerator_count = try deserializeAcceleratorCountRequest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AcceleratorManufacturers")) {
                    result.accelerator_manufacturers = try deserializeAcceleratorManufacturers(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AcceleratorNames")) {
                    result.accelerator_names = try deserializeAcceleratorNames(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AcceleratorTotalMemoryMiB")) {
                    result.accelerator_total_memory_mi_b = try deserializeAcceleratorTotalMemoryMiBRequest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AcceleratorTypes")) {
                    result.accelerator_types = try deserializeAcceleratorTypes(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AllowedInstanceTypes")) {
                    result.allowed_instance_types = try deserializeAllowedInstanceTypes(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "BareMetal")) {
                    result.bare_metal = std.meta.stringToEnum(BareMetal, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BaselineEbsBandwidthMbps")) {
                    result.baseline_ebs_bandwidth_mbps = try deserializeBaselineEbsBandwidthMbpsRequest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "BaselinePerformanceFactors")) {
                    result.baseline_performance_factors = try deserializeBaselinePerformanceFactorsRequest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "BurstablePerformance")) {
                    result.burstable_performance = std.meta.stringToEnum(BurstablePerformance, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CpuManufacturers")) {
                    result.cpu_manufacturers = try deserializeCpuManufacturers(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ExcludedInstanceTypes")) {
                    result.excluded_instance_types = try deserializeExcludedInstanceTypes(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "InstanceGenerations")) {
                    result.instance_generations = try deserializeInstanceGenerations(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LocalStorage")) {
                    result.local_storage = std.meta.stringToEnum(LocalStorage, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LocalStorageTypes")) {
                    result.local_storage_types = try deserializeLocalStorageTypes(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MaxSpotPriceAsPercentageOfOptimalOnDemandPrice")) {
                    result.max_spot_price_as_percentage_of_optimal_on_demand_price = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MemoryGiBPerVCpu")) {
                    result.memory_gi_b_per_v_cpu = try deserializeMemoryGiBPerVCpuRequest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MemoryMiB")) {
                    result.memory_mi_b = try deserializeMemoryMiBRequest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NetworkBandwidthGbps")) {
                    result.network_bandwidth_gbps = try deserializeNetworkBandwidthGbpsRequest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NetworkInterfaceCount")) {
                    result.network_interface_count = try deserializeNetworkInterfaceCountRequest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "OnDemandMaxPricePercentageOverLowestPrice")) {
                    result.on_demand_max_price_percentage_over_lowest_price = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RequireHibernateSupport")) {
                    result.require_hibernate_support = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SpotMaxPricePercentageOverLowestPrice")) {
                    result.spot_max_price_percentage_over_lowest_price = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TotalLocalStorageGB")) {
                    result.total_local_storage_gb = try deserializeTotalLocalStorageGBRequest(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "VCpuCount")) {
                    result.v_cpu_count = try deserializeVCpuCountRequest(allocator, reader);
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

pub fn deserializeInstanceReusePolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceReusePolicy {
    _ = allocator;
    var result: InstanceReusePolicy = undefined;
    result.reuse_on_scale_in = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReuseOnScaleIn")) {
                    result.reuse_on_scale_in = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeInstancesDistribution(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstancesDistribution {
    var result: InstancesDistribution = undefined;
    result.on_demand_allocation_strategy = null;
    result.on_demand_base_capacity = null;
    result.on_demand_percentage_above_base_capacity = null;
    result.spot_allocation_strategy = null;
    result.spot_instance_pools = null;
    result.spot_max_price = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OnDemandAllocationStrategy")) {
                    result.on_demand_allocation_strategy = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OnDemandBaseCapacity")) {
                    result.on_demand_base_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OnDemandPercentageAboveBaseCapacity")) {
                    result.on_demand_percentage_above_base_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SpotAllocationStrategy")) {
                    result.spot_allocation_strategy = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SpotInstancePools")) {
                    result.spot_instance_pools = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SpotMaxPrice")) {
                    result.spot_max_price = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLaunchConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LaunchConfiguration {
    var result: LaunchConfiguration = undefined;
    result.associate_public_ip_address = null;
    result.block_device_mappings = null;
    result.classic_link_vpc_id = null;
    result.classic_link_vpc_security_groups = null;
    result.ebs_optimized = null;
    result.iam_instance_profile = null;
    result.instance_monitoring = null;
    result.kernel_id = null;
    result.key_name = null;
    result.launch_configuration_arn = null;
    result.metadata_options = null;
    result.placement_tenancy = null;
    result.ramdisk_id = null;
    result.security_groups = null;
    result.spot_price = null;
    result.user_data = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssociatePublicIpAddress")) {
                    result.associate_public_ip_address = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "BlockDeviceMappings")) {
                    result.block_device_mappings = try deserializeBlockDeviceMappings(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ClassicLinkVPCId")) {
                    result.classic_link_vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClassicLinkVPCSecurityGroups")) {
                    result.classic_link_vpc_security_groups = try deserializeClassicLinkVPCSecurityGroups(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EbsOptimized")) {
                    result.ebs_optimized = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IamInstanceProfile")) {
                    result.iam_instance_profile = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceMonitoring")) {
                    result.instance_monitoring = try deserializeInstanceMonitoring(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KernelId")) {
                    result.kernel_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyName")) {
                    result.key_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationARN")) {
                    result.launch_configuration_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationName")) {
                    result.launch_configuration_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetadataOptions")) {
                    result.metadata_options = try deserializeInstanceMetadataOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PlacementTenancy")) {
                    result.placement_tenancy = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RamdiskId")) {
                    result.ramdisk_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecurityGroups")) {
                    result.security_groups = try deserializeSecurityGroups(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SpotPrice")) {
                    result.spot_price = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserData")) {
                    result.user_data = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLaunchInstancesError(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LaunchInstancesError {
    var result: LaunchInstancesError = undefined;
    result.availability_zone = null;
    result.availability_zone_id = null;
    result.error_code = null;
    result.error_message = null;
    result.instance_type = null;
    result.market_type = null;
    result.subnet_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZoneId")) {
                    result.availability_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MarketType")) {
                    result.market_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetId")) {
                    result.subnet_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLaunchTemplate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LaunchTemplate {
    var result: LaunchTemplate = undefined;
    result.launch_template_specification = null;
    result.overrides = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LaunchTemplateSpecification")) {
                    result.launch_template_specification = try deserializeLaunchTemplateSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Overrides")) {
                    result.overrides = try deserializeOverrides(allocator, reader, "member");
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

pub fn deserializeLaunchTemplateOverrides(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LaunchTemplateOverrides {
    var result: LaunchTemplateOverrides = undefined;
    result.image_id = null;
    result.instance_requirements = null;
    result.instance_type = null;
    result.launch_template_specification = null;
    result.weighted_capacity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceRequirements")) {
                    result.instance_requirements = try deserializeInstanceRequirements(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplateSpecification")) {
                    result.launch_template_specification = try deserializeLaunchTemplateSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "WeightedCapacity")) {
                    result.weighted_capacity = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLaunchTemplateSpecification(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LaunchTemplateSpecification {
    var result: LaunchTemplateSpecification = undefined;
    result.launch_template_id = null;
    result.launch_template_name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LaunchTemplateId")) {
                    result.launch_template_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplateName")) {
                    result.launch_template_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLifecycleHook(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LifecycleHook {
    var result: LifecycleHook = undefined;
    result.auto_scaling_group_name = null;
    result.default_result = null;
    result.global_timeout = null;
    result.heartbeat_timeout = null;
    result.lifecycle_hook_name = null;
    result.lifecycle_transition = null;
    result.notification_metadata = null;
    result.notification_target_arn = null;
    result.role_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultResult")) {
                    result.default_result = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalTimeout")) {
                    result.global_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "HeartbeatTimeout")) {
                    result.heartbeat_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LifecycleHookName")) {
                    result.lifecycle_hook_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LifecycleTransition")) {
                    result.lifecycle_transition = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NotificationMetadata")) {
                    result.notification_metadata = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NotificationTargetARN")) {
                    result.notification_target_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleARN")) {
                    result.role_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLoadBalancerState(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancerState {
    var result: LoadBalancerState = undefined;
    result.load_balancer_name = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLoadBalancerTargetGroupState(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancerTargetGroupState {
    var result: LoadBalancerTargetGroupState = undefined;
    result.load_balancer_target_group_arn = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancerTargetGroupARN")) {
                    result.load_balancer_target_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLoadForecast(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadForecast {
    var result: LoadForecast = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricSpecification")) {
                    result.metric_specification = try deserializePredictiveScalingMetricSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Timestamps")) {
                    result.timestamps = try deserializePredictiveScalingForecastTimestamps(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializePredictiveScalingForecastValues(allocator, reader, "member");
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

pub fn deserializeMemoryGiBPerVCpuRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MemoryGiBPerVCpuRequest {
    _ = allocator;
    var result: MemoryGiBPerVCpuRequest = undefined;
    result.max = null;
    result.min = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Min")) {
                    result.min = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
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

pub fn deserializeMemoryMiBRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MemoryMiBRequest {
    _ = allocator;
    var result: MemoryMiBRequest = undefined;
    result.max = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Min")) {
                    result.min = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
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
    result.dimensions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeMetricDimensions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeMetricCollectionType(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricCollectionType {
    var result: MetricCollectionType = undefined;
    result.metric = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metric")) {
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

pub fn deserializeMetricDataQuery(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricDataQuery {
    var result: MetricDataQuery = undefined;
    result.expression = null;
    result.label = null;
    result.metric_stat = null;
    result.return_data = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Expression")) {
                    result.expression = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetricStat")) {
                    result.metric_stat = try deserializeMetricStat(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ReturnData")) {
                    result.return_data = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeMetricDimension(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricDimension {
    var result: MetricDimension = undefined;
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

pub fn deserializeMetricGranularityType(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricGranularityType {
    var result: MetricGranularityType = undefined;
    result.granularity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Granularity")) {
                    result.granularity = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeMetricStat(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricStat {
    var result: MetricStat = undefined;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metric")) {
                    result.metric = try deserializeMetric(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeMixedInstancesPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MixedInstancesPolicy {
    var result: MixedInstancesPolicy = undefined;
    result.instances_distribution = null;
    result.launch_template = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstancesDistribution")) {
                    result.instances_distribution = try deserializeInstancesDistribution(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplate(allocator, reader);
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

pub fn deserializeNetworkBandwidthGbpsRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NetworkBandwidthGbpsRequest {
    _ = allocator;
    var result: NetworkBandwidthGbpsRequest = undefined;
    result.max = null;
    result.min = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Min")) {
                    result.min = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
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

pub fn deserializeNetworkInterfaceCountRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NetworkInterfaceCountRequest {
    _ = allocator;
    var result: NetworkInterfaceCountRequest = undefined;
    result.max = null;
    result.min = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Min")) {
                    result.min = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeNotificationConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NotificationConfiguration {
    var result: NotificationConfiguration = undefined;
    result.auto_scaling_group_name = null;
    result.notification_type = null;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NotificationType")) {
                    result.notification_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicARN")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePerformanceFactorReferenceRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PerformanceFactorReferenceRequest {
    var result: PerformanceFactorReferenceRequest = undefined;
    result.instance_family = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstanceFamily")) {
                    result.instance_family = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePredefinedMetricSpecification(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PredefinedMetricSpecification {
    var result: PredefinedMetricSpecification = undefined;
    result.resource_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PredefinedMetricType")) {
                    result.predefined_metric_type = std.meta.stringToEnum(MetricType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLabel")) {
                    result.resource_label = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePredictiveScalingConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PredictiveScalingConfiguration {
    var result: PredictiveScalingConfiguration = undefined;
    result.max_capacity_breach_behavior = null;
    result.max_capacity_buffer = null;
    result.mode = null;
    result.scheduling_buffer_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MaxCapacityBreachBehavior")) {
                    result.max_capacity_breach_behavior = std.meta.stringToEnum(PredictiveScalingMaxCapacityBreachBehavior, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxCapacityBuffer")) {
                    result.max_capacity_buffer = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MetricSpecifications")) {
                    result.metric_specifications = try deserializePredictiveScalingMetricSpecifications(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = std.meta.stringToEnum(PredictiveScalingMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SchedulingBufferTime")) {
                    result.scheduling_buffer_time = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializePredictiveScalingCustomizedCapacityMetric(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PredictiveScalingCustomizedCapacityMetric {
    var result: PredictiveScalingCustomizedCapacityMetric = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricDataQueries")) {
                    result.metric_data_queries = try deserializeMetricDataQueries(allocator, reader, "member");
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

pub fn deserializePredictiveScalingCustomizedLoadMetric(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PredictiveScalingCustomizedLoadMetric {
    var result: PredictiveScalingCustomizedLoadMetric = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricDataQueries")) {
                    result.metric_data_queries = try deserializeMetricDataQueries(allocator, reader, "member");
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

pub fn deserializePredictiveScalingCustomizedScalingMetric(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PredictiveScalingCustomizedScalingMetric {
    var result: PredictiveScalingCustomizedScalingMetric = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricDataQueries")) {
                    result.metric_data_queries = try deserializeMetricDataQueries(allocator, reader, "member");
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

pub fn deserializePredictiveScalingMetricSpecification(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PredictiveScalingMetricSpecification {
    var result: PredictiveScalingMetricSpecification = undefined;
    result.customized_capacity_metric_specification = null;
    result.customized_load_metric_specification = null;
    result.customized_scaling_metric_specification = null;
    result.predefined_load_metric_specification = null;
    result.predefined_metric_pair_specification = null;
    result.predefined_scaling_metric_specification = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CustomizedCapacityMetricSpecification")) {
                    result.customized_capacity_metric_specification = try deserializePredictiveScalingCustomizedCapacityMetric(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CustomizedLoadMetricSpecification")) {
                    result.customized_load_metric_specification = try deserializePredictiveScalingCustomizedLoadMetric(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CustomizedScalingMetricSpecification")) {
                    result.customized_scaling_metric_specification = try deserializePredictiveScalingCustomizedScalingMetric(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PredefinedLoadMetricSpecification")) {
                    result.predefined_load_metric_specification = try deserializePredictiveScalingPredefinedLoadMetric(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PredefinedMetricPairSpecification")) {
                    result.predefined_metric_pair_specification = try deserializePredictiveScalingPredefinedMetricPair(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PredefinedScalingMetricSpecification")) {
                    result.predefined_scaling_metric_specification = try deserializePredictiveScalingPredefinedScalingMetric(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TargetValue")) {
                    result.target_value = try std.fmt.parseFloat(f64, try reader.readElementText());
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

pub fn deserializePredictiveScalingPredefinedLoadMetric(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PredictiveScalingPredefinedLoadMetric {
    var result: PredictiveScalingPredefinedLoadMetric = undefined;
    result.resource_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PredefinedMetricType")) {
                    result.predefined_metric_type = std.meta.stringToEnum(PredefinedLoadMetricType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLabel")) {
                    result.resource_label = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePredictiveScalingPredefinedMetricPair(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PredictiveScalingPredefinedMetricPair {
    var result: PredictiveScalingPredefinedMetricPair = undefined;
    result.resource_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PredefinedMetricType")) {
                    result.predefined_metric_type = std.meta.stringToEnum(PredefinedMetricPairType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLabel")) {
                    result.resource_label = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePredictiveScalingPredefinedScalingMetric(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PredictiveScalingPredefinedScalingMetric {
    var result: PredictiveScalingPredefinedScalingMetric = undefined;
    result.resource_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PredefinedMetricType")) {
                    result.predefined_metric_type = std.meta.stringToEnum(PredefinedScalingMetricType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLabel")) {
                    result.resource_label = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeProcessType(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ProcessType {
    var result: ProcessType = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ProcessName")) {
                    result.process_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeRefreshPreferences(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RefreshPreferences {
    var result: RefreshPreferences = undefined;
    result.alarm_specification = null;
    result.auto_rollback = null;
    result.bake_time = null;
    result.checkpoint_delay = null;
    result.checkpoint_percentages = null;
    result.instance_warmup = null;
    result.max_healthy_percentage = null;
    result.min_healthy_percentage = null;
    result.scale_in_protected_instances = null;
    result.skip_matching = null;
    result.standby_instances = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmSpecification")) {
                    result.alarm_specification = try deserializeAlarmSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AutoRollback")) {
                    result.auto_rollback = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "BakeTime")) {
                    result.bake_time = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CheckpointDelay")) {
                    result.checkpoint_delay = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CheckpointPercentages")) {
                    result.checkpoint_percentages = try deserializeCheckpointPercentages(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "InstanceWarmup")) {
                    result.instance_warmup = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxHealthyPercentage")) {
                    result.max_healthy_percentage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinHealthyPercentage")) {
                    result.min_healthy_percentage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ScaleInProtectedInstances")) {
                    result.scale_in_protected_instances = std.meta.stringToEnum(ScaleInProtectedInstances, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SkipMatching")) {
                    result.skip_matching = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StandbyInstances")) {
                    result.standby_instances = std.meta.stringToEnum(StandbyInstances, try reader.readElementText());
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

pub fn deserializeRetentionTriggers(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RetentionTriggers {
    _ = allocator;
    var result: RetentionTriggers = undefined;
    result.terminate_hook_abandon = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TerminateHookAbandon")) {
                    result.terminate_hook_abandon = std.meta.stringToEnum(RetentionAction, try reader.readElementText());
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

pub fn deserializeRollbackDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RollbackDetails {
    var result: RollbackDetails = undefined;
    result.instances_to_update_on_rollback = null;
    result.percentage_complete_on_rollback = null;
    result.progress_details_on_rollback = null;
    result.rollback_reason = null;
    result.rollback_start_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstancesToUpdateOnRollback")) {
                    result.instances_to_update_on_rollback = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PercentageCompleteOnRollback")) {
                    result.percentage_complete_on_rollback = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProgressDetailsOnRollback")) {
                    result.progress_details_on_rollback = try deserializeInstanceRefreshProgressDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RollbackReason")) {
                    result.rollback_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RollbackStartTime")) {
                    result.rollback_start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeScalingPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScalingPolicy {
    var result: ScalingPolicy = undefined;
    result.adjustment_type = null;
    result.alarms = null;
    result.auto_scaling_group_name = null;
    result.cooldown = null;
    result.enabled = null;
    result.estimated_instance_warmup = null;
    result.metric_aggregation_type = null;
    result.min_adjustment_magnitude = null;
    result.min_adjustment_step = null;
    result.policy_arn = null;
    result.policy_name = null;
    result.policy_type = null;
    result.predictive_scaling_configuration = null;
    result.scaling_adjustment = null;
    result.step_adjustments = null;
    result.target_tracking_configuration = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdjustmentType")) {
                    result.adjustment_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Alarms")) {
                    result.alarms = try deserializeAlarms(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cooldown")) {
                    result.cooldown = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EstimatedInstanceWarmup")) {
                    result.estimated_instance_warmup = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MetricAggregationType")) {
                    result.metric_aggregation_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinAdjustmentMagnitude")) {
                    result.min_adjustment_magnitude = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinAdjustmentStep")) {
                    result.min_adjustment_step = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyARN")) {
                    result.policy_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyType")) {
                    result.policy_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PredictiveScalingConfiguration")) {
                    result.predictive_scaling_configuration = try deserializePredictiveScalingConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ScalingAdjustment")) {
                    result.scaling_adjustment = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StepAdjustments")) {
                    result.step_adjustments = try deserializeStepAdjustments(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TargetTrackingConfiguration")) {
                    result.target_tracking_configuration = try deserializeTargetTrackingConfiguration(allocator, reader);
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

pub fn deserializeScheduledUpdateGroupAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScheduledUpdateGroupAction {
    var result: ScheduledUpdateGroupAction = undefined;
    result.auto_scaling_group_name = null;
    result.desired_capacity = null;
    result.end_time = null;
    result.max_size = null;
    result.min_size = null;
    result.recurrence = null;
    result.scheduled_action_arn = null;
    result.scheduled_action_name = null;
    result.start_time = null;
    result.time = null;
    result.time_zone = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DesiredCapacity")) {
                    result.desired_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxSize")) {
                    result.max_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinSize")) {
                    result.min_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Recurrence")) {
                    result.recurrence = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionARN")) {
                    result.scheduled_action_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionName")) {
                    result.scheduled_action_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Time")) {
                    result.time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TimeZone")) {
                    result.time_zone = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStepAdjustment(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StepAdjustment {
    _ = allocator;
    var result: StepAdjustment = undefined;
    result.metric_interval_lower_bound = null;
    result.metric_interval_upper_bound = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricIntervalLowerBound")) {
                    result.metric_interval_lower_bound = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MetricIntervalUpperBound")) {
                    result.metric_interval_upper_bound = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ScalingAdjustment")) {
                    result.scaling_adjustment = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
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

pub fn deserializeSuspendedProcess(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SuspendedProcess {
    var result: SuspendedProcess = undefined;
    result.process_name = null;
    result.suspension_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ProcessName")) {
                    result.process_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuspensionReason")) {
                    result.suspension_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTagDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TagDescription {
    var result: TagDescription = undefined;
    result.key = null;
    result.propagate_at_launch = null;
    result.resource_id = null;
    result.resource_type = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PropagateAtLaunch")) {
                    result.propagate_at_launch = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ResourceId")) {
                    result.resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTargetTrackingConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetTrackingConfiguration {
    var result: TargetTrackingConfiguration = undefined;
    result.customized_metric_specification = null;
    result.disable_scale_in = null;
    result.predefined_metric_specification = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CustomizedMetricSpecification")) {
                    result.customized_metric_specification = try deserializeCustomizedMetricSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DisableScaleIn")) {
                    result.disable_scale_in = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PredefinedMetricSpecification")) {
                    result.predefined_metric_specification = try deserializePredefinedMetricSpecification(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TargetValue")) {
                    result.target_value = try std.fmt.parseFloat(f64, try reader.readElementText());
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

pub fn deserializeTargetTrackingMetricDataQuery(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetTrackingMetricDataQuery {
    var result: TargetTrackingMetricDataQuery = undefined;
    result.expression = null;
    result.label = null;
    result.metric_stat = null;
    result.period = null;
    result.return_data = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Expression")) {
                    result.expression = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetricStat")) {
                    result.metric_stat = try deserializeTargetTrackingMetricStat(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ReturnData")) {
                    result.return_data = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeTargetTrackingMetricStat(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetTrackingMetricStat {
    var result: TargetTrackingMetricStat = undefined;
    result.period = null;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metric")) {
                    result.metric = try deserializeMetric(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTotalLocalStorageGBRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TotalLocalStorageGBRequest {
    _ = allocator;
    var result: TotalLocalStorageGBRequest = undefined;
    result.max = null;
    result.min = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Min")) {
                    result.min = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
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

pub fn deserializeTrafficSourceIdentifier(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrafficSourceIdentifier {
    var result: TrafficSourceIdentifier = undefined;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Identifier")) {
                    result.identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTrafficSourceState(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrafficSourceState {
    var result: TrafficSourceState = undefined;
    result.identifier = null;
    result.state = null;
    result.traffic_source = null;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Identifier")) {
                    result.identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficSource")) {
                    result.traffic_source = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeVCpuCountRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VCpuCountRequest {
    _ = allocator;
    var result: VCpuCountRequest = undefined;
    result.max = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Min")) {
                    result.min = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
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

pub fn deserializeWarmPoolConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !WarmPoolConfiguration {
    var result: WarmPoolConfiguration = undefined;
    result.instance_reuse_policy = null;
    result.max_group_prepared_capacity = null;
    result.min_size = null;
    result.pool_state = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstanceReusePolicy")) {
                    result.instance_reuse_policy = try deserializeInstanceReusePolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MaxGroupPreparedCapacity")) {
                    result.max_group_prepared_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinSize")) {
                    result.min_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PoolState")) {
                    result.pool_state = std.meta.stringToEnum(WarmPoolState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(WarmPoolStatus, try reader.readElementText());
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

pub fn serializeAcceleratorManufacturers(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AcceleratorManufacturer, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAcceleratorNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AcceleratorName, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAcceleratorTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AcceleratorType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeActivityIds(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAlarmList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAllowedInstanceTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAutoScalingGroupNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAutoScalingNotificationTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAvailabilityZoneIdsLimit1(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAvailabilityZonesLimit1(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeBlockDeviceMappings(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const BlockDeviceMapping, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeBlockDeviceMapping(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCapacityReservationIds(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCapacityReservationResourceGroupArns(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCheckpointPercentages(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const i32, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{item}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeClassicLinkVPCSecurityGroups(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCpuManufacturers(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CpuManufacturer, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeExcludedInstanceTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Filter, comptime item_tag: []const u8) !void {
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

pub fn serializeInstanceGenerations(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const InstanceGeneration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeInstanceIds(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeInstanceRefreshIds(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLaunchConfigurationNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLifecycleHookNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLifecycleHookSpecifications(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LifecycleHookSpecification, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeLifecycleHookSpecification(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLoadBalancerNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLocalStorageTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LocalStorageType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricDataQueries(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricDataQuery, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMetricDataQuery(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricDimensions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricDimension, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMetricDimension(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeOverrides(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LaunchTemplateOverrides, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeLaunchTemplateOverrides(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializePerformanceFactorReferenceSetRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PerformanceFactorReferenceRequest, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializePerformanceFactorReferenceRequest(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializePolicyNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePolicyTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePredictiveScalingMetricSpecifications(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PredictiveScalingMetricSpecification, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializePredictiveScalingMetricSpecification(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeProcessNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeScheduledActionNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeScheduledUpdateGroupActionRequests(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ScheduledUpdateGroupActionRequest, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeScheduledUpdateGroupActionRequest(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSecurityGroups(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeStepAdjustments(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StepAdjustment, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeStepAdjustment(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSubnetIdsLimit1(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTags(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
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

pub fn serializeTargetGroupARNs(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTargetTrackingMetricDataQueries(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TargetTrackingMetricDataQuery, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTargetTrackingMetricDataQuery(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTerminationPolicies(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTrafficSources(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TrafficSourceIdentifier, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTrafficSourceIdentifier(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeValues(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAcceleratorCountRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AcceleratorCountRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(allocator, "<Max>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(allocator, "<Min>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Min>");
    }
}

pub fn serializeAcceleratorTotalMemoryMiBRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AcceleratorTotalMemoryMiBRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(allocator, "<Max>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(allocator, "<Min>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Min>");
    }
}

pub fn serializeAlarmSpecification(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AlarmSpecification) !void {
    if (value.alarms) |v| {
        try buf.appendSlice(allocator, "<Alarms>");
        try serializeAlarmList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Alarms>");
    }
}

pub fn serializeAvailabilityZoneDistribution(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AvailabilityZoneDistribution) !void {
    if (value.capacity_distribution_strategy) |v| {
        try buf.appendSlice(allocator, "<CapacityDistributionStrategy>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</CapacityDistributionStrategy>");
    }
}

pub fn serializeAvailabilityZoneImpairmentPolicy(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AvailabilityZoneImpairmentPolicy) !void {
    if (value.impaired_zone_health_check_behavior) |v| {
        try buf.appendSlice(allocator, "<ImpairedZoneHealthCheckBehavior>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</ImpairedZoneHealthCheckBehavior>");
    }
    if (value.zonal_shift_enabled) |v| {
        try buf.appendSlice(allocator, "<ZonalShiftEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ZonalShiftEnabled>");
    }
}

pub fn serializeBaselineEbsBandwidthMbpsRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BaselineEbsBandwidthMbpsRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(allocator, "<Max>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(allocator, "<Min>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Min>");
    }
}

pub fn serializeBaselinePerformanceFactorsRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BaselinePerformanceFactorsRequest) !void {
    if (value.cpu) |v| {
        try buf.appendSlice(allocator, "<Cpu>");
        try serializeCpuPerformanceFactorRequest(allocator, buf, v);
        try buf.appendSlice(allocator, "</Cpu>");
    }
}

pub fn serializeBlockDeviceMapping(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BlockDeviceMapping) !void {
    try buf.appendSlice(allocator, "<DeviceName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.device_name);
    try buf.appendSlice(allocator, "</DeviceName>");
    if (value.ebs) |v| {
        try buf.appendSlice(allocator, "<Ebs>");
        try serializeEbs(allocator, buf, v);
        try buf.appendSlice(allocator, "</Ebs>");
    }
    if (value.no_device) |v| {
        try buf.appendSlice(allocator, "<NoDevice>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</NoDevice>");
    }
    if (value.virtual_name) |v| {
        try buf.appendSlice(allocator, "<VirtualName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</VirtualName>");
    }
}

pub fn serializeCapacityReservationSpecification(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CapacityReservationSpecification) !void {
    if (value.capacity_reservation_preference) |v| {
        try buf.appendSlice(allocator, "<CapacityReservationPreference>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</CapacityReservationPreference>");
    }
    if (value.capacity_reservation_target) |v| {
        try buf.appendSlice(allocator, "<CapacityReservationTarget>");
        try serializeCapacityReservationTarget(allocator, buf, v);
        try buf.appendSlice(allocator, "</CapacityReservationTarget>");
    }
}

pub fn serializeCapacityReservationTarget(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CapacityReservationTarget) !void {
    if (value.capacity_reservation_ids) |v| {
        try buf.appendSlice(allocator, "<CapacityReservationIds>");
        try serializeCapacityReservationIds(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</CapacityReservationIds>");
    }
    if (value.capacity_reservation_resource_group_arns) |v| {
        try buf.appendSlice(allocator, "<CapacityReservationResourceGroupArns>");
        try serializeCapacityReservationResourceGroupArns(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</CapacityReservationResourceGroupArns>");
    }
}

pub fn serializeCpuPerformanceFactorRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CpuPerformanceFactorRequest) !void {
    if (value.references) |v| {
        try buf.appendSlice(allocator, "<Reference>");
        try serializePerformanceFactorReferenceSetRequest(allocator, buf, v, "item");
        try buf.appendSlice(allocator, "</Reference>");
    }
}

pub fn serializeCustomizedMetricSpecification(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomizedMetricSpecification) !void {
    if (value.dimensions) |v| {
        try buf.appendSlice(allocator, "<Dimensions>");
        try serializeMetricDimensions(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Dimensions>");
    }
    if (value.metric_name) |v| {
        try buf.appendSlice(allocator, "<MetricName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</MetricName>");
    }
    if (value.metrics) |v| {
        try buf.appendSlice(allocator, "<Metrics>");
        try serializeTargetTrackingMetricDataQueries(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Metrics>");
    }
    if (value.namespace) |v| {
        try buf.appendSlice(allocator, "<Namespace>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Namespace>");
    }
    if (value.period) |v| {
        try buf.appendSlice(allocator, "<Period>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Period>");
    }
    if (value.statistic) |v| {
        try buf.appendSlice(allocator, "<Statistic>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</Statistic>");
    }
    if (value.unit) |v| {
        try buf.appendSlice(allocator, "<Unit>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Unit>");
    }
}

pub fn serializeDesiredConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DesiredConfiguration) !void {
    if (value.launch_template) |v| {
        try buf.appendSlice(allocator, "<LaunchTemplate>");
        try serializeLaunchTemplateSpecification(allocator, buf, v);
        try buf.appendSlice(allocator, "</LaunchTemplate>");
    }
    if (value.mixed_instances_policy) |v| {
        try buf.appendSlice(allocator, "<MixedInstancesPolicy>");
        try serializeMixedInstancesPolicy(allocator, buf, v);
        try buf.appendSlice(allocator, "</MixedInstancesPolicy>");
    }
}

pub fn serializeEbs(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Ebs) !void {
    if (value.delete_on_termination) |v| {
        try buf.appendSlice(allocator, "<DeleteOnTermination>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</DeleteOnTermination>");
    }
    if (value.encrypted) |v| {
        try buf.appendSlice(allocator, "<Encrypted>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Encrypted>");
    }
    if (value.iops) |v| {
        try buf.appendSlice(allocator, "<Iops>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Iops>");
    }
    if (value.snapshot_id) |v| {
        try buf.appendSlice(allocator, "<SnapshotId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SnapshotId>");
    }
    if (value.throughput) |v| {
        try buf.appendSlice(allocator, "<Throughput>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Throughput>");
    }
    if (value.volume_size) |v| {
        try buf.appendSlice(allocator, "<VolumeSize>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</VolumeSize>");
    }
    if (value.volume_type) |v| {
        try buf.appendSlice(allocator, "<VolumeType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</VolumeType>");
    }
}

pub fn serializeFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Filter) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeValues(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeInstanceLifecyclePolicy(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceLifecyclePolicy) !void {
    if (value.retention_triggers) |v| {
        try buf.appendSlice(allocator, "<RetentionTriggers>");
        try serializeRetentionTriggers(allocator, buf, v);
        try buf.appendSlice(allocator, "</RetentionTriggers>");
    }
}

pub fn serializeInstanceMaintenancePolicy(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceMaintenancePolicy) !void {
    if (value.max_healthy_percentage) |v| {
        try buf.appendSlice(allocator, "<MaxHealthyPercentage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxHealthyPercentage>");
    }
    if (value.min_healthy_percentage) |v| {
        try buf.appendSlice(allocator, "<MinHealthyPercentage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MinHealthyPercentage>");
    }
}

pub fn serializeInstanceMetadataOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceMetadataOptions) !void {
    if (value.http_endpoint) |v| {
        try buf.appendSlice(allocator, "<HttpEndpoint>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</HttpEndpoint>");
    }
    if (value.http_put_response_hop_limit) |v| {
        try buf.appendSlice(allocator, "<HttpPutResponseHopLimit>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</HttpPutResponseHopLimit>");
    }
    if (value.http_tokens) |v| {
        try buf.appendSlice(allocator, "<HttpTokens>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</HttpTokens>");
    }
}

pub fn serializeInstanceMonitoring(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceMonitoring) !void {
    if (value.enabled) |v| {
        try buf.appendSlice(allocator, "<Enabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Enabled>");
    }
}

pub fn serializeInstanceRequirements(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceRequirements) !void {
    if (value.accelerator_count) |v| {
        try buf.appendSlice(allocator, "<AcceleratorCount>");
        try serializeAcceleratorCountRequest(allocator, buf, v);
        try buf.appendSlice(allocator, "</AcceleratorCount>");
    }
    if (value.accelerator_manufacturers) |v| {
        try buf.appendSlice(allocator, "<AcceleratorManufacturers>");
        try serializeAcceleratorManufacturers(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</AcceleratorManufacturers>");
    }
    if (value.accelerator_names) |v| {
        try buf.appendSlice(allocator, "<AcceleratorNames>");
        try serializeAcceleratorNames(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</AcceleratorNames>");
    }
    if (value.accelerator_total_memory_mi_b) |v| {
        try buf.appendSlice(allocator, "<AcceleratorTotalMemoryMiB>");
        try serializeAcceleratorTotalMemoryMiBRequest(allocator, buf, v);
        try buf.appendSlice(allocator, "</AcceleratorTotalMemoryMiB>");
    }
    if (value.accelerator_types) |v| {
        try buf.appendSlice(allocator, "<AcceleratorTypes>");
        try serializeAcceleratorTypes(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</AcceleratorTypes>");
    }
    if (value.allowed_instance_types) |v| {
        try buf.appendSlice(allocator, "<AllowedInstanceTypes>");
        try serializeAllowedInstanceTypes(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</AllowedInstanceTypes>");
    }
    if (value.bare_metal) |v| {
        try buf.appendSlice(allocator, "<BareMetal>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</BareMetal>");
    }
    if (value.baseline_ebs_bandwidth_mbps) |v| {
        try buf.appendSlice(allocator, "<BaselineEbsBandwidthMbps>");
        try serializeBaselineEbsBandwidthMbpsRequest(allocator, buf, v);
        try buf.appendSlice(allocator, "</BaselineEbsBandwidthMbps>");
    }
    if (value.baseline_performance_factors) |v| {
        try buf.appendSlice(allocator, "<BaselinePerformanceFactors>");
        try serializeBaselinePerformanceFactorsRequest(allocator, buf, v);
        try buf.appendSlice(allocator, "</BaselinePerformanceFactors>");
    }
    if (value.burstable_performance) |v| {
        try buf.appendSlice(allocator, "<BurstablePerformance>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</BurstablePerformance>");
    }
    if (value.cpu_manufacturers) |v| {
        try buf.appendSlice(allocator, "<CpuManufacturers>");
        try serializeCpuManufacturers(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</CpuManufacturers>");
    }
    if (value.excluded_instance_types) |v| {
        try buf.appendSlice(allocator, "<ExcludedInstanceTypes>");
        try serializeExcludedInstanceTypes(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</ExcludedInstanceTypes>");
    }
    if (value.instance_generations) |v| {
        try buf.appendSlice(allocator, "<InstanceGenerations>");
        try serializeInstanceGenerations(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</InstanceGenerations>");
    }
    if (value.local_storage) |v| {
        try buf.appendSlice(allocator, "<LocalStorage>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</LocalStorage>");
    }
    if (value.local_storage_types) |v| {
        try buf.appendSlice(allocator, "<LocalStorageTypes>");
        try serializeLocalStorageTypes(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</LocalStorageTypes>");
    }
    if (value.max_spot_price_as_percentage_of_optimal_on_demand_price) |v| {
        try buf.appendSlice(allocator, "<MaxSpotPriceAsPercentageOfOptimalOnDemandPrice>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxSpotPriceAsPercentageOfOptimalOnDemandPrice>");
    }
    if (value.memory_gi_b_per_v_cpu) |v| {
        try buf.appendSlice(allocator, "<MemoryGiBPerVCpu>");
        try serializeMemoryGiBPerVCpuRequest(allocator, buf, v);
        try buf.appendSlice(allocator, "</MemoryGiBPerVCpu>");
    }
    try buf.appendSlice(allocator, "<MemoryMiB>");
    try serializeMemoryMiBRequest(allocator, buf, value.memory_mi_b);
    try buf.appendSlice(allocator, "</MemoryMiB>");
    if (value.network_bandwidth_gbps) |v| {
        try buf.appendSlice(allocator, "<NetworkBandwidthGbps>");
        try serializeNetworkBandwidthGbpsRequest(allocator, buf, v);
        try buf.appendSlice(allocator, "</NetworkBandwidthGbps>");
    }
    if (value.network_interface_count) |v| {
        try buf.appendSlice(allocator, "<NetworkInterfaceCount>");
        try serializeNetworkInterfaceCountRequest(allocator, buf, v);
        try buf.appendSlice(allocator, "</NetworkInterfaceCount>");
    }
    if (value.on_demand_max_price_percentage_over_lowest_price) |v| {
        try buf.appendSlice(allocator, "<OnDemandMaxPricePercentageOverLowestPrice>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</OnDemandMaxPricePercentageOverLowestPrice>");
    }
    if (value.require_hibernate_support) |v| {
        try buf.appendSlice(allocator, "<RequireHibernateSupport>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</RequireHibernateSupport>");
    }
    if (value.spot_max_price_percentage_over_lowest_price) |v| {
        try buf.appendSlice(allocator, "<SpotMaxPricePercentageOverLowestPrice>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</SpotMaxPricePercentageOverLowestPrice>");
    }
    if (value.total_local_storage_gb) |v| {
        try buf.appendSlice(allocator, "<TotalLocalStorageGB>");
        try serializeTotalLocalStorageGBRequest(allocator, buf, v);
        try buf.appendSlice(allocator, "</TotalLocalStorageGB>");
    }
    try buf.appendSlice(allocator, "<VCpuCount>");
    try serializeVCpuCountRequest(allocator, buf, value.v_cpu_count);
    try buf.appendSlice(allocator, "</VCpuCount>");
}

pub fn serializeInstanceReusePolicy(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceReusePolicy) !void {
    if (value.reuse_on_scale_in) |v| {
        try buf.appendSlice(allocator, "<ReuseOnScaleIn>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReuseOnScaleIn>");
    }
}

pub fn serializeInstancesDistribution(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstancesDistribution) !void {
    if (value.on_demand_allocation_strategy) |v| {
        try buf.appendSlice(allocator, "<OnDemandAllocationStrategy>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OnDemandAllocationStrategy>");
    }
    if (value.on_demand_base_capacity) |v| {
        try buf.appendSlice(allocator, "<OnDemandBaseCapacity>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</OnDemandBaseCapacity>");
    }
    if (value.on_demand_percentage_above_base_capacity) |v| {
        try buf.appendSlice(allocator, "<OnDemandPercentageAboveBaseCapacity>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</OnDemandPercentageAboveBaseCapacity>");
    }
    if (value.spot_allocation_strategy) |v| {
        try buf.appendSlice(allocator, "<SpotAllocationStrategy>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SpotAllocationStrategy>");
    }
    if (value.spot_instance_pools) |v| {
        try buf.appendSlice(allocator, "<SpotInstancePools>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</SpotInstancePools>");
    }
    if (value.spot_max_price) |v| {
        try buf.appendSlice(allocator, "<SpotMaxPrice>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SpotMaxPrice>");
    }
}

pub fn serializeLaunchTemplate(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LaunchTemplate) !void {
    if (value.launch_template_specification) |v| {
        try buf.appendSlice(allocator, "<LaunchTemplateSpecification>");
        try serializeLaunchTemplateSpecification(allocator, buf, v);
        try buf.appendSlice(allocator, "</LaunchTemplateSpecification>");
    }
    if (value.overrides) |v| {
        try buf.appendSlice(allocator, "<Overrides>");
        try serializeOverrides(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Overrides>");
    }
}

pub fn serializeLaunchTemplateOverrides(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LaunchTemplateOverrides) !void {
    if (value.image_id) |v| {
        try buf.appendSlice(allocator, "<ImageId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ImageId>");
    }
    if (value.instance_requirements) |v| {
        try buf.appendSlice(allocator, "<InstanceRequirements>");
        try serializeInstanceRequirements(allocator, buf, v);
        try buf.appendSlice(allocator, "</InstanceRequirements>");
    }
    if (value.instance_type) |v| {
        try buf.appendSlice(allocator, "<InstanceType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</InstanceType>");
    }
    if (value.launch_template_specification) |v| {
        try buf.appendSlice(allocator, "<LaunchTemplateSpecification>");
        try serializeLaunchTemplateSpecification(allocator, buf, v);
        try buf.appendSlice(allocator, "</LaunchTemplateSpecification>");
    }
    if (value.weighted_capacity) |v| {
        try buf.appendSlice(allocator, "<WeightedCapacity>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</WeightedCapacity>");
    }
}

pub fn serializeLaunchTemplateSpecification(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LaunchTemplateSpecification) !void {
    if (value.launch_template_id) |v| {
        try buf.appendSlice(allocator, "<LaunchTemplateId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</LaunchTemplateId>");
    }
    if (value.launch_template_name) |v| {
        try buf.appendSlice(allocator, "<LaunchTemplateName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</LaunchTemplateName>");
    }
    if (value.version) |v| {
        try buf.appendSlice(allocator, "<Version>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Version>");
    }
}

pub fn serializeLifecycleHookSpecification(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleHookSpecification) !void {
    if (value.default_result) |v| {
        try buf.appendSlice(allocator, "<DefaultResult>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultResult>");
    }
    if (value.heartbeat_timeout) |v| {
        try buf.appendSlice(allocator, "<HeartbeatTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</HeartbeatTimeout>");
    }
    try buf.appendSlice(allocator, "<LifecycleHookName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.lifecycle_hook_name);
    try buf.appendSlice(allocator, "</LifecycleHookName>");
    try buf.appendSlice(allocator, "<LifecycleTransition>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.lifecycle_transition);
    try buf.appendSlice(allocator, "</LifecycleTransition>");
    if (value.notification_metadata) |v| {
        try buf.appendSlice(allocator, "<NotificationMetadata>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</NotificationMetadata>");
    }
    if (value.notification_target_arn) |v| {
        try buf.appendSlice(allocator, "<NotificationTargetARN>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</NotificationTargetARN>");
    }
    if (value.role_arn) |v| {
        try buf.appendSlice(allocator, "<RoleARN>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RoleARN>");
    }
}

pub fn serializeMemoryGiBPerVCpuRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MemoryGiBPerVCpuRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(allocator, "<Max>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(allocator, "<Min>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Min>");
    }
}

pub fn serializeMemoryMiBRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MemoryMiBRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(allocator, "<Max>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Max>");
    }
    try buf.appendSlice(allocator, "<Min>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.min}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Min>");
}

pub fn serializeMetric(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Metric) !void {
    if (value.dimensions) |v| {
        try buf.appendSlice(allocator, "<Dimensions>");
        try serializeMetricDimensions(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Dimensions>");
    }
    try buf.appendSlice(allocator, "<MetricName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.metric_name);
    try buf.appendSlice(allocator, "</MetricName>");
    try buf.appendSlice(allocator, "<Namespace>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.namespace);
    try buf.appendSlice(allocator, "</Namespace>");
}

pub fn serializeMetricDataQuery(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricDataQuery) !void {
    if (value.expression) |v| {
        try buf.appendSlice(allocator, "<Expression>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Expression>");
    }
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    if (value.label) |v| {
        try buf.appendSlice(allocator, "<Label>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Label>");
    }
    if (value.metric_stat) |v| {
        try buf.appendSlice(allocator, "<MetricStat>");
        try serializeMetricStat(allocator, buf, v);
        try buf.appendSlice(allocator, "</MetricStat>");
    }
    if (value.return_data) |v| {
        try buf.appendSlice(allocator, "<ReturnData>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnData>");
    }
}

pub fn serializeMetricDimension(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricDimension) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeMetricStat(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStat) !void {
    try buf.appendSlice(allocator, "<Metric>");
    try serializeMetric(allocator, buf, value.metric);
    try buf.appendSlice(allocator, "</Metric>");
    try buf.appendSlice(allocator, "<Stat>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.stat);
    try buf.appendSlice(allocator, "</Stat>");
    if (value.unit) |v| {
        try buf.appendSlice(allocator, "<Unit>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Unit>");
    }
}

pub fn serializeMixedInstancesPolicy(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MixedInstancesPolicy) !void {
    if (value.instances_distribution) |v| {
        try buf.appendSlice(allocator, "<InstancesDistribution>");
        try serializeInstancesDistribution(allocator, buf, v);
        try buf.appendSlice(allocator, "</InstancesDistribution>");
    }
    if (value.launch_template) |v| {
        try buf.appendSlice(allocator, "<LaunchTemplate>");
        try serializeLaunchTemplate(allocator, buf, v);
        try buf.appendSlice(allocator, "</LaunchTemplate>");
    }
}

pub fn serializeNetworkBandwidthGbpsRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: NetworkBandwidthGbpsRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(allocator, "<Max>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(allocator, "<Min>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Min>");
    }
}

pub fn serializeNetworkInterfaceCountRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: NetworkInterfaceCountRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(allocator, "<Max>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(allocator, "<Min>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Min>");
    }
}

pub fn serializePerformanceFactorReferenceRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PerformanceFactorReferenceRequest) !void {
    if (value.instance_family) |v| {
        try buf.appendSlice(allocator, "<InstanceFamily>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</InstanceFamily>");
    }
}

pub fn serializePredefinedMetricSpecification(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredefinedMetricSpecification) !void {
    try buf.appendSlice(allocator, "<PredefinedMetricType>");
    try buf.appendSlice(allocator, @tagName(value.predefined_metric_type));
    try buf.appendSlice(allocator, "</PredefinedMetricType>");
    if (value.resource_label) |v| {
        try buf.appendSlice(allocator, "<ResourceLabel>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourceLabel>");
    }
}

pub fn serializePredictiveScalingConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingConfiguration) !void {
    if (value.max_capacity_breach_behavior) |v| {
        try buf.appendSlice(allocator, "<MaxCapacityBreachBehavior>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</MaxCapacityBreachBehavior>");
    }
    if (value.max_capacity_buffer) |v| {
        try buf.appendSlice(allocator, "<MaxCapacityBuffer>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxCapacityBuffer>");
    }
    try buf.appendSlice(allocator, "<MetricSpecifications>");
    try serializePredictiveScalingMetricSpecifications(allocator, buf, value.metric_specifications, "member");
    try buf.appendSlice(allocator, "</MetricSpecifications>");
    if (value.mode) |v| {
        try buf.appendSlice(allocator, "<Mode>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</Mode>");
    }
    if (value.scheduling_buffer_time) |v| {
        try buf.appendSlice(allocator, "<SchedulingBufferTime>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</SchedulingBufferTime>");
    }
}

pub fn serializePredictiveScalingCustomizedCapacityMetric(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingCustomizedCapacityMetric) !void {
    try buf.appendSlice(allocator, "<MetricDataQueries>");
    try serializeMetricDataQueries(allocator, buf, value.metric_data_queries, "member");
    try buf.appendSlice(allocator, "</MetricDataQueries>");
}

pub fn serializePredictiveScalingCustomizedLoadMetric(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingCustomizedLoadMetric) !void {
    try buf.appendSlice(allocator, "<MetricDataQueries>");
    try serializeMetricDataQueries(allocator, buf, value.metric_data_queries, "member");
    try buf.appendSlice(allocator, "</MetricDataQueries>");
}

pub fn serializePredictiveScalingCustomizedScalingMetric(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingCustomizedScalingMetric) !void {
    try buf.appendSlice(allocator, "<MetricDataQueries>");
    try serializeMetricDataQueries(allocator, buf, value.metric_data_queries, "member");
    try buf.appendSlice(allocator, "</MetricDataQueries>");
}

pub fn serializePredictiveScalingMetricSpecification(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingMetricSpecification) !void {
    if (value.customized_capacity_metric_specification) |v| {
        try buf.appendSlice(allocator, "<CustomizedCapacityMetricSpecification>");
        try serializePredictiveScalingCustomizedCapacityMetric(allocator, buf, v);
        try buf.appendSlice(allocator, "</CustomizedCapacityMetricSpecification>");
    }
    if (value.customized_load_metric_specification) |v| {
        try buf.appendSlice(allocator, "<CustomizedLoadMetricSpecification>");
        try serializePredictiveScalingCustomizedLoadMetric(allocator, buf, v);
        try buf.appendSlice(allocator, "</CustomizedLoadMetricSpecification>");
    }
    if (value.customized_scaling_metric_specification) |v| {
        try buf.appendSlice(allocator, "<CustomizedScalingMetricSpecification>");
        try serializePredictiveScalingCustomizedScalingMetric(allocator, buf, v);
        try buf.appendSlice(allocator, "</CustomizedScalingMetricSpecification>");
    }
    if (value.predefined_load_metric_specification) |v| {
        try buf.appendSlice(allocator, "<PredefinedLoadMetricSpecification>");
        try serializePredictiveScalingPredefinedLoadMetric(allocator, buf, v);
        try buf.appendSlice(allocator, "</PredefinedLoadMetricSpecification>");
    }
    if (value.predefined_metric_pair_specification) |v| {
        try buf.appendSlice(allocator, "<PredefinedMetricPairSpecification>");
        try serializePredictiveScalingPredefinedMetricPair(allocator, buf, v);
        try buf.appendSlice(allocator, "</PredefinedMetricPairSpecification>");
    }
    if (value.predefined_scaling_metric_specification) |v| {
        try buf.appendSlice(allocator, "<PredefinedScalingMetricSpecification>");
        try serializePredictiveScalingPredefinedScalingMetric(allocator, buf, v);
        try buf.appendSlice(allocator, "</PredefinedScalingMetricSpecification>");
    }
    try buf.appendSlice(allocator, "<TargetValue>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.target_value}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</TargetValue>");
}

pub fn serializePredictiveScalingPredefinedLoadMetric(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingPredefinedLoadMetric) !void {
    try buf.appendSlice(allocator, "<PredefinedMetricType>");
    try buf.appendSlice(allocator, @tagName(value.predefined_metric_type));
    try buf.appendSlice(allocator, "</PredefinedMetricType>");
    if (value.resource_label) |v| {
        try buf.appendSlice(allocator, "<ResourceLabel>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourceLabel>");
    }
}

pub fn serializePredictiveScalingPredefinedMetricPair(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingPredefinedMetricPair) !void {
    try buf.appendSlice(allocator, "<PredefinedMetricType>");
    try buf.appendSlice(allocator, @tagName(value.predefined_metric_type));
    try buf.appendSlice(allocator, "</PredefinedMetricType>");
    if (value.resource_label) |v| {
        try buf.appendSlice(allocator, "<ResourceLabel>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourceLabel>");
    }
}

pub fn serializePredictiveScalingPredefinedScalingMetric(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingPredefinedScalingMetric) !void {
    try buf.appendSlice(allocator, "<PredefinedMetricType>");
    try buf.appendSlice(allocator, @tagName(value.predefined_metric_type));
    try buf.appendSlice(allocator, "</PredefinedMetricType>");
    if (value.resource_label) |v| {
        try buf.appendSlice(allocator, "<ResourceLabel>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourceLabel>");
    }
}

pub fn serializeRefreshPreferences(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RefreshPreferences) !void {
    if (value.alarm_specification) |v| {
        try buf.appendSlice(allocator, "<AlarmSpecification>");
        try serializeAlarmSpecification(allocator, buf, v);
        try buf.appendSlice(allocator, "</AlarmSpecification>");
    }
    if (value.auto_rollback) |v| {
        try buf.appendSlice(allocator, "<AutoRollback>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</AutoRollback>");
    }
    if (value.bake_time) |v| {
        try buf.appendSlice(allocator, "<BakeTime>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</BakeTime>");
    }
    if (value.checkpoint_delay) |v| {
        try buf.appendSlice(allocator, "<CheckpointDelay>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</CheckpointDelay>");
    }
    if (value.checkpoint_percentages) |v| {
        try buf.appendSlice(allocator, "<CheckpointPercentages>");
        try serializeCheckpointPercentages(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</CheckpointPercentages>");
    }
    if (value.instance_warmup) |v| {
        try buf.appendSlice(allocator, "<InstanceWarmup>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</InstanceWarmup>");
    }
    if (value.max_healthy_percentage) |v| {
        try buf.appendSlice(allocator, "<MaxHealthyPercentage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxHealthyPercentage>");
    }
    if (value.min_healthy_percentage) |v| {
        try buf.appendSlice(allocator, "<MinHealthyPercentage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MinHealthyPercentage>");
    }
    if (value.scale_in_protected_instances) |v| {
        try buf.appendSlice(allocator, "<ScaleInProtectedInstances>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</ScaleInProtectedInstances>");
    }
    if (value.skip_matching) |v| {
        try buf.appendSlice(allocator, "<SkipMatching>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SkipMatching>");
    }
    if (value.standby_instances) |v| {
        try buf.appendSlice(allocator, "<StandbyInstances>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</StandbyInstances>");
    }
}

pub fn serializeRetentionTriggers(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RetentionTriggers) !void {
    if (value.terminate_hook_abandon) |v| {
        try buf.appendSlice(allocator, "<TerminateHookAbandon>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</TerminateHookAbandon>");
    }
}

pub fn serializeScheduledUpdateGroupActionRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScheduledUpdateGroupActionRequest) !void {
    if (value.desired_capacity) |v| {
        try buf.appendSlice(allocator, "<DesiredCapacity>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DesiredCapacity>");
    }
    if (value.end_time) |v| {
        try buf.appendSlice(allocator, "<EndTime>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</EndTime>");
    }
    if (value.max_size) |v| {
        try buf.appendSlice(allocator, "<MaxSize>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxSize>");
    }
    if (value.min_size) |v| {
        try buf.appendSlice(allocator, "<MinSize>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MinSize>");
    }
    if (value.recurrence) |v| {
        try buf.appendSlice(allocator, "<Recurrence>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Recurrence>");
    }
    try buf.appendSlice(allocator, "<ScheduledActionName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.scheduled_action_name);
    try buf.appendSlice(allocator, "</ScheduledActionName>");
    if (value.start_time) |v| {
        try buf.appendSlice(allocator, "<StartTime>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</StartTime>");
    }
    if (value.time_zone) |v| {
        try buf.appendSlice(allocator, "<TimeZone>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TimeZone>");
    }
}

pub fn serializeStepAdjustment(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StepAdjustment) !void {
    if (value.metric_interval_lower_bound) |v| {
        try buf.appendSlice(allocator, "<MetricIntervalLowerBound>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MetricIntervalLowerBound>");
    }
    if (value.metric_interval_upper_bound) |v| {
        try buf.appendSlice(allocator, "<MetricIntervalUpperBound>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MetricIntervalUpperBound>");
    }
    try buf.appendSlice(allocator, "<ScalingAdjustment>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.scaling_adjustment}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</ScalingAdjustment>");
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    if (value.propagate_at_launch) |v| {
        try buf.appendSlice(allocator, "<PropagateAtLaunch>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</PropagateAtLaunch>");
    }
    if (value.resource_id) |v| {
        try buf.appendSlice(allocator, "<ResourceId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourceId>");
    }
    if (value.resource_type) |v| {
        try buf.appendSlice(allocator, "<ResourceType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourceType>");
    }
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeTargetTrackingConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetTrackingConfiguration) !void {
    if (value.customized_metric_specification) |v| {
        try buf.appendSlice(allocator, "<CustomizedMetricSpecification>");
        try serializeCustomizedMetricSpecification(allocator, buf, v);
        try buf.appendSlice(allocator, "</CustomizedMetricSpecification>");
    }
    if (value.disable_scale_in) |v| {
        try buf.appendSlice(allocator, "<DisableScaleIn>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</DisableScaleIn>");
    }
    if (value.predefined_metric_specification) |v| {
        try buf.appendSlice(allocator, "<PredefinedMetricSpecification>");
        try serializePredefinedMetricSpecification(allocator, buf, v);
        try buf.appendSlice(allocator, "</PredefinedMetricSpecification>");
    }
    try buf.appendSlice(allocator, "<TargetValue>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.target_value}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</TargetValue>");
}

pub fn serializeTargetTrackingMetricDataQuery(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetTrackingMetricDataQuery) !void {
    if (value.expression) |v| {
        try buf.appendSlice(allocator, "<Expression>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Expression>");
    }
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    if (value.label) |v| {
        try buf.appendSlice(allocator, "<Label>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Label>");
    }
    if (value.metric_stat) |v| {
        try buf.appendSlice(allocator, "<MetricStat>");
        try serializeTargetTrackingMetricStat(allocator, buf, v);
        try buf.appendSlice(allocator, "</MetricStat>");
    }
    if (value.period) |v| {
        try buf.appendSlice(allocator, "<Period>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Period>");
    }
    if (value.return_data) |v| {
        try buf.appendSlice(allocator, "<ReturnData>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnData>");
    }
}

pub fn serializeTargetTrackingMetricStat(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetTrackingMetricStat) !void {
    try buf.appendSlice(allocator, "<Metric>");
    try serializeMetric(allocator, buf, value.metric);
    try buf.appendSlice(allocator, "</Metric>");
    if (value.period) |v| {
        try buf.appendSlice(allocator, "<Period>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Period>");
    }
    try buf.appendSlice(allocator, "<Stat>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.stat);
    try buf.appendSlice(allocator, "</Stat>");
    if (value.unit) |v| {
        try buf.appendSlice(allocator, "<Unit>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Unit>");
    }
}

pub fn serializeTotalLocalStorageGBRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TotalLocalStorageGBRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(allocator, "<Max>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(allocator, "<Min>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Min>");
    }
}

pub fn serializeTrafficSourceIdentifier(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrafficSourceIdentifier) !void {
    try buf.appendSlice(allocator, "<Identifier>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.identifier);
    try buf.appendSlice(allocator, "</Identifier>");
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Type>");
    }
}

pub fn serializeVCpuCountRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: VCpuCountRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(allocator, "<Max>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Max>");
    }
    try buf.appendSlice(allocator, "<Min>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.min}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Min>");
}

