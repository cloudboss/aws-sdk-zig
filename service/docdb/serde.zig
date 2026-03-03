const aws = @import("aws");
const std = @import("std");

const ApplyMethod = @import("apply_method.zig").ApplyMethod;
const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const Certificate = @import("certificate.zig").Certificate;
const CertificateDetails = @import("certificate_details.zig").CertificateDetails;
const CloudwatchLogsExportConfiguration = @import("cloudwatch_logs_export_configuration.zig").CloudwatchLogsExportConfiguration;
const ClusterMasterUserSecret = @import("cluster_master_user_secret.zig").ClusterMasterUserSecret;
const DBCluster = @import("db_cluster.zig").DBCluster;
const DBClusterMember = @import("db_cluster_member.zig").DBClusterMember;
const DBClusterParameterGroup = @import("db_cluster_parameter_group.zig").DBClusterParameterGroup;
const DBClusterRole = @import("db_cluster_role.zig").DBClusterRole;
const DBClusterSnapshot = @import("db_cluster_snapshot.zig").DBClusterSnapshot;
const DBClusterSnapshotAttribute = @import("db_cluster_snapshot_attribute.zig").DBClusterSnapshotAttribute;
const DBClusterSnapshotAttributesResult = @import("db_cluster_snapshot_attributes_result.zig").DBClusterSnapshotAttributesResult;
const DBEngineVersion = @import("db_engine_version.zig").DBEngineVersion;
const DBInstance = @import("db_instance.zig").DBInstance;
const DBInstanceStatusInfo = @import("db_instance_status_info.zig").DBInstanceStatusInfo;
const DBSubnetGroup = @import("db_subnet_group.zig").DBSubnetGroup;
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
const GlobalClusterMemberSynchronizationStatus = @import("global_cluster_member_synchronization_status.zig").GlobalClusterMemberSynchronizationStatus;
const OrderableDBInstanceOption = @import("orderable_db_instance_option.zig").OrderableDBInstanceOption;
const Parameter = @import("parameter.zig").Parameter;
const PendingCloudwatchLogsExports = @import("pending_cloudwatch_logs_exports.zig").PendingCloudwatchLogsExports;
const PendingMaintenanceAction = @import("pending_maintenance_action.zig").PendingMaintenanceAction;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const ResourcePendingMaintenanceActions = @import("resource_pending_maintenance_actions.zig").ResourcePendingMaintenanceActions;
const ServerlessV2FeaturesSupport = @import("serverless_v2_features_support.zig").ServerlessV2FeaturesSupport;
const ServerlessV2ScalingConfiguration = @import("serverless_v2_scaling_configuration.zig").ServerlessV2ScalingConfiguration;
const ServerlessV2ScalingConfigurationInfo = @import("serverless_v2_scaling_configuration_info.zig").ServerlessV2ScalingConfigurationInfo;
const SourceType = @import("source_type.zig").SourceType;
const Subnet = @import("subnet.zig").Subnet;
const Tag = @import("tag.zig").Tag;
const UpgradeTarget = @import("upgrade_target.zig").UpgradeTarget;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

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

pub fn deserializeNetworkTypeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCertificate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Certificate {
    var result: Certificate = undefined;
    result.certificate_arn = null;
    result.certificate_identifier = null;
    result.certificate_type = null;
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

pub fn deserializeClusterMasterUserSecret(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterMasterUserSecret {
    var result: ClusterMasterUserSecret = undefined;
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

pub fn deserializeDBCluster(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBCluster {
    var result: DBCluster = undefined;
    result.associated_roles = null;
    result.availability_zones = null;
    result.backup_retention_period = null;
    result.clone_group_id = null;
    result.cluster_create_time = null;
    result.db_cluster_arn = null;
    result.db_cluster_identifier = null;
    result.db_cluster_members = null;
    result.db_cluster_parameter_group = null;
    result.db_cluster_resource_id = null;
    result.db_subnet_group = null;
    result.deletion_protection = null;
    result.earliest_restorable_time = null;
    result.enabled_cloudwatch_logs_exports = null;
    result.endpoint = null;
    result.engine = null;
    result.engine_version = null;
    result.hosted_zone_id = null;
    result.io_optimized_next_allowed_modification_time = null;
    result.kms_key_id = null;
    result.latest_restorable_time = null;
    result.master_username = null;
    result.master_user_secret = null;
    result.multi_az = null;
    result.network_type = null;
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
                if (std.mem.eql(u8, e.local, "AssociatedRoles")) {
                    result.associated_roles = try deserializeDBClusterRoles(allocator, reader, "DBClusterRole");
                } else if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(allocator, reader, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CloneGroupId")) {
                    result.clone_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterArn")) {
                    result.db_cluster_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterMembers")) {
                    result.db_cluster_members = try deserializeDBClusterMemberList(allocator, reader, "DBClusterMember");
                } else if (std.mem.eql(u8, e.local, "DBClusterParameterGroup")) {
                    result.db_cluster_parameter_group = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbClusterResourceId")) {
                    result.db_cluster_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroup")) {
                    result.db_subnet_group = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionProtection")) {
                    result.deletion_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EarliestRestorableTime")) {
                    result.earliest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EnabledCloudwatchLogsExports")) {
                    result.enabled_cloudwatch_logs_exports = try deserializeLogTypeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IOOptimizedNextAllowedModificationTime")) {
                    result.io_optimized_next_allowed_modification_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestRestorableTime")) {
                    result.latest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserSecret")) {
                    result.master_user_secret = try deserializeClusterMasterUserSecret(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "NetworkType")) {
                    result.network_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PreferredBackupWindow")) {
                    result.preferred_backup_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReaderEndpoint")) {
                    result.reader_endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReadReplicaIdentifiers")) {
                    result.read_replica_identifiers = try deserializeReadReplicaIdentifierList(allocator, reader, "ReadReplicaIdentifier");
                } else if (std.mem.eql(u8, e.local, "ReplicationSourceIdentifier")) {
                    result.replication_source_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessV2ScalingConfiguration")) {
                    result.serverless_v2_scaling_configuration = try deserializeServerlessV2ScalingConfigurationInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
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
    result.role_arn = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RoleArn")) {
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
    result.availability_zones = null;
    result.cluster_create_time = null;
    result.db_cluster_identifier = null;
    result.db_cluster_snapshot_arn = null;
    result.db_cluster_snapshot_identifier = null;
    result.engine = null;
    result.engine_version = null;
    result.kms_key_id = null;
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
                if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(allocator, reader, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotArn")) {
                    result.db_cluster_snapshot_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBClusterSnapshotIdentifier")) {
                    result.db_cluster_snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
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
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDBEngineVersion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DBEngineVersion {
    var result: DBEngineVersion = undefined;
    result.db_engine_description = null;
    result.db_engine_version_description = null;
    result.db_parameter_group_family = null;
    result.engine = null;
    result.engine_version = null;
    result.exportable_log_types = null;
    result.serverless_v2_features_support = null;
    result.supported_ca_certificate_identifiers = null;
    result.supports_certificate_rotation_without_restart = null;
    result.supports_log_exports_to_cloudwatch_logs = null;
    result.valid_upgrade_target = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBEngineDescription")) {
                    result.db_engine_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineVersionDescription")) {
                    result.db_engine_version_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExportableLogTypes")) {
                    result.exportable_log_types = try deserializeLogTypeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ServerlessV2FeaturesSupport")) {
                    result.serverless_v2_features_support = try deserializeServerlessV2FeaturesSupport(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SupportedCACertificateIdentifiers")) {
                    result.supported_ca_certificate_identifiers = try deserializeCACertificateIdentifiersList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportsCertificateRotationWithoutRestart")) {
                    result.supports_certificate_rotation_without_restart = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLogExportsToCloudwatchLogs")) {
                    result.supports_log_exports_to_cloudwatch_logs = std.mem.eql(u8, try reader.readElementText(), "true");
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
    result.auto_minor_version_upgrade = null;
    result.availability_zone = null;
    result.backup_retention_period = null;
    result.ca_certificate_identifier = null;
    result.certificate_details = null;
    result.copy_tags_to_snapshot = null;
    result.db_cluster_identifier = null;
    result.db_instance_arn = null;
    result.db_instance_class = null;
    result.db_instance_identifier = null;
    result.db_instance_status = null;
    result.dbi_resource_id = null;
    result.db_subnet_group = null;
    result.enabled_cloudwatch_logs_exports = null;
    result.endpoint = null;
    result.engine = null;
    result.engine_version = null;
    result.instance_create_time = null;
    result.kms_key_id = null;
    result.latest_restorable_time = null;
    result.pending_modified_values = null;
    result.performance_insights_enabled = null;
    result.performance_insights_kms_key_id = null;
    result.preferred_backup_window = null;
    result.preferred_maintenance_window = null;
    result.promotion_tier = null;
    result.publicly_accessible = null;
    result.status_infos = null;
    result.storage_encrypted = null;
    result.vpc_security_groups = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupRetentionPeriod")) {
                    result.backup_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CACertificateIdentifier")) {
                    result.ca_certificate_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateDetails")) {
                    result.certificate_details = try deserializeCertificateDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CopyTagsToSnapshot")) {
                    result.copy_tags_to_snapshot = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DBClusterIdentifier")) {
                    result.db_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceArn")) {
                    result.db_instance_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceStatus")) {
                    result.db_instance_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbiResourceId")) {
                    result.dbi_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroup")) {
                    result.db_subnet_group = try deserializeDBSubnetGroup(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "EnabledCloudwatchLogsExports")) {
                    result.enabled_cloudwatch_logs_exports = try deserializeLogTypeList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceCreateTime")) {
                    result.instance_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestRestorableTime")) {
                    result.latest_restorable_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializePendingModifiedValues(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsEnabled")) {
                    result.performance_insights_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PerformanceInsightsKMSKeyId")) {
                    result.performance_insights_kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredBackupWindow")) {
                    result.preferred_backup_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PromotionTier")) {
                    result.promotion_tier = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StatusInfos")) {
                    result.status_infos = try deserializeDBInstanceStatusInfoList(allocator, reader, "DBInstanceStatusInfo");
                } else if (std.mem.eql(u8, e.local, "StorageEncrypted")) {
                    result.storage_encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
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
                    result.supported_network_types = try deserializeNetworkTypeList(allocator, reader, "member");
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
    result.engine = null;
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
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
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
    result.is_writer = null;
    result.readers = null;
    result.synchronization_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterArn")) {
                    result.db_cluster_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOrderableDBInstanceOption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OrderableDBInstanceOption {
    var result: OrderableDBInstanceOption = undefined;
    result.availability_zones = null;
    result.db_instance_class = null;
    result.engine = null;
    result.engine_version = null;
    result.license_model = null;
    result.storage_type = null;
    result.vpc = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZoneList(allocator, reader, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageType")) {
                    result.storage_type = try allocator.dupe(u8, try reader.readElementText());
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
                } else {
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
                    result.ca_certificate_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceClass")) {
                    result.db_instance_class = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBInstanceIdentifier")) {
                    result.db_instance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBSubnetGroupName")) {
                    result.db_subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LicenseModel")) {
                    result.license_model = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserPassword")) {
                    result.master_user_password = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PendingCloudwatchLogsExports")) {
                    result.pending_cloudwatch_logs_exports = try deserializePendingCloudwatchLogsExports(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeSubnet(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Subnet {
    var result: Subnet = undefined;
    result.subnet_availability_zone = null;
    result.subnet_identifier = null;
    result.subnet_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubnetAvailabilityZone")) {
                    result.subnet_availability_zone = try deserializeAvailabilityZone(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SubnetIdentifier")) {
                    result.subnet_identifier = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeUpgradeTarget(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UpgradeTarget {
    var result: UpgradeTarget = undefined;
    result.auto_upgrade = null;
    result.description = null;
    result.engine = null;
    result.engine_version = null;
    result.is_major_version_upgrade = null;
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
                } else {
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

pub fn serializeFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Filter) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Values>");
    try serializeFilterValueList(allocator, buf, value.values, "Value");
    try buf.appendSlice(allocator, "</Values>");
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

