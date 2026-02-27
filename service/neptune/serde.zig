const aws = @import("aws");
const std = @import("std");

const ApplyMethod = @import("apply_method.zig").ApplyMethod;
const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const CharacterSet = @import("character_set.zig").CharacterSet;
const CloudwatchLogsExportConfiguration = @import("cloudwatch_logs_export_configuration.zig").CloudwatchLogsExportConfiguration;
const ClusterPendingModifiedValues = @import("cluster_pending_modified_values.zig").ClusterPendingModifiedValues;
const DBCluster = @import("db_cluster.zig").DBCluster;
const DBClusterEndpoint = @import("db_cluster_endpoint.zig").DBClusterEndpoint;
const DBClusterMember = @import("db_cluster_member.zig").DBClusterMember;
const DBClusterOptionGroupStatus = @import("db_cluster_option_group_status.zig").DBClusterOptionGroupStatus;
const DBClusterParameterGroup = @import("db_cluster_parameter_group.zig").DBClusterParameterGroup;
const DBClusterRole = @import("db_cluster_role.zig").DBClusterRole;
const DBClusterSnapshot = @import("db_cluster_snapshot.zig").DBClusterSnapshot;
const DBClusterSnapshotAttribute = @import("db_cluster_snapshot_attribute.zig").DBClusterSnapshotAttribute;
const DBClusterSnapshotAttributesResult = @import("db_cluster_snapshot_attributes_result.zig").DBClusterSnapshotAttributesResult;
const DBEngineVersion = @import("db_engine_version.zig").DBEngineVersion;
const DBInstance = @import("db_instance.zig").DBInstance;
const DBInstanceStatusInfo = @import("db_instance_status_info.zig").DBInstanceStatusInfo;
const DBParameterGroup = @import("db_parameter_group.zig").DBParameterGroup;
const DBParameterGroupStatus = @import("db_parameter_group_status.zig").DBParameterGroupStatus;
const DBSecurityGroupMembership = @import("db_security_group_membership.zig").DBSecurityGroupMembership;
const DBSubnetGroup = @import("db_subnet_group.zig").DBSubnetGroup;
const DomainMembership = @import("domain_membership.zig").DomainMembership;
const DoubleRange = @import("double_range.zig").DoubleRange;
const Endpoint = @import("endpoint.zig").Endpoint;
const EngineDefaults = @import("engine_defaults.zig").EngineDefaults;
const Event = @import("event.zig").Event;
const EventCategoriesMap = @import("event_categories_map.zig").EventCategoriesMap;
const EventSubscription = @import("event_subscription.zig").EventSubscription;
const FailoverState = @import("failover_state.zig").FailoverState;
const FailoverStatus = @import("failover_status.zig").FailoverStatus;
const Filter = @import("filter.zig").Filter;
const GlobalCluster = @import("global_cluster.zig").GlobalCluster;
const GlobalClusterMember = @import("global_cluster_member.zig").GlobalClusterMember;
const OptionGroupMembership = @import("option_group_membership.zig").OptionGroupMembership;
const OrderableDBInstanceOption = @import("orderable_db_instance_option.zig").OrderableDBInstanceOption;
const Parameter = @import("parameter.zig").Parameter;
const PendingCloudwatchLogsExports = @import("pending_cloudwatch_logs_exports.zig").PendingCloudwatchLogsExports;
const PendingMaintenanceAction = @import("pending_maintenance_action.zig").PendingMaintenanceAction;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const Range = @import("range.zig").Range;
const ResourcePendingMaintenanceActions = @import("resource_pending_maintenance_actions.zig").ResourcePendingMaintenanceActions;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const ServerlessV2ScalingConfigurationInfo = @import("serverless_v2_scaling_configuration_info.zig").ServerlessV2ScalingConfigurationInfo;
const SourceType = @import("source_type.zig").SourceType;
const Subnet = @import("subnet.zig").Subnet;
const Tag = @import("tag.zig").Tag;
const Timezone = @import("timezone.zig").Timezone;
const UpgradeTarget = @import("upgrade_target.zig").UpgradeTarget;
const ValidDBInstanceModificationsMessage = @import("valid_db_instance_modifications_message.zig").ValidDBInstanceModificationsMessage;
const ValidStorageOptions = @import("valid_storage_options.zig").ValidStorageOptions;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

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
    result.db_cluster_identifier = null;
    result.engine_version = null;
    result.iam_database_authentication_enabled = null;
    result.iops = null;
    result.pending_cloudwatch_logs_exports = null;
    result.storage_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PendingCloudwatchLogsExports")) {
                    result.pending_cloudwatch_logs_exports = try deserializePendingCloudwatchLogsExports(reader, alloc);
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

pub fn deserializeDBCluster(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBCluster {
    var result: DBCluster = undefined;
    result.allocated_storage = null;
    result.associated_roles = null;
    result.automatic_restart_time = null;
    result.availability_zones = null;
    result.backup_retention_period = null;
    result.character_set_name = null;
    result.clone_group_id = null;
    result.cluster_create_time = null;
    result.copy_tags_to_snapshot = null;
    result.cross_account_clone = null;
    result.database_name = null;
    result.db_cluster_arn = null;
    result.db_cluster_identifier = null;
    result.db_cluster_members = null;
    result.db_cluster_option_group_memberships = null;
    result.db_cluster_parameter_group = null;
    result.db_cluster_resource_id = null;
    result.db_subnet_group = null;
    result.deletion_protection = null;
    result.earliest_restorable_time = null;
    result.enabled_cloudwatch_logs_exports = null;
    result.endpoint = null;
    result.engine = null;
    result.engine_version = null;
    result.global_cluster_identifier = null;
    result.hosted_zone_id = null;
    result.iam_database_authentication_enabled = null;
    result.io_optimized_next_allowed_modification_time = null;
    result.kms_key_id = null;
    result.latest_restorable_time = null;
    result.master_username = null;
    result.multi_az = null;
    result.pending_modified_values = null;
    result.percent_progress = null;
    result.port = null;
    result.preferred_backup_window = null;
    result.preferred_maintenance_window = null;
    result.reader_endpoint = null;
    result.read_replica_identifiers = null;
    result.replication_source_identifier = null;
    result.serverless_v2_scaling_configuration = null;
    result.status = null;
    result.storage_encrypted = null;
    result.storage_type = null;
    result.vpc_security_groups = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AssociatedRoles")) {
                    result.associated_roles = try deserializeDBClusterRoles(reader, alloc, "DBClusterRole");
                } else if (std.mem.eql(u8, e.local, "AutomaticRestartTime")) {
                    result.automatic_restart_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(reader, alloc, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CloneGroupId")) {
                    result.clone_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CopyTagsToSnapshot")) {
                    result.copy_tags_to_snapshot = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CrossAccountClone")) {
                    result.cross_account_clone = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DatabaseName")) {
                    result.database_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterArn")) {
                    result.db_cluster_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
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
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EarliestRestorableTime")) {
                    result.earliest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EnabledCloudwatchLogsExports")) {
                    result.enabled_cloudwatch_logs_exports = try deserializeLogTypeList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalClusterIdentifier")) {
                    result.global_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMDatabaseAuthenticationEnabled")) {
                    result.iam_database_authentication_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IOOptimizedNextAllowedModificationTime")) {
                    result.io_optimized_next_allowed_modification_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestRestorableTime")) {
                    result.latest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializeClusterPendingModifiedValues(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PreferredBackupWindow")) {
                    result.preferred_backup_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReaderEndpoint")) {
                    result.reader_endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReadReplicaIdentifiers")) {
                    result.read_replica_identifiers = try deserializeReadReplicaIdentifierList(reader, alloc, "ReadReplicaIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReplicationSourceIdentifier")) {
                    result.replication_source_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessV2ScalingConfiguration")) {
                    result.serverless_v2_scaling_configuration = try deserializeServerlessV2ScalingConfigurationInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
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
    result.db_cluster_snapshot_arn = null;
    result.db_cluster_snapshot_identifier = null;
    result.engine = null;
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
    result.storage_type = null;
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
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotArn")) {
                    result.db_cluster_snapshot_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotIdentifier")) {
                    result.db_cluster_snapshot_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
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
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBEngineVersion(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBEngineVersion {
    var result: DBEngineVersion = undefined;
    result.db_engine_description = null;
    result.db_engine_version_description = null;
    result.db_parameter_group_family = null;
    result.default_character_set = null;
    result.engine = null;
    result.engine_version = null;
    result.exportable_log_types = null;
    result.supported_character_sets = null;
    result.supported_timezones = null;
    result.supports_global_databases = null;
    result.supports_log_exports_to_cloudwatch_logs = null;
    result.supports_read_replica = null;
    result.valid_upgrade_target = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBEngineDescription")) {
                    result.db_engine_description = try alloc.dupe(u8, try reader.readElementText());
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
                } else if (std.mem.eql(u8, e.local, "SupportedCharacterSets")) {
                    result.supported_character_sets = try deserializeSupportedCharacterSetsList(reader, alloc, "CharacterSet");
                } else if (std.mem.eql(u8, e.local, "SupportedTimezones")) {
                    result.supported_timezones = try deserializeSupportedTimezonesList(reader, alloc, "Timezone");
                } else if (std.mem.eql(u8, e.local, "SupportsGlobalDatabases")) {
                    result.supports_global_databases = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLogExportsToCloudwatchLogs")) {
                    result.supports_log_exports_to_cloudwatch_logs = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsReadReplica")) {
                    result.supports_read_replica = std.mem.eql(u8, try reader.readElementText(), "true");
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
    result.allocated_storage = null;
    result.auto_minor_version_upgrade = null;
    result.availability_zone = null;
    result.backup_retention_period = null;
    result.ca_certificate_identifier = null;
    result.character_set_name = null;
    result.copy_tags_to_snapshot = null;
    result.db_cluster_identifier = null;
    result.db_instance_arn = null;
    result.db_instance_class = null;
    result.db_instance_identifier = null;
    result.db_instance_port = null;
    result.db_instance_status = null;
    result.dbi_resource_id = null;
    result.db_name = null;
    result.db_parameter_groups = null;
    result.db_security_groups = null;
    result.db_subnet_group = null;
    result.deletion_protection = null;
    result.domain_memberships = null;
    result.enabled_cloudwatch_logs_exports = null;
    result.endpoint = null;
    result.engine = null;
    result.engine_version = null;
    result.enhanced_monitoring_resource_arn = null;
    result.iam_database_authentication_enabled = null;
    result.instance_create_time = null;
    result.iops = null;
    result.kms_key_id = null;
    result.latest_restorable_time = null;
    result.license_model = null;
    result.master_username = null;
    result.monitoring_interval = null;
    result.monitoring_role_arn = null;
    result.multi_az = null;
    result.option_group_memberships = null;
    result.pending_modified_values = null;
    result.performance_insights_enabled = null;
    result.performance_insights_kms_key_id = null;
    result.preferred_backup_window = null;
    result.preferred_maintenance_window = null;
    result.promotion_tier = null;
    result.publicly_accessible = null;
    result.read_replica_db_cluster_identifiers = null;
    result.read_replica_db_instance_identifiers = null;
    result.read_replica_source_db_instance_identifier = null;
    result.secondary_availability_zone = null;
    result.status_infos = null;
    result.storage_encrypted = null;
    result.storage_type = null;
    result.tde_credential_arn = null;
    result.timezone = null;
    result.vpc_security_groups = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CACertificateIdentifier")) {
                    result.ca_certificate_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CharacterSetName")) {
                    result.character_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CopyTagsToSnapshot")) {
                    result.copy_tags_to_snapshot = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceArn")) {
                    result.db_instance_arn = try alloc.dupe(u8, try reader.readElementText());
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
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestRestorableTime")) {
                    result.latest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MonitoringInterval")) {
                    result.monitoring_interval = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MonitoringRoleArn")) {
                    result.monitoring_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OptionGroupMemberships")) {
                    result.option_group_memberships = try deserializeOptionGroupMembershipList(reader, alloc, "OptionGroupMembership");
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializePendingModifiedValues(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsEnabled")) {
                    result.performance_insights_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsKMSKeyId")) {
                    result.performance_insights_kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredBackupWindow")) {
                    result.preferred_backup_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PromotionTier")) {
                    result.promotion_tier = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaDBClusterIdentifiers")) {
                    result.read_replica_db_cluster_identifiers = try deserializeReadReplicaDBClusterIdentifierList(reader, alloc, "ReadReplicaDBClusterIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaDBInstanceIdentifiers")) {
                    result.read_replica_db_instance_identifiers = try deserializeReadReplicaDBInstanceIdentifierList(reader, alloc, "ReadReplicaDBInstanceIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaSourceDBInstanceIdentifier")) {
                    result.read_replica_source_db_instance_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecondaryAvailabilityZone")) {
                    result.secondary_availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusInfos")) {
                    result.status_infos = try deserializeDBInstanceStatusInfoList(reader, alloc, "DBInstanceStatusInfo");
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TdeCredentialArn")) {
                    result.tde_credential_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timezone")) {
                    result.timezone = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBSubnetGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DBSubnetGroup {
    var result: DBSubnetGroup = undefined;
    result.db_subnet_group_arn = null;
    result.db_subnet_group_description = null;
    result.db_subnet_group_name = null;
    result.subnet_group_status = null;
    result.subnets = null;
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

pub fn deserializeDomainMembership(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DomainMembership {
    var result: DomainMembership = undefined;
    result.domain = null;
    result.fqdn = null;
    result.iam_role_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FQDN")) {
                    result.fqdn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IAMRoleName")) {
                    result.iam_role_name = try alloc.dupe(u8, try reader.readElementText());
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
    result.deletion_protection = null;
    result.engine = null;
    result.engine_version = null;
    result.failover_state = null;
    result.global_cluster_arn = null;
    result.global_cluster_identifier = null;
    result.global_cluster_members = null;
    result.global_cluster_resource_id = null;
    result.status = null;
    result.storage_encrypted = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
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
                } else {
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
    result.is_writer = null;
    result.readers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterArn")) {
                    result.db_cluster_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsWriter")) {
                    result.is_writer = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Readers")) {
                    result.readers = try deserializeReadersArnList(reader, alloc, "member");
                } else {
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

pub fn deserializeOrderableDBInstanceOption(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OrderableDBInstanceOption {
    var result: OrderableDBInstanceOption = undefined;
    result.availability_zones = null;
    result.db_instance_class = null;
    result.engine = null;
    result.engine_version = null;
    result.license_model = null;
    result.max_iops_per_db_instance = null;
    result.max_iops_per_gib = null;
    result.max_storage_size = null;
    result.min_iops_per_db_instance = null;
    result.min_iops_per_gib = null;
    result.min_storage_size = null;
    result.multi_az_capable = null;
    result.read_replica_capable = null;
    result.storage_type = null;
    result.supports_enhanced_monitoring = null;
    result.supports_global_databases = null;
    result.supports_iam_database_authentication = null;
    result.supports_iops = null;
    result.supports_performance_insights = null;
    result.supports_storage_encryption = null;
    result.vpc = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZoneList(reader, alloc, "AvailabilityZone");
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
                } else if (std.mem.eql(u8, e.local, "MinIopsPerDbInstance")) {
                    result.min_iops_per_db_instance = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinIopsPerGib")) {
                    result.min_iops_per_gib = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinStorageSize")) {
                    result.min_storage_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MultiAZCapable")) {
                    result.multi_az_capable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReadReplicaCapable")) {
                    result.read_replica_capable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportsEnhancedMonitoring")) {
                    result.supports_enhanced_monitoring = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsGlobalDatabases")) {
                    result.supports_global_databases = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsIAMDatabaseAuthentication")) {
                    result.supports_iam_database_authentication = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsIops")) {
                    result.supports_iops = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsPerformanceInsights")) {
                    result.supports_performance_insights = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsStorageEncryption")) {
                    result.supports_storage_encryption = std.mem.eql(u8, try reader.readElementText(), "true");
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
                } else {
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
    result.allocated_storage = null;
    result.backup_retention_period = null;
    result.ca_certificate_identifier = null;
    result.db_instance_class = null;
    result.db_instance_identifier = null;
    result.db_subnet_group_name = null;
    result.engine_version = null;
    result.iops = null;
    result.license_model = null;
    result.master_user_password = null;
    result.multi_az = null;
    result.pending_cloudwatch_logs_exports = null;
    result.port = null;
    result.storage_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocatedStorage")) {
                    result.allocated_storage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserPassword")) {
                    result.master_user_password = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PendingCloudwatchLogsExports")) {
                    result.pending_cloudwatch_logs_exports = try deserializePendingCloudwatchLogsExports(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeServerlessV2ScalingConfigurationInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerlessV2ScalingConfigurationInfo {
    _ = alloc;
    var result: ServerlessV2ScalingConfigurationInfo = undefined;
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

pub fn deserializeSubnet(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Subnet {
    var result: Subnet = undefined;
    result.subnet_availability_zone = null;
    result.subnet_identifier = null;
    result.subnet_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubnetAvailabilityZone")) {
                    result.subnet_availability_zone = try deserializeAvailabilityZone(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SubnetIdentifier")) {
                    result.subnet_identifier = try alloc.dupe(u8, try reader.readElementText());
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
    result.supports_global_databases = null;
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
                } else if (std.mem.eql(u8, e.local, "SupportsGlobalDatabases")) {
                    result.supports_global_databases = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
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
    result.storage = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Storage")) {
                    result.storage = try deserializeValidStorageOptionsList(reader, alloc, "ValidStorageOptions");
                } else {
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
    result.storage_size = null;
    result.storage_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IopsToStorageRatio")) {
                    result.iops_to_storage_ratio = try deserializeDoubleRangeList(reader, alloc, "DoubleRange");
                } else if (std.mem.eql(u8, e.local, "ProvisionedIops")) {
                    result.provisioned_iops = try deserializeRangeList(reader, alloc, "Range");
                } else if (std.mem.eql(u8, e.local, "StorageSize")) {
                    result.storage_size = try deserializeRangeList(reader, alloc, "Range");
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

pub fn serializeFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Filter) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Values>");
    try serializeFilterValueList(alloc, buf, value.values, "Value");
    try buf.appendSlice(alloc, "</Values>");
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
