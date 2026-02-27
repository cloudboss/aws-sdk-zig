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

pub fn deserializeApplicationDescriptionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ApplicationDescription {
    var list: std.ArrayList(ApplicationDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeApplicationDescription(reader, alloc));
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

pub fn deserializeApplicationVersionDescriptionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ApplicationVersionDescription {
    var list: std.ArrayList(ApplicationVersionDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeApplicationVersionDescription(reader, alloc));
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

pub fn deserializeAutoScalingGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AutoScalingGroup {
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

pub fn deserializeAvailableSolutionStackDetailsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SolutionStackDescription {
    var list: std.ArrayList(SolutionStackDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSolutionStackDescription(reader, alloc));
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

pub fn deserializeAvailableSolutionStackNamesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCauses(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeConfigurationOptionDescriptionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ConfigurationOptionDescription {
    var list: std.ArrayList(ConfigurationOptionDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeConfigurationOptionDescription(reader, alloc));
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

pub fn deserializeConfigurationOptionPossibleValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeConfigurationOptionSettingsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ConfigurationOptionSetting {
    var list: std.ArrayList(ConfigurationOptionSetting) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeConfigurationOptionSetting(reader, alloc));
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

pub fn deserializeConfigurationSettingsDescriptionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ConfigurationSettingsDescription {
    var list: std.ArrayList(ConfigurationSettingsDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeConfigurationSettingsDescription(reader, alloc));
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

pub fn deserializeConfigurationTemplateNamesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCustomAmiList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CustomAmi {
    var list: std.ArrayList(CustomAmi) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCustomAmi(reader, alloc));
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

pub fn deserializeEnvironmentDescriptionsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EnvironmentDescription {
    var list: std.ArrayList(EnvironmentDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEnvironmentDescription(reader, alloc));
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

pub fn deserializeEnvironmentInfoDescriptionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EnvironmentInfoDescription {
    var list: std.ArrayList(EnvironmentInfoDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEnvironmentInfoDescription(reader, alloc));
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

pub fn deserializeEnvironmentLinks(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EnvironmentLink {
    var list: std.ArrayList(EnvironmentLink) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEnvironmentLink(reader, alloc));
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

pub fn deserializeEventDescriptionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EventDescription {
    var list: std.ArrayList(EventDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEventDescription(reader, alloc));
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

pub fn deserializeInstanceHealthList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SingleInstanceHealth {
    var list: std.ArrayList(SingleInstanceHealth) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSingleInstanceHealth(reader, alloc));
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

pub fn deserializeInstanceList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Instance {
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

pub fn deserializeLaunchConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LaunchConfiguration {
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

pub fn deserializeLaunchTemplateList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LaunchTemplate {
    var list: std.ArrayList(LaunchTemplate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLaunchTemplate(reader, alloc));
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

pub fn deserializeLoadAverage(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const f64 {
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

pub fn deserializeLoadBalancerList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LoadBalancer {
    var list: std.ArrayList(LoadBalancer) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLoadBalancer(reader, alloc));
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

pub fn deserializeLoadBalancerListenersDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Listener {
    var list: std.ArrayList(Listener) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListener(reader, alloc));
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

pub fn deserializeManagedActionHistoryItems(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ManagedActionHistoryItem {
    var list: std.ArrayList(ManagedActionHistoryItem) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeManagedActionHistoryItem(reader, alloc));
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

pub fn deserializeManagedActions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ManagedAction {
    var list: std.ArrayList(ManagedAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeManagedAction(reader, alloc));
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

pub fn deserializePlatformBranchSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PlatformBranchSummary {
    var list: std.ArrayList(PlatformBranchSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePlatformBranchSummary(reader, alloc));
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

pub fn deserializePlatformFrameworks(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PlatformFramework {
    var list: std.ArrayList(PlatformFramework) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePlatformFramework(reader, alloc));
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

pub fn deserializePlatformProgrammingLanguages(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PlatformProgrammingLanguage {
    var list: std.ArrayList(PlatformProgrammingLanguage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePlatformProgrammingLanguage(reader, alloc));
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

pub fn deserializePlatformSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PlatformSummary {
    var list: std.ArrayList(PlatformSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePlatformSummary(reader, alloc));
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

pub fn deserializeQueueList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Queue {
    var list: std.ArrayList(Queue) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeQueue(reader, alloc));
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

pub fn deserializeSolutionStackFileTypeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSupportedAddonList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSupportedTierList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTriggerList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Trigger {
    var list: std.ArrayList(Trigger) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrigger(reader, alloc));
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

pub fn deserializeValidationMessagesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ValidationMessage {
    var list: std.ArrayList(ValidationMessage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeValidationMessage(reader, alloc));
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

pub fn deserializeVersionLabelsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeApplicationDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ApplicationDescription {
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
                    result.application_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConfigurationTemplates")) {
                    result.configuration_templates = try deserializeConfigurationTemplateNamesList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLifecycleConfig")) {
                    result.resource_lifecycle_config = try deserializeApplicationResourceLifecycleConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Versions")) {
                    result.versions = try deserializeVersionLabelsList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeApplicationMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ApplicationMetrics {
    var result: ApplicationMetrics = undefined;
    result.duration = null;
    result.latency = null;
    result.request_count = null;
    result.status_codes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Latency")) {
                    result.latency = try deserializeLatency(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RequestCount")) {
                    result.request_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StatusCodes")) {
                    result.status_codes = try deserializeStatusCodes(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeApplicationResourceLifecycleConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ApplicationResourceLifecycleConfig {
    var result: ApplicationResourceLifecycleConfig = undefined;
    result.service_role = null;
    result.version_lifecycle_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ServiceRole")) {
                    result.service_role = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionLifecycleConfig")) {
                    result.version_lifecycle_config = try deserializeApplicationVersionLifecycleConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeApplicationVersionDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ApplicationVersionDescription {
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
                    result.application_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplicationVersionArn")) {
                    result.application_version_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BuildArn")) {
                    result.build_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceBuildInformation")) {
                    result.source_build_information = try deserializeSourceBuildInformation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SourceBundle")) {
                    result.source_bundle = try deserializeS3Location(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ApplicationVersionStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionLabel")) {
                    result.version_label = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeApplicationVersionLifecycleConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ApplicationVersionLifecycleConfig {
    var result: ApplicationVersionLifecycleConfig = undefined;
    result.max_age_rule = null;
    result.max_count_rule = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MaxAgeRule")) {
                    result.max_age_rule = try deserializeMaxAgeRule(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MaxCountRule")) {
                    result.max_count_rule = try deserializeMaxCountRule(reader, alloc);
                } else {
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

pub fn deserializeBuilder(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Builder {
    var result: Builder = undefined;
    result.arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
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

pub fn deserializeCPUUtilization(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CPUUtilization {
    _ = alloc;
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

pub fn deserializeConfigurationOptionDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConfigurationOptionDescription {
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
                    result.change_severity = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxLength")) {
                    result.max_length = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxValue")) {
                    result.max_value = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinValue")) {
                    result.min_value = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Regex")) {
                    result.regex = try deserializeOptionRestrictionRegex(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "UserDefined")) {
                    result.user_defined = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ValueOptions")) {
                    result.value_options = try deserializeConfigurationOptionPossibleValues(reader, alloc, "member");
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

pub fn deserializeConfigurationOptionSetting(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConfigurationOptionSetting {
    var result: ConfigurationOptionSetting = undefined;
    result.namespace = null;
    result.option_name = null;
    result.resource_name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionName")) {
                    result.option_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceName")) {
                    result.resource_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeConfigurationSettingsDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConfigurationSettingsDescription {
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
                    result.application_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DeploymentStatus")) {
                    result.deployment_status = std.meta.stringToEnum(ConfigurationDeploymentStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionSettings")) {
                    result.option_settings = try deserializeConfigurationOptionSettingsList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomAmi(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CustomAmi {
    var result: CustomAmi = undefined;
    result.image_id = null;
    result.virtualization_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ImageId")) {
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VirtualizationType")) {
                    result.virtualization_type = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDeployment(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Deployment {
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
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionLabel")) {
                    result.version_label = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EnvironmentDescription {
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
                    result.application_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CNAME")) {
                    result.cname = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointURL")) {
                    result.endpoint_url = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentArn")) {
                    result.environment_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentId")) {
                    result.environment_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentLinks")) {
                    result.environment_links = try deserializeEnvironmentLinks(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Health")) {
                    result.health = std.meta.stringToEnum(EnvironmentHealth, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = std.meta.stringToEnum(EnvironmentHealthStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationsRole")) {
                    result.operations_role = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Resources")) {
                    result.resources = try deserializeEnvironmentResourcesDescription(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(EnvironmentStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tier")) {
                    result.tier = try deserializeEnvironmentTier(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "VersionLabel")) {
                    result.version_label = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentInfoDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EnvironmentInfoDescription {
    var result: EnvironmentInfoDescription = undefined;
    result.ec_2_instance_id = null;
    result.info_type = null;
    result.message = null;
    result.sample_timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Ec2InstanceId")) {
                    result.ec_2_instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InfoType")) {
                    result.info_type = std.meta.stringToEnum(EnvironmentInfoType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeEnvironmentLink(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EnvironmentLink {
    var result: EnvironmentLink = undefined;
    result.environment_name = null;
    result.link_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LinkName")) {
                    result.link_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentResourceDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EnvironmentResourceDescription {
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
                    result.auto_scaling_groups = try deserializeAutoScalingGroupList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Instances")) {
                    result.instances = try deserializeInstanceList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LaunchConfigurations")) {
                    result.launch_configurations = try deserializeLaunchConfigurationList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LaunchTemplates")) {
                    result.launch_templates = try deserializeLaunchTemplateList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LoadBalancers")) {
                    result.load_balancers = try deserializeLoadBalancerList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Queues")) {
                    result.queues = try deserializeQueueList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Triggers")) {
                    result.triggers = try deserializeTriggerList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentResourcesDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EnvironmentResourcesDescription {
    var result: EnvironmentResourcesDescription = undefined;
    result.load_balancer = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancer")) {
                    result.load_balancer = try deserializeLoadBalancerDescription(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEnvironmentTier(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EnvironmentTier {
    var result: EnvironmentTier = undefined;
    result.name = null;
    result.type = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeEventDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EventDescription {
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
                    result.application_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EventDate")) {
                    result.event_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestId")) {
                    result.request_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Severity")) {
                    result.severity = std.meta.stringToEnum(EventSeverity, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionLabel")) {
                    result.version_label = try alloc.dupe(u8, try reader.readElementText());
                } else {
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
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInstanceHealthSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceHealthSummary {
    _ = alloc;
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

pub fn deserializeLatency(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Latency {
    _ = alloc;
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

pub fn deserializeLaunchConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LaunchConfiguration {
    var result: LaunchConfiguration = undefined;
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

pub fn deserializeLaunchTemplate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LaunchTemplate {
    var result: LaunchTemplate = undefined;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeListener(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Listener {
    var result: Listener = undefined;
    result.port = null;
    result.protocol = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoadBalancer(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancer {
    var result: LoadBalancer = undefined;
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

pub fn deserializeLoadBalancerDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancerDescription {
    var result: LoadBalancerDescription = undefined;
    result.domain = null;
    result.listeners = null;
    result.load_balancer_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Listeners")) {
                    result.listeners = try deserializeLoadBalancerListenersDescription(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeManagedAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ManagedAction {
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
                    result.action_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionId")) {
                    result.action_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeManagedActionHistoryItem(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ManagedActionHistoryItem {
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
                    result.action_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionId")) {
                    result.action_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionType")) {
                    result.action_type = std.meta.stringToEnum(ActionType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutedTime")) {
                    result.executed_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "FailureDescription")) {
                    result.failure_description = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeMaxAgeRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MaxAgeRule {
    _ = alloc;
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

pub fn deserializeMaxCountRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MaxCountRule {
    _ = alloc;
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

pub fn deserializeOptionRestrictionRegex(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OptionRestrictionRegex {
    var result: OptionRestrictionRegex = undefined;
    result.label = null;
    result.pattern = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Pattern")) {
                    result.pattern = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePlatformBranchSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PlatformBranchSummary {
    var result: PlatformBranchSummary = undefined;
    result.branch_name = null;
    result.branch_order = null;
    result.lifecycle_state = null;
    result.platform_name = null;
    result.supported_tier_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BranchName")) {
                    result.branch_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BranchOrder")) {
                    result.branch_order = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LifecycleState")) {
                    result.lifecycle_state = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformName")) {
                    result.platform_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedTierList")) {
                    result.supported_tier_list = try deserializeSupportedTierList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePlatformDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PlatformDescription {
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
                    result.custom_ami_list = try deserializeCustomAmiList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Frameworks")) {
                    result.frameworks = try deserializePlatformFrameworks(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Maintainer")) {
                    result.maintainer = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperatingSystemName")) {
                    result.operating_system_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperatingSystemVersion")) {
                    result.operating_system_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformBranchLifecycleState")) {
                    result.platform_branch_lifecycle_state = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformBranchName")) {
                    result.platform_branch_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformCategory")) {
                    result.platform_category = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformLifecycleState")) {
                    result.platform_lifecycle_state = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformName")) {
                    result.platform_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformOwner")) {
                    result.platform_owner = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformStatus")) {
                    result.platform_status = std.meta.stringToEnum(PlatformStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformVersion")) {
                    result.platform_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProgrammingLanguages")) {
                    result.programming_languages = try deserializePlatformProgrammingLanguages(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedAddonList")) {
                    result.supported_addon_list = try deserializeSupportedAddonList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedTierList")) {
                    result.supported_tier_list = try deserializeSupportedTierList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePlatformFramework(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PlatformFramework {
    var result: PlatformFramework = undefined;
    result.name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePlatformProgrammingLanguage(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PlatformProgrammingLanguage {
    var result: PlatformProgrammingLanguage = undefined;
    result.name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePlatformSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PlatformSummary {
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
                    result.operating_system_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperatingSystemVersion")) {
                    result.operating_system_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformBranchLifecycleState")) {
                    result.platform_branch_lifecycle_state = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformBranchName")) {
                    result.platform_branch_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformCategory")) {
                    result.platform_category = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformLifecycleState")) {
                    result.platform_lifecycle_state = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformOwner")) {
                    result.platform_owner = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformStatus")) {
                    result.platform_status = std.meta.stringToEnum(PlatformStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformVersion")) {
                    result.platform_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedAddonList")) {
                    result.supported_addon_list = try deserializeSupportedAddonList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedTierList")) {
                    result.supported_tier_list = try deserializeSupportedTierList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueue(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Queue {
    var result: Queue = undefined;
    result.name = null;
    result.url = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "URL")) {
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

pub fn deserializeResourceQuota(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceQuota {
    _ = alloc;
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

pub fn deserializeResourceQuotas(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceQuotas {
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
                    result.application_quota = try deserializeResourceQuota(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ApplicationVersionQuota")) {
                    result.application_version_quota = try deserializeResourceQuota(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ConfigurationTemplateQuota")) {
                    result.configuration_template_quota = try deserializeResourceQuota(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CustomPlatformQuota")) {
                    result.custom_platform_quota = try deserializeResourceQuota(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "EnvironmentQuota")) {
                    result.environment_quota = try deserializeResourceQuota(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3Location(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3Location {
    var result: S3Location = undefined;
    result.s3_bucket = null;
    result.s3_key = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "S3Bucket")) {
                    result.s3_bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3Key")) {
                    result.s3_key = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSingleInstanceHealth(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SingleInstanceHealth {
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
                    result.application_metrics = try deserializeApplicationMetrics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Causes")) {
                    result.causes = try deserializeCauses(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Color")) {
                    result.color = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Deployment")) {
                    result.deployment = try deserializeDeployment(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceId")) {
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceType")) {
                    result.instance_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LaunchedAt")) {
                    result.launched_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "System")) {
                    result.system = try deserializeSystemStatus(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSolutionStackDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SolutionStackDescription {
    var result: SolutionStackDescription = undefined;
    result.permitted_file_types = null;
    result.solution_stack_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PermittedFileTypes")) {
                    result.permitted_file_types = try deserializeSolutionStackFileTypeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSourceBuildInformation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SourceBuildInformation {
    var result: SourceBuildInformation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SourceLocation")) {
                    result.source_location = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStatusCodes(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StatusCodes {
    _ = alloc;
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

pub fn deserializeSystemStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SystemStatus {
    var result: SystemStatus = undefined;
    result.cpu_utilization = null;
    result.load_average = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CPUUtilization")) {
                    result.cpu_utilization = try deserializeCPUUtilization(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LoadAverage")) {
                    result.load_average = try deserializeLoadAverage(reader, alloc, "member");
                } else {
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

pub fn deserializeTrigger(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Trigger {
    var result: Trigger = undefined;
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

pub fn deserializeValidationMessage(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ValidationMessage {
    var result: ValidationMessage = undefined;
    result.message = null;
    result.namespace = null;
    result.option_name = null;
    result.severity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionName")) {
                    result.option_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn serializeApplicationNamesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeConfigurationOptionSettingsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ConfigurationOptionSetting, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeConfigurationOptionSetting(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEnvironmentHealthAttributes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EnvironmentHealthAttribute, comptime item_tag: []const u8) !void {
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

pub fn serializeEnvironmentIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeEnvironmentNamesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeInstancesHealthAttributes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const InstancesHealthAttribute, comptime item_tag: []const u8) !void {
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

pub fn serializeOptionsSpecifierList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OptionSpecification, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeOptionSpecification(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializePlatformFilterValueList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePlatformFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PlatformFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializePlatformFilter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeSearchFilterValues(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSearchFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const SearchFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeSearchFilter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagKeyList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeVersionLabels(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeVersionLabelsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeApplicationResourceLifecycleConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ApplicationResourceLifecycleConfig) !void {
    if (value.service_role) |v| {
        try buf.appendSlice(alloc, "<ServiceRole>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ServiceRole>");
    }
    if (value.version_lifecycle_config) |v| {
        try buf.appendSlice(alloc, "<VersionLifecycleConfig>");
        try serializeApplicationVersionLifecycleConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</VersionLifecycleConfig>");
    }
}

pub fn serializeApplicationVersionLifecycleConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ApplicationVersionLifecycleConfig) !void {
    if (value.max_age_rule) |v| {
        try buf.appendSlice(alloc, "<MaxAgeRule>");
        try serializeMaxAgeRule(alloc, buf, v);
        try buf.appendSlice(alloc, "</MaxAgeRule>");
    }
    if (value.max_count_rule) |v| {
        try buf.appendSlice(alloc, "<MaxCountRule>");
        try serializeMaxCountRule(alloc, buf, v);
        try buf.appendSlice(alloc, "</MaxCountRule>");
    }
}

pub fn serializeBuildConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: BuildConfiguration) !void {
    if (value.artifact_name) |v| {
        try buf.appendSlice(alloc, "<ArtifactName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ArtifactName>");
    }
    try buf.appendSlice(alloc, "<CodeBuildServiceRole>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.code_build_service_role);
    try buf.appendSlice(alloc, "</CodeBuildServiceRole>");
    if (value.compute_type) |v| {
        try buf.appendSlice(alloc, "<ComputeType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ComputeType>");
    }
    try buf.appendSlice(alloc, "<Image>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.image);
    try buf.appendSlice(alloc, "</Image>");
    if (value.timeout_in_minutes) |v| {
        try buf.appendSlice(alloc, "<TimeoutInMinutes>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</TimeoutInMinutes>");
    }
}

pub fn serializeConfigurationOptionSetting(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConfigurationOptionSetting) !void {
    if (value.namespace) |v| {
        try buf.appendSlice(alloc, "<Namespace>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Namespace>");
    }
    if (value.option_name) |v| {
        try buf.appendSlice(alloc, "<OptionName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OptionName>");
    }
    if (value.resource_name) |v| {
        try buf.appendSlice(alloc, "<ResourceName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourceName>");
    }
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeEnvironmentTier(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: EnvironmentTier) !void {
    if (value.name) |v| {
        try buf.appendSlice(alloc, "<Name>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Name>");
    }
    if (value.type) |v| {
        try buf.appendSlice(alloc, "<Type>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Type>");
    }
    if (value.version) |v| {
        try buf.appendSlice(alloc, "<Version>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Version>");
    }
}

pub fn serializeMaxAgeRule(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MaxAgeRule) !void {
    if (value.delete_source_from_s3) |v| {
        try buf.appendSlice(alloc, "<DeleteSourceFromS3>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</DeleteSourceFromS3>");
    }
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.max_age_in_days) |v| {
        try buf.appendSlice(alloc, "<MaxAgeInDays>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxAgeInDays>");
    }
}

pub fn serializeMaxCountRule(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MaxCountRule) !void {
    if (value.delete_source_from_s3) |v| {
        try buf.appendSlice(alloc, "<DeleteSourceFromS3>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</DeleteSourceFromS3>");
    }
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.max_count) |v| {
        try buf.appendSlice(alloc, "<MaxCount>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxCount>");
    }
}

pub fn serializeOptionSpecification(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OptionSpecification) !void {
    if (value.namespace) |v| {
        try buf.appendSlice(alloc, "<Namespace>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Namespace>");
    }
    if (value.option_name) |v| {
        try buf.appendSlice(alloc, "<OptionName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OptionName>");
    }
    if (value.resource_name) |v| {
        try buf.appendSlice(alloc, "<ResourceName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourceName>");
    }
}

pub fn serializePlatformFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PlatformFilter) !void {
    if (value.operator) |v| {
        try buf.appendSlice(alloc, "<Operator>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Operator>");
    }
    if (value.type) |v| {
        try buf.appendSlice(alloc, "<Type>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Type>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializePlatformFilterValueList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeS3Location(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Location) !void {
    if (value.s3_bucket) |v| {
        try buf.appendSlice(alloc, "<S3Bucket>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3Bucket>");
    }
    if (value.s3_key) |v| {
        try buf.appendSlice(alloc, "<S3Key>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3Key>");
    }
}

pub fn serializeSearchFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SearchFilter) !void {
    if (value.attribute) |v| {
        try buf.appendSlice(alloc, "<Attribute>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Attribute>");
    }
    if (value.operator) |v| {
        try buf.appendSlice(alloc, "<Operator>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Operator>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeSearchFilterValues(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeSourceBuildInformation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SourceBuildInformation) !void {
    try buf.appendSlice(alloc, "<SourceLocation>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.source_location);
    try buf.appendSlice(alloc, "</SourceLocation>");
    try buf.appendSlice(alloc, "<SourceRepository>");
    try buf.appendSlice(alloc, @tagName(value.source_repository));
    try buf.appendSlice(alloc, "</SourceRepository>");
    try buf.appendSlice(alloc, "<SourceType>");
    try buf.appendSlice(alloc, @tagName(value.source_type));
    try buf.appendSlice(alloc, "</SourceType>");
}

pub fn serializeSourceConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SourceConfiguration) !void {
    if (value.application_name) |v| {
        try buf.appendSlice(alloc, "<ApplicationName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ApplicationName>");
    }
    if (value.template_name) |v| {
        try buf.appendSlice(alloc, "<TemplateName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TemplateName>");
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
