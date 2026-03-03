const aws = @import("aws");
const std = @import("std");

const ActionHistoryStatus = @import("action_history_status.zig").ActionHistoryStatus;
const ActionStatus = @import("action_status.zig").ActionStatus;
const ActionType = @import("action_type.zig").ActionType;
const ApplicationDescription = @import("application_description.zig").ApplicationDescription;
const ApplicationMetrics = @import("application_metrics.zig").ApplicationMetrics;
const ApplicationResourceLifecycleConfig = @import("application_resource_lifecycle_config.zig").ApplicationResourceLifecycleConfig;
const ApplicationVersionDescription = @import("application_version_description.zig").ApplicationVersionDescription;
const ApplicationVersionLifecycleConfig = @import("application_version_lifecycle_config.zig").ApplicationVersionLifecycleConfig;
const ApplicationVersionStatus = @import("application_version_status.zig").ApplicationVersionStatus;
const AutoScalingGroup = @import("auto_scaling_group.zig").AutoScalingGroup;
const BuildConfiguration = @import("build_configuration.zig").BuildConfiguration;
const Builder = @import("builder.zig").Builder;
const CPUUtilization = @import("cpu_utilization.zig").CPUUtilization;
const ComputeType = @import("compute_type.zig").ComputeType;
const ConfigurationDeploymentStatus = @import("configuration_deployment_status.zig").ConfigurationDeploymentStatus;
const ConfigurationOptionDescription = @import("configuration_option_description.zig").ConfigurationOptionDescription;
const ConfigurationOptionSetting = @import("configuration_option_setting.zig").ConfigurationOptionSetting;
const ConfigurationOptionValueType = @import("configuration_option_value_type.zig").ConfigurationOptionValueType;
const ConfigurationSettingsDescription = @import("configuration_settings_description.zig").ConfigurationSettingsDescription;
const CustomAmi = @import("custom_ami.zig").CustomAmi;
const Deployment = @import("deployment.zig").Deployment;
const EnvironmentDescription = @import("environment_description.zig").EnvironmentDescription;
const EnvironmentHealth = @import("environment_health.zig").EnvironmentHealth;
const EnvironmentHealthAttribute = @import("environment_health_attribute.zig").EnvironmentHealthAttribute;
const EnvironmentHealthStatus = @import("environment_health_status.zig").EnvironmentHealthStatus;
const EnvironmentInfoDescription = @import("environment_info_description.zig").EnvironmentInfoDescription;
const EnvironmentInfoType = @import("environment_info_type.zig").EnvironmentInfoType;
const EnvironmentLink = @import("environment_link.zig").EnvironmentLink;
const EnvironmentResourceDescription = @import("environment_resource_description.zig").EnvironmentResourceDescription;
const EnvironmentResourcesDescription = @import("environment_resources_description.zig").EnvironmentResourcesDescription;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const EnvironmentTier = @import("environment_tier.zig").EnvironmentTier;
const EventDescription = @import("event_description.zig").EventDescription;
const EventSeverity = @import("event_severity.zig").EventSeverity;
const FailureType = @import("failure_type.zig").FailureType;
const Instance = @import("instance.zig").Instance;
const InstanceHealthSummary = @import("instance_health_summary.zig").InstanceHealthSummary;
const InstancesHealthAttribute = @import("instances_health_attribute.zig").InstancesHealthAttribute;
const Latency = @import("latency.zig").Latency;
const LaunchConfiguration = @import("launch_configuration.zig").LaunchConfiguration;
const LaunchTemplate = @import("launch_template.zig").LaunchTemplate;
const Listener = @import("listener.zig").Listener;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const LoadBalancerDescription = @import("load_balancer_description.zig").LoadBalancerDescription;
const ManagedAction = @import("managed_action.zig").ManagedAction;
const ManagedActionHistoryItem = @import("managed_action_history_item.zig").ManagedActionHistoryItem;
const MaxAgeRule = @import("max_age_rule.zig").MaxAgeRule;
const MaxCountRule = @import("max_count_rule.zig").MaxCountRule;
const OptionRestrictionRegex = @import("option_restriction_regex.zig").OptionRestrictionRegex;
const OptionSpecification = @import("option_specification.zig").OptionSpecification;
const PlatformBranchSummary = @import("platform_branch_summary.zig").PlatformBranchSummary;
const PlatformDescription = @import("platform_description.zig").PlatformDescription;
const PlatformFilter = @import("platform_filter.zig").PlatformFilter;
const PlatformFramework = @import("platform_framework.zig").PlatformFramework;
const PlatformProgrammingLanguage = @import("platform_programming_language.zig").PlatformProgrammingLanguage;
const PlatformStatus = @import("platform_status.zig").PlatformStatus;
const PlatformSummary = @import("platform_summary.zig").PlatformSummary;
const Queue = @import("queue.zig").Queue;
const ResourceQuota = @import("resource_quota.zig").ResourceQuota;
const ResourceQuotas = @import("resource_quotas.zig").ResourceQuotas;
const S3Location = @import("s3_location.zig").S3Location;
const SearchFilter = @import("search_filter.zig").SearchFilter;
const SingleInstanceHealth = @import("single_instance_health.zig").SingleInstanceHealth;
const SolutionStackDescription = @import("solution_stack_description.zig").SolutionStackDescription;
const SourceBuildInformation = @import("source_build_information.zig").SourceBuildInformation;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const SourceRepository = @import("source_repository.zig").SourceRepository;
const SourceType = @import("source_type.zig").SourceType;
const StatusCodes = @import("status_codes.zig").StatusCodes;
const SystemStatus = @import("system_status.zig").SystemStatus;
const Tag = @import("tag.zig").Tag;
const Trigger = @import("trigger.zig").Trigger;
const ValidationMessage = @import("validation_message.zig").ValidationMessage;
const ValidationSeverity = @import("validation_severity.zig").ValidationSeverity;

pub fn deserializeApplicationDescriptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ApplicationDescription {
    var list: std.ArrayList(ApplicationDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeApplicationDescription(allocator, reader));
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

pub fn deserializeApplicationVersionDescriptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ApplicationVersionDescription {
    var list: std.ArrayList(ApplicationVersionDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeApplicationVersionDescription(allocator, reader));
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

pub fn deserializeAutoScalingGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AutoScalingGroup {
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

pub fn deserializeAvailableSolutionStackDetailsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SolutionStackDescription {
    var list: std.ArrayList(SolutionStackDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSolutionStackDescription(allocator, reader));
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

pub fn deserializeAvailableSolutionStackNamesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCauses(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeConfigurationOptionDescriptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ConfigurationOptionDescription {
    var list: std.ArrayList(ConfigurationOptionDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeConfigurationOptionDescription(allocator, reader));
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

pub fn deserializeConfigurationOptionPossibleValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeConfigurationOptionSettingsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ConfigurationOptionSetting {
    var list: std.ArrayList(ConfigurationOptionSetting) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeConfigurationOptionSetting(allocator, reader));
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

pub fn deserializeConfigurationSettingsDescriptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ConfigurationSettingsDescription {
    var list: std.ArrayList(ConfigurationSettingsDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeConfigurationSettingsDescription(allocator, reader));
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

pub fn deserializeConfigurationTemplateNamesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCustomAmiList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CustomAmi {
    var list: std.ArrayList(CustomAmi) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCustomAmi(allocator, reader));
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

pub fn deserializeEnvironmentDescriptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EnvironmentDescription {
    var list: std.ArrayList(EnvironmentDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEnvironmentDescription(allocator, reader));
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

pub fn deserializeEnvironmentInfoDescriptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EnvironmentInfoDescription {
    var list: std.ArrayList(EnvironmentInfoDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEnvironmentInfoDescription(allocator, reader));
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

pub fn deserializeEnvironmentLinks(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EnvironmentLink {
    var list: std.ArrayList(EnvironmentLink) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEnvironmentLink(allocator, reader));
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

pub fn deserializeEventDescriptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EventDescription {
    var list: std.ArrayList(EventDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEventDescription(allocator, reader));
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

pub fn deserializeInstanceHealthList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SingleInstanceHealth {
    var list: std.ArrayList(SingleInstanceHealth) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSingleInstanceHealth(allocator, reader));
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

pub fn deserializeInstanceList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Instance {
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

pub fn deserializeLaunchConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LaunchConfiguration {
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

pub fn deserializeLaunchTemplateList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LaunchTemplate {
    var list: std.ArrayList(LaunchTemplate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLaunchTemplate(allocator, reader));
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

pub fn deserializeLoadAverage(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const f64 {
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

pub fn deserializeLoadBalancerList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LoadBalancer {
    var list: std.ArrayList(LoadBalancer) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLoadBalancer(allocator, reader));
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

pub fn deserializeLoadBalancerListenersDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Listener {
    var list: std.ArrayList(Listener) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListener(allocator, reader));
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

pub fn deserializeManagedActionHistoryItems(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ManagedActionHistoryItem {
    var list: std.ArrayList(ManagedActionHistoryItem) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeManagedActionHistoryItem(allocator, reader));
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

pub fn deserializeManagedActions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ManagedAction {
    var list: std.ArrayList(ManagedAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeManagedAction(allocator, reader));
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

pub fn deserializePlatformBranchSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PlatformBranchSummary {
    var list: std.ArrayList(PlatformBranchSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePlatformBranchSummary(allocator, reader));
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

pub fn deserializePlatformFrameworks(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PlatformFramework {
    var list: std.ArrayList(PlatformFramework) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePlatformFramework(allocator, reader));
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

pub fn deserializePlatformProgrammingLanguages(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PlatformProgrammingLanguage {
    var list: std.ArrayList(PlatformProgrammingLanguage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePlatformProgrammingLanguage(allocator, reader));
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

pub fn deserializePlatformSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PlatformSummary {
    var list: std.ArrayList(PlatformSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePlatformSummary(allocator, reader));
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

pub fn deserializeQueueList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Queue {
    var list: std.ArrayList(Queue) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeQueue(allocator, reader));
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

pub fn deserializeSolutionStackFileTypeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSupportedAddonList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSupportedTierList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTriggerList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Trigger {
    var list: std.ArrayList(Trigger) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrigger(allocator, reader));
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

pub fn deserializeValidationMessagesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ValidationMessage {
    var list: std.ArrayList(ValidationMessage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeValidationMessage(allocator, reader));
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

pub fn deserializeVersionLabelsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeApplicationDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ApplicationDescription {
    var result: ApplicationDescription = undefined;
    result.application_arn = null;
    result.application_name = null;
    result.configuration_templates = null;
    result.date_created = null;
    result.date_updated = null;
    result.description = null;
    result.resource_lifecycle_config = null;
    result.versions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationArn")) {
                    result.application_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConfigurationTemplates")) {
                    result.configuration_templates = try deserializeConfigurationTemplateNamesList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLifecycleConfig")) {
                    result.resource_lifecycle_config = try deserializeApplicationResourceLifecycleConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Versions")) {
                    result.versions = try deserializeVersionLabelsList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeApplicationMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ApplicationMetrics {
    var result: ApplicationMetrics = undefined;
    result.duration = null;
    result.latency = null;
    result.request_count = 0;
    result.status_codes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Latency")) {
                    result.latency = try deserializeLatency(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RequestCount")) {
                    result.request_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StatusCodes")) {
                    result.status_codes = try deserializeStatusCodes(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeApplicationResourceLifecycleConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ApplicationResourceLifecycleConfig {
    var result: ApplicationResourceLifecycleConfig = undefined;
    result.service_role = null;
    result.version_lifecycle_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ServiceRole")) {
                    result.service_role = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionLifecycleConfig")) {
                    result.version_lifecycle_config = try deserializeApplicationVersionLifecycleConfig(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeApplicationVersionDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ApplicationVersionDescription {
    var result: ApplicationVersionDescription = undefined;
    result.application_name = null;
    result.application_version_arn = null;
    result.build_arn = null;
    result.date_created = null;
    result.date_updated = null;
    result.description = null;
    result.source_build_information = null;
    result.source_bundle = null;
    result.status = null;
    result.version_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplicationVersionArn")) {
                    result.application_version_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BuildArn")) {
                    result.build_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceBuildInformation")) {
                    result.source_build_information = try deserializeSourceBuildInformation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SourceBundle")) {
                    result.source_bundle = try deserializeS3Location(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ApplicationVersionStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionLabel")) {
                    result.version_label = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeApplicationVersionLifecycleConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ApplicationVersionLifecycleConfig {
    var result: ApplicationVersionLifecycleConfig = undefined;
    result.max_age_rule = null;
    result.max_count_rule = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MaxAgeRule")) {
                    result.max_age_rule = try deserializeMaxAgeRule(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MaxCountRule")) {
                    result.max_count_rule = try deserializeMaxCountRule(allocator, reader);
                } else {
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

pub fn deserializeBuilder(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Builder {
    var result: Builder = undefined;
    result.arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
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

pub fn deserializeCPUUtilization(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CPUUtilization {
    _ = allocator;
    var result: CPUUtilization = undefined;
    result.idle = null;
    result.io_wait = null;
    result.irq = null;
    result.nice = null;
    result.privileged = null;
    result.soft_irq = null;
    result.system = null;
    result.user = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Idle")) {
                    result.idle = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IOWait")) {
                    result.io_wait = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IRQ")) {
                    result.irq = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Nice")) {
                    result.nice = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Privileged")) {
                    result.privileged = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SoftIRQ")) {
                    result.soft_irq = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "System")) {
                    result.system = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "User")) {
                    result.user = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConfigurationOptionDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConfigurationOptionDescription {
    var result: ConfigurationOptionDescription = undefined;
    result.change_severity = null;
    result.default_value = null;
    result.max_length = null;
    result.max_value = null;
    result.min_value = null;
    result.name = null;
    result.namespace = null;
    result.regex = null;
    result.user_defined = null;
    result.value_options = null;
    result.value_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChangeSeverity")) {
                    result.change_severity = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxLength")) {
                    result.max_length = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxValue")) {
                    result.max_value = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinValue")) {
                    result.min_value = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Regex")) {
                    result.regex = try deserializeOptionRestrictionRegex(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "UserDefined")) {
                    result.user_defined = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ValueOptions")) {
                    result.value_options = try deserializeConfigurationOptionPossibleValues(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ValueType")) {
                    result.value_type = std.meta.stringToEnum(ConfigurationOptionValueType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConfigurationOptionSetting(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConfigurationOptionSetting {
    var result: ConfigurationOptionSetting = undefined;
    result.namespace = null;
    result.option_name = null;
    result.resource_name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionName")) {
                    result.option_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceName")) {
                    result.resource_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeConfigurationSettingsDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConfigurationSettingsDescription {
    var result: ConfigurationSettingsDescription = undefined;
    result.application_name = null;
    result.date_created = null;
    result.date_updated = null;
    result.deployment_status = null;
    result.description = null;
    result.environment_name = null;
    result.option_settings = null;
    result.platform_arn = null;
    result.solution_stack_name = null;
    result.template_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DeploymentStatus")) {
                    result.deployment_status = std.meta.stringToEnum(ConfigurationDeploymentStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionSettings")) {
                    result.option_settings = try deserializeConfigurationOptionSettingsList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomAmi(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CustomAmi {
    var result: CustomAmi = undefined;
    result.image_id = null;
    result.virtualization_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VirtualizationType")) {
                    result.virtualization_type = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDeployment(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Deployment {
    var result: Deployment = undefined;
    result.deployment_id = null;
    result.deployment_time = null;
    result.status = null;
    result.version_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeploymentId")) {
                    result.deployment_id = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DeploymentTime")) {
                    result.deployment_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionLabel")) {
                    result.version_label = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EnvironmentDescription {
    var result: EnvironmentDescription = undefined;
    result.abortable_operation_in_progress = null;
    result.application_name = null;
    result.cname = null;
    result.date_created = null;
    result.date_updated = null;
    result.description = null;
    result.endpoint_url = null;
    result.environment_arn = null;
    result.environment_id = null;
    result.environment_links = null;
    result.environment_name = null;
    result.health = null;
    result.health_status = null;
    result.operations_role = null;
    result.platform_arn = null;
    result.resources = null;
    result.solution_stack_name = null;
    result.status = null;
    result.template_name = null;
    result.tier = null;
    result.version_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AbortableOperationInProgress")) {
                    result.abortable_operation_in_progress = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CNAME")) {
                    result.cname = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointURL")) {
                    result.endpoint_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentArn")) {
                    result.environment_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentId")) {
                    result.environment_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentLinks")) {
                    result.environment_links = try deserializeEnvironmentLinks(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Health")) {
                    result.health = std.meta.stringToEnum(EnvironmentHealth, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = std.meta.stringToEnum(EnvironmentHealthStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationsRole")) {
                    result.operations_role = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Resources")) {
                    result.resources = try deserializeEnvironmentResourcesDescription(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(EnvironmentStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tier")) {
                    result.tier = try deserializeEnvironmentTier(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "VersionLabel")) {
                    result.version_label = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentInfoDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EnvironmentInfoDescription {
    var result: EnvironmentInfoDescription = undefined;
    result.ec_2_instance_id = null;
    result.info_type = null;
    result.message = null;
    result.sample_timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Ec2InstanceId")) {
                    result.ec_2_instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InfoType")) {
                    result.info_type = std.meta.stringToEnum(EnvironmentInfoType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SampleTimestamp")) {
                    result.sample_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentLink(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EnvironmentLink {
    var result: EnvironmentLink = undefined;
    result.environment_name = null;
    result.link_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LinkName")) {
                    result.link_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentResourceDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EnvironmentResourceDescription {
    var result: EnvironmentResourceDescription = undefined;
    result.auto_scaling_groups = null;
    result.environment_name = null;
    result.instances = null;
    result.launch_configurations = null;
    result.launch_templates = null;
    result.load_balancers = null;
    result.queues = null;
    result.triggers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoScalingGroups")) {
                    result.auto_scaling_groups = try deserializeAutoScalingGroupList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Instances")) {
                    result.instances = try deserializeInstanceList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurations")) {
                    result.launch_configurations = try deserializeLaunchConfigurationList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LaunchTemplates")) {
                    result.launch_templates = try deserializeLaunchTemplateList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LoadBalancers")) {
                    result.load_balancers = try deserializeLoadBalancerList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Queues")) {
                    result.queues = try deserializeQueueList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Triggers")) {
                    result.triggers = try deserializeTriggerList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentResourcesDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EnvironmentResourcesDescription {
    var result: EnvironmentResourcesDescription = undefined;
    result.load_balancer = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancer")) {
                    result.load_balancer = try deserializeLoadBalancerDescription(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentTier(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EnvironmentTier {
    var result: EnvironmentTier = undefined;
    result.name = null;
    result.@"type" = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeEventDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EventDescription {
    var result: EventDescription = undefined;
    result.application_name = null;
    result.environment_name = null;
    result.event_date = null;
    result.message = null;
    result.platform_arn = null;
    result.request_id = null;
    result.severity = null;
    result.template_name = null;
    result.version_label = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EventDate")) {
                    result.event_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestId")) {
                    result.request_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Severity")) {
                    result.severity = std.meta.stringToEnum(EventSeverity, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionLabel")) {
                    result.version_label = try allocator.dupe(u8, try reader.readElementText());
                } else {
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
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInstanceHealthSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceHealthSummary {
    _ = allocator;
    var result: InstanceHealthSummary = undefined;
    result.degraded = null;
    result.info = null;
    result.no_data = null;
    result.ok = null;
    result.pending = null;
    result.severe = null;
    result.unknown = null;
    result.warning = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Degraded")) {
                    result.degraded = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Info")) {
                    result.info = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NoData")) {
                    result.no_data = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Ok")) {
                    result.ok = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Pending")) {
                    result.pending = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Severe")) {
                    result.severe = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Unknown")) {
                    result.unknown = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Warning")) {
                    result.warning = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLatency(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Latency {
    _ = allocator;
    var result: Latency = undefined;
    result.p10 = null;
    result.p50 = null;
    result.p75 = null;
    result.p85 = null;
    result.p90 = null;
    result.p95 = null;
    result.p99 = null;
    result.p999 = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "P10")) {
                    result.p10 = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "P50")) {
                    result.p50 = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "P75")) {
                    result.p75 = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "P85")) {
                    result.p85 = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "P90")) {
                    result.p90 = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "P95")) {
                    result.p95 = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "P99")) {
                    result.p99 = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "P999")) {
                    result.p999 = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
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

pub fn deserializeLaunchTemplate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LaunchTemplate {
    var result: LaunchTemplate = undefined;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeListener(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Listener {
    var result: Listener = undefined;
    result.port = 0;
    result.protocol = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoadBalancer(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancer {
    var result: LoadBalancer = undefined;
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

pub fn deserializeLoadBalancerDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancerDescription {
    var result: LoadBalancerDescription = undefined;
    result.domain = null;
    result.listeners = null;
    result.load_balancer_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Listeners")) {
                    result.listeners = try deserializeLoadBalancerListenersDescription(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeManagedAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ManagedAction {
    var result: ManagedAction = undefined;
    result.action_description = null;
    result.action_id = null;
    result.action_type = null;
    result.status = null;
    result.window_start_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActionDescription")) {
                    result.action_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionId")) {
                    result.action_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionType")) {
                    result.action_type = std.meta.stringToEnum(ActionType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ActionStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "WindowStartTime")) {
                    result.window_start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeManagedActionHistoryItem(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ManagedActionHistoryItem {
    var result: ManagedActionHistoryItem = undefined;
    result.action_description = null;
    result.action_id = null;
    result.action_type = null;
    result.executed_time = null;
    result.failure_description = null;
    result.failure_type = null;
    result.finished_time = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActionDescription")) {
                    result.action_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionId")) {
                    result.action_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionType")) {
                    result.action_type = std.meta.stringToEnum(ActionType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutedTime")) {
                    result.executed_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "FailureDescription")) {
                    result.failure_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureType")) {
                    result.failure_type = std.meta.stringToEnum(FailureType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FinishedTime")) {
                    result.finished_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ActionHistoryStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMaxAgeRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MaxAgeRule {
    _ = allocator;
    var result: MaxAgeRule = undefined;
    result.delete_source_from_s3 = null;
    result.max_age_in_days = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteSourceFromS3")) {
                    result.delete_source_from_s3 = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxAgeInDays")) {
                    result.max_age_in_days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMaxCountRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MaxCountRule {
    _ = allocator;
    var result: MaxCountRule = undefined;
    result.delete_source_from_s3 = null;
    result.max_count = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteSourceFromS3")) {
                    result.delete_source_from_s3 = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxCount")) {
                    result.max_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOptionRestrictionRegex(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OptionRestrictionRegex {
    var result: OptionRestrictionRegex = undefined;
    result.label = null;
    result.pattern = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Pattern")) {
                    result.pattern = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePlatformBranchSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PlatformBranchSummary {
    var result: PlatformBranchSummary = undefined;
    result.branch_name = null;
    result.branch_order = 0;
    result.lifecycle_state = null;
    result.platform_name = null;
    result.supported_tier_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BranchName")) {
                    result.branch_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BranchOrder")) {
                    result.branch_order = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LifecycleState")) {
                    result.lifecycle_state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformName")) {
                    result.platform_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedTierList")) {
                    result.supported_tier_list = try deserializeSupportedTierList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePlatformDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PlatformDescription {
    var result: PlatformDescription = undefined;
    result.custom_ami_list = null;
    result.date_created = null;
    result.date_updated = null;
    result.description = null;
    result.frameworks = null;
    result.maintainer = null;
    result.operating_system_name = null;
    result.operating_system_version = null;
    result.platform_arn = null;
    result.platform_branch_lifecycle_state = null;
    result.platform_branch_name = null;
    result.platform_category = null;
    result.platform_lifecycle_state = null;
    result.platform_name = null;
    result.platform_owner = null;
    result.platform_status = null;
    result.platform_version = null;
    result.programming_languages = null;
    result.solution_stack_name = null;
    result.supported_addon_list = null;
    result.supported_tier_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CustomAmiList")) {
                    result.custom_ami_list = try deserializeCustomAmiList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Frameworks")) {
                    result.frameworks = try deserializePlatformFrameworks(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Maintainer")) {
                    result.maintainer = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperatingSystemName")) {
                    result.operating_system_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperatingSystemVersion")) {
                    result.operating_system_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformBranchLifecycleState")) {
                    result.platform_branch_lifecycle_state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformBranchName")) {
                    result.platform_branch_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformCategory")) {
                    result.platform_category = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformLifecycleState")) {
                    result.platform_lifecycle_state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformName")) {
                    result.platform_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformOwner")) {
                    result.platform_owner = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformStatus")) {
                    result.platform_status = std.meta.stringToEnum(PlatformStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformVersion")) {
                    result.platform_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProgrammingLanguages")) {
                    result.programming_languages = try deserializePlatformProgrammingLanguages(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedAddonList")) {
                    result.supported_addon_list = try deserializeSupportedAddonList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedTierList")) {
                    result.supported_tier_list = try deserializeSupportedTierList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePlatformFramework(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PlatformFramework {
    var result: PlatformFramework = undefined;
    result.name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePlatformProgrammingLanguage(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PlatformProgrammingLanguage {
    var result: PlatformProgrammingLanguage = undefined;
    result.name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePlatformSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PlatformSummary {
    var result: PlatformSummary = undefined;
    result.operating_system_name = null;
    result.operating_system_version = null;
    result.platform_arn = null;
    result.platform_branch_lifecycle_state = null;
    result.platform_branch_name = null;
    result.platform_category = null;
    result.platform_lifecycle_state = null;
    result.platform_owner = null;
    result.platform_status = null;
    result.platform_version = null;
    result.supported_addon_list = null;
    result.supported_tier_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OperatingSystemName")) {
                    result.operating_system_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperatingSystemVersion")) {
                    result.operating_system_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformBranchLifecycleState")) {
                    result.platform_branch_lifecycle_state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformBranchName")) {
                    result.platform_branch_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformCategory")) {
                    result.platform_category = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformLifecycleState")) {
                    result.platform_lifecycle_state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformOwner")) {
                    result.platform_owner = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformStatus")) {
                    result.platform_status = std.meta.stringToEnum(PlatformStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformVersion")) {
                    result.platform_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedAddonList")) {
                    result.supported_addon_list = try deserializeSupportedAddonList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedTierList")) {
                    result.supported_tier_list = try deserializeSupportedTierList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueue(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Queue {
    var result: Queue = undefined;
    result.name = null;
    result.url = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "URL")) {
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

pub fn deserializeResourceQuota(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceQuota {
    _ = allocator;
    var result: ResourceQuota = undefined;
    result.maximum = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Maximum")) {
                    result.maximum = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResourceQuotas(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceQuotas {
    var result: ResourceQuotas = undefined;
    result.application_quota = null;
    result.application_version_quota = null;
    result.configuration_template_quota = null;
    result.custom_platform_quota = null;
    result.environment_quota = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationQuota")) {
                    result.application_quota = try deserializeResourceQuota(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ApplicationVersionQuota")) {
                    result.application_version_quota = try deserializeResourceQuota(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ConfigurationTemplateQuota")) {
                    result.configuration_template_quota = try deserializeResourceQuota(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CustomPlatformQuota")) {
                    result.custom_platform_quota = try deserializeResourceQuota(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "EnvironmentQuota")) {
                    result.environment_quota = try deserializeResourceQuota(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3Location(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3Location {
    var result: S3Location = undefined;
    result.s3_bucket = null;
    result.s3_key = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3Bucket")) {
                    result.s3_bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3Key")) {
                    result.s3_key = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSingleInstanceHealth(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SingleInstanceHealth {
    var result: SingleInstanceHealth = undefined;
    result.application_metrics = null;
    result.availability_zone = null;
    result.causes = null;
    result.color = null;
    result.deployment = null;
    result.health_status = null;
    result.instance_id = null;
    result.instance_type = null;
    result.launched_at = null;
    result.system = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationMetrics")) {
                    result.application_metrics = try deserializeApplicationMetrics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Causes")) {
                    result.causes = try deserializeCauses(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Color")) {
                    result.color = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Deployment")) {
                    result.deployment = try deserializeDeployment(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchedAt")) {
                    result.launched_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "System")) {
                    result.system = try deserializeSystemStatus(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSolutionStackDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SolutionStackDescription {
    var result: SolutionStackDescription = undefined;
    result.permitted_file_types = null;
    result.solution_stack_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PermittedFileTypes")) {
                    result.permitted_file_types = try deserializeSolutionStackFileTypeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSourceBuildInformation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SourceBuildInformation {
    var result: SourceBuildInformation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SourceLocation")) {
                    result.source_location = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceRepository")) {
                    result.source_repository = std.meta.stringToEnum(SourceRepository, try reader.readElementText());
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

pub fn deserializeStatusCodes(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StatusCodes {
    _ = allocator;
    var result: StatusCodes = undefined;
    result.status_2_xx = null;
    result.status_3_xx = null;
    result.status_4_xx = null;
    result.status_5_xx = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status2xx")) {
                    result.status_2_xx = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status3xx")) {
                    result.status_3_xx = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status4xx")) {
                    result.status_4_xx = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status5xx")) {
                    result.status_5_xx = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSystemStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SystemStatus {
    var result: SystemStatus = undefined;
    result.cpu_utilization = null;
    result.load_average = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CPUUtilization")) {
                    result.cpu_utilization = try deserializeCPUUtilization(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LoadAverage")) {
                    result.load_average = try deserializeLoadAverage(allocator, reader, "member");
                } else {
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

pub fn deserializeTrigger(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Trigger {
    var result: Trigger = undefined;
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

pub fn deserializeValidationMessage(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ValidationMessage {
    var result: ValidationMessage = undefined;
    result.message = null;
    result.namespace = null;
    result.option_name = null;
    result.severity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionName")) {
                    result.option_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Severity")) {
                    result.severity = std.meta.stringToEnum(ValidationSeverity, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeApplicationNamesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeConfigurationOptionSettingsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ConfigurationOptionSetting, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeConfigurationOptionSetting(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEnvironmentHealthAttributes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EnvironmentHealthAttribute, comptime item_tag: []const u8) !void {
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

pub fn serializeEnvironmentIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeEnvironmentNamesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeInstancesHealthAttributes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const InstancesHealthAttribute, comptime item_tag: []const u8) !void {
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

pub fn serializeOptionsSpecifierList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OptionSpecification, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeOptionSpecification(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializePlatformFilterValueList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePlatformFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PlatformFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializePlatformFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSearchFilterValues(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSearchFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const SearchFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeSearchFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagKeyList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeVersionLabels(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeVersionLabelsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeApplicationResourceLifecycleConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ApplicationResourceLifecycleConfig) !void {
    if (value.service_role) |v| {
        try buf.appendSlice(allocator, "<ServiceRole>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ServiceRole>");
    }
    if (value.version_lifecycle_config) |v| {
        try buf.appendSlice(allocator, "<VersionLifecycleConfig>");
        try serializeApplicationVersionLifecycleConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</VersionLifecycleConfig>");
    }
}

pub fn serializeApplicationVersionLifecycleConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ApplicationVersionLifecycleConfig) !void {
    if (value.max_age_rule) |v| {
        try buf.appendSlice(allocator, "<MaxAgeRule>");
        try serializeMaxAgeRule(allocator, buf, v);
        try buf.appendSlice(allocator, "</MaxAgeRule>");
    }
    if (value.max_count_rule) |v| {
        try buf.appendSlice(allocator, "<MaxCountRule>");
        try serializeMaxCountRule(allocator, buf, v);
        try buf.appendSlice(allocator, "</MaxCountRule>");
    }
}

pub fn serializeBuildConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: BuildConfiguration) !void {
    if (value.artifact_name) |v| {
        try buf.appendSlice(allocator, "<ArtifactName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ArtifactName>");
    }
    try buf.appendSlice(allocator, "<CodeBuildServiceRole>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.code_build_service_role);
    try buf.appendSlice(allocator, "</CodeBuildServiceRole>");
    if (value.compute_type) |v| {
        try buf.appendSlice(allocator, "<ComputeType>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</ComputeType>");
    }
    try buf.appendSlice(allocator, "<Image>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.image);
    try buf.appendSlice(allocator, "</Image>");
    if (value.timeout_in_minutes) |v| {
        try buf.appendSlice(allocator, "<TimeoutInMinutes>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</TimeoutInMinutes>");
    }
}

pub fn serializeConfigurationOptionSetting(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConfigurationOptionSetting) !void {
    if (value.namespace) |v| {
        try buf.appendSlice(allocator, "<Namespace>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Namespace>");
    }
    if (value.option_name) |v| {
        try buf.appendSlice(allocator, "<OptionName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OptionName>");
    }
    if (value.resource_name) |v| {
        try buf.appendSlice(allocator, "<ResourceName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourceName>");
    }
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeEnvironmentTier(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EnvironmentTier) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Type>");
    }
    if (value.version) |v| {
        try buf.appendSlice(allocator, "<Version>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Version>");
    }
}

pub fn serializeMaxAgeRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MaxAgeRule) !void {
    if (value.delete_source_from_s3) |v| {
        try buf.appendSlice(allocator, "<DeleteSourceFromS3>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</DeleteSourceFromS3>");
    }
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.max_age_in_days) |v| {
        try buf.appendSlice(allocator, "<MaxAgeInDays>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxAgeInDays>");
    }
}

pub fn serializeMaxCountRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MaxCountRule) !void {
    if (value.delete_source_from_s3) |v| {
        try buf.appendSlice(allocator, "<DeleteSourceFromS3>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</DeleteSourceFromS3>");
    }
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.max_count) |v| {
        try buf.appendSlice(allocator, "<MaxCount>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxCount>");
    }
}

pub fn serializeOptionSpecification(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OptionSpecification) !void {
    if (value.namespace) |v| {
        try buf.appendSlice(allocator, "<Namespace>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Namespace>");
    }
    if (value.option_name) |v| {
        try buf.appendSlice(allocator, "<OptionName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OptionName>");
    }
    if (value.resource_name) |v| {
        try buf.appendSlice(allocator, "<ResourceName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourceName>");
    }
}

pub fn serializePlatformFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PlatformFilter) !void {
    if (value.operator) |v| {
        try buf.appendSlice(allocator, "<Operator>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Operator>");
    }
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Type>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializePlatformFilterValueList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeS3Location(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Location) !void {
    if (value.s3_bucket) |v| {
        try buf.appendSlice(allocator, "<S3Bucket>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3Bucket>");
    }
    if (value.s3_key) |v| {
        try buf.appendSlice(allocator, "<S3Key>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3Key>");
    }
}

pub fn serializeSearchFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SearchFilter) !void {
    if (value.attribute) |v| {
        try buf.appendSlice(allocator, "<Attribute>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Attribute>");
    }
    if (value.operator) |v| {
        try buf.appendSlice(allocator, "<Operator>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Operator>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeSearchFilterValues(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeSourceBuildInformation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SourceBuildInformation) !void {
    try buf.appendSlice(allocator, "<SourceLocation>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.source_location);
    try buf.appendSlice(allocator, "</SourceLocation>");
    try buf.appendSlice(allocator, "<SourceRepository>");
    try buf.appendSlice(allocator, @tagName(value.source_repository));
    try buf.appendSlice(allocator, "</SourceRepository>");
    try buf.appendSlice(allocator, "<SourceType>");
    try buf.appendSlice(allocator, @tagName(value.source_type));
    try buf.appendSlice(allocator, "</SourceType>");
}

pub fn serializeSourceConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SourceConfiguration) !void {
    if (value.application_name) |v| {
        try buf.appendSlice(allocator, "<ApplicationName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ApplicationName>");
    }
    if (value.template_name) |v| {
        try buf.appendSlice(allocator, "<TemplateName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TemplateName>");
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

