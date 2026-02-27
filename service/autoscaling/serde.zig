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

pub fn deserializeAcceleratorManufacturers(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AcceleratorManufacturer {
    var list: std.ArrayList(AcceleratorManufacturer) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(AcceleratorManufacturer, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeAcceleratorNames(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AcceleratorName {
    var list: std.ArrayList(AcceleratorName) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(AcceleratorName, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeAcceleratorTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AcceleratorType {
    var list: std.ArrayList(AcceleratorType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(AcceleratorType, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeActivities(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Activity {
    var list: std.ArrayList(Activity) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeActivity(reader, alloc));
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

pub fn deserializeAdjustmentTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AdjustmentType {
    var list: std.ArrayList(AdjustmentType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAdjustmentType(reader, alloc));
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

pub fn deserializeAlarmList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAlarms(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Alarm {
    var list: std.ArrayList(Alarm) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAlarm(reader, alloc));
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

pub fn deserializeAllowedInstanceTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAutoScalingGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AutoScalingGroup {
    var list: std.ArrayList(AutoScalingGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAutoScalingGroup(reader, alloc));
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

pub fn deserializeAutoScalingInstances(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AutoScalingInstanceDetails {
    var list: std.ArrayList(AutoScalingInstanceDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAutoScalingInstanceDetails(reader, alloc));
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

pub fn deserializeAutoScalingNotificationTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeBlockDeviceMappings(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const BlockDeviceMapping {
    var list: std.ArrayList(BlockDeviceMapping) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeBlockDeviceMapping(reader, alloc));
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

pub fn deserializeCapacityReservationIds(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCapacityReservationResourceGroupArns(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCheckpointPercentages(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const i32 {
    var list: std.ArrayList(i32) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null) |v| try list.append(alloc, v);
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

pub fn deserializeClassicLinkVPCSecurityGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCpuManufacturers(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CpuManufacturer {
    var list: std.ArrayList(CpuManufacturer) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(CpuManufacturer, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeEnabledMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EnabledMetric {
    var list: std.ArrayList(EnabledMetric) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEnabledMetric(reader, alloc));
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

pub fn deserializeExcludedInstanceTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeFailedScheduledUpdateGroupActionRequests(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const FailedScheduledUpdateGroupActionRequest {
    var list: std.ArrayList(FailedScheduledUpdateGroupActionRequest) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeFailedScheduledUpdateGroupActionRequest(reader, alloc));
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

pub fn deserializeInstanceCollections(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InstanceCollection {
    var list: std.ArrayList(InstanceCollection) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInstanceCollection(reader, alloc));
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

pub fn deserializeInstanceGenerations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InstanceGeneration {
    var list: std.ArrayList(InstanceGeneration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(InstanceGeneration, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeInstanceIds(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeInstanceRefreshes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InstanceRefresh {
    var list: std.ArrayList(InstanceRefresh) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInstanceRefresh(reader, alloc));
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

pub fn deserializeInstances(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Instance {
    var list: std.ArrayList(Instance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInstance(reader, alloc));
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

pub fn deserializeLaunchConfigurations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LaunchConfiguration {
    var list: std.ArrayList(LaunchConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLaunchConfiguration(reader, alloc));
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

pub fn deserializeLaunchInstancesErrors(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LaunchInstancesError {
    var list: std.ArrayList(LaunchInstancesError) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLaunchInstancesError(reader, alloc));
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

pub fn deserializeLifecycleHooks(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LifecycleHook {
    var list: std.ArrayList(LifecycleHook) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLifecycleHook(reader, alloc));
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

pub fn deserializeLoadBalancerNames(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeLoadBalancerStates(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LoadBalancerState {
    var list: std.ArrayList(LoadBalancerState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLoadBalancerState(reader, alloc));
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

pub fn deserializeLoadBalancerTargetGroupStates(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LoadBalancerTargetGroupState {
    var list: std.ArrayList(LoadBalancerTargetGroupState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLoadBalancerTargetGroupState(reader, alloc));
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

pub fn deserializeLoadForecasts(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LoadForecast {
    var list: std.ArrayList(LoadForecast) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLoadForecast(reader, alloc));
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

pub fn deserializeLocalStorageTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LocalStorageType {
    var list: std.ArrayList(LocalStorageType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(LocalStorageType, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeMetricCollectionTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricCollectionType {
    var list: std.ArrayList(MetricCollectionType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricCollectionType(reader, alloc));
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

pub fn deserializeMetricDataQueries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricDataQuery {
    var list: std.ArrayList(MetricDataQuery) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricDataQuery(reader, alloc));
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

pub fn deserializeMetricDimensions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricDimension {
    var list: std.ArrayList(MetricDimension) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricDimension(reader, alloc));
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

pub fn deserializeMetricGranularityTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricGranularityType {
    var list: std.ArrayList(MetricGranularityType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricGranularityType(reader, alloc));
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

pub fn deserializeNotificationConfigurations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const NotificationConfiguration {
    var list: std.ArrayList(NotificationConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeNotificationConfiguration(reader, alloc));
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

pub fn deserializeOverrides(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LaunchTemplateOverrides {
    var list: std.ArrayList(LaunchTemplateOverrides) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLaunchTemplateOverrides(reader, alloc));
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

pub fn deserializePerformanceFactorReferenceSetRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PerformanceFactorReferenceRequest {
    var list: std.ArrayList(PerformanceFactorReferenceRequest) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePerformanceFactorReferenceRequest(reader, alloc));
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

pub fn deserializePredictiveScalingForecastTimestamps(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const i64 {
    var list: std.ArrayList(i64) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (aws.date.parseIso8601(try reader.readElementText()) catch null) |v| try list.append(alloc, v);
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

pub fn deserializePredictiveScalingForecastValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const f64 {
    var list: std.ArrayList(f64) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseFloat(f64, try reader.readElementText()) catch null) |v| try list.append(alloc, v);
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

pub fn deserializePredictiveScalingMetricSpecifications(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PredictiveScalingMetricSpecification {
    var list: std.ArrayList(PredictiveScalingMetricSpecification) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePredictiveScalingMetricSpecification(reader, alloc));
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

pub fn deserializeProcesses(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ProcessType {
    var list: std.ArrayList(ProcessType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeProcessType(reader, alloc));
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

pub fn deserializeScalingPolicies(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ScalingPolicy {
    var list: std.ArrayList(ScalingPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeScalingPolicy(reader, alloc));
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

pub fn deserializeScheduledUpdateGroupActions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ScheduledUpdateGroupAction {
    var list: std.ArrayList(ScheduledUpdateGroupAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeScheduledUpdateGroupAction(reader, alloc));
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

pub fn deserializeSecurityGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeStepAdjustments(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StepAdjustment {
    var list: std.ArrayList(StepAdjustment) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStepAdjustment(reader, alloc));
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

pub fn deserializeSuspendedProcesses(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SuspendedProcess {
    var list: std.ArrayList(SuspendedProcess) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSuspendedProcess(reader, alloc));
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

pub fn deserializeTagDescriptionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TagDescription {
    var list: std.ArrayList(TagDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTagDescription(reader, alloc));
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

pub fn deserializeTargetGroupARNs(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTargetTrackingMetricDataQueries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TargetTrackingMetricDataQuery {
    var list: std.ArrayList(TargetTrackingMetricDataQuery) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTargetTrackingMetricDataQuery(reader, alloc));
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

pub fn deserializeTerminationPolicies(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTrafficSourceStates(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrafficSourceState {
    var list: std.ArrayList(TrafficSourceState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrafficSourceState(reader, alloc));
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

pub fn deserializeTrafficSources(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrafficSourceIdentifier {
    var list: std.ArrayList(TrafficSourceIdentifier) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrafficSourceIdentifier(reader, alloc));
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

pub fn deserializeAcceleratorCountRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AcceleratorCountRequest {
    _ = alloc;
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

pub fn deserializeAcceleratorTotalMemoryMiBRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AcceleratorTotalMemoryMiBRequest {
    _ = alloc;
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

pub fn deserializeActivity(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Activity {
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
                    result.activity_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupARN")) {
                    result.auto_scaling_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupState")) {
                    result.auto_scaling_group_state = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cause")) {
                    result.cause = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Details")) {
                    result.details = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Progress")) {
                    result.progress = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = std.meta.stringToEnum(ScalingActivityStatusCode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusMessage")) {
                    result.status_message = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAdjustmentType(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AdjustmentType {
    var result: AdjustmentType = undefined;
    result.adjustment_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdjustmentType")) {
                    result.adjustment_type = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAlarm(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Alarm {
    var result: Alarm = undefined;
    result.alarm_arn = null;
    result.alarm_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmARN")) {
                    result.alarm_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmName")) {
                    result.alarm_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAlarmSpecification(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AlarmSpecification {
    var result: AlarmSpecification = undefined;
    result.alarms = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Alarms")) {
                    result.alarms = try deserializeAlarmList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAutoScalingGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AutoScalingGroup {
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
                    result.auto_scaling_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZoneDistribution")) {
                    result.availability_zone_distribution = try deserializeAvailabilityZoneDistribution(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AvailabilityZoneImpairmentPolicy")) {
                    result.availability_zone_impairment_policy = try deserializeAvailabilityZoneImpairmentPolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "CapacityRebalance")) {
                    result.capacity_rebalance = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CapacityReservationSpecification")) {
                    result.capacity_reservation_specification = try deserializeCapacityReservationSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Context")) {
                    result.context = try alloc.dupe(u8, try reader.readElementText());
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
                    result.desired_capacity_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnabledMetrics")) {
                    result.enabled_metrics = try deserializeEnabledMetrics(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "HealthCheckGracePeriod")) {
                    result.health_check_grace_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "HealthCheckType")) {
                    result.health_check_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceLifecyclePolicy")) {
                    result.instance_lifecycle_policy = try deserializeInstanceLifecyclePolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "InstanceMaintenancePolicy")) {
                    result.instance_maintenance_policy = try deserializeInstanceMaintenancePolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Instances")) {
                    result.instances = try deserializeInstances(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationName")) {
                    result.launch_configuration_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplateSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LoadBalancerNames")) {
                    result.load_balancer_names = try deserializeLoadBalancerNames(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MaxInstanceLifetime")) {
                    result.max_instance_lifetime = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxSize")) {
                    result.max_size = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "MinSize")) {
                    result.min_size = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "MixedInstancesPolicy")) {
                    result.mixed_instances_policy = try deserializeMixedInstancesPolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "NewInstancesProtectedFromScaleIn")) {
                    result.new_instances_protected_from_scale_in = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PlacementGroup")) {
                    result.placement_group = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PredictedCapacity")) {
                    result.predicted_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceLinkedRoleARN")) {
                    result.service_linked_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuspendedProcesses")) {
                    result.suspended_processes = try deserializeSuspendedProcesses(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagDescriptionList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "TargetGroupARNs")) {
                    result.target_group_ar_ns = try deserializeTargetGroupARNs(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "TerminationPolicies")) {
                    result.termination_policies = try deserializeTerminationPolicies(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "TrafficSources")) {
                    result.traffic_sources = try deserializeTrafficSources(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "VPCZoneIdentifier")) {
                    result.vpc_zone_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "WarmPoolConfiguration")) {
                    result.warm_pool_configuration = try deserializeWarmPoolConfiguration(reader, alloc);
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

pub fn deserializeAutoScalingInstanceDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AutoScalingInstanceDetails {
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
                    result.auto_scaling_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationName")) {
                    result.launch_configuration_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplateSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LifecycleState")) {
                    result.lifecycle_state = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProtectedFromScaleIn")) {
                    result.protected_from_scale_in = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "WeightedCapacity")) {
                    result.weighted_capacity = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAvailabilityZoneDistribution(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AvailabilityZoneDistribution {
    _ = alloc;
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

pub fn deserializeAvailabilityZoneImpairmentPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AvailabilityZoneImpairmentPolicy {
    _ = alloc;
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

pub fn deserializeBaselineEbsBandwidthMbpsRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BaselineEbsBandwidthMbpsRequest {
    _ = alloc;
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

pub fn deserializeBaselinePerformanceFactorsRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BaselinePerformanceFactorsRequest {
    var result: BaselinePerformanceFactorsRequest = undefined;
    result.cpu = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cpu")) {
                    result.cpu = try deserializeCpuPerformanceFactorRequest(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeBlockDeviceMapping(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BlockDeviceMapping {
    var result: BlockDeviceMapping = undefined;
    result.ebs = null;
    result.no_device = null;
    result.virtual_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeviceName")) {
                    result.device_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Ebs")) {
                    result.ebs = try deserializeEbs(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "NoDevice")) {
                    result.no_device = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "VirtualName")) {
                    result.virtual_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCapacityForecast(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CapacityForecast {
    var result: CapacityForecast = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Timestamps")) {
                    result.timestamps = try deserializePredictiveScalingForecastTimestamps(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializePredictiveScalingForecastValues(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCapacityReservationSpecification(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CapacityReservationSpecification {
    var result: CapacityReservationSpecification = undefined;
    result.capacity_reservation_preference = null;
    result.capacity_reservation_target = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CapacityReservationPreference")) {
                    result.capacity_reservation_preference = std.meta.stringToEnum(CapacityReservationPreference, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CapacityReservationTarget")) {
                    result.capacity_reservation_target = try deserializeCapacityReservationTarget(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCapacityReservationTarget(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CapacityReservationTarget {
    var result: CapacityReservationTarget = undefined;
    result.capacity_reservation_ids = null;
    result.capacity_reservation_resource_group_arns = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CapacityReservationIds")) {
                    result.capacity_reservation_ids = try deserializeCapacityReservationIds(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "CapacityReservationResourceGroupArns")) {
                    result.capacity_reservation_resource_group_arns = try deserializeCapacityReservationResourceGroupArns(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCpuPerformanceFactorRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CpuPerformanceFactorRequest {
    var result: CpuPerformanceFactorRequest = undefined;
    result.references = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Reference")) {
                    result.references = try deserializePerformanceFactorReferenceSetRequest(reader, alloc, "item");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomizedMetricSpecification(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CustomizedMetricSpecification {
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
                    result.dimensions = try deserializeMetricDimensions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try deserializeTargetTrackingMetricDataQueries(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Statistic")) {
                    result.statistic = std.meta.stringToEnum(MetricStatistic, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDesiredConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DesiredConfiguration {
    var result: DesiredConfiguration = undefined;
    result.launch_template = null;
    result.mixed_instances_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplateSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MixedInstancesPolicy")) {
                    result.mixed_instances_policy = try deserializeMixedInstancesPolicy(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEbs(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Ebs {
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
                    result.snapshot_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Throughput")) {
                    result.throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "VolumeSize")) {
                    result.volume_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "VolumeType")) {
                    result.volume_type = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnabledMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EnabledMetric {
    var result: EnabledMetric = undefined;
    result.granularity = null;
    result.metric = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Granularity")) {
                    result.granularity = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeFailedScheduledUpdateGroupActionRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FailedScheduledUpdateGroupActionRequest {
    var result: FailedScheduledUpdateGroupActionRequest = undefined;
    result.error_code = null;
    result.error_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionName")) {
                    result.scheduled_action_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInstance(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Instance {
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
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationName")) {
                    result.launch_configuration_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplateSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LifecycleState")) {
                    result.lifecycle_state = std.meta.stringToEnum(LifecycleState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProtectedFromScaleIn")) {
                    result.protected_from_scale_in = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "WeightedCapacity")) {
                    result.weighted_capacity = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInstanceCollection(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceCollection {
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
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZoneId")) {
                    result.availability_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceIds")) {
                    result.instance_ids = try deserializeInstanceIds(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MarketType")) {
                    result.market_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetId")) {
                    result.subnet_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInstanceLifecyclePolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceLifecyclePolicy {
    var result: InstanceLifecyclePolicy = undefined;
    result.retention_triggers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RetentionTriggers")) {
                    result.retention_triggers = try deserializeRetentionTriggers(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInstanceMaintenancePolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceMaintenancePolicy {
    _ = alloc;
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

pub fn deserializeInstanceMetadataOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceMetadataOptions {
    _ = alloc;
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

pub fn deserializeInstanceMonitoring(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceMonitoring {
    _ = alloc;
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

pub fn deserializeInstanceRefresh(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceRefresh {
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
                    result.auto_scaling_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DesiredConfiguration")) {
                    result.desired_configuration = try deserializeDesiredConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "InstanceRefreshId")) {
                    result.instance_refresh_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstancesToUpdate")) {
                    result.instances_to_update = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PercentageComplete")) {
                    result.percentage_complete = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Preferences")) {
                    result.preferences = try deserializeRefreshPreferences(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ProgressDetails")) {
                    result.progress_details = try deserializeInstanceRefreshProgressDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RollbackDetails")) {
                    result.rollback_details = try deserializeRollbackDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(InstanceRefreshStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeInstanceRefreshLivePoolProgress(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceRefreshLivePoolProgress {
    _ = alloc;
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

pub fn deserializeInstanceRefreshProgressDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceRefreshProgressDetails {
    var result: InstanceRefreshProgressDetails = undefined;
    result.live_pool_progress = null;
    result.warm_pool_progress = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LivePoolProgress")) {
                    result.live_pool_progress = try deserializeInstanceRefreshLivePoolProgress(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "WarmPoolProgress")) {
                    result.warm_pool_progress = try deserializeInstanceRefreshWarmPoolProgress(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInstanceRefreshWarmPoolProgress(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceRefreshWarmPoolProgress {
    _ = alloc;
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

pub fn deserializeInstanceRequirements(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceRequirements {
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
                    result.accelerator_count = try deserializeAcceleratorCountRequest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AcceleratorManufacturers")) {
                    result.accelerator_manufacturers = try deserializeAcceleratorManufacturers(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AcceleratorNames")) {
                    result.accelerator_names = try deserializeAcceleratorNames(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AcceleratorTotalMemoryMiB")) {
                    result.accelerator_total_memory_mi_b = try deserializeAcceleratorTotalMemoryMiBRequest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AcceleratorTypes")) {
                    result.accelerator_types = try deserializeAcceleratorTypes(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AllowedInstanceTypes")) {
                    result.allowed_instance_types = try deserializeAllowedInstanceTypes(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "BareMetal")) {
                    result.bare_metal = std.meta.stringToEnum(BareMetal, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BaselineEbsBandwidthMbps")) {
                    result.baseline_ebs_bandwidth_mbps = try deserializeBaselineEbsBandwidthMbpsRequest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "BaselinePerformanceFactors")) {
                    result.baseline_performance_factors = try deserializeBaselinePerformanceFactorsRequest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "BurstablePerformance")) {
                    result.burstable_performance = std.meta.stringToEnum(BurstablePerformance, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CpuManufacturers")) {
                    result.cpu_manufacturers = try deserializeCpuManufacturers(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ExcludedInstanceTypes")) {
                    result.excluded_instance_types = try deserializeExcludedInstanceTypes(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "InstanceGenerations")) {
                    result.instance_generations = try deserializeInstanceGenerations(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LocalStorage")) {
                    result.local_storage = std.meta.stringToEnum(LocalStorage, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LocalStorageTypes")) {
                    result.local_storage_types = try deserializeLocalStorageTypes(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MaxSpotPriceAsPercentageOfOptimalOnDemandPrice")) {
                    result.max_spot_price_as_percentage_of_optimal_on_demand_price = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MemoryGiBPerVCpu")) {
                    result.memory_gi_b_per_v_cpu = try deserializeMemoryGiBPerVCpuRequest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MemoryMiB")) {
                    result.memory_mi_b = try deserializeMemoryMiBRequest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "NetworkBandwidthGbps")) {
                    result.network_bandwidth_gbps = try deserializeNetworkBandwidthGbpsRequest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "NetworkInterfaceCount")) {
                    result.network_interface_count = try deserializeNetworkInterfaceCountRequest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "OnDemandMaxPricePercentageOverLowestPrice")) {
                    result.on_demand_max_price_percentage_over_lowest_price = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RequireHibernateSupport")) {
                    result.require_hibernate_support = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SpotMaxPricePercentageOverLowestPrice")) {
                    result.spot_max_price_percentage_over_lowest_price = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TotalLocalStorageGB")) {
                    result.total_local_storage_gb = try deserializeTotalLocalStorageGBRequest(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "VCpuCount")) {
                    result.v_cpu_count = try deserializeVCpuCountRequest(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInstanceReusePolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceReusePolicy {
    _ = alloc;
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

pub fn deserializeInstancesDistribution(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstancesDistribution {
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
                    result.on_demand_allocation_strategy = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OnDemandBaseCapacity")) {
                    result.on_demand_base_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OnDemandPercentageAboveBaseCapacity")) {
                    result.on_demand_percentage_above_base_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SpotAllocationStrategy")) {
                    result.spot_allocation_strategy = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SpotInstancePools")) {
                    result.spot_instance_pools = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SpotMaxPrice")) {
                    result.spot_max_price = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLaunchConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LaunchConfiguration {
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
                    result.block_device_mappings = try deserializeBlockDeviceMappings(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ClassicLinkVPCId")) {
                    result.classic_link_vpc_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClassicLinkVPCSecurityGroups")) {
                    result.classic_link_vpc_security_groups = try deserializeClassicLinkVPCSecurityGroups(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EbsOptimized")) {
                    result.ebs_optimized = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IamInstanceProfile")) {
                    result.iam_instance_profile = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceMonitoring")) {
                    result.instance_monitoring = try deserializeInstanceMonitoring(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KernelId")) {
                    result.kernel_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyName")) {
                    result.key_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationARN")) {
                    result.launch_configuration_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurationName")) {
                    result.launch_configuration_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetadataOptions")) {
                    result.metadata_options = try deserializeInstanceMetadataOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PlacementTenancy")) {
                    result.placement_tenancy = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RamdiskId")) {
                    result.ramdisk_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecurityGroups")) {
                    result.security_groups = try deserializeSecurityGroups(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SpotPrice")) {
                    result.spot_price = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserData")) {
                    result.user_data = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLaunchInstancesError(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LaunchInstancesError {
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
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZoneId")) {
                    result.availability_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MarketType")) {
                    result.market_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetId")) {
                    result.subnet_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLaunchTemplate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LaunchTemplate {
    var result: LaunchTemplate = undefined;
    result.launch_template_specification = null;
    result.overrides = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LaunchTemplateSpecification")) {
                    result.launch_template_specification = try deserializeLaunchTemplateSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Overrides")) {
                    result.overrides = try deserializeOverrides(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLaunchTemplateOverrides(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LaunchTemplateOverrides {
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
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceRequirements")) {
                    result.instance_requirements = try deserializeInstanceRequirements(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplateSpecification")) {
                    result.launch_template_specification = try deserializeLaunchTemplateSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "WeightedCapacity")) {
                    result.weighted_capacity = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLaunchTemplateSpecification(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LaunchTemplateSpecification {
    var result: LaunchTemplateSpecification = undefined;
    result.launch_template_id = null;
    result.launch_template_name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LaunchTemplateId")) {
                    result.launch_template_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchTemplateName")) {
                    result.launch_template_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLifecycleHook(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LifecycleHook {
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
                    result.auto_scaling_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultResult")) {
                    result.default_result = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalTimeout")) {
                    result.global_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "HeartbeatTimeout")) {
                    result.heartbeat_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LifecycleHookName")) {
                    result.lifecycle_hook_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LifecycleTransition")) {
                    result.lifecycle_transition = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NotificationMetadata")) {
                    result.notification_metadata = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NotificationTargetARN")) {
                    result.notification_target_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleARN")) {
                    result.role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoadBalancerState(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancerState {
    var result: LoadBalancerState = undefined;
    result.load_balancer_name = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoadBalancerTargetGroupState(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancerTargetGroupState {
    var result: LoadBalancerTargetGroupState = undefined;
    result.load_balancer_target_group_arn = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancerTargetGroupARN")) {
                    result.load_balancer_target_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoadForecast(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadForecast {
    var result: LoadForecast = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricSpecification")) {
                    result.metric_specification = try deserializePredictiveScalingMetricSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Timestamps")) {
                    result.timestamps = try deserializePredictiveScalingForecastTimestamps(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializePredictiveScalingForecastValues(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMemoryGiBPerVCpuRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MemoryGiBPerVCpuRequest {
    _ = alloc;
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

pub fn deserializeMemoryMiBRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MemoryMiBRequest {
    _ = alloc;
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

pub fn deserializeMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Metric {
    var result: Metric = undefined;
    result.dimensions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeMetricDimensions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricCollectionType(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricCollectionType {
    var result: MetricCollectionType = undefined;
    result.metric = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metric")) {
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

pub fn deserializeMetricDataQuery(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricDataQuery {
    var result: MetricDataQuery = undefined;
    result.expression = null;
    result.label = null;
    result.metric_stat = null;
    result.return_data = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Expression")) {
                    result.expression = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetricStat")) {
                    result.metric_stat = try deserializeMetricStat(reader, alloc);
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

pub fn deserializeMetricDimension(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricDimension {
    var result: MetricDimension = undefined;
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

pub fn deserializeMetricGranularityType(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricGranularityType {
    var result: MetricGranularityType = undefined;
    result.granularity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Granularity")) {
                    result.granularity = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStat(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricStat {
    var result: MetricStat = undefined;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metric")) {
                    result.metric = try deserializeMetric(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMixedInstancesPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MixedInstancesPolicy {
    var result: MixedInstancesPolicy = undefined;
    result.instances_distribution = null;
    result.launch_template = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstancesDistribution")) {
                    result.instances_distribution = try deserializeInstancesDistribution(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LaunchTemplate")) {
                    result.launch_template = try deserializeLaunchTemplate(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNetworkBandwidthGbpsRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NetworkBandwidthGbpsRequest {
    _ = alloc;
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

pub fn deserializeNetworkInterfaceCountRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NetworkInterfaceCountRequest {
    _ = alloc;
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

pub fn deserializeNotificationConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NotificationConfiguration {
    var result: NotificationConfiguration = undefined;
    result.auto_scaling_group_name = null;
    result.notification_type = null;
    result.topic_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NotificationType")) {
                    result.notification_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicARN")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePerformanceFactorReferenceRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PerformanceFactorReferenceRequest {
    var result: PerformanceFactorReferenceRequest = undefined;
    result.instance_family = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstanceFamily")) {
                    result.instance_family = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePredefinedMetricSpecification(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PredefinedMetricSpecification {
    var result: PredefinedMetricSpecification = undefined;
    result.resource_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PredefinedMetricType")) {
                    result.predefined_metric_type = std.meta.stringToEnum(MetricType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLabel")) {
                    result.resource_label = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePredictiveScalingConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PredictiveScalingConfiguration {
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
                    result.metric_specifications = try deserializePredictiveScalingMetricSpecifications(reader, alloc, "member");
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

pub fn deserializePredictiveScalingCustomizedCapacityMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PredictiveScalingCustomizedCapacityMetric {
    var result: PredictiveScalingCustomizedCapacityMetric = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricDataQueries")) {
                    result.metric_data_queries = try deserializeMetricDataQueries(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePredictiveScalingCustomizedLoadMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PredictiveScalingCustomizedLoadMetric {
    var result: PredictiveScalingCustomizedLoadMetric = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricDataQueries")) {
                    result.metric_data_queries = try deserializeMetricDataQueries(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePredictiveScalingCustomizedScalingMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PredictiveScalingCustomizedScalingMetric {
    var result: PredictiveScalingCustomizedScalingMetric = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricDataQueries")) {
                    result.metric_data_queries = try deserializeMetricDataQueries(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePredictiveScalingMetricSpecification(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PredictiveScalingMetricSpecification {
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
                    result.customized_capacity_metric_specification = try deserializePredictiveScalingCustomizedCapacityMetric(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CustomizedLoadMetricSpecification")) {
                    result.customized_load_metric_specification = try deserializePredictiveScalingCustomizedLoadMetric(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CustomizedScalingMetricSpecification")) {
                    result.customized_scaling_metric_specification = try deserializePredictiveScalingCustomizedScalingMetric(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PredefinedLoadMetricSpecification")) {
                    result.predefined_load_metric_specification = try deserializePredictiveScalingPredefinedLoadMetric(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PredefinedMetricPairSpecification")) {
                    result.predefined_metric_pair_specification = try deserializePredictiveScalingPredefinedMetricPair(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PredefinedScalingMetricSpecification")) {
                    result.predefined_scaling_metric_specification = try deserializePredictiveScalingPredefinedScalingMetric(reader, alloc);
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

pub fn deserializePredictiveScalingPredefinedLoadMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PredictiveScalingPredefinedLoadMetric {
    var result: PredictiveScalingPredefinedLoadMetric = undefined;
    result.resource_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PredefinedMetricType")) {
                    result.predefined_metric_type = std.meta.stringToEnum(PredefinedLoadMetricType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLabel")) {
                    result.resource_label = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePredictiveScalingPredefinedMetricPair(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PredictiveScalingPredefinedMetricPair {
    var result: PredictiveScalingPredefinedMetricPair = undefined;
    result.resource_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PredefinedMetricType")) {
                    result.predefined_metric_type = std.meta.stringToEnum(PredefinedMetricPairType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLabel")) {
                    result.resource_label = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePredictiveScalingPredefinedScalingMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PredictiveScalingPredefinedScalingMetric {
    var result: PredictiveScalingPredefinedScalingMetric = undefined;
    result.resource_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PredefinedMetricType")) {
                    result.predefined_metric_type = std.meta.stringToEnum(PredefinedScalingMetricType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLabel")) {
                    result.resource_label = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeProcessType(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ProcessType {
    var result: ProcessType = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ProcessName")) {
                    result.process_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRefreshPreferences(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RefreshPreferences {
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
                    result.alarm_specification = try deserializeAlarmSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AutoRollback")) {
                    result.auto_rollback = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "BakeTime")) {
                    result.bake_time = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CheckpointDelay")) {
                    result.checkpoint_delay = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CheckpointPercentages")) {
                    result.checkpoint_percentages = try deserializeCheckpointPercentages(reader, alloc, "member");
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

pub fn deserializeRetentionTriggers(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RetentionTriggers {
    _ = alloc;
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

pub fn deserializeRollbackDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RollbackDetails {
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
                    result.progress_details_on_rollback = try deserializeInstanceRefreshProgressDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RollbackReason")) {
                    result.rollback_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeScalingPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ScalingPolicy {
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
                    result.adjustment_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Alarms")) {
                    result.alarms = try deserializeAlarms(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AutoScalingGroupName")) {
                    result.auto_scaling_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cooldown")) {
                    result.cooldown = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EstimatedInstanceWarmup")) {
                    result.estimated_instance_warmup = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MetricAggregationType")) {
                    result.metric_aggregation_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinAdjustmentMagnitude")) {
                    result.min_adjustment_magnitude = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinAdjustmentStep")) {
                    result.min_adjustment_step = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyARN")) {
                    result.policy_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyType")) {
                    result.policy_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PredictiveScalingConfiguration")) {
                    result.predictive_scaling_configuration = try deserializePredictiveScalingConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ScalingAdjustment")) {
                    result.scaling_adjustment = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StepAdjustments")) {
                    result.step_adjustments = try deserializeStepAdjustments(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "TargetTrackingConfiguration")) {
                    result.target_tracking_configuration = try deserializeTargetTrackingConfiguration(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeScheduledUpdateGroupAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ScheduledUpdateGroupAction {
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
                    result.auto_scaling_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DesiredCapacity")) {
                    result.desired_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxSize")) {
                    result.max_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinSize")) {
                    result.min_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Recurrence")) {
                    result.recurrence = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionARN")) {
                    result.scheduled_action_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionName")) {
                    result.scheduled_action_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Time")) {
                    result.time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TimeZone")) {
                    result.time_zone = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStepAdjustment(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StepAdjustment {
    _ = alloc;
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

pub fn deserializeSuspendedProcess(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SuspendedProcess {
    var result: SuspendedProcess = undefined;
    result.process_name = null;
    result.suspension_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ProcessName")) {
                    result.process_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuspensionReason")) {
                    result.suspension_reason = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTagDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TagDescription {
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
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PropagateAtLaunch")) {
                    result.propagate_at_launch = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ResourceId")) {
                    result.resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTargetTrackingConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetTrackingConfiguration {
    var result: TargetTrackingConfiguration = undefined;
    result.customized_metric_specification = null;
    result.disable_scale_in = null;
    result.predefined_metric_specification = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CustomizedMetricSpecification")) {
                    result.customized_metric_specification = try deserializeCustomizedMetricSpecification(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DisableScaleIn")) {
                    result.disable_scale_in = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PredefinedMetricSpecification")) {
                    result.predefined_metric_specification = try deserializePredefinedMetricSpecification(reader, alloc);
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

pub fn deserializeTargetTrackingMetricDataQuery(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetTrackingMetricDataQuery {
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
                    result.expression = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetricStat")) {
                    result.metric_stat = try deserializeTargetTrackingMetricStat(reader, alloc);
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

pub fn deserializeTargetTrackingMetricStat(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetTrackingMetricStat {
    var result: TargetTrackingMetricStat = undefined;
    result.period = null;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metric")) {
                    result.metric = try deserializeMetric(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTotalLocalStorageGBRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TotalLocalStorageGBRequest {
    _ = alloc;
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

pub fn deserializeTrafficSourceIdentifier(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrafficSourceIdentifier {
    var result: TrafficSourceIdentifier = undefined;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Identifier")) {
                    result.identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrafficSourceState(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrafficSourceState {
    var result: TrafficSourceState = undefined;
    result.identifier = null;
    result.state = null;
    result.traffic_source = null;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Identifier")) {
                    result.identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficSource")) {
                    result.traffic_source = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVCpuCountRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VCpuCountRequest {
    _ = alloc;
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

pub fn deserializeWarmPoolConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !WarmPoolConfiguration {
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
                    result.instance_reuse_policy = try deserializeInstanceReusePolicy(reader, alloc);
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

pub fn serializeAcceleratorManufacturers(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AcceleratorManufacturer, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAcceleratorNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AcceleratorName, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAcceleratorTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AcceleratorType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeActivityIds(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAlarmList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAllowedInstanceTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAutoScalingGroupNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAutoScalingNotificationTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAvailabilityZoneIdsLimit1(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAvailabilityZonesLimit1(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeBlockDeviceMappings(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const BlockDeviceMapping, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeBlockDeviceMapping(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeCapacityReservationIds(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCapacityReservationResourceGroupArns(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCheckpointPercentages(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const i32, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{item}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeClassicLinkVPCSecurityGroups(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCpuManufacturers(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CpuManufacturer, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeExcludedInstanceTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Filter, comptime item_tag: []const u8) !void {
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

pub fn serializeInstanceGenerations(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const InstanceGeneration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeInstanceIds(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeInstanceRefreshIds(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLaunchConfigurationNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLifecycleHookNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLifecycleHookSpecifications(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LifecycleHookSpecification, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeLifecycleHookSpecification(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeLoadBalancerNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLocalStorageTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LocalStorageType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricDataQueries(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricDataQuery, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeMetricDataQuery(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricDimensions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricDimension, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeMetricDimension(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeOverrides(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LaunchTemplateOverrides, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeLaunchTemplateOverrides(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializePerformanceFactorReferenceSetRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PerformanceFactorReferenceRequest, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializePerformanceFactorReferenceRequest(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializePolicyNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePolicyTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePredictiveScalingMetricSpecifications(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PredictiveScalingMetricSpecification, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializePredictiveScalingMetricSpecification(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeProcessNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeScheduledActionNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeScheduledUpdateGroupActionRequests(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ScheduledUpdateGroupActionRequest, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeScheduledUpdateGroupActionRequest(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeSecurityGroups(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeStepAdjustments(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StepAdjustment, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeStepAdjustment(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeSubnetIdsLimit1(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTags(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
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

pub fn serializeTargetGroupARNs(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTargetTrackingMetricDataQueries(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TargetTrackingMetricDataQuery, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTargetTrackingMetricDataQuery(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTerminationPolicies(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTrafficSources(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TrafficSourceIdentifier, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTrafficSourceIdentifier(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeValues(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAcceleratorCountRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AcceleratorCountRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(alloc, "<Max>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(alloc, "<Min>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Min>");
    }
}

pub fn serializeAcceleratorTotalMemoryMiBRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AcceleratorTotalMemoryMiBRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(alloc, "<Max>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(alloc, "<Min>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Min>");
    }
}

pub fn serializeAlarmSpecification(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AlarmSpecification) !void {
    if (value.alarms) |v| {
        try buf.appendSlice(alloc, "<Alarms>");
        try serializeAlarmList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Alarms>");
    }
}

pub fn serializeAvailabilityZoneDistribution(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AvailabilityZoneDistribution) !void {
    if (value.capacity_distribution_strategy) |v| {
        try buf.appendSlice(alloc, "<CapacityDistributionStrategy>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</CapacityDistributionStrategy>");
    }
}

pub fn serializeAvailabilityZoneImpairmentPolicy(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AvailabilityZoneImpairmentPolicy) !void {
    if (value.impaired_zone_health_check_behavior) |v| {
        try buf.appendSlice(alloc, "<ImpairedZoneHealthCheckBehavior>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ImpairedZoneHealthCheckBehavior>");
    }
    if (value.zonal_shift_enabled) |v| {
        try buf.appendSlice(alloc, "<ZonalShiftEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ZonalShiftEnabled>");
    }
}

pub fn serializeBaselineEbsBandwidthMbpsRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: BaselineEbsBandwidthMbpsRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(alloc, "<Max>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(alloc, "<Min>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Min>");
    }
}

pub fn serializeBaselinePerformanceFactorsRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: BaselinePerformanceFactorsRequest) !void {
    if (value.cpu) |v| {
        try buf.appendSlice(alloc, "<Cpu>");
        try serializeCpuPerformanceFactorRequest(alloc, buf, v);
        try buf.appendSlice(alloc, "</Cpu>");
    }
}

pub fn serializeBlockDeviceMapping(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: BlockDeviceMapping) !void {
    try buf.appendSlice(alloc, "<DeviceName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.device_name);
    try buf.appendSlice(alloc, "</DeviceName>");
    if (value.ebs) |v| {
        try buf.appendSlice(alloc, "<Ebs>");
        try serializeEbs(alloc, buf, v);
        try buf.appendSlice(alloc, "</Ebs>");
    }
    if (value.no_device) |v| {
        try buf.appendSlice(alloc, "<NoDevice>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</NoDevice>");
    }
    if (value.virtual_name) |v| {
        try buf.appendSlice(alloc, "<VirtualName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</VirtualName>");
    }
}

pub fn serializeCapacityReservationSpecification(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CapacityReservationSpecification) !void {
    if (value.capacity_reservation_preference) |v| {
        try buf.appendSlice(alloc, "<CapacityReservationPreference>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</CapacityReservationPreference>");
    }
    if (value.capacity_reservation_target) |v| {
        try buf.appendSlice(alloc, "<CapacityReservationTarget>");
        try serializeCapacityReservationTarget(alloc, buf, v);
        try buf.appendSlice(alloc, "</CapacityReservationTarget>");
    }
}

pub fn serializeCapacityReservationTarget(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CapacityReservationTarget) !void {
    if (value.capacity_reservation_ids) |v| {
        try buf.appendSlice(alloc, "<CapacityReservationIds>");
        try serializeCapacityReservationIds(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</CapacityReservationIds>");
    }
    if (value.capacity_reservation_resource_group_arns) |v| {
        try buf.appendSlice(alloc, "<CapacityReservationResourceGroupArns>");
        try serializeCapacityReservationResourceGroupArns(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</CapacityReservationResourceGroupArns>");
    }
}

pub fn serializeCpuPerformanceFactorRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CpuPerformanceFactorRequest) !void {
    if (value.references) |v| {
        try buf.appendSlice(alloc, "<Reference>");
        try serializePerformanceFactorReferenceSetRequest(alloc, buf, v, "item");
        try buf.appendSlice(alloc, "</Reference>");
    }
}

pub fn serializeCustomizedMetricSpecification(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomizedMetricSpecification) !void {
    if (value.dimensions) |v| {
        try buf.appendSlice(alloc, "<Dimensions>");
        try serializeMetricDimensions(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Dimensions>");
    }
    if (value.metric_name) |v| {
        try buf.appendSlice(alloc, "<MetricName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</MetricName>");
    }
    if (value.metrics) |v| {
        try buf.appendSlice(alloc, "<Metrics>");
        try serializeTargetTrackingMetricDataQueries(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Metrics>");
    }
    if (value.namespace) |v| {
        try buf.appendSlice(alloc, "<Namespace>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Namespace>");
    }
    if (value.period) |v| {
        try buf.appendSlice(alloc, "<Period>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Period>");
    }
    if (value.statistic) |v| {
        try buf.appendSlice(alloc, "<Statistic>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Statistic>");
    }
    if (value.unit) |v| {
        try buf.appendSlice(alloc, "<Unit>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Unit>");
    }
}

pub fn serializeDesiredConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DesiredConfiguration) !void {
    if (value.launch_template) |v| {
        try buf.appendSlice(alloc, "<LaunchTemplate>");
        try serializeLaunchTemplateSpecification(alloc, buf, v);
        try buf.appendSlice(alloc, "</LaunchTemplate>");
    }
    if (value.mixed_instances_policy) |v| {
        try buf.appendSlice(alloc, "<MixedInstancesPolicy>");
        try serializeMixedInstancesPolicy(alloc, buf, v);
        try buf.appendSlice(alloc, "</MixedInstancesPolicy>");
    }
}

pub fn serializeEbs(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Ebs) !void {
    if (value.delete_on_termination) |v| {
        try buf.appendSlice(alloc, "<DeleteOnTermination>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</DeleteOnTermination>");
    }
    if (value.encrypted) |v| {
        try buf.appendSlice(alloc, "<Encrypted>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Encrypted>");
    }
    if (value.iops) |v| {
        try buf.appendSlice(alloc, "<Iops>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Iops>");
    }
    if (value.snapshot_id) |v| {
        try buf.appendSlice(alloc, "<SnapshotId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SnapshotId>");
    }
    if (value.throughput) |v| {
        try buf.appendSlice(alloc, "<Throughput>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Throughput>");
    }
    if (value.volume_size) |v| {
        try buf.appendSlice(alloc, "<VolumeSize>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</VolumeSize>");
    }
    if (value.volume_type) |v| {
        try buf.appendSlice(alloc, "<VolumeType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</VolumeType>");
    }
}

pub fn serializeFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Filter) !void {
    if (value.name) |v| {
        try buf.appendSlice(alloc, "<Name>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Name>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeValues(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeInstanceLifecyclePolicy(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceLifecyclePolicy) !void {
    if (value.retention_triggers) |v| {
        try buf.appendSlice(alloc, "<RetentionTriggers>");
        try serializeRetentionTriggers(alloc, buf, v);
        try buf.appendSlice(alloc, "</RetentionTriggers>");
    }
}

pub fn serializeInstanceMaintenancePolicy(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceMaintenancePolicy) !void {
    if (value.max_healthy_percentage) |v| {
        try buf.appendSlice(alloc, "<MaxHealthyPercentage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxHealthyPercentage>");
    }
    if (value.min_healthy_percentage) |v| {
        try buf.appendSlice(alloc, "<MinHealthyPercentage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MinHealthyPercentage>");
    }
}

pub fn serializeInstanceMetadataOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceMetadataOptions) !void {
    if (value.http_endpoint) |v| {
        try buf.appendSlice(alloc, "<HttpEndpoint>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</HttpEndpoint>");
    }
    if (value.http_put_response_hop_limit) |v| {
        try buf.appendSlice(alloc, "<HttpPutResponseHopLimit>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</HttpPutResponseHopLimit>");
    }
    if (value.http_tokens) |v| {
        try buf.appendSlice(alloc, "<HttpTokens>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</HttpTokens>");
    }
}

pub fn serializeInstanceMonitoring(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceMonitoring) !void {
    if (value.enabled) |v| {
        try buf.appendSlice(alloc, "<Enabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Enabled>");
    }
}

pub fn serializeInstanceRequirements(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceRequirements) !void {
    if (value.accelerator_count) |v| {
        try buf.appendSlice(alloc, "<AcceleratorCount>");
        try serializeAcceleratorCountRequest(alloc, buf, v);
        try buf.appendSlice(alloc, "</AcceleratorCount>");
    }
    if (value.accelerator_manufacturers) |v| {
        try buf.appendSlice(alloc, "<AcceleratorManufacturers>");
        try serializeAcceleratorManufacturers(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</AcceleratorManufacturers>");
    }
    if (value.accelerator_names) |v| {
        try buf.appendSlice(alloc, "<AcceleratorNames>");
        try serializeAcceleratorNames(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</AcceleratorNames>");
    }
    if (value.accelerator_total_memory_mi_b) |v| {
        try buf.appendSlice(alloc, "<AcceleratorTotalMemoryMiB>");
        try serializeAcceleratorTotalMemoryMiBRequest(alloc, buf, v);
        try buf.appendSlice(alloc, "</AcceleratorTotalMemoryMiB>");
    }
    if (value.accelerator_types) |v| {
        try buf.appendSlice(alloc, "<AcceleratorTypes>");
        try serializeAcceleratorTypes(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</AcceleratorTypes>");
    }
    if (value.allowed_instance_types) |v| {
        try buf.appendSlice(alloc, "<AllowedInstanceTypes>");
        try serializeAllowedInstanceTypes(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</AllowedInstanceTypes>");
    }
    if (value.bare_metal) |v| {
        try buf.appendSlice(alloc, "<BareMetal>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</BareMetal>");
    }
    if (value.baseline_ebs_bandwidth_mbps) |v| {
        try buf.appendSlice(alloc, "<BaselineEbsBandwidthMbps>");
        try serializeBaselineEbsBandwidthMbpsRequest(alloc, buf, v);
        try buf.appendSlice(alloc, "</BaselineEbsBandwidthMbps>");
    }
    if (value.baseline_performance_factors) |v| {
        try buf.appendSlice(alloc, "<BaselinePerformanceFactors>");
        try serializeBaselinePerformanceFactorsRequest(alloc, buf, v);
        try buf.appendSlice(alloc, "</BaselinePerformanceFactors>");
    }
    if (value.burstable_performance) |v| {
        try buf.appendSlice(alloc, "<BurstablePerformance>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</BurstablePerformance>");
    }
    if (value.cpu_manufacturers) |v| {
        try buf.appendSlice(alloc, "<CpuManufacturers>");
        try serializeCpuManufacturers(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</CpuManufacturers>");
    }
    if (value.excluded_instance_types) |v| {
        try buf.appendSlice(alloc, "<ExcludedInstanceTypes>");
        try serializeExcludedInstanceTypes(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</ExcludedInstanceTypes>");
    }
    if (value.instance_generations) |v| {
        try buf.appendSlice(alloc, "<InstanceGenerations>");
        try serializeInstanceGenerations(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</InstanceGenerations>");
    }
    if (value.local_storage) |v| {
        try buf.appendSlice(alloc, "<LocalStorage>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</LocalStorage>");
    }
    if (value.local_storage_types) |v| {
        try buf.appendSlice(alloc, "<LocalStorageTypes>");
        try serializeLocalStorageTypes(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</LocalStorageTypes>");
    }
    if (value.max_spot_price_as_percentage_of_optimal_on_demand_price) |v| {
        try buf.appendSlice(alloc, "<MaxSpotPriceAsPercentageOfOptimalOnDemandPrice>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxSpotPriceAsPercentageOfOptimalOnDemandPrice>");
    }
    if (value.memory_gi_b_per_v_cpu) |v| {
        try buf.appendSlice(alloc, "<MemoryGiBPerVCpu>");
        try serializeMemoryGiBPerVCpuRequest(alloc, buf, v);
        try buf.appendSlice(alloc, "</MemoryGiBPerVCpu>");
    }
    try buf.appendSlice(alloc, "<MemoryMiB>");
    try serializeMemoryMiBRequest(alloc, buf, value.memory_mi_b);
    try buf.appendSlice(alloc, "</MemoryMiB>");
    if (value.network_bandwidth_gbps) |v| {
        try buf.appendSlice(alloc, "<NetworkBandwidthGbps>");
        try serializeNetworkBandwidthGbpsRequest(alloc, buf, v);
        try buf.appendSlice(alloc, "</NetworkBandwidthGbps>");
    }
    if (value.network_interface_count) |v| {
        try buf.appendSlice(alloc, "<NetworkInterfaceCount>");
        try serializeNetworkInterfaceCountRequest(alloc, buf, v);
        try buf.appendSlice(alloc, "</NetworkInterfaceCount>");
    }
    if (value.on_demand_max_price_percentage_over_lowest_price) |v| {
        try buf.appendSlice(alloc, "<OnDemandMaxPricePercentageOverLowestPrice>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</OnDemandMaxPricePercentageOverLowestPrice>");
    }
    if (value.require_hibernate_support) |v| {
        try buf.appendSlice(alloc, "<RequireHibernateSupport>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</RequireHibernateSupport>");
    }
    if (value.spot_max_price_percentage_over_lowest_price) |v| {
        try buf.appendSlice(alloc, "<SpotMaxPricePercentageOverLowestPrice>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</SpotMaxPricePercentageOverLowestPrice>");
    }
    if (value.total_local_storage_gb) |v| {
        try buf.appendSlice(alloc, "<TotalLocalStorageGB>");
        try serializeTotalLocalStorageGBRequest(alloc, buf, v);
        try buf.appendSlice(alloc, "</TotalLocalStorageGB>");
    }
    try buf.appendSlice(alloc, "<VCpuCount>");
    try serializeVCpuCountRequest(alloc, buf, value.v_cpu_count);
    try buf.appendSlice(alloc, "</VCpuCount>");
}

pub fn serializeInstanceReusePolicy(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstanceReusePolicy) !void {
    if (value.reuse_on_scale_in) |v| {
        try buf.appendSlice(alloc, "<ReuseOnScaleIn>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReuseOnScaleIn>");
    }
}

pub fn serializeInstancesDistribution(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: InstancesDistribution) !void {
    if (value.on_demand_allocation_strategy) |v| {
        try buf.appendSlice(alloc, "<OnDemandAllocationStrategy>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OnDemandAllocationStrategy>");
    }
    if (value.on_demand_base_capacity) |v| {
        try buf.appendSlice(alloc, "<OnDemandBaseCapacity>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</OnDemandBaseCapacity>");
    }
    if (value.on_demand_percentage_above_base_capacity) |v| {
        try buf.appendSlice(alloc, "<OnDemandPercentageAboveBaseCapacity>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</OnDemandPercentageAboveBaseCapacity>");
    }
    if (value.spot_allocation_strategy) |v| {
        try buf.appendSlice(alloc, "<SpotAllocationStrategy>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SpotAllocationStrategy>");
    }
    if (value.spot_instance_pools) |v| {
        try buf.appendSlice(alloc, "<SpotInstancePools>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</SpotInstancePools>");
    }
    if (value.spot_max_price) |v| {
        try buf.appendSlice(alloc, "<SpotMaxPrice>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SpotMaxPrice>");
    }
}

pub fn serializeLaunchTemplate(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LaunchTemplate) !void {
    if (value.launch_template_specification) |v| {
        try buf.appendSlice(alloc, "<LaunchTemplateSpecification>");
        try serializeLaunchTemplateSpecification(alloc, buf, v);
        try buf.appendSlice(alloc, "</LaunchTemplateSpecification>");
    }
    if (value.overrides) |v| {
        try buf.appendSlice(alloc, "<Overrides>");
        try serializeOverrides(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Overrides>");
    }
}

pub fn serializeLaunchTemplateOverrides(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LaunchTemplateOverrides) !void {
    if (value.image_id) |v| {
        try buf.appendSlice(alloc, "<ImageId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ImageId>");
    }
    if (value.instance_requirements) |v| {
        try buf.appendSlice(alloc, "<InstanceRequirements>");
        try serializeInstanceRequirements(alloc, buf, v);
        try buf.appendSlice(alloc, "</InstanceRequirements>");
    }
    if (value.instance_type) |v| {
        try buf.appendSlice(alloc, "<InstanceType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</InstanceType>");
    }
    if (value.launch_template_specification) |v| {
        try buf.appendSlice(alloc, "<LaunchTemplateSpecification>");
        try serializeLaunchTemplateSpecification(alloc, buf, v);
        try buf.appendSlice(alloc, "</LaunchTemplateSpecification>");
    }
    if (value.weighted_capacity) |v| {
        try buf.appendSlice(alloc, "<WeightedCapacity>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</WeightedCapacity>");
    }
}

pub fn serializeLaunchTemplateSpecification(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LaunchTemplateSpecification) !void {
    if (value.launch_template_id) |v| {
        try buf.appendSlice(alloc, "<LaunchTemplateId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</LaunchTemplateId>");
    }
    if (value.launch_template_name) |v| {
        try buf.appendSlice(alloc, "<LaunchTemplateName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</LaunchTemplateName>");
    }
    if (value.version) |v| {
        try buf.appendSlice(alloc, "<Version>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Version>");
    }
}

pub fn serializeLifecycleHookSpecification(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LifecycleHookSpecification) !void {
    if (value.default_result) |v| {
        try buf.appendSlice(alloc, "<DefaultResult>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultResult>");
    }
    if (value.heartbeat_timeout) |v| {
        try buf.appendSlice(alloc, "<HeartbeatTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</HeartbeatTimeout>");
    }
    try buf.appendSlice(alloc, "<LifecycleHookName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.lifecycle_hook_name);
    try buf.appendSlice(alloc, "</LifecycleHookName>");
    try buf.appendSlice(alloc, "<LifecycleTransition>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.lifecycle_transition);
    try buf.appendSlice(alloc, "</LifecycleTransition>");
    if (value.notification_metadata) |v| {
        try buf.appendSlice(alloc, "<NotificationMetadata>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</NotificationMetadata>");
    }
    if (value.notification_target_arn) |v| {
        try buf.appendSlice(alloc, "<NotificationTargetARN>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</NotificationTargetARN>");
    }
    if (value.role_arn) |v| {
        try buf.appendSlice(alloc, "<RoleARN>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</RoleARN>");
    }
}

pub fn serializeMemoryGiBPerVCpuRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MemoryGiBPerVCpuRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(alloc, "<Max>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(alloc, "<Min>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Min>");
    }
}

pub fn serializeMemoryMiBRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MemoryMiBRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(alloc, "<Max>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Max>");
    }
    try buf.appendSlice(alloc, "<Min>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.min}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Min>");
}

pub fn serializeMetric(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Metric) !void {
    if (value.dimensions) |v| {
        try buf.appendSlice(alloc, "<Dimensions>");
        try serializeMetricDimensions(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Dimensions>");
    }
    try buf.appendSlice(alloc, "<MetricName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.metric_name);
    try buf.appendSlice(alloc, "</MetricName>");
    try buf.appendSlice(alloc, "<Namespace>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.namespace);
    try buf.appendSlice(alloc, "</Namespace>");
}

pub fn serializeMetricDataQuery(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricDataQuery) !void {
    if (value.expression) |v| {
        try buf.appendSlice(alloc, "<Expression>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Expression>");
    }
    try buf.appendSlice(alloc, "<Id>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.id);
    try buf.appendSlice(alloc, "</Id>");
    if (value.label) |v| {
        try buf.appendSlice(alloc, "<Label>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Label>");
    }
    if (value.metric_stat) |v| {
        try buf.appendSlice(alloc, "<MetricStat>");
        try serializeMetricStat(alloc, buf, v);
        try buf.appendSlice(alloc, "</MetricStat>");
    }
    if (value.return_data) |v| {
        try buf.appendSlice(alloc, "<ReturnData>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnData>");
    }
}

pub fn serializeMetricDimension(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricDimension) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeMetricStat(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStat) !void {
    try buf.appendSlice(alloc, "<Metric>");
    try serializeMetric(alloc, buf, value.metric);
    try buf.appendSlice(alloc, "</Metric>");
    try buf.appendSlice(alloc, "<Stat>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.stat);
    try buf.appendSlice(alloc, "</Stat>");
    if (value.unit) |v| {
        try buf.appendSlice(alloc, "<Unit>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Unit>");
    }
}

pub fn serializeMixedInstancesPolicy(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MixedInstancesPolicy) !void {
    if (value.instances_distribution) |v| {
        try buf.appendSlice(alloc, "<InstancesDistribution>");
        try serializeInstancesDistribution(alloc, buf, v);
        try buf.appendSlice(alloc, "</InstancesDistribution>");
    }
    if (value.launch_template) |v| {
        try buf.appendSlice(alloc, "<LaunchTemplate>");
        try serializeLaunchTemplate(alloc, buf, v);
        try buf.appendSlice(alloc, "</LaunchTemplate>");
    }
}

pub fn serializeNetworkBandwidthGbpsRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: NetworkBandwidthGbpsRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(alloc, "<Max>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(alloc, "<Min>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Min>");
    }
}

pub fn serializeNetworkInterfaceCountRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: NetworkInterfaceCountRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(alloc, "<Max>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(alloc, "<Min>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Min>");
    }
}

pub fn serializePerformanceFactorReferenceRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PerformanceFactorReferenceRequest) !void {
    if (value.instance_family) |v| {
        try buf.appendSlice(alloc, "<InstanceFamily>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</InstanceFamily>");
    }
}

pub fn serializePredefinedMetricSpecification(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredefinedMetricSpecification) !void {
    try buf.appendSlice(alloc, "<PredefinedMetricType>");
    try buf.appendSlice(alloc, @tagName(value.predefined_metric_type));
    try buf.appendSlice(alloc, "</PredefinedMetricType>");
    if (value.resource_label) |v| {
        try buf.appendSlice(alloc, "<ResourceLabel>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourceLabel>");
    }
}

pub fn serializePredictiveScalingConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingConfiguration) !void {
    if (value.max_capacity_breach_behavior) |v| {
        try buf.appendSlice(alloc, "<MaxCapacityBreachBehavior>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</MaxCapacityBreachBehavior>");
    }
    if (value.max_capacity_buffer) |v| {
        try buf.appendSlice(alloc, "<MaxCapacityBuffer>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxCapacityBuffer>");
    }
    try buf.appendSlice(alloc, "<MetricSpecifications>");
    try serializePredictiveScalingMetricSpecifications(alloc, buf, value.metric_specifications, "member");
    try buf.appendSlice(alloc, "</MetricSpecifications>");
    if (value.mode) |v| {
        try buf.appendSlice(alloc, "<Mode>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Mode>");
    }
    if (value.scheduling_buffer_time) |v| {
        try buf.appendSlice(alloc, "<SchedulingBufferTime>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</SchedulingBufferTime>");
    }
}

pub fn serializePredictiveScalingCustomizedCapacityMetric(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingCustomizedCapacityMetric) !void {
    try buf.appendSlice(alloc, "<MetricDataQueries>");
    try serializeMetricDataQueries(alloc, buf, value.metric_data_queries, "member");
    try buf.appendSlice(alloc, "</MetricDataQueries>");
}

pub fn serializePredictiveScalingCustomizedLoadMetric(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingCustomizedLoadMetric) !void {
    try buf.appendSlice(alloc, "<MetricDataQueries>");
    try serializeMetricDataQueries(alloc, buf, value.metric_data_queries, "member");
    try buf.appendSlice(alloc, "</MetricDataQueries>");
}

pub fn serializePredictiveScalingCustomizedScalingMetric(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingCustomizedScalingMetric) !void {
    try buf.appendSlice(alloc, "<MetricDataQueries>");
    try serializeMetricDataQueries(alloc, buf, value.metric_data_queries, "member");
    try buf.appendSlice(alloc, "</MetricDataQueries>");
}

pub fn serializePredictiveScalingMetricSpecification(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingMetricSpecification) !void {
    if (value.customized_capacity_metric_specification) |v| {
        try buf.appendSlice(alloc, "<CustomizedCapacityMetricSpecification>");
        try serializePredictiveScalingCustomizedCapacityMetric(alloc, buf, v);
        try buf.appendSlice(alloc, "</CustomizedCapacityMetricSpecification>");
    }
    if (value.customized_load_metric_specification) |v| {
        try buf.appendSlice(alloc, "<CustomizedLoadMetricSpecification>");
        try serializePredictiveScalingCustomizedLoadMetric(alloc, buf, v);
        try buf.appendSlice(alloc, "</CustomizedLoadMetricSpecification>");
    }
    if (value.customized_scaling_metric_specification) |v| {
        try buf.appendSlice(alloc, "<CustomizedScalingMetricSpecification>");
        try serializePredictiveScalingCustomizedScalingMetric(alloc, buf, v);
        try buf.appendSlice(alloc, "</CustomizedScalingMetricSpecification>");
    }
    if (value.predefined_load_metric_specification) |v| {
        try buf.appendSlice(alloc, "<PredefinedLoadMetricSpecification>");
        try serializePredictiveScalingPredefinedLoadMetric(alloc, buf, v);
        try buf.appendSlice(alloc, "</PredefinedLoadMetricSpecification>");
    }
    if (value.predefined_metric_pair_specification) |v| {
        try buf.appendSlice(alloc, "<PredefinedMetricPairSpecification>");
        try serializePredictiveScalingPredefinedMetricPair(alloc, buf, v);
        try buf.appendSlice(alloc, "</PredefinedMetricPairSpecification>");
    }
    if (value.predefined_scaling_metric_specification) |v| {
        try buf.appendSlice(alloc, "<PredefinedScalingMetricSpecification>");
        try serializePredictiveScalingPredefinedScalingMetric(alloc, buf, v);
        try buf.appendSlice(alloc, "</PredefinedScalingMetricSpecification>");
    }
    try buf.appendSlice(alloc, "<TargetValue>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.target_value}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</TargetValue>");
}

pub fn serializePredictiveScalingPredefinedLoadMetric(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingPredefinedLoadMetric) !void {
    try buf.appendSlice(alloc, "<PredefinedMetricType>");
    try buf.appendSlice(alloc, @tagName(value.predefined_metric_type));
    try buf.appendSlice(alloc, "</PredefinedMetricType>");
    if (value.resource_label) |v| {
        try buf.appendSlice(alloc, "<ResourceLabel>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourceLabel>");
    }
}

pub fn serializePredictiveScalingPredefinedMetricPair(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingPredefinedMetricPair) !void {
    try buf.appendSlice(alloc, "<PredefinedMetricType>");
    try buf.appendSlice(alloc, @tagName(value.predefined_metric_type));
    try buf.appendSlice(alloc, "</PredefinedMetricType>");
    if (value.resource_label) |v| {
        try buf.appendSlice(alloc, "<ResourceLabel>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourceLabel>");
    }
}

pub fn serializePredictiveScalingPredefinedScalingMetric(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PredictiveScalingPredefinedScalingMetric) !void {
    try buf.appendSlice(alloc, "<PredefinedMetricType>");
    try buf.appendSlice(alloc, @tagName(value.predefined_metric_type));
    try buf.appendSlice(alloc, "</PredefinedMetricType>");
    if (value.resource_label) |v| {
        try buf.appendSlice(alloc, "<ResourceLabel>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourceLabel>");
    }
}

pub fn serializeRefreshPreferences(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RefreshPreferences) !void {
    if (value.alarm_specification) |v| {
        try buf.appendSlice(alloc, "<AlarmSpecification>");
        try serializeAlarmSpecification(alloc, buf, v);
        try buf.appendSlice(alloc, "</AlarmSpecification>");
    }
    if (value.auto_rollback) |v| {
        try buf.appendSlice(alloc, "<AutoRollback>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</AutoRollback>");
    }
    if (value.bake_time) |v| {
        try buf.appendSlice(alloc, "<BakeTime>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</BakeTime>");
    }
    if (value.checkpoint_delay) |v| {
        try buf.appendSlice(alloc, "<CheckpointDelay>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</CheckpointDelay>");
    }
    if (value.checkpoint_percentages) |v| {
        try buf.appendSlice(alloc, "<CheckpointPercentages>");
        try serializeCheckpointPercentages(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</CheckpointPercentages>");
    }
    if (value.instance_warmup) |v| {
        try buf.appendSlice(alloc, "<InstanceWarmup>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</InstanceWarmup>");
    }
    if (value.max_healthy_percentage) |v| {
        try buf.appendSlice(alloc, "<MaxHealthyPercentage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxHealthyPercentage>");
    }
    if (value.min_healthy_percentage) |v| {
        try buf.appendSlice(alloc, "<MinHealthyPercentage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MinHealthyPercentage>");
    }
    if (value.scale_in_protected_instances) |v| {
        try buf.appendSlice(alloc, "<ScaleInProtectedInstances>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ScaleInProtectedInstances>");
    }
    if (value.skip_matching) |v| {
        try buf.appendSlice(alloc, "<SkipMatching>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SkipMatching>");
    }
    if (value.standby_instances) |v| {
        try buf.appendSlice(alloc, "<StandbyInstances>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</StandbyInstances>");
    }
}

pub fn serializeRetentionTriggers(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RetentionTriggers) !void {
    if (value.terminate_hook_abandon) |v| {
        try buf.appendSlice(alloc, "<TerminateHookAbandon>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</TerminateHookAbandon>");
    }
}

pub fn serializeScheduledUpdateGroupActionRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScheduledUpdateGroupActionRequest) !void {
    if (value.desired_capacity) |v| {
        try buf.appendSlice(alloc, "<DesiredCapacity>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DesiredCapacity>");
    }
    if (value.end_time) |v| {
        try buf.appendSlice(alloc, "<EndTime>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</EndTime>");
    }
    if (value.max_size) |v| {
        try buf.appendSlice(alloc, "<MaxSize>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxSize>");
    }
    if (value.min_size) |v| {
        try buf.appendSlice(alloc, "<MinSize>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MinSize>");
    }
    if (value.recurrence) |v| {
        try buf.appendSlice(alloc, "<Recurrence>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Recurrence>");
    }
    try buf.appendSlice(alloc, "<ScheduledActionName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.scheduled_action_name);
    try buf.appendSlice(alloc, "</ScheduledActionName>");
    if (value.start_time) |v| {
        try buf.appendSlice(alloc, "<StartTime>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</StartTime>");
    }
    if (value.time_zone) |v| {
        try buf.appendSlice(alloc, "<TimeZone>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TimeZone>");
    }
}

pub fn serializeStepAdjustment(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StepAdjustment) !void {
    if (value.metric_interval_lower_bound) |v| {
        try buf.appendSlice(alloc, "<MetricIntervalLowerBound>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MetricIntervalLowerBound>");
    }
    if (value.metric_interval_upper_bound) |v| {
        try buf.appendSlice(alloc, "<MetricIntervalUpperBound>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MetricIntervalUpperBound>");
    }
    try buf.appendSlice(alloc, "<ScalingAdjustment>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.scaling_adjustment}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</ScalingAdjustment>");
}

pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    if (value.propagate_at_launch) |v| {
        try buf.appendSlice(alloc, "<PropagateAtLaunch>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</PropagateAtLaunch>");
    }
    if (value.resource_id) |v| {
        try buf.appendSlice(alloc, "<ResourceId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourceId>");
    }
    if (value.resource_type) |v| {
        try buf.appendSlice(alloc, "<ResourceType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourceType>");
    }
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeTargetTrackingConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetTrackingConfiguration) !void {
    if (value.customized_metric_specification) |v| {
        try buf.appendSlice(alloc, "<CustomizedMetricSpecification>");
        try serializeCustomizedMetricSpecification(alloc, buf, v);
        try buf.appendSlice(alloc, "</CustomizedMetricSpecification>");
    }
    if (value.disable_scale_in) |v| {
        try buf.appendSlice(alloc, "<DisableScaleIn>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</DisableScaleIn>");
    }
    if (value.predefined_metric_specification) |v| {
        try buf.appendSlice(alloc, "<PredefinedMetricSpecification>");
        try serializePredefinedMetricSpecification(alloc, buf, v);
        try buf.appendSlice(alloc, "</PredefinedMetricSpecification>");
    }
    try buf.appendSlice(alloc, "<TargetValue>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.target_value}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</TargetValue>");
}

pub fn serializeTargetTrackingMetricDataQuery(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetTrackingMetricDataQuery) !void {
    if (value.expression) |v| {
        try buf.appendSlice(alloc, "<Expression>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Expression>");
    }
    try buf.appendSlice(alloc, "<Id>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.id);
    try buf.appendSlice(alloc, "</Id>");
    if (value.label) |v| {
        try buf.appendSlice(alloc, "<Label>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Label>");
    }
    if (value.metric_stat) |v| {
        try buf.appendSlice(alloc, "<MetricStat>");
        try serializeTargetTrackingMetricStat(alloc, buf, v);
        try buf.appendSlice(alloc, "</MetricStat>");
    }
    if (value.period) |v| {
        try buf.appendSlice(alloc, "<Period>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Period>");
    }
    if (value.return_data) |v| {
        try buf.appendSlice(alloc, "<ReturnData>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnData>");
    }
}

pub fn serializeTargetTrackingMetricStat(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetTrackingMetricStat) !void {
    try buf.appendSlice(alloc, "<Metric>");
    try serializeMetric(alloc, buf, value.metric);
    try buf.appendSlice(alloc, "</Metric>");
    if (value.period) |v| {
        try buf.appendSlice(alloc, "<Period>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Period>");
    }
    try buf.appendSlice(alloc, "<Stat>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.stat);
    try buf.appendSlice(alloc, "</Stat>");
    if (value.unit) |v| {
        try buf.appendSlice(alloc, "<Unit>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Unit>");
    }
}

pub fn serializeTotalLocalStorageGBRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TotalLocalStorageGBRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(alloc, "<Max>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Max>");
    }
    if (value.min) |v| {
        try buf.appendSlice(alloc, "<Min>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Min>");
    }
}

pub fn serializeTrafficSourceIdentifier(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrafficSourceIdentifier) !void {
    try buf.appendSlice(alloc, "<Identifier>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.identifier);
    try buf.appendSlice(alloc, "</Identifier>");
    if (value.@"type") |v| {
        try buf.appendSlice(alloc, "<Type>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Type>");
    }
}

pub fn serializeVCpuCountRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: VCpuCountRequest) !void {
    if (value.max) |v| {
        try buf.appendSlice(alloc, "<Max>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Max>");
    }
    try buf.appendSlice(alloc, "<Min>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.min}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Min>");
}

