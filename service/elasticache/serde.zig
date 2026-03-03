const aws = @import("aws");
const std = @import("std");

const AuthTokenUpdateStatus = @import("auth_token_update_status.zig").AuthTokenUpdateStatus;
const Authentication = @import("authentication.zig").Authentication;
const AuthenticationMode = @import("authentication_mode.zig").AuthenticationMode;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const AutomaticFailoverStatus = @import("automatic_failover_status.zig").AutomaticFailoverStatus;
const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const CacheCluster = @import("cache_cluster.zig").CacheCluster;
const CacheEngineVersion = @import("cache_engine_version.zig").CacheEngineVersion;
const CacheNode = @import("cache_node.zig").CacheNode;
const CacheNodeTypeSpecificParameter = @import("cache_node_type_specific_parameter.zig").CacheNodeTypeSpecificParameter;
const CacheNodeTypeSpecificValue = @import("cache_node_type_specific_value.zig").CacheNodeTypeSpecificValue;
const CacheNodeUpdateStatus = @import("cache_node_update_status.zig").CacheNodeUpdateStatus;
const CacheParameterGroup = @import("cache_parameter_group.zig").CacheParameterGroup;
const CacheParameterGroupStatus = @import("cache_parameter_group_status.zig").CacheParameterGroupStatus;
const CacheSecurityGroup = @import("cache_security_group.zig").CacheSecurityGroup;
const CacheSecurityGroupMembership = @import("cache_security_group_membership.zig").CacheSecurityGroupMembership;
const CacheSubnetGroup = @import("cache_subnet_group.zig").CacheSubnetGroup;
const CacheUsageLimits = @import("cache_usage_limits.zig").CacheUsageLimits;
const ChangeType = @import("change_type.zig").ChangeType;
const CloudWatchLogsDestinationDetails = @import("cloud_watch_logs_destination_details.zig").CloudWatchLogsDestinationDetails;
const ClusterMode = @import("cluster_mode.zig").ClusterMode;
const ConfigureShard = @import("configure_shard.zig").ConfigureShard;
const CustomerNodeEndpoint = @import("customer_node_endpoint.zig").CustomerNodeEndpoint;
const DataStorage = @import("data_storage.zig").DataStorage;
const DataStorageUnit = @import("data_storage_unit.zig").DataStorageUnit;
const DataTieringStatus = @import("data_tiering_status.zig").DataTieringStatus;
const DestinationDetails = @import("destination_details.zig").DestinationDetails;
const DestinationType = @import("destination_type.zig").DestinationType;
const EC2SecurityGroup = @import("ec2_security_group.zig").EC2SecurityGroup;
const ECPUPerSecond = @import("ecpu_per_second.zig").ECPUPerSecond;
const Endpoint = @import("endpoint.zig").Endpoint;
const EngineDefaults = @import("engine_defaults.zig").EngineDefaults;
const Event = @import("event.zig").Event;
const Filter = @import("filter.zig").Filter;
const GlobalNodeGroup = @import("global_node_group.zig").GlobalNodeGroup;
const GlobalReplicationGroup = @import("global_replication_group.zig").GlobalReplicationGroup;
const GlobalReplicationGroupInfo = @import("global_replication_group_info.zig").GlobalReplicationGroupInfo;
const GlobalReplicationGroupMember = @import("global_replication_group_member.zig").GlobalReplicationGroupMember;
const InputAuthenticationType = @import("input_authentication_type.zig").InputAuthenticationType;
const IpDiscovery = @import("ip_discovery.zig").IpDiscovery;
const KinesisFirehoseDestinationDetails = @import("kinesis_firehose_destination_details.zig").KinesisFirehoseDestinationDetails;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const LogDeliveryConfigurationRequest = @import("log_delivery_configuration_request.zig").LogDeliveryConfigurationRequest;
const LogDeliveryConfigurationStatus = @import("log_delivery_configuration_status.zig").LogDeliveryConfigurationStatus;
const LogFormat = @import("log_format.zig").LogFormat;
const LogType = @import("log_type.zig").LogType;
const MultiAZStatus = @import("multi_az_status.zig").MultiAZStatus;
const NetworkType = @import("network_type.zig").NetworkType;
const NodeGroup = @import("node_group.zig").NodeGroup;
const NodeGroupConfiguration = @import("node_group_configuration.zig").NodeGroupConfiguration;
const NodeGroupMember = @import("node_group_member.zig").NodeGroupMember;
const NodeGroupMemberUpdateStatus = @import("node_group_member_update_status.zig").NodeGroupMemberUpdateStatus;
const NodeGroupUpdateStatus = @import("node_group_update_status.zig").NodeGroupUpdateStatus;
const NodeSnapshot = @import("node_snapshot.zig").NodeSnapshot;
const NodeUpdateInitiatedBy = @import("node_update_initiated_by.zig").NodeUpdateInitiatedBy;
const NodeUpdateStatus = @import("node_update_status.zig").NodeUpdateStatus;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;
const Parameter = @import("parameter.zig").Parameter;
const ParameterNameValue = @import("parameter_name_value.zig").ParameterNameValue;
const PendingAutomaticFailoverStatus = @import("pending_automatic_failover_status.zig").PendingAutomaticFailoverStatus;
const PendingLogDeliveryConfiguration = @import("pending_log_delivery_configuration.zig").PendingLogDeliveryConfiguration;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const ProcessedUpdateAction = @import("processed_update_action.zig").ProcessedUpdateAction;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;
const RegionalConfiguration = @import("regional_configuration.zig").RegionalConfiguration;
const ReplicationGroup = @import("replication_group.zig").ReplicationGroup;
const ReplicationGroupPendingModifiedValues = @import("replication_group_pending_modified_values.zig").ReplicationGroupPendingModifiedValues;
const ReservedCacheNode = @import("reserved_cache_node.zig").ReservedCacheNode;
const ReservedCacheNodesOffering = @import("reserved_cache_nodes_offering.zig").ReservedCacheNodesOffering;
const ReshardingConfiguration = @import("resharding_configuration.zig").ReshardingConfiguration;
const ReshardingStatus = @import("resharding_status.zig").ReshardingStatus;
const ScaleConfig = @import("scale_config.zig").ScaleConfig;
const SecurityGroupMembership = @import("security_group_membership.zig").SecurityGroupMembership;
const ServerlessCache = @import("serverless_cache.zig").ServerlessCache;
const ServerlessCacheConfiguration = @import("serverless_cache_configuration.zig").ServerlessCacheConfiguration;
const ServerlessCacheSnapshot = @import("serverless_cache_snapshot.zig").ServerlessCacheSnapshot;
const ServiceUpdate = @import("service_update.zig").ServiceUpdate;
const ServiceUpdateSeverity = @import("service_update_severity.zig").ServiceUpdateSeverity;
const ServiceUpdateStatus = @import("service_update_status.zig").ServiceUpdateStatus;
const ServiceUpdateType = @import("service_update_type.zig").ServiceUpdateType;
const SlaMet = @import("sla_met.zig").SlaMet;
const SlotMigration = @import("slot_migration.zig").SlotMigration;
const Snapshot = @import("snapshot.zig").Snapshot;
const SourceType = @import("source_type.zig").SourceType;
const Subnet = @import("subnet.zig").Subnet;
const SubnetOutpost = @import("subnet_outpost.zig").SubnetOutpost;
const Tag = @import("tag.zig").Tag;
const TimeRangeFilter = @import("time_range_filter.zig").TimeRangeFilter;
const TransitEncryptionMode = @import("transit_encryption_mode.zig").TransitEncryptionMode;
const UnprocessedUpdateAction = @import("unprocessed_update_action.zig").UnprocessedUpdateAction;
const UpdateAction = @import("update_action.zig").UpdateAction;
const UpdateActionStatus = @import("update_action_status.zig").UpdateActionStatus;
const User = @import("user.zig").User;
const UserGroup = @import("user_group.zig").UserGroup;
const UserGroupPendingChanges = @import("user_group_pending_changes.zig").UserGroupPendingChanges;
const UserGroupsUpdateStatus = @import("user_groups_update_status.zig").UserGroupsUpdateStatus;

pub fn deserializeAvailabilityZonesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCacheClusterList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheCluster {
    var list: std.ArrayList(CacheCluster) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheCluster(allocator, reader));
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

pub fn deserializeCacheEngineVersionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheEngineVersion {
    var list: std.ArrayList(CacheEngineVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheEngineVersion(allocator, reader));
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

pub fn deserializeCacheNodeIdsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCacheNodeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheNode {
    var list: std.ArrayList(CacheNode) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheNode(allocator, reader));
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

pub fn deserializeCacheNodeTypeSpecificParametersList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheNodeTypeSpecificParameter {
    var list: std.ArrayList(CacheNodeTypeSpecificParameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheNodeTypeSpecificParameter(allocator, reader));
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

pub fn deserializeCacheNodeTypeSpecificValueList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheNodeTypeSpecificValue {
    var list: std.ArrayList(CacheNodeTypeSpecificValue) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheNodeTypeSpecificValue(allocator, reader));
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

pub fn deserializeCacheNodeUpdateStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheNodeUpdateStatus {
    var list: std.ArrayList(CacheNodeUpdateStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheNodeUpdateStatus(allocator, reader));
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

pub fn deserializeCacheParameterGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheParameterGroup {
    var list: std.ArrayList(CacheParameterGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheParameterGroup(allocator, reader));
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

pub fn deserializeCacheSecurityGroupMembershipList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheSecurityGroupMembership {
    var list: std.ArrayList(CacheSecurityGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheSecurityGroupMembership(allocator, reader));
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

pub fn deserializeCacheSecurityGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheSecurityGroup {
    var list: std.ArrayList(CacheSecurityGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheSecurityGroup(allocator, reader));
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

pub fn deserializeCacheSubnetGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheSubnetGroup {
    var list: std.ArrayList(CacheSubnetGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheSubnetGroup(allocator, reader));
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

pub fn deserializeClusterIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeGlobalNodeGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const GlobalNodeGroup {
    var list: std.ArrayList(GlobalNodeGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeGlobalNodeGroup(allocator, reader));
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

pub fn deserializeGlobalReplicationGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const GlobalReplicationGroup {
    var list: std.ArrayList(GlobalReplicationGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeGlobalReplicationGroup(allocator, reader));
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

pub fn deserializeGlobalReplicationGroupMemberList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const GlobalReplicationGroupMember {
    var list: std.ArrayList(GlobalReplicationGroupMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeGlobalReplicationGroupMember(allocator, reader));
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

pub fn deserializeLogDeliveryConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LogDeliveryConfiguration {
    var list: std.ArrayList(LogDeliveryConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLogDeliveryConfiguration(allocator, reader));
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

pub fn deserializeNetworkTypeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NetworkType {
    var list: std.ArrayList(NetworkType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (NetworkType.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
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

pub fn deserializeNodeGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NodeGroup {
    var list: std.ArrayList(NodeGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeNodeGroup(allocator, reader));
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

pub fn deserializeNodeGroupMemberList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NodeGroupMember {
    var list: std.ArrayList(NodeGroupMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeNodeGroupMember(allocator, reader));
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

pub fn deserializeNodeGroupMemberUpdateStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NodeGroupMemberUpdateStatus {
    var list: std.ArrayList(NodeGroupMemberUpdateStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeNodeGroupMemberUpdateStatus(allocator, reader));
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

pub fn deserializeNodeGroupUpdateStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NodeGroupUpdateStatus {
    var list: std.ArrayList(NodeGroupUpdateStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeNodeGroupUpdateStatus(allocator, reader));
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

pub fn deserializeNodeSnapshotList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NodeSnapshot {
    var list: std.ArrayList(NodeSnapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeNodeSnapshot(allocator, reader));
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

pub fn deserializeNodeTypeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeOutpostArnsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializePendingLogDeliveryConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PendingLogDeliveryConfiguration {
    var list: std.ArrayList(PendingLogDeliveryConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePendingLogDeliveryConfiguration(allocator, reader));
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

pub fn deserializeProcessedUpdateActionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ProcessedUpdateAction {
    var list: std.ArrayList(ProcessedUpdateAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeProcessedUpdateAction(allocator, reader));
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

pub fn deserializeReplicationGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReplicationGroup {
    var list: std.ArrayList(ReplicationGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReplicationGroup(allocator, reader));
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

pub fn deserializeReplicationGroupOutpostArnList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeReservedCacheNodeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReservedCacheNode {
    var list: std.ArrayList(ReservedCacheNode) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReservedCacheNode(allocator, reader));
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

pub fn deserializeReservedCacheNodesOfferingList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReservedCacheNodesOffering {
    var list: std.ArrayList(ReservedCacheNodesOffering) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReservedCacheNodesOffering(allocator, reader));
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

pub fn deserializeSecurityGroupIdsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSecurityGroupMembershipList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SecurityGroupMembership {
    var list: std.ArrayList(SecurityGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSecurityGroupMembership(allocator, reader));
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

pub fn deserializeServerlessCacheList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ServerlessCache {
    var list: std.ArrayList(ServerlessCache) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeServerlessCache(allocator, reader));
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

pub fn deserializeServerlessCacheSnapshotList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ServerlessCacheSnapshot {
    var list: std.ArrayList(ServerlessCacheSnapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeServerlessCacheSnapshot(allocator, reader));
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

pub fn deserializeServiceUpdateList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ServiceUpdate {
    var list: std.ArrayList(ServiceUpdate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeServiceUpdate(allocator, reader));
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

pub fn deserializeSnapshotList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Snapshot {
    var list: std.ArrayList(Snapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSnapshot(allocator, reader));
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

pub fn deserializeSubnetIdsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUGReplicationGroupIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUGServerlessCacheIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUnprocessedUpdateActionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const UnprocessedUpdateAction {
    var list: std.ArrayList(UnprocessedUpdateAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUnprocessedUpdateAction(allocator, reader));
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

pub fn deserializeUpdateActionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const UpdateAction {
    var list: std.ArrayList(UpdateAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUpdateAction(allocator, reader));
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

pub fn deserializeUserGroupIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUserGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const UserGroup {
    var list: std.ArrayList(UserGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUserGroup(allocator, reader));
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

pub fn deserializeUserIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUserList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const User {
    var list: std.ArrayList(User) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUser(allocator, reader));
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

pub fn deserializeAuthentication(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Authentication {
    _ = allocator;
    var result: Authentication = undefined;
    result.password_count = null;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PasswordCount")) {
                    result.password_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = AuthenticationType.fromWireName(try reader.readElementText());
                } else {
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

pub fn deserializeCacheCluster(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheCluster {
    var result: CacheCluster = undefined;
    result.arn = null;
    result.at_rest_encryption_enabled = null;
    result.auth_token_enabled = null;
    result.auth_token_last_modified_date = null;
    result.auto_minor_version_upgrade = null;
    result.cache_cluster_create_time = null;
    result.cache_cluster_id = null;
    result.cache_cluster_status = null;
    result.cache_nodes = null;
    result.cache_node_type = null;
    result.cache_parameter_group = null;
    result.cache_security_groups = null;
    result.cache_subnet_group_name = null;
    result.client_download_landing_page = null;
    result.configuration_endpoint = null;
    result.engine = null;
    result.engine_version = null;
    result.ip_discovery = null;
    result.log_delivery_configurations = null;
    result.network_type = null;
    result.notification_configuration = null;
    result.num_cache_nodes = null;
    result.pending_modified_values = null;
    result.preferred_availability_zone = null;
    result.preferred_maintenance_window = null;
    result.preferred_outpost_arn = null;
    result.replication_group_id = null;
    result.replication_group_log_delivery_enabled = null;
    result.security_groups = null;
    result.snapshot_retention_limit = null;
    result.snapshot_window = null;
    result.transit_encryption_enabled = null;
    result.transit_encryption_mode = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AtRestEncryptionEnabled")) {
                    result.at_rest_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AuthTokenEnabled")) {
                    result.auth_token_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AuthTokenLastModifiedDate")) {
                    result.auth_token_last_modified_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CacheClusterCreateTime")) {
                    result.cache_cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheClusterStatus")) {
                    result.cache_cluster_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodes")) {
                    result.cache_nodes = try deserializeCacheNodeList(allocator, reader, "CacheNode");
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroup")) {
                    result.cache_parameter_group = try deserializeCacheParameterGroupStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CacheSecurityGroups")) {
                    result.cache_security_groups = try deserializeCacheSecurityGroupMembershipList(allocator, reader, "CacheSecurityGroup");
                } else if (std.mem.eql(u8, e.local, "CacheSubnetGroupName")) {
                    result.cache_subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClientDownloadLandingPage")) {
                    result.client_download_landing_page = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConfigurationEndpoint")) {
                    result.configuration_endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpDiscovery")) {
                    result.ip_discovery = IpDiscovery.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogDeliveryConfigurations")) {
                    result.log_delivery_configurations = try deserializeLogDeliveryConfigurationList(allocator, reader, "LogDeliveryConfiguration");
                } else if (std.mem.eql(u8, e.local, "NetworkType")) {
                    result.network_type = NetworkType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NotificationConfiguration")) {
                    result.notification_configuration = try deserializeNotificationConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NumCacheNodes")) {
                    result.num_cache_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializePendingModifiedValues(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PreferredAvailabilityZone")) {
                    result.preferred_availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredOutpostArn")) {
                    result.preferred_outpost_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupLogDeliveryEnabled")) {
                    result.replication_group_log_delivery_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SecurityGroups")) {
                    result.security_groups = try deserializeSecurityGroupMembershipList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SnapshotRetentionLimit")) {
                    result.snapshot_retention_limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotWindow")) {
                    result.snapshot_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionEnabled")) {
                    result.transit_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionMode")) {
                    result.transit_encryption_mode = TransitEncryptionMode.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheEngineVersion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheEngineVersion {
    var result: CacheEngineVersion = undefined;
    result.cache_engine_description = null;
    result.cache_engine_version_description = null;
    result.cache_parameter_group_family = null;
    result.engine = null;
    result.engine_version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheEngineDescription")) {
                    result.cache_engine_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheEngineVersionDescription")) {
                    result.cache_engine_version_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupFamily")) {
                    result.cache_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheNode(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheNode {
    var result: CacheNode = undefined;
    result.cache_node_create_time = null;
    result.cache_node_id = null;
    result.cache_node_status = null;
    result.customer_availability_zone = null;
    result.customer_outpost_arn = null;
    result.endpoint = null;
    result.parameter_group_status = null;
    result.source_cache_node_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeCreateTime")) {
                    result.cache_node_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CacheNodeId")) {
                    result.cache_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeStatus")) {
                    result.cache_node_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomerAvailabilityZone")) {
                    result.customer_availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomerOutpostArn")) {
                    result.customer_outpost_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ParameterGroupStatus")) {
                    result.parameter_group_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceCacheNodeId")) {
                    result.source_cache_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheNodeTypeSpecificParameter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheNodeTypeSpecificParameter {
    var result: CacheNodeTypeSpecificParameter = undefined;
    result.allowed_values = null;
    result.cache_node_type_specific_values = null;
    result.change_type = null;
    result.data_type = null;
    result.description = null;
    result.is_modifiable = null;
    result.minimum_engine_version = null;
    result.parameter_name = null;
    result.source = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValues")) {
                    result.allowed_values = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeTypeSpecificValues")) {
                    result.cache_node_type_specific_values = try deserializeCacheNodeTypeSpecificValueList(allocator, reader, "CacheNodeTypeSpecificValue");
                } else if (std.mem.eql(u8, e.local, "ChangeType")) {
                    result.change_type = ChangeType.fromWireName(try reader.readElementText());
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

pub fn deserializeCacheNodeTypeSpecificValue(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheNodeTypeSpecificValue {
    var result: CacheNodeTypeSpecificValue = undefined;
    result.cache_node_type = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCacheNodeUpdateStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheNodeUpdateStatus {
    var result: CacheNodeUpdateStatus = undefined;
    result.cache_node_id = null;
    result.node_deletion_date = null;
    result.node_update_end_date = null;
    result.node_update_initiated_by = null;
    result.node_update_initiated_date = null;
    result.node_update_start_date = null;
    result.node_update_status = null;
    result.node_update_status_modified_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeId")) {
                    result.cache_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeDeletionDate")) {
                    result.node_deletion_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateEndDate")) {
                    result.node_update_end_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateInitiatedBy")) {
                    result.node_update_initiated_by = NodeUpdateInitiatedBy.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeUpdateInitiatedDate")) {
                    result.node_update_initiated_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStartDate")) {
                    result.node_update_start_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStatus")) {
                    result.node_update_status = NodeUpdateStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStatusModifiedDate")) {
                    result.node_update_status_modified_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheParameterGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheParameterGroup {
    var result: CacheParameterGroup = undefined;
    result.arn = null;
    result.cache_parameter_group_family = null;
    result.cache_parameter_group_name = null;
    result.description = null;
    result.is_global = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupFamily")) {
                    result.cache_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupName")) {
                    result.cache_parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsGlobal")) {
                    result.is_global = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheParameterGroupStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheParameterGroupStatus {
    var result: CacheParameterGroupStatus = undefined;
    result.cache_node_ids_to_reboot = null;
    result.cache_parameter_group_name = null;
    result.parameter_apply_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeIdsToReboot")) {
                    result.cache_node_ids_to_reboot = try deserializeCacheNodeIdsList(allocator, reader, "CacheNodeId");
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupName")) {
                    result.cache_parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCacheSecurityGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheSecurityGroup {
    var result: CacheSecurityGroup = undefined;
    result.arn = null;
    result.cache_security_group_name = null;
    result.description = null;
    result.ec2_security_groups = null;
    result.owner_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSecurityGroupName")) {
                    result.cache_security_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroups")) {
                    result.ec2_security_groups = try deserializeEC2SecurityGroupList(allocator, reader, "EC2SecurityGroup");
                } else if (std.mem.eql(u8, e.local, "OwnerId")) {
                    result.owner_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheSecurityGroupMembership(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheSecurityGroupMembership {
    var result: CacheSecurityGroupMembership = undefined;
    result.cache_security_group_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheSecurityGroupName")) {
                    result.cache_security_group_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCacheSubnetGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheSubnetGroup {
    var result: CacheSubnetGroup = undefined;
    result.arn = null;
    result.cache_subnet_group_description = null;
    result.cache_subnet_group_name = null;
    result.subnets = null;
    result.supported_network_types = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSubnetGroupDescription")) {
                    result.cache_subnet_group_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSubnetGroupName")) {
                    result.cache_subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCacheUsageLimits(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheUsageLimits {
    var result: CacheUsageLimits = undefined;
    result.data_storage = null;
    result.ecpu_per_second = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DataStorage")) {
                    result.data_storage = try deserializeDataStorage(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ECPUPerSecond")) {
                    result.ecpu_per_second = try deserializeECPUPerSecond(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudWatchLogsDestinationDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CloudWatchLogsDestinationDetails {
    var result: CloudWatchLogsDestinationDetails = undefined;
    result.log_group = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogGroup")) {
                    result.log_group = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDataStorage(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DataStorage {
    _ = allocator;
    var result: DataStorage = undefined;
    result.maximum = null;
    result.minimum = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Maximum")) {
                    result.maximum = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Minimum")) {
                    result.minimum = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = DataStorageUnit.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDestinationDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DestinationDetails {
    var result: DestinationDetails = undefined;
    result.cloud_watch_logs_details = null;
    result.kinesis_firehose_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudWatchLogsDetails")) {
                    result.cloud_watch_logs_details = try deserializeCloudWatchLogsDestinationDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "KinesisFirehoseDetails")) {
                    result.kinesis_firehose_details = try deserializeKinesisFirehoseDestinationDetails(allocator, reader);
                } else {
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
    result.ec2_security_group_name = null;
    result.ec2_security_group_owner_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EC2SecurityGroupName")) {
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

pub fn deserializeECPUPerSecond(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ECPUPerSecond {
    _ = allocator;
    var result: ECPUPerSecond = undefined;
    result.maximum = null;
    result.minimum = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Maximum")) {
                    result.maximum = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Minimum")) {
                    result.minimum = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
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
    result.port = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Address")) {
                    result.address = try allocator.dupe(u8, try reader.readElementText());
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
    result.cache_node_type_specific_parameters = null;
    result.cache_parameter_group_family = null;
    result.marker = null;
    result.parameters = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeTypeSpecificParameters")) {
                    result.cache_node_type_specific_parameters = try deserializeCacheNodeTypeSpecificParametersList(allocator, reader, "CacheNodeTypeSpecificParameter");
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupFamily")) {
                    result.cache_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
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
    result.message = null;
    result.source_identifier = null;
    result.source_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Date")) {
                    result.date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeGlobalNodeGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GlobalNodeGroup {
    var result: GlobalNodeGroup = undefined;
    result.global_node_group_id = null;
    result.slots = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GlobalNodeGroupId")) {
                    result.global_node_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Slots")) {
                    result.slots = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGlobalReplicationGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GlobalReplicationGroup {
    var result: GlobalReplicationGroup = undefined;
    result.arn = null;
    result.at_rest_encryption_enabled = null;
    result.auth_token_enabled = null;
    result.cache_node_type = null;
    result.cluster_enabled = null;
    result.engine = null;
    result.engine_version = null;
    result.global_node_groups = null;
    result.global_replication_group_description = null;
    result.global_replication_group_id = null;
    result.members = null;
    result.status = null;
    result.transit_encryption_enabled = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AtRestEncryptionEnabled")) {
                    result.at_rest_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AuthTokenEnabled")) {
                    result.auth_token_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterEnabled")) {
                    result.cluster_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalNodeGroups")) {
                    result.global_node_groups = try deserializeGlobalNodeGroupList(allocator, reader, "GlobalNodeGroup");
                } else if (std.mem.eql(u8, e.local, "GlobalReplicationGroupDescription")) {
                    result.global_replication_group_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalReplicationGroupId")) {
                    result.global_replication_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Members")) {
                    result.members = try deserializeGlobalReplicationGroupMemberList(allocator, reader, "GlobalReplicationGroupMember");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionEnabled")) {
                    result.transit_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGlobalReplicationGroupInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GlobalReplicationGroupInfo {
    var result: GlobalReplicationGroupInfo = undefined;
    result.global_replication_group_id = null;
    result.global_replication_group_member_role = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GlobalReplicationGroupId")) {
                    result.global_replication_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalReplicationGroupMemberRole")) {
                    result.global_replication_group_member_role = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGlobalReplicationGroupMember(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GlobalReplicationGroupMember {
    var result: GlobalReplicationGroupMember = undefined;
    result.automatic_failover = null;
    result.replication_group_id = null;
    result.replication_group_region = null;
    result.role = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutomaticFailover")) {
                    result.automatic_failover = AutomaticFailoverStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupRegion")) {
                    result.replication_group_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Role")) {
                    result.role = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeKinesisFirehoseDestinationDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KinesisFirehoseDestinationDetails {
    var result: KinesisFirehoseDestinationDetails = undefined;
    result.delivery_stream = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeliveryStream")) {
                    result.delivery_stream = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLogDeliveryConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LogDeliveryConfiguration {
    var result: LogDeliveryConfiguration = undefined;
    result.destination_details = null;
    result.destination_type = null;
    result.log_format = null;
    result.log_type = null;
    result.message = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DestinationDetails")) {
                    result.destination_details = try deserializeDestinationDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DestinationType")) {
                    result.destination_type = DestinationType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogFormat")) {
                    result.log_format = LogFormat.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogType")) {
                    result.log_type = LogType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = LogDeliveryConfigurationStatus.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNodeGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NodeGroup {
    var result: NodeGroup = undefined;
    result.node_group_id = null;
    result.node_group_members = null;
    result.primary_endpoint = null;
    result.reader_endpoint = null;
    result.slots = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NodeGroupId")) {
                    result.node_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroupMembers")) {
                    result.node_group_members = try deserializeNodeGroupMemberList(allocator, reader, "NodeGroupMember");
                } else if (std.mem.eql(u8, e.local, "PrimaryEndpoint")) {
                    result.primary_endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ReaderEndpoint")) {
                    result.reader_endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Slots")) {
                    result.slots = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeNodeGroupConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NodeGroupConfiguration {
    var result: NodeGroupConfiguration = undefined;
    result.node_group_id = null;
    result.primary_availability_zone = null;
    result.primary_outpost_arn = null;
    result.replica_availability_zones = null;
    result.replica_count = null;
    result.replica_outpost_arns = null;
    result.slots = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NodeGroupId")) {
                    result.node_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PrimaryAvailabilityZone")) {
                    result.primary_availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PrimaryOutpostArn")) {
                    result.primary_outpost_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicaAvailabilityZones")) {
                    result.replica_availability_zones = try deserializeAvailabilityZonesList(allocator, reader, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "ReplicaCount")) {
                    result.replica_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ReplicaOutpostArns")) {
                    result.replica_outpost_arns = try deserializeOutpostArnsList(allocator, reader, "OutpostArn");
                } else if (std.mem.eql(u8, e.local, "Slots")) {
                    result.slots = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNodeGroupMember(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NodeGroupMember {
    var result: NodeGroupMember = undefined;
    result.cache_cluster_id = null;
    result.cache_node_id = null;
    result.current_role = null;
    result.preferred_availability_zone = null;
    result.preferred_outpost_arn = null;
    result.read_endpoint = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeId")) {
                    result.cache_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CurrentRole")) {
                    result.current_role = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredAvailabilityZone")) {
                    result.preferred_availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredOutpostArn")) {
                    result.preferred_outpost_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReadEndpoint")) {
                    result.read_endpoint = try deserializeEndpoint(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNodeGroupMemberUpdateStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NodeGroupMemberUpdateStatus {
    var result: NodeGroupMemberUpdateStatus = undefined;
    result.cache_cluster_id = null;
    result.cache_node_id = null;
    result.node_deletion_date = null;
    result.node_update_end_date = null;
    result.node_update_initiated_by = null;
    result.node_update_initiated_date = null;
    result.node_update_start_date = null;
    result.node_update_status = null;
    result.node_update_status_modified_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeId")) {
                    result.cache_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeDeletionDate")) {
                    result.node_deletion_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateEndDate")) {
                    result.node_update_end_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateInitiatedBy")) {
                    result.node_update_initiated_by = NodeUpdateInitiatedBy.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeUpdateInitiatedDate")) {
                    result.node_update_initiated_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStartDate")) {
                    result.node_update_start_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStatus")) {
                    result.node_update_status = NodeUpdateStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStatusModifiedDate")) {
                    result.node_update_status_modified_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNodeGroupUpdateStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NodeGroupUpdateStatus {
    var result: NodeGroupUpdateStatus = undefined;
    result.node_group_id = null;
    result.node_group_member_update_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NodeGroupId")) {
                    result.node_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroupMemberUpdateStatus")) {
                    result.node_group_member_update_status = try deserializeNodeGroupMemberUpdateStatusList(allocator, reader, "NodeGroupMemberUpdateStatus");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNodeSnapshot(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NodeSnapshot {
    var result: NodeSnapshot = undefined;
    result.cache_cluster_id = null;
    result.cache_node_create_time = null;
    result.cache_node_id = null;
    result.cache_size = null;
    result.node_group_configuration = null;
    result.node_group_id = null;
    result.snapshot_create_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeCreateTime")) {
                    result.cache_node_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CacheNodeId")) {
                    result.cache_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSize")) {
                    result.cache_size = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroupConfiguration")) {
                    result.node_group_configuration = try deserializeNodeGroupConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NodeGroupId")) {
                    result.node_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotCreateTime")) {
                    result.snapshot_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
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
    result.topic_arn = null;
    result.topic_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicStatus")) {
                    result.topic_status = try allocator.dupe(u8, try reader.readElementText());
                } else {
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
    result.change_type = null;
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
                } else if (std.mem.eql(u8, e.local, "ChangeType")) {
                    result.change_type = ChangeType.fromWireName(try reader.readElementText());
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

pub fn deserializePendingLogDeliveryConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PendingLogDeliveryConfiguration {
    var result: PendingLogDeliveryConfiguration = undefined;
    result.destination_details = null;
    result.destination_type = null;
    result.log_format = null;
    result.log_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DestinationDetails")) {
                    result.destination_details = try deserializeDestinationDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DestinationType")) {
                    result.destination_type = DestinationType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogFormat")) {
                    result.log_format = LogFormat.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogType")) {
                    result.log_type = LogType.fromWireName(try reader.readElementText());
                } else {
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
    result.auth_token_status = null;
    result.cache_node_ids_to_remove = null;
    result.cache_node_type = null;
    result.engine_version = null;
    result.log_delivery_configurations = null;
    result.num_cache_nodes = null;
    result.scale_config = null;
    result.transit_encryption_enabled = null;
    result.transit_encryption_mode = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthTokenStatus")) {
                    result.auth_token_status = AuthTokenUpdateStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeIdsToRemove")) {
                    result.cache_node_ids_to_remove = try deserializeCacheNodeIdsList(allocator, reader, "CacheNodeId");
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogDeliveryConfigurations")) {
                    result.log_delivery_configurations = try deserializePendingLogDeliveryConfigurationList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "NumCacheNodes")) {
                    result.num_cache_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ScaleConfig")) {
                    result.scale_config = try deserializeScaleConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionEnabled")) {
                    result.transit_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionMode")) {
                    result.transit_encryption_mode = TransitEncryptionMode.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeProcessedUpdateAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ProcessedUpdateAction {
    var result: ProcessedUpdateAction = undefined;
    result.cache_cluster_id = null;
    result.replication_group_id = null;
    result.service_update_name = null;
    result.update_action_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateName")) {
                    result.service_update_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdateActionStatus")) {
                    result.update_action_status = UpdateActionStatus.fromWireName(try reader.readElementText());
                } else {
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

pub fn deserializeReplicationGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReplicationGroup {
    var result: ReplicationGroup = undefined;
    result.arn = null;
    result.at_rest_encryption_enabled = null;
    result.auth_token_enabled = null;
    result.auth_token_last_modified_date = null;
    result.automatic_failover = null;
    result.auto_minor_version_upgrade = null;
    result.cache_node_type = null;
    result.cluster_enabled = null;
    result.cluster_mode = null;
    result.configuration_endpoint = null;
    result.data_tiering = null;
    result.description = null;
    result.engine = null;
    result.global_replication_group_info = null;
    result.ip_discovery = null;
    result.kms_key_id = null;
    result.log_delivery_configurations = null;
    result.member_clusters = null;
    result.member_clusters_outpost_arns = null;
    result.multi_az = null;
    result.network_type = null;
    result.node_groups = null;
    result.pending_modified_values = null;
    result.replication_group_create_time = null;
    result.replication_group_id = null;
    result.snapshot_retention_limit = null;
    result.snapshotting_cluster_id = null;
    result.snapshot_window = null;
    result.status = null;
    result.transit_encryption_enabled = null;
    result.transit_encryption_mode = null;
    result.user_group_ids = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AtRestEncryptionEnabled")) {
                    result.at_rest_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AuthTokenEnabled")) {
                    result.auth_token_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AuthTokenLastModifiedDate")) {
                    result.auth_token_last_modified_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AutomaticFailover")) {
                    result.automatic_failover = AutomaticFailoverStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterEnabled")) {
                    result.cluster_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ClusterMode")) {
                    result.cluster_mode = ClusterMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConfigurationEndpoint")) {
                    result.configuration_endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DataTiering")) {
                    result.data_tiering = DataTieringStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalReplicationGroupInfo")) {
                    result.global_replication_group_info = try deserializeGlobalReplicationGroupInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "IpDiscovery")) {
                    result.ip_discovery = IpDiscovery.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogDeliveryConfigurations")) {
                    result.log_delivery_configurations = try deserializeLogDeliveryConfigurationList(allocator, reader, "LogDeliveryConfiguration");
                } else if (std.mem.eql(u8, e.local, "MemberClusters")) {
                    result.member_clusters = try deserializeClusterIdList(allocator, reader, "ClusterId");
                } else if (std.mem.eql(u8, e.local, "MemberClustersOutpostArns")) {
                    result.member_clusters_outpost_arns = try deserializeReplicationGroupOutpostArnList(allocator, reader, "ReplicationGroupOutpostArn");
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = MultiAZStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NetworkType")) {
                    result.network_type = NetworkType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroups")) {
                    result.node_groups = try deserializeNodeGroupList(allocator, reader, "NodeGroup");
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializeReplicationGroupPendingModifiedValues(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupCreateTime")) {
                    result.replication_group_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotRetentionLimit")) {
                    result.snapshot_retention_limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshottingClusterId")) {
                    result.snapshotting_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotWindow")) {
                    result.snapshot_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionEnabled")) {
                    result.transit_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionMode")) {
                    result.transit_encryption_mode = TransitEncryptionMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroupIds")) {
                    result.user_group_ids = try deserializeUserGroupIdList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReplicationGroupPendingModifiedValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReplicationGroupPendingModifiedValues {
    var result: ReplicationGroupPendingModifiedValues = undefined;
    result.auth_token_status = null;
    result.automatic_failover_status = null;
    result.cluster_mode = null;
    result.log_delivery_configurations = null;
    result.primary_cluster_id = null;
    result.resharding = null;
    result.transit_encryption_enabled = null;
    result.transit_encryption_mode = null;
    result.user_groups = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthTokenStatus")) {
                    result.auth_token_status = AuthTokenUpdateStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutomaticFailoverStatus")) {
                    result.automatic_failover_status = PendingAutomaticFailoverStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterMode")) {
                    result.cluster_mode = ClusterMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogDeliveryConfigurations")) {
                    result.log_delivery_configurations = try deserializePendingLogDeliveryConfigurationList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PrimaryClusterId")) {
                    result.primary_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Resharding")) {
                    result.resharding = try deserializeReshardingStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionEnabled")) {
                    result.transit_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionMode")) {
                    result.transit_encryption_mode = TransitEncryptionMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroups")) {
                    result.user_groups = try deserializeUserGroupsUpdateStatus(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReservedCacheNode(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReservedCacheNode {
    var result: ReservedCacheNode = undefined;
    result.cache_node_count = null;
    result.cache_node_type = null;
    result.duration = null;
    result.fixed_price = null;
    result.offering_type = null;
    result.product_description = null;
    result.recurring_charges = null;
    result.reservation_arn = null;
    result.reserved_cache_node_id = null;
    result.reserved_cache_nodes_offering_id = null;
    result.start_time = null;
    result.state = null;
    result.usage_price = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeCount")) {
                    result.cache_node_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProductDescription")) {
                    result.product_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(allocator, reader, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservationARN")) {
                    result.reservation_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedCacheNodeId")) {
                    result.reserved_cache_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedCacheNodesOfferingId")) {
                    result.reserved_cache_nodes_offering_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeReservedCacheNodesOffering(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReservedCacheNodesOffering {
    var result: ReservedCacheNodesOffering = undefined;
    result.cache_node_type = null;
    result.duration = null;
    result.fixed_price = null;
    result.offering_type = null;
    result.product_description = null;
    result.recurring_charges = null;
    result.reserved_cache_nodes_offering_id = null;
    result.usage_price = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProductDescription")) {
                    result.product_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(allocator, reader, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservedCacheNodesOfferingId")) {
                    result.reserved_cache_nodes_offering_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeReshardingStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReshardingStatus {
    var result: ReshardingStatus = undefined;
    result.slot_migration = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SlotMigration")) {
                    result.slot_migration = try deserializeSlotMigration(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeScaleConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScaleConfig {
    _ = allocator;
    var result: ScaleConfig = undefined;
    result.scale_interval_minutes = null;
    result.scale_percentage = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ScaleIntervalMinutes")) {
                    result.scale_interval_minutes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ScalePercentage")) {
                    result.scale_percentage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSecurityGroupMembership(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SecurityGroupMembership {
    var result: SecurityGroupMembership = undefined;
    result.security_group_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SecurityGroupId")) {
                    result.security_group_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeServerlessCache(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerlessCache {
    var result: ServerlessCache = undefined;
    result.arn = null;
    result.cache_usage_limits = null;
    result.create_time = null;
    result.daily_snapshot_time = null;
    result.description = null;
    result.endpoint = null;
    result.engine = null;
    result.full_engine_version = null;
    result.kms_key_id = null;
    result.major_engine_version = null;
    result.reader_endpoint = null;
    result.security_group_ids = null;
    result.serverless_cache_name = null;
    result.snapshot_retention_limit = null;
    result.status = null;
    result.subnet_ids = null;
    result.user_group_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheUsageLimits")) {
                    result.cache_usage_limits = try deserializeCacheUsageLimits(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DailySnapshotTime")) {
                    result.daily_snapshot_time = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FullEngineVersion")) {
                    result.full_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReaderEndpoint")) {
                    result.reader_endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SecurityGroupIds")) {
                    result.security_group_ids = try deserializeSecurityGroupIdsList(allocator, reader, "SecurityGroupId");
                } else if (std.mem.eql(u8, e.local, "ServerlessCacheName")) {
                    result.serverless_cache_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotRetentionLimit")) {
                    result.snapshot_retention_limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetIds")) {
                    result.subnet_ids = try deserializeSubnetIdsList(allocator, reader, "SubnetId");
                } else if (std.mem.eql(u8, e.local, "UserGroupId")) {
                    result.user_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerlessCacheConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerlessCacheConfiguration {
    var result: ServerlessCacheConfiguration = undefined;
    result.engine = null;
    result.major_engine_version = null;
    result.serverless_cache_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessCacheName")) {
                    result.serverless_cache_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerlessCacheSnapshot(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerlessCacheSnapshot {
    var result: ServerlessCacheSnapshot = undefined;
    result.arn = null;
    result.bytes_used_for_cache = null;
    result.create_time = null;
    result.expiry_time = null;
    result.kms_key_id = null;
    result.serverless_cache_configuration = null;
    result.serverless_cache_snapshot_name = null;
    result.snapshot_type = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BytesUsedForCache")) {
                    result.bytes_used_for_cache = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExpiryTime")) {
                    result.expiry_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessCacheConfiguration")) {
                    result.serverless_cache_configuration = try deserializeServerlessCacheConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ServerlessCacheSnapshotName")) {
                    result.serverless_cache_snapshot_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotType")) {
                    result.snapshot_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeServiceUpdate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServiceUpdate {
    var result: ServiceUpdate = undefined;
    result.auto_update_after_recommended_apply_by_date = null;
    result.engine = null;
    result.engine_version = null;
    result.estimated_update_time = null;
    result.service_update_description = null;
    result.service_update_end_date = null;
    result.service_update_name = null;
    result.service_update_recommended_apply_by_date = null;
    result.service_update_release_date = null;
    result.service_update_severity = null;
    result.service_update_status = null;
    result.service_update_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoUpdateAfterRecommendedApplyByDate")) {
                    result.auto_update_after_recommended_apply_by_date = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EstimatedUpdateTime")) {
                    result.estimated_update_time = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateDescription")) {
                    result.service_update_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateEndDate")) {
                    result.service_update_end_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateName")) {
                    result.service_update_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateRecommendedApplyByDate")) {
                    result.service_update_recommended_apply_by_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateReleaseDate")) {
                    result.service_update_release_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateSeverity")) {
                    result.service_update_severity = ServiceUpdateSeverity.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateStatus")) {
                    result.service_update_status = ServiceUpdateStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateType")) {
                    result.service_update_type = ServiceUpdateType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSlotMigration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SlotMigration {
    _ = allocator;
    var result: SlotMigration = undefined;
    result.progress_percentage = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ProgressPercentage")) {
                    result.progress_percentage = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSnapshot(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Snapshot {
    var result: Snapshot = undefined;
    result.arn = null;
    result.automatic_failover = null;
    result.auto_minor_version_upgrade = null;
    result.cache_cluster_create_time = null;
    result.cache_cluster_id = null;
    result.cache_node_type = null;
    result.cache_parameter_group_name = null;
    result.cache_subnet_group_name = null;
    result.data_tiering = null;
    result.engine = null;
    result.engine_version = null;
    result.kms_key_id = null;
    result.node_snapshots = null;
    result.num_cache_nodes = null;
    result.num_node_groups = null;
    result.port = null;
    result.preferred_availability_zone = null;
    result.preferred_maintenance_window = null;
    result.preferred_outpost_arn = null;
    result.replication_group_description = null;
    result.replication_group_id = null;
    result.snapshot_name = null;
    result.snapshot_retention_limit = null;
    result.snapshot_source = null;
    result.snapshot_status = null;
    result.snapshot_window = null;
    result.topic_arn = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutomaticFailover")) {
                    result.automatic_failover = AutomaticFailoverStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CacheClusterCreateTime")) {
                    result.cache_cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupName")) {
                    result.cache_parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSubnetGroupName")) {
                    result.cache_subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataTiering")) {
                    result.data_tiering = DataTieringStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeSnapshots")) {
                    result.node_snapshots = try deserializeNodeSnapshotList(allocator, reader, "NodeSnapshot");
                } else if (std.mem.eql(u8, e.local, "NumCacheNodes")) {
                    result.num_cache_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NumNodeGroups")) {
                    result.num_node_groups = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PreferredAvailabilityZone")) {
                    result.preferred_availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredOutpostArn")) {
                    result.preferred_outpost_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupDescription")) {
                    result.replication_group_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotName")) {
                    result.snapshot_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotRetentionLimit")) {
                    result.snapshot_retention_limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotSource")) {
                    result.snapshot_source = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotStatus")) {
                    result.snapshot_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotWindow")) {
                    result.snapshot_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeSubnet(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Subnet {
    var result: Subnet = undefined;
    result.subnet_availability_zone = null;
    result.subnet_identifier = null;
    result.subnet_outpost = null;
    result.supported_network_types = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubnetAvailabilityZone")) {
                    result.subnet_availability_zone = try deserializeAvailabilityZone(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SubnetIdentifier")) {
                    result.subnet_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetOutpost")) {
                    result.subnet_outpost = try deserializeSubnetOutpost(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SupportedNetworkTypes")) {
                    result.supported_network_types = try deserializeNetworkTypeList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSubnetOutpost(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SubnetOutpost {
    var result: SubnetOutpost = undefined;
    result.subnet_outpost_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubnetOutpostArn")) {
                    result.subnet_outpost_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
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

pub fn deserializeUnprocessedUpdateAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UnprocessedUpdateAction {
    var result: UnprocessedUpdateAction = undefined;
    result.cache_cluster_id = null;
    result.error_message = null;
    result.error_type = null;
    result.replication_group_id = null;
    result.service_update_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorType")) {
                    result.error_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateName")) {
                    result.service_update_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUpdateAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UpdateAction {
    var result: UpdateAction = undefined;
    result.cache_cluster_id = null;
    result.cache_node_update_status = null;
    result.engine = null;
    result.estimated_update_time = null;
    result.node_group_update_status = null;
    result.nodes_updated = null;
    result.replication_group_id = null;
    result.service_update_name = null;
    result.service_update_recommended_apply_by_date = null;
    result.service_update_release_date = null;
    result.service_update_severity = null;
    result.service_update_status = null;
    result.service_update_type = null;
    result.sla_met = null;
    result.update_action_available_date = null;
    result.update_action_status = null;
    result.update_action_status_modified_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeUpdateStatus")) {
                    result.cache_node_update_status = try deserializeCacheNodeUpdateStatusList(allocator, reader, "CacheNodeUpdateStatus");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EstimatedUpdateTime")) {
                    result.estimated_update_time = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroupUpdateStatus")) {
                    result.node_group_update_status = try deserializeNodeGroupUpdateStatusList(allocator, reader, "NodeGroupUpdateStatus");
                } else if (std.mem.eql(u8, e.local, "NodesUpdated")) {
                    result.nodes_updated = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateName")) {
                    result.service_update_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateRecommendedApplyByDate")) {
                    result.service_update_recommended_apply_by_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateReleaseDate")) {
                    result.service_update_release_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateSeverity")) {
                    result.service_update_severity = ServiceUpdateSeverity.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateStatus")) {
                    result.service_update_status = ServiceUpdateStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateType")) {
                    result.service_update_type = ServiceUpdateType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SlaMet")) {
                    result.sla_met = SlaMet.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdateActionAvailableDate")) {
                    result.update_action_available_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "UpdateActionStatus")) {
                    result.update_action_status = UpdateActionStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdateActionStatusModifiedDate")) {
                    result.update_action_status_modified_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUser(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !User {
    var result: User = undefined;
    result.access_string = null;
    result.arn = null;
    result.authentication = null;
    result.engine = null;
    result.minimum_engine_version = null;
    result.status = null;
    result.user_group_ids = null;
    result.user_id = null;
    result.user_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessString")) {
                    result.access_string = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Authentication")) {
                    result.authentication = try deserializeAuthentication(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroupIds")) {
                    result.user_group_ids = try deserializeUserGroupIdList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeUserGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UserGroup {
    var result: UserGroup = undefined;
    result.arn = null;
    result.engine = null;
    result.minimum_engine_version = null;
    result.pending_changes = null;
    result.replication_groups = null;
    result.serverless_caches = null;
    result.status = null;
    result.user_group_id = null;
    result.user_ids = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingChanges")) {
                    result.pending_changes = try deserializeUserGroupPendingChanges(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ReplicationGroups")) {
                    result.replication_groups = try deserializeUGReplicationGroupIdList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ServerlessCaches")) {
                    result.serverless_caches = try deserializeUGServerlessCacheIdList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroupId")) {
                    result.user_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserIds")) {
                    result.user_ids = try deserializeUserIdList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUserGroupPendingChanges(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UserGroupPendingChanges {
    var result: UserGroupPendingChanges = undefined;
    result.user_ids_to_add = null;
    result.user_ids_to_remove = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UserIdsToAdd")) {
                    result.user_ids_to_add = try deserializeUserIdList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "UserIdsToRemove")) {
                    result.user_ids_to_remove = try deserializeUserIdList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUserGroupsUpdateStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UserGroupsUpdateStatus {
    var result: UserGroupsUpdateStatus = undefined;
    result.user_group_ids_to_add = null;
    result.user_group_ids_to_remove = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UserGroupIdsToAdd")) {
                    result.user_group_ids_to_add = try deserializeUserGroupIdList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "UserGroupIdsToRemove")) {
                    result.user_group_ids_to_remove = try deserializeUserGroupIdList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeAvailabilityZonesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCacheClusterIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCacheNodeIdsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCacheSecurityGroupNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCustomerNodeEndpointList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CustomerNodeEndpoint, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeCustomerNodeEndpoint(allocator, buf, item);
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

pub fn serializeGlobalNodeGroupIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLogDeliveryConfigurationRequestList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LogDeliveryConfigurationRequest, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeLogDeliveryConfigurationRequest(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeNodeGroupConfigurationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const NodeGroupConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeNodeGroupConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeNodeGroupsToRemoveList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeNodeGroupsToRetainList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeOutpostArnsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeParameterNameValueList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ParameterNameValue, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeParameterNameValue(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializePasswordListInput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePreferredAvailabilityZoneList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePreferredOutpostArnList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRegionalConfigurationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RegionalConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRegionalConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRemoveReplicasList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeReplicaConfigurationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ConfigureShard, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeConfigureShard(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeReplicationGroupIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeReshardingConfigurationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ReshardingConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeReshardingConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSecurityGroupIdsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeServiceUpdateStatusList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ServiceUpdateStatus, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSnapshotArnsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSubnetIdsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeUpdateActionStatusList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const UpdateActionStatus, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeUserGroupIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeUserGroupIdListInput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeUserIdListInput(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAuthenticationMode(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AuthenticationMode) !void {
    if (value.passwords) |v| {
        try buf.appendSlice(allocator, "<Passwords>");
        try serializePasswordListInput(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Passwords>");
    }
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Type>");
    }
}

pub fn serializeCacheUsageLimits(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CacheUsageLimits) !void {
    if (value.data_storage) |v| {
        try buf.appendSlice(allocator, "<DataStorage>");
        try serializeDataStorage(allocator, buf, v);
        try buf.appendSlice(allocator, "</DataStorage>");
    }
    if (value.ecpu_per_second) |v| {
        try buf.appendSlice(allocator, "<ECPUPerSecond>");
        try serializeECPUPerSecond(allocator, buf, v);
        try buf.appendSlice(allocator, "</ECPUPerSecond>");
    }
}

pub fn serializeCloudWatchLogsDestinationDetails(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudWatchLogsDestinationDetails) !void {
    if (value.log_group) |v| {
        try buf.appendSlice(allocator, "<LogGroup>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</LogGroup>");
    }
}

pub fn serializeConfigureShard(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConfigureShard) !void {
    try buf.appendSlice(allocator, "<NewReplicaCount>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.new_replica_count}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</NewReplicaCount>");
    try buf.appendSlice(allocator, "<NodeGroupId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.node_group_id);
    try buf.appendSlice(allocator, "</NodeGroupId>");
    if (value.preferred_availability_zones) |v| {
        try buf.appendSlice(allocator, "<PreferredAvailabilityZones>");
        try serializePreferredAvailabilityZoneList(allocator, buf, v, "PreferredAvailabilityZone");
        try buf.appendSlice(allocator, "</PreferredAvailabilityZones>");
    }
    if (value.preferred_outpost_arns) |v| {
        try buf.appendSlice(allocator, "<PreferredOutpostArns>");
        try serializePreferredOutpostArnList(allocator, buf, v, "PreferredOutpostArn");
        try buf.appendSlice(allocator, "</PreferredOutpostArns>");
    }
}

pub fn serializeCustomerNodeEndpoint(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomerNodeEndpoint) !void {
    if (value.address) |v| {
        try buf.appendSlice(allocator, "<Address>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Address>");
    }
    if (value.port) |v| {
        try buf.appendSlice(allocator, "<Port>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Port>");
    }
}

pub fn serializeDataStorage(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DataStorage) !void {
    if (value.maximum) |v| {
        try buf.appendSlice(allocator, "<Maximum>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Maximum>");
    }
    if (value.minimum) |v| {
        try buf.appendSlice(allocator, "<Minimum>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Minimum>");
    }
    try buf.appendSlice(allocator, "<Unit>");
    try buf.appendSlice(allocator, value.unit.wireName());
    try buf.appendSlice(allocator, "</Unit>");
}

pub fn serializeDestinationDetails(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DestinationDetails) !void {
    if (value.cloud_watch_logs_details) |v| {
        try buf.appendSlice(allocator, "<CloudWatchLogsDetails>");
        try serializeCloudWatchLogsDestinationDetails(allocator, buf, v);
        try buf.appendSlice(allocator, "</CloudWatchLogsDetails>");
    }
    if (value.kinesis_firehose_details) |v| {
        try buf.appendSlice(allocator, "<KinesisFirehoseDetails>");
        try serializeKinesisFirehoseDestinationDetails(allocator, buf, v);
        try buf.appendSlice(allocator, "</KinesisFirehoseDetails>");
    }
}

pub fn serializeECPUPerSecond(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ECPUPerSecond) !void {
    if (value.maximum) |v| {
        try buf.appendSlice(allocator, "<Maximum>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Maximum>");
    }
    if (value.minimum) |v| {
        try buf.appendSlice(allocator, "<Minimum>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Minimum>");
    }
}

pub fn serializeFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Filter) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Values>");
    try serializeFilterValueList(allocator, buf, value.values, "member");
    try buf.appendSlice(allocator, "</Values>");
}

pub fn serializeKinesisFirehoseDestinationDetails(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: KinesisFirehoseDestinationDetails) !void {
    if (value.delivery_stream) |v| {
        try buf.appendSlice(allocator, "<DeliveryStream>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DeliveryStream>");
    }
}

pub fn serializeLogDeliveryConfigurationRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LogDeliveryConfigurationRequest) !void {
    if (value.destination_details) |v| {
        try buf.appendSlice(allocator, "<DestinationDetails>");
        try serializeDestinationDetails(allocator, buf, v);
        try buf.appendSlice(allocator, "</DestinationDetails>");
    }
    if (value.destination_type) |v| {
        try buf.appendSlice(allocator, "<DestinationType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</DestinationType>");
    }
    if (value.enabled) |v| {
        try buf.appendSlice(allocator, "<Enabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Enabled>");
    }
    if (value.log_format) |v| {
        try buf.appendSlice(allocator, "<LogFormat>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</LogFormat>");
    }
    if (value.log_type) |v| {
        try buf.appendSlice(allocator, "<LogType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</LogType>");
    }
}

pub fn serializeNodeGroupConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: NodeGroupConfiguration) !void {
    if (value.node_group_id) |v| {
        try buf.appendSlice(allocator, "<NodeGroupId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</NodeGroupId>");
    }
    if (value.primary_availability_zone) |v| {
        try buf.appendSlice(allocator, "<PrimaryAvailabilityZone>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</PrimaryAvailabilityZone>");
    }
    if (value.primary_outpost_arn) |v| {
        try buf.appendSlice(allocator, "<PrimaryOutpostArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</PrimaryOutpostArn>");
    }
    if (value.replica_availability_zones) |v| {
        try buf.appendSlice(allocator, "<ReplicaAvailabilityZones>");
        try serializeAvailabilityZonesList(allocator, buf, v, "AvailabilityZone");
        try buf.appendSlice(allocator, "</ReplicaAvailabilityZones>");
    }
    if (value.replica_count) |v| {
        try buf.appendSlice(allocator, "<ReplicaCount>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ReplicaCount>");
    }
    if (value.replica_outpost_arns) |v| {
        try buf.appendSlice(allocator, "<ReplicaOutpostArns>");
        try serializeOutpostArnsList(allocator, buf, v, "OutpostArn");
        try buf.appendSlice(allocator, "</ReplicaOutpostArns>");
    }
    if (value.slots) |v| {
        try buf.appendSlice(allocator, "<Slots>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Slots>");
    }
}

pub fn serializeParameterNameValue(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ParameterNameValue) !void {
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
}

pub fn serializeRegionalConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RegionalConfiguration) !void {
    try buf.appendSlice(allocator, "<ReplicationGroupId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.replication_group_id);
    try buf.appendSlice(allocator, "</ReplicationGroupId>");
    try buf.appendSlice(allocator, "<ReplicationGroupRegion>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.replication_group_region);
    try buf.appendSlice(allocator, "</ReplicationGroupRegion>");
    try buf.appendSlice(allocator, "<ReshardingConfiguration>");
    try serializeReshardingConfigurationList(allocator, buf, value.resharding_configuration, "ReshardingConfiguration");
    try buf.appendSlice(allocator, "</ReshardingConfiguration>");
}

pub fn serializeReshardingConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReshardingConfiguration) !void {
    if (value.node_group_id) |v| {
        try buf.appendSlice(allocator, "<NodeGroupId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</NodeGroupId>");
    }
    if (value.preferred_availability_zones) |v| {
        try buf.appendSlice(allocator, "<PreferredAvailabilityZones>");
        try serializeAvailabilityZonesList(allocator, buf, v, "AvailabilityZone");
        try buf.appendSlice(allocator, "</PreferredAvailabilityZones>");
    }
}

pub fn serializeScaleConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScaleConfig) !void {
    if (value.scale_interval_minutes) |v| {
        try buf.appendSlice(allocator, "<ScaleIntervalMinutes>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ScaleIntervalMinutes>");
    }
    if (value.scale_percentage) |v| {
        try buf.appendSlice(allocator, "<ScalePercentage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ScalePercentage>");
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

pub fn serializeTimeRangeFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TimeRangeFilter) !void {
    if (value.end_time) |v| {
        try buf.appendSlice(allocator, "<EndTime>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</EndTime>");
    }
    if (value.start_time) |v| {
        try buf.appendSlice(allocator, "<StartTime>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</StartTime>");
    }
}

