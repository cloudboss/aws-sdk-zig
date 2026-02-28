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

pub fn deserializeAvailabilityZonesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCacheClusterList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheCluster {
    var list: std.ArrayList(CacheCluster) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheCluster(reader, alloc));
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

pub fn deserializeCacheEngineVersionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheEngineVersion {
    var list: std.ArrayList(CacheEngineVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheEngineVersion(reader, alloc));
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

pub fn deserializeCacheNodeIdsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCacheNodeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheNode {
    var list: std.ArrayList(CacheNode) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheNode(reader, alloc));
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

pub fn deserializeCacheNodeTypeSpecificParametersList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheNodeTypeSpecificParameter {
    var list: std.ArrayList(CacheNodeTypeSpecificParameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheNodeTypeSpecificParameter(reader, alloc));
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

pub fn deserializeCacheNodeTypeSpecificValueList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheNodeTypeSpecificValue {
    var list: std.ArrayList(CacheNodeTypeSpecificValue) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheNodeTypeSpecificValue(reader, alloc));
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

pub fn deserializeCacheNodeUpdateStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheNodeUpdateStatus {
    var list: std.ArrayList(CacheNodeUpdateStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheNodeUpdateStatus(reader, alloc));
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

pub fn deserializeCacheParameterGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheParameterGroup {
    var list: std.ArrayList(CacheParameterGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheParameterGroup(reader, alloc));
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

pub fn deserializeCacheSecurityGroupMembershipList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheSecurityGroupMembership {
    var list: std.ArrayList(CacheSecurityGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheSecurityGroupMembership(reader, alloc));
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

pub fn deserializeCacheSecurityGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheSecurityGroup {
    var list: std.ArrayList(CacheSecurityGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheSecurityGroup(reader, alloc));
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

pub fn deserializeCacheSubnetGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheSubnetGroup {
    var list: std.ArrayList(CacheSubnetGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheSubnetGroup(reader, alloc));
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

pub fn deserializeClusterIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeGlobalNodeGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const GlobalNodeGroup {
    var list: std.ArrayList(GlobalNodeGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeGlobalNodeGroup(reader, alloc));
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

pub fn deserializeGlobalReplicationGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const GlobalReplicationGroup {
    var list: std.ArrayList(GlobalReplicationGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeGlobalReplicationGroup(reader, alloc));
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

pub fn deserializeGlobalReplicationGroupMemberList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const GlobalReplicationGroupMember {
    var list: std.ArrayList(GlobalReplicationGroupMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeGlobalReplicationGroupMember(reader, alloc));
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

pub fn deserializeLogDeliveryConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LogDeliveryConfiguration {
    var list: std.ArrayList(LogDeliveryConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLogDeliveryConfiguration(reader, alloc));
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

pub fn deserializeNetworkTypeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const NetworkType {
    var list: std.ArrayList(NetworkType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(NetworkType, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeNodeGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const NodeGroup {
    var list: std.ArrayList(NodeGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeNodeGroup(reader, alloc));
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

pub fn deserializeNodeGroupMemberList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const NodeGroupMember {
    var list: std.ArrayList(NodeGroupMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeNodeGroupMember(reader, alloc));
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

pub fn deserializeNodeGroupMemberUpdateStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const NodeGroupMemberUpdateStatus {
    var list: std.ArrayList(NodeGroupMemberUpdateStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeNodeGroupMemberUpdateStatus(reader, alloc));
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

pub fn deserializeNodeGroupUpdateStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const NodeGroupUpdateStatus {
    var list: std.ArrayList(NodeGroupUpdateStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeNodeGroupUpdateStatus(reader, alloc));
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

pub fn deserializeNodeSnapshotList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const NodeSnapshot {
    var list: std.ArrayList(NodeSnapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeNodeSnapshot(reader, alloc));
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

pub fn deserializeNodeTypeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeOutpostArnsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializePendingLogDeliveryConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PendingLogDeliveryConfiguration {
    var list: std.ArrayList(PendingLogDeliveryConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePendingLogDeliveryConfiguration(reader, alloc));
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

pub fn deserializeProcessedUpdateActionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ProcessedUpdateAction {
    var list: std.ArrayList(ProcessedUpdateAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeProcessedUpdateAction(reader, alloc));
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

pub fn deserializeReplicationGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReplicationGroup {
    var list: std.ArrayList(ReplicationGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReplicationGroup(reader, alloc));
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

pub fn deserializeReplicationGroupOutpostArnList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeReservedCacheNodeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReservedCacheNode {
    var list: std.ArrayList(ReservedCacheNode) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReservedCacheNode(reader, alloc));
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

pub fn deserializeReservedCacheNodesOfferingList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ReservedCacheNodesOffering {
    var list: std.ArrayList(ReservedCacheNodesOffering) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeReservedCacheNodesOffering(reader, alloc));
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

pub fn deserializeSecurityGroupIdsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSecurityGroupMembershipList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SecurityGroupMembership {
    var list: std.ArrayList(SecurityGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSecurityGroupMembership(reader, alloc));
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

pub fn deserializeServerlessCacheList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ServerlessCache {
    var list: std.ArrayList(ServerlessCache) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeServerlessCache(reader, alloc));
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

pub fn deserializeServerlessCacheSnapshotList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ServerlessCacheSnapshot {
    var list: std.ArrayList(ServerlessCacheSnapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeServerlessCacheSnapshot(reader, alloc));
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

pub fn deserializeServiceUpdateList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ServiceUpdate {
    var list: std.ArrayList(ServiceUpdate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeServiceUpdate(reader, alloc));
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

pub fn deserializeSnapshotList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Snapshot {
    var list: std.ArrayList(Snapshot) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSnapshot(reader, alloc));
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

pub fn deserializeSubnetIdsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUGReplicationGroupIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUGServerlessCacheIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUnprocessedUpdateActionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const UnprocessedUpdateAction {
    var list: std.ArrayList(UnprocessedUpdateAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeUnprocessedUpdateAction(reader, alloc));
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

pub fn deserializeUpdateActionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const UpdateAction {
    var list: std.ArrayList(UpdateAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeUpdateAction(reader, alloc));
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

pub fn deserializeUserGroupIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUserGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const UserGroup {
    var list: std.ArrayList(UserGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeUserGroup(reader, alloc));
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

pub fn deserializeUserIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeUserList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const User {
    var list: std.ArrayList(User) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeUser(reader, alloc));
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

pub fn deserializeAuthentication(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Authentication {
    _ = alloc;
    var result: Authentication = undefined;
    result.password_count = null;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PasswordCount")) {
                    result.password_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(AuthenticationType, try reader.readElementText());
                } else {
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

pub fn deserializeCacheCluster(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheCluster {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
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
                    result.cache_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheClusterStatus")) {
                    result.cache_cluster_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodes")) {
                    result.cache_nodes = try deserializeCacheNodeList(reader, alloc, "CacheNode");
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroup")) {
                    result.cache_parameter_group = try deserializeCacheParameterGroupStatus(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CacheSecurityGroups")) {
                    result.cache_security_groups = try deserializeCacheSecurityGroupMembershipList(reader, alloc, "CacheSecurityGroup");
                } else if (std.mem.eql(u8, e.local, "CacheSubnetGroupName")) {
                    result.cache_subnet_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClientDownloadLandingPage")) {
                    result.client_download_landing_page = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConfigurationEndpoint")) {
                    result.configuration_endpoint = try deserializeEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpDiscovery")) {
                    result.ip_discovery = std.meta.stringToEnum(IpDiscovery, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogDeliveryConfigurations")) {
                    result.log_delivery_configurations = try deserializeLogDeliveryConfigurationList(reader, alloc, "LogDeliveryConfiguration");
                } else if (std.mem.eql(u8, e.local, "NetworkType")) {
                    result.network_type = std.meta.stringToEnum(NetworkType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NotificationConfiguration")) {
                    result.notification_configuration = try deserializeNotificationConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "NumCacheNodes")) {
                    result.num_cache_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializePendingModifiedValues(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PreferredAvailabilityZone")) {
                    result.preferred_availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredOutpostArn")) {
                    result.preferred_outpost_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupLogDeliveryEnabled")) {
                    result.replication_group_log_delivery_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SecurityGroups")) {
                    result.security_groups = try deserializeSecurityGroupMembershipList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SnapshotRetentionLimit")) {
                    result.snapshot_retention_limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotWindow")) {
                    result.snapshot_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionEnabled")) {
                    result.transit_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionMode")) {
                    result.transit_encryption_mode = std.meta.stringToEnum(TransitEncryptionMode, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheEngineVersion(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheEngineVersion {
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
                    result.cache_engine_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheEngineVersionDescription")) {
                    result.cache_engine_version_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupFamily")) {
                    result.cache_parameter_group_family = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheNode(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheNode {
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
                    result.cache_node_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeStatus")) {
                    result.cache_node_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomerAvailabilityZone")) {
                    result.customer_availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomerOutpostArn")) {
                    result.customer_outpost_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try deserializeEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ParameterGroupStatus")) {
                    result.parameter_group_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceCacheNodeId")) {
                    result.source_cache_node_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheNodeTypeSpecificParameter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheNodeTypeSpecificParameter {
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
                    result.allowed_values = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeTypeSpecificValues")) {
                    result.cache_node_type_specific_values = try deserializeCacheNodeTypeSpecificValueList(reader, alloc, "CacheNodeTypeSpecificValue");
                } else if (std.mem.eql(u8, e.local, "ChangeType")) {
                    result.change_type = std.meta.stringToEnum(ChangeType, try reader.readElementText());
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

pub fn deserializeCacheNodeTypeSpecificValue(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheNodeTypeSpecificValue {
    var result: CacheNodeTypeSpecificValue = undefined;
    result.cache_node_type = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCacheNodeUpdateStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheNodeUpdateStatus {
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
                    result.cache_node_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeDeletionDate")) {
                    result.node_deletion_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateEndDate")) {
                    result.node_update_end_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateInitiatedBy")) {
                    result.node_update_initiated_by = std.meta.stringToEnum(NodeUpdateInitiatedBy, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeUpdateInitiatedDate")) {
                    result.node_update_initiated_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStartDate")) {
                    result.node_update_start_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStatus")) {
                    result.node_update_status = std.meta.stringToEnum(NodeUpdateStatus, try reader.readElementText());
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

pub fn deserializeCacheParameterGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheParameterGroup {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupFamily")) {
                    result.cache_parameter_group_family = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupName")) {
                    result.cache_parameter_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCacheParameterGroupStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheParameterGroupStatus {
    var result: CacheParameterGroupStatus = undefined;
    result.cache_node_ids_to_reboot = null;
    result.cache_parameter_group_name = null;
    result.parameter_apply_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeIdsToReboot")) {
                    result.cache_node_ids_to_reboot = try deserializeCacheNodeIdsList(reader, alloc, "CacheNodeId");
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupName")) {
                    result.cache_parameter_group_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCacheSecurityGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheSecurityGroup {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSecurityGroupName")) {
                    result.cache_security_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroups")) {
                    result.ec2_security_groups = try deserializeEC2SecurityGroupList(reader, alloc, "EC2SecurityGroup");
                } else if (std.mem.eql(u8, e.local, "OwnerId")) {
                    result.owner_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheSecurityGroupMembership(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheSecurityGroupMembership {
    var result: CacheSecurityGroupMembership = undefined;
    result.cache_security_group_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheSecurityGroupName")) {
                    result.cache_security_group_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeCacheSubnetGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheSubnetGroup {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSubnetGroupDescription")) {
                    result.cache_subnet_group_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSubnetGroupName")) {
                    result.cache_subnet_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Subnets")) {
                    result.subnets = try deserializeSubnetList(reader, alloc, "Subnet");
                } else if (std.mem.eql(u8, e.local, "SupportedNetworkTypes")) {
                    result.supported_network_types = try deserializeNetworkTypeList(reader, alloc, "member");
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

pub fn deserializeCacheUsageLimits(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheUsageLimits {
    var result: CacheUsageLimits = undefined;
    result.data_storage = null;
    result.ecpu_per_second = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DataStorage")) {
                    result.data_storage = try deserializeDataStorage(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ECPUPerSecond")) {
                    result.ecpu_per_second = try deserializeECPUPerSecond(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudWatchLogsDestinationDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CloudWatchLogsDestinationDetails {
    var result: CloudWatchLogsDestinationDetails = undefined;
    result.log_group = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogGroup")) {
                    result.log_group = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDataStorage(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DataStorage {
    _ = alloc;
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
                    result.unit = std.meta.stringToEnum(DataStorageUnit, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDestinationDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DestinationDetails {
    var result: DestinationDetails = undefined;
    result.cloud_watch_logs_details = null;
    result.kinesis_firehose_details = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudWatchLogsDetails")) {
                    result.cloud_watch_logs_details = try deserializeCloudWatchLogsDestinationDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "KinesisFirehoseDetails")) {
                    result.kinesis_firehose_details = try deserializeKinesisFirehoseDestinationDetails(reader, alloc);
                } else {
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
    result.ec2_security_group_name = null;
    result.ec2_security_group_owner_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EC2SecurityGroupName")) {
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

pub fn deserializeECPUPerSecond(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ECPUPerSecond {
    _ = alloc;
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

pub fn deserializeEndpoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Endpoint {
    var result: Endpoint = undefined;
    result.address = null;
    result.port = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Address")) {
                    result.address = try alloc.dupe(u8, try reader.readElementText());
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
    result.cache_node_type_specific_parameters = null;
    result.cache_parameter_group_family = null;
    result.marker = null;
    result.parameters = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheNodeTypeSpecificParameters")) {
                    result.cache_node_type_specific_parameters = try deserializeCacheNodeTypeSpecificParametersList(reader, alloc, "CacheNodeTypeSpecificParameter");
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupFamily")) {
                    result.cache_parameter_group_family = try alloc.dupe(u8, try reader.readElementText());
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
    result.message = null;
    result.source_identifier = null;
    result.source_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Date")) {
                    result.date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeGlobalNodeGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GlobalNodeGroup {
    var result: GlobalNodeGroup = undefined;
    result.global_node_group_id = null;
    result.slots = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GlobalNodeGroupId")) {
                    result.global_node_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Slots")) {
                    result.slots = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGlobalReplicationGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GlobalReplicationGroup {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AtRestEncryptionEnabled")) {
                    result.at_rest_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AuthTokenEnabled")) {
                    result.auth_token_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterEnabled")) {
                    result.cluster_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalNodeGroups")) {
                    result.global_node_groups = try deserializeGlobalNodeGroupList(reader, alloc, "GlobalNodeGroup");
                } else if (std.mem.eql(u8, e.local, "GlobalReplicationGroupDescription")) {
                    result.global_replication_group_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalReplicationGroupId")) {
                    result.global_replication_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Members")) {
                    result.members = try deserializeGlobalReplicationGroupMemberList(reader, alloc, "GlobalReplicationGroupMember");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeGlobalReplicationGroupInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GlobalReplicationGroupInfo {
    var result: GlobalReplicationGroupInfo = undefined;
    result.global_replication_group_id = null;
    result.global_replication_group_member_role = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GlobalReplicationGroupId")) {
                    result.global_replication_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalReplicationGroupMemberRole")) {
                    result.global_replication_group_member_role = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGlobalReplicationGroupMember(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GlobalReplicationGroupMember {
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
                    result.automatic_failover = std.meta.stringToEnum(AutomaticFailoverStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupRegion")) {
                    result.replication_group_region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Role")) {
                    result.role = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeKinesisFirehoseDestinationDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KinesisFirehoseDestinationDetails {
    var result: KinesisFirehoseDestinationDetails = undefined;
    result.delivery_stream = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeliveryStream")) {
                    result.delivery_stream = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLogDeliveryConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LogDeliveryConfiguration {
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
                    result.destination_details = try deserializeDestinationDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DestinationType")) {
                    result.destination_type = std.meta.stringToEnum(DestinationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogFormat")) {
                    result.log_format = std.meta.stringToEnum(LogFormat, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogType")) {
                    result.log_type = std.meta.stringToEnum(LogType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(LogDeliveryConfigurationStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNodeGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NodeGroup {
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
                    result.node_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroupMembers")) {
                    result.node_group_members = try deserializeNodeGroupMemberList(reader, alloc, "NodeGroupMember");
                } else if (std.mem.eql(u8, e.local, "PrimaryEndpoint")) {
                    result.primary_endpoint = try deserializeEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ReaderEndpoint")) {
                    result.reader_endpoint = try deserializeEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Slots")) {
                    result.slots = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeNodeGroupConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NodeGroupConfiguration {
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
                    result.node_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PrimaryAvailabilityZone")) {
                    result.primary_availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PrimaryOutpostArn")) {
                    result.primary_outpost_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicaAvailabilityZones")) {
                    result.replica_availability_zones = try deserializeAvailabilityZonesList(reader, alloc, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "ReplicaCount")) {
                    result.replica_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ReplicaOutpostArns")) {
                    result.replica_outpost_arns = try deserializeOutpostArnsList(reader, alloc, "OutpostArn");
                } else if (std.mem.eql(u8, e.local, "Slots")) {
                    result.slots = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNodeGroupMember(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NodeGroupMember {
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
                    result.cache_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeId")) {
                    result.cache_node_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CurrentRole")) {
                    result.current_role = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredAvailabilityZone")) {
                    result.preferred_availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredOutpostArn")) {
                    result.preferred_outpost_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReadEndpoint")) {
                    result.read_endpoint = try deserializeEndpoint(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNodeGroupMemberUpdateStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NodeGroupMemberUpdateStatus {
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
                    result.cache_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeId")) {
                    result.cache_node_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeDeletionDate")) {
                    result.node_deletion_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateEndDate")) {
                    result.node_update_end_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateInitiatedBy")) {
                    result.node_update_initiated_by = std.meta.stringToEnum(NodeUpdateInitiatedBy, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeUpdateInitiatedDate")) {
                    result.node_update_initiated_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStartDate")) {
                    result.node_update_start_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeUpdateStatus")) {
                    result.node_update_status = std.meta.stringToEnum(NodeUpdateStatus, try reader.readElementText());
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

pub fn deserializeNodeGroupUpdateStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NodeGroupUpdateStatus {
    var result: NodeGroupUpdateStatus = undefined;
    result.node_group_id = null;
    result.node_group_member_update_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NodeGroupId")) {
                    result.node_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroupMemberUpdateStatus")) {
                    result.node_group_member_update_status = try deserializeNodeGroupMemberUpdateStatusList(reader, alloc, "NodeGroupMemberUpdateStatus");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNodeSnapshot(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NodeSnapshot {
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
                    result.cache_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeCreateTime")) {
                    result.cache_node_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CacheNodeId")) {
                    result.cache_node_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSize")) {
                    result.cache_size = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroupConfiguration")) {
                    result.node_group_configuration = try deserializeNodeGroupConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "NodeGroupId")) {
                    result.node_group_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeNotificationConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !NotificationConfiguration {
    var result: NotificationConfiguration = undefined;
    result.topic_arn = null;
    result.topic_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicStatus")) {
                    result.topic_status = try alloc.dupe(u8, try reader.readElementText());
                } else {
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
                    result.allowed_values = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChangeType")) {
                    result.change_type = std.meta.stringToEnum(ChangeType, try reader.readElementText());
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

pub fn deserializePendingLogDeliveryConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PendingLogDeliveryConfiguration {
    var result: PendingLogDeliveryConfiguration = undefined;
    result.destination_details = null;
    result.destination_type = null;
    result.log_format = null;
    result.log_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DestinationDetails")) {
                    result.destination_details = try deserializeDestinationDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DestinationType")) {
                    result.destination_type = std.meta.stringToEnum(DestinationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogFormat")) {
                    result.log_format = std.meta.stringToEnum(LogFormat, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogType")) {
                    result.log_type = std.meta.stringToEnum(LogType, try reader.readElementText());
                } else {
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
                    result.auth_token_status = std.meta.stringToEnum(AuthTokenUpdateStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeIdsToRemove")) {
                    result.cache_node_ids_to_remove = try deserializeCacheNodeIdsList(reader, alloc, "CacheNodeId");
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogDeliveryConfigurations")) {
                    result.log_delivery_configurations = try deserializePendingLogDeliveryConfigurationList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "NumCacheNodes")) {
                    result.num_cache_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ScaleConfig")) {
                    result.scale_config = try deserializeScaleConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionEnabled")) {
                    result.transit_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionMode")) {
                    result.transit_encryption_mode = std.meta.stringToEnum(TransitEncryptionMode, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeProcessedUpdateAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ProcessedUpdateAction {
    var result: ProcessedUpdateAction = undefined;
    result.cache_cluster_id = null;
    result.replication_group_id = null;
    result.service_update_name = null;
    result.update_action_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateName")) {
                    result.service_update_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdateActionStatus")) {
                    result.update_action_status = std.meta.stringToEnum(UpdateActionStatus, try reader.readElementText());
                } else {
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

pub fn deserializeReplicationGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReplicationGroup {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AtRestEncryptionEnabled")) {
                    result.at_rest_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AuthTokenEnabled")) {
                    result.auth_token_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AuthTokenLastModifiedDate")) {
                    result.auth_token_last_modified_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AutomaticFailover")) {
                    result.automatic_failover = std.meta.stringToEnum(AutomaticFailoverStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterEnabled")) {
                    result.cluster_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ClusterMode")) {
                    result.cluster_mode = std.meta.stringToEnum(ClusterMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConfigurationEndpoint")) {
                    result.configuration_endpoint = try deserializeEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DataTiering")) {
                    result.data_tiering = std.meta.stringToEnum(DataTieringStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GlobalReplicationGroupInfo")) {
                    result.global_replication_group_info = try deserializeGlobalReplicationGroupInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "IpDiscovery")) {
                    result.ip_discovery = std.meta.stringToEnum(IpDiscovery, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogDeliveryConfigurations")) {
                    result.log_delivery_configurations = try deserializeLogDeliveryConfigurationList(reader, alloc, "LogDeliveryConfiguration");
                } else if (std.mem.eql(u8, e.local, "MemberClusters")) {
                    result.member_clusters = try deserializeClusterIdList(reader, alloc, "ClusterId");
                } else if (std.mem.eql(u8, e.local, "MemberClustersOutpostArns")) {
                    result.member_clusters_outpost_arns = try deserializeReplicationGroupOutpostArnList(reader, alloc, "ReplicationGroupOutpostArn");
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = std.meta.stringToEnum(MultiAZStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NetworkType")) {
                    result.network_type = std.meta.stringToEnum(NetworkType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroups")) {
                    result.node_groups = try deserializeNodeGroupList(reader, alloc, "NodeGroup");
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializeReplicationGroupPendingModifiedValues(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupCreateTime")) {
                    result.replication_group_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotRetentionLimit")) {
                    result.snapshot_retention_limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshottingClusterId")) {
                    result.snapshotting_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotWindow")) {
                    result.snapshot_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionEnabled")) {
                    result.transit_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionMode")) {
                    result.transit_encryption_mode = std.meta.stringToEnum(TransitEncryptionMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroupIds")) {
                    result.user_group_ids = try deserializeUserGroupIdList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReplicationGroupPendingModifiedValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReplicationGroupPendingModifiedValues {
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
                    result.auth_token_status = std.meta.stringToEnum(AuthTokenUpdateStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutomaticFailoverStatus")) {
                    result.automatic_failover_status = std.meta.stringToEnum(PendingAutomaticFailoverStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterMode")) {
                    result.cluster_mode = std.meta.stringToEnum(ClusterMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogDeliveryConfigurations")) {
                    result.log_delivery_configurations = try deserializePendingLogDeliveryConfigurationList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PrimaryClusterId")) {
                    result.primary_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Resharding")) {
                    result.resharding = try deserializeReshardingStatus(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionEnabled")) {
                    result.transit_encryption_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TransitEncryptionMode")) {
                    result.transit_encryption_mode = std.meta.stringToEnum(TransitEncryptionMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroups")) {
                    result.user_groups = try deserializeUserGroupsUpdateStatus(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReservedCacheNode(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReservedCacheNode {
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
                    result.cache_node_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProductDescription")) {
                    result.product_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(reader, alloc, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservationARN")) {
                    result.reservation_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedCacheNodeId")) {
                    result.reserved_cache_node_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedCacheNodesOfferingId")) {
                    result.reserved_cache_nodes_offering_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeReservedCacheNodesOffering(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReservedCacheNodesOffering {
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
                    result.cache_node_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProductDescription")) {
                    result.product_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(reader, alloc, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservedCacheNodesOfferingId")) {
                    result.reserved_cache_nodes_offering_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeReshardingStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReshardingStatus {
    var result: ReshardingStatus = undefined;
    result.slot_migration = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SlotMigration")) {
                    result.slot_migration = try deserializeSlotMigration(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeScaleConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ScaleConfig {
    _ = alloc;
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

pub fn deserializeSecurityGroupMembership(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SecurityGroupMembership {
    var result: SecurityGroupMembership = undefined;
    result.security_group_id = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SecurityGroupId")) {
                    result.security_group_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeServerlessCache(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerlessCache {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheUsageLimits")) {
                    result.cache_usage_limits = try deserializeCacheUsageLimits(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DailySnapshotTime")) {
                    result.daily_snapshot_time = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try deserializeEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FullEngineVersion")) {
                    result.full_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReaderEndpoint")) {
                    result.reader_endpoint = try deserializeEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SecurityGroupIds")) {
                    result.security_group_ids = try deserializeSecurityGroupIdsList(reader, alloc, "SecurityGroupId");
                } else if (std.mem.eql(u8, e.local, "ServerlessCacheName")) {
                    result.serverless_cache_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotRetentionLimit")) {
                    result.snapshot_retention_limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetIds")) {
                    result.subnet_ids = try deserializeSubnetIdsList(reader, alloc, "SubnetId");
                } else if (std.mem.eql(u8, e.local, "UserGroupId")) {
                    result.user_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerlessCacheConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerlessCacheConfiguration {
    var result: ServerlessCacheConfiguration = undefined;
    result.engine = null;
    result.major_engine_version = null;
    result.serverless_cache_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessCacheName")) {
                    result.serverless_cache_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerlessCacheSnapshot(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerlessCacheSnapshot {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BytesUsedForCache")) {
                    result.bytes_used_for_cache = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExpiryTime")) {
                    result.expiry_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessCacheConfiguration")) {
                    result.serverless_cache_configuration = try deserializeServerlessCacheConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ServerlessCacheSnapshotName")) {
                    result.serverless_cache_snapshot_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotType")) {
                    result.snapshot_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeServiceUpdate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServiceUpdate {
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
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EstimatedUpdateTime")) {
                    result.estimated_update_time = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateDescription")) {
                    result.service_update_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateEndDate")) {
                    result.service_update_end_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateName")) {
                    result.service_update_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateRecommendedApplyByDate")) {
                    result.service_update_recommended_apply_by_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateReleaseDate")) {
                    result.service_update_release_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateSeverity")) {
                    result.service_update_severity = std.meta.stringToEnum(ServiceUpdateSeverity, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateStatus")) {
                    result.service_update_status = std.meta.stringToEnum(ServiceUpdateStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateType")) {
                    result.service_update_type = std.meta.stringToEnum(ServiceUpdateType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSlotMigration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SlotMigration {
    _ = alloc;
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

pub fn deserializeSnapshot(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Snapshot {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutomaticFailover")) {
                    result.automatic_failover = std.meta.stringToEnum(AutomaticFailoverStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoMinorVersionUpgrade")) {
                    result.auto_minor_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "CacheClusterCreateTime")) {
                    result.cache_cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CacheClusterId")) {
                    result.cache_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeType")) {
                    result.cache_node_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheParameterGroupName")) {
                    result.cache_parameter_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheSubnetGroupName")) {
                    result.cache_subnet_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataTiering")) {
                    result.data_tiering = std.meta.stringToEnum(DataTieringStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeSnapshots")) {
                    result.node_snapshots = try deserializeNodeSnapshotList(reader, alloc, "NodeSnapshot");
                } else if (std.mem.eql(u8, e.local, "NumCacheNodes")) {
                    result.num_cache_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NumNodeGroups")) {
                    result.num_node_groups = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PreferredAvailabilityZone")) {
                    result.preferred_availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreferredOutpostArn")) {
                    result.preferred_outpost_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupDescription")) {
                    result.replication_group_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotName")) {
                    result.snapshot_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotRetentionLimit")) {
                    result.snapshot_retention_limit = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotSource")) {
                    result.snapshot_source = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotStatus")) {
                    result.snapshot_status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotWindow")) {
                    result.snapshot_window = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TopicArn")) {
                    result.topic_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSubnet(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Subnet {
    var result: Subnet = undefined;
    result.subnet_availability_zone = null;
    result.subnet_identifier = null;
    result.subnet_outpost = null;
    result.supported_network_types = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubnetAvailabilityZone")) {
                    result.subnet_availability_zone = try deserializeAvailabilityZone(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SubnetIdentifier")) {
                    result.subnet_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetOutpost")) {
                    result.subnet_outpost = try deserializeSubnetOutpost(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SupportedNetworkTypes")) {
                    result.supported_network_types = try deserializeNetworkTypeList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSubnetOutpost(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SubnetOutpost {
    var result: SubnetOutpost = undefined;
    result.subnet_outpost_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubnetOutpostArn")) {
                    result.subnet_outpost_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
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

pub fn deserializeUnprocessedUpdateAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !UnprocessedUpdateAction {
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
                    result.cache_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorType")) {
                    result.error_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateName")) {
                    result.service_update_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUpdateAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !UpdateAction {
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
                    result.cache_cluster_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheNodeUpdateStatus")) {
                    result.cache_node_update_status = try deserializeCacheNodeUpdateStatusList(reader, alloc, "CacheNodeUpdateStatus");
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EstimatedUpdateTime")) {
                    result.estimated_update_time = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeGroupUpdateStatus")) {
                    result.node_group_update_status = try deserializeNodeGroupUpdateStatusList(reader, alloc, "NodeGroupUpdateStatus");
                } else if (std.mem.eql(u8, e.local, "NodesUpdated")) {
                    result.nodes_updated = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReplicationGroupId")) {
                    result.replication_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateName")) {
                    result.service_update_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateRecommendedApplyByDate")) {
                    result.service_update_recommended_apply_by_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateReleaseDate")) {
                    result.service_update_release_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateSeverity")) {
                    result.service_update_severity = std.meta.stringToEnum(ServiceUpdateSeverity, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateStatus")) {
                    result.service_update_status = std.meta.stringToEnum(ServiceUpdateStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUpdateType")) {
                    result.service_update_type = std.meta.stringToEnum(ServiceUpdateType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SlaMet")) {
                    result.sla_met = std.meta.stringToEnum(SlaMet, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdateActionAvailableDate")) {
                    result.update_action_available_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "UpdateActionStatus")) {
                    result.update_action_status = std.meta.stringToEnum(UpdateActionStatus, try reader.readElementText());
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

pub fn deserializeUser(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !User {
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
                    result.access_string = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Authentication")) {
                    result.authentication = try deserializeAuthentication(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroupIds")) {
                    result.user_group_ids = try deserializeUserGroupIdList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeUserGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !UserGroup {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingChanges")) {
                    result.pending_changes = try deserializeUserGroupPendingChanges(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ReplicationGroups")) {
                    result.replication_groups = try deserializeUGReplicationGroupIdList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ServerlessCaches")) {
                    result.serverless_caches = try deserializeUGServerlessCacheIdList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroupId")) {
                    result.user_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserIds")) {
                    result.user_ids = try deserializeUserIdList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUserGroupPendingChanges(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !UserGroupPendingChanges {
    var result: UserGroupPendingChanges = undefined;
    result.user_ids_to_add = null;
    result.user_ids_to_remove = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UserIdsToAdd")) {
                    result.user_ids_to_add = try deserializeUserIdList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "UserIdsToRemove")) {
                    result.user_ids_to_remove = try deserializeUserIdList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUserGroupsUpdateStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !UserGroupsUpdateStatus {
    var result: UserGroupsUpdateStatus = undefined;
    result.user_group_ids_to_add = null;
    result.user_group_ids_to_remove = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UserGroupIdsToAdd")) {
                    result.user_group_ids_to_add = try deserializeUserGroupIdList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "UserGroupIdsToRemove")) {
                    result.user_group_ids_to_remove = try deserializeUserGroupIdList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeAvailabilityZonesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCacheClusterIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCacheNodeIdsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCacheSecurityGroupNameList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCustomerNodeEndpointList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CustomerNodeEndpoint, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeCustomerNodeEndpoint(alloc, buf, item);
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

pub fn serializeGlobalNodeGroupIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLogDeliveryConfigurationRequestList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LogDeliveryConfigurationRequest, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeLogDeliveryConfigurationRequest(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeNodeGroupConfigurationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const NodeGroupConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeNodeGroupConfiguration(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeNodeGroupsToRemoveList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeNodeGroupsToRetainList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeOutpostArnsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeParameterNameValueList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ParameterNameValue, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeParameterNameValue(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializePasswordListInput(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePreferredAvailabilityZoneList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializePreferredOutpostArnList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRegionalConfigurationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RegionalConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRegionalConfiguration(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRemoveReplicasList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeReplicaConfigurationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ConfigureShard, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeConfigureShard(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeReplicationGroupIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeReshardingConfigurationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ReshardingConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeReshardingConfiguration(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeSecurityGroupIdsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeServiceUpdateStatusList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ServiceUpdateStatus, comptime item_tag: []const u8) !void {
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

pub fn serializeSnapshotArnsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSubnetIdsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeUpdateActionStatusList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const UpdateActionStatus, comptime item_tag: []const u8) !void {
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

pub fn serializeUserGroupIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeUserGroupIdListInput(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeUserIdListInput(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAuthenticationMode(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AuthenticationMode) !void {
    if (value.passwords) |v| {
        try buf.appendSlice(alloc, "<Passwords>");
        try serializePasswordListInput(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Passwords>");
    }
    if (value.@"type") |v| {
        try buf.appendSlice(alloc, "<Type>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Type>");
    }
}

pub fn serializeCacheUsageLimits(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CacheUsageLimits) !void {
    if (value.data_storage) |v| {
        try buf.appendSlice(alloc, "<DataStorage>");
        try serializeDataStorage(alloc, buf, v);
        try buf.appendSlice(alloc, "</DataStorage>");
    }
    if (value.ecpu_per_second) |v| {
        try buf.appendSlice(alloc, "<ECPUPerSecond>");
        try serializeECPUPerSecond(alloc, buf, v);
        try buf.appendSlice(alloc, "</ECPUPerSecond>");
    }
}

pub fn serializeCloudWatchLogsDestinationDetails(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudWatchLogsDestinationDetails) !void {
    if (value.log_group) |v| {
        try buf.appendSlice(alloc, "<LogGroup>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</LogGroup>");
    }
}

pub fn serializeConfigureShard(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConfigureShard) !void {
    try buf.appendSlice(alloc, "<NewReplicaCount>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.new_replica_count}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</NewReplicaCount>");
    try buf.appendSlice(alloc, "<NodeGroupId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.node_group_id);
    try buf.appendSlice(alloc, "</NodeGroupId>");
    if (value.preferred_availability_zones) |v| {
        try buf.appendSlice(alloc, "<PreferredAvailabilityZones>");
        try serializePreferredAvailabilityZoneList(alloc, buf, v, "PreferredAvailabilityZone");
        try buf.appendSlice(alloc, "</PreferredAvailabilityZones>");
    }
    if (value.preferred_outpost_arns) |v| {
        try buf.appendSlice(alloc, "<PreferredOutpostArns>");
        try serializePreferredOutpostArnList(alloc, buf, v, "PreferredOutpostArn");
        try buf.appendSlice(alloc, "</PreferredOutpostArns>");
    }
}

pub fn serializeCustomerNodeEndpoint(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomerNodeEndpoint) !void {
    if (value.address) |v| {
        try buf.appendSlice(alloc, "<Address>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Address>");
    }
    if (value.port) |v| {
        try buf.appendSlice(alloc, "<Port>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Port>");
    }
}

pub fn serializeDataStorage(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DataStorage) !void {
    if (value.maximum) |v| {
        try buf.appendSlice(alloc, "<Maximum>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Maximum>");
    }
    if (value.minimum) |v| {
        try buf.appendSlice(alloc, "<Minimum>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Minimum>");
    }
    try buf.appendSlice(alloc, "<Unit>");
    try buf.appendSlice(alloc, @tagName(value.unit));
    try buf.appendSlice(alloc, "</Unit>");
}

pub fn serializeDestinationDetails(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DestinationDetails) !void {
    if (value.cloud_watch_logs_details) |v| {
        try buf.appendSlice(alloc, "<CloudWatchLogsDetails>");
        try serializeCloudWatchLogsDestinationDetails(alloc, buf, v);
        try buf.appendSlice(alloc, "</CloudWatchLogsDetails>");
    }
    if (value.kinesis_firehose_details) |v| {
        try buf.appendSlice(alloc, "<KinesisFirehoseDetails>");
        try serializeKinesisFirehoseDestinationDetails(alloc, buf, v);
        try buf.appendSlice(alloc, "</KinesisFirehoseDetails>");
    }
}

pub fn serializeECPUPerSecond(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ECPUPerSecond) !void {
    if (value.maximum) |v| {
        try buf.appendSlice(alloc, "<Maximum>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Maximum>");
    }
    if (value.minimum) |v| {
        try buf.appendSlice(alloc, "<Minimum>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Minimum>");
    }
}

pub fn serializeFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Filter) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Values>");
    try serializeFilterValueList(alloc, buf, value.values, "member");
    try buf.appendSlice(alloc, "</Values>");
}

pub fn serializeKinesisFirehoseDestinationDetails(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: KinesisFirehoseDestinationDetails) !void {
    if (value.delivery_stream) |v| {
        try buf.appendSlice(alloc, "<DeliveryStream>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DeliveryStream>");
    }
}

pub fn serializeLogDeliveryConfigurationRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LogDeliveryConfigurationRequest) !void {
    if (value.destination_details) |v| {
        try buf.appendSlice(alloc, "<DestinationDetails>");
        try serializeDestinationDetails(alloc, buf, v);
        try buf.appendSlice(alloc, "</DestinationDetails>");
    }
    if (value.destination_type) |v| {
        try buf.appendSlice(alloc, "<DestinationType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</DestinationType>");
    }
    if (value.enabled) |v| {
        try buf.appendSlice(alloc, "<Enabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Enabled>");
    }
    if (value.log_format) |v| {
        try buf.appendSlice(alloc, "<LogFormat>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</LogFormat>");
    }
    if (value.log_type) |v| {
        try buf.appendSlice(alloc, "<LogType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</LogType>");
    }
}

pub fn serializeNodeGroupConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: NodeGroupConfiguration) !void {
    if (value.node_group_id) |v| {
        try buf.appendSlice(alloc, "<NodeGroupId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</NodeGroupId>");
    }
    if (value.primary_availability_zone) |v| {
        try buf.appendSlice(alloc, "<PrimaryAvailabilityZone>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</PrimaryAvailabilityZone>");
    }
    if (value.primary_outpost_arn) |v| {
        try buf.appendSlice(alloc, "<PrimaryOutpostArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</PrimaryOutpostArn>");
    }
    if (value.replica_availability_zones) |v| {
        try buf.appendSlice(alloc, "<ReplicaAvailabilityZones>");
        try serializeAvailabilityZonesList(alloc, buf, v, "AvailabilityZone");
        try buf.appendSlice(alloc, "</ReplicaAvailabilityZones>");
    }
    if (value.replica_count) |v| {
        try buf.appendSlice(alloc, "<ReplicaCount>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ReplicaCount>");
    }
    if (value.replica_outpost_arns) |v| {
        try buf.appendSlice(alloc, "<ReplicaOutpostArns>");
        try serializeOutpostArnsList(alloc, buf, v, "OutpostArn");
        try buf.appendSlice(alloc, "</ReplicaOutpostArns>");
    }
    if (value.slots) |v| {
        try buf.appendSlice(alloc, "<Slots>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Slots>");
    }
}

pub fn serializeParameterNameValue(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ParameterNameValue) !void {
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
}

pub fn serializeRegionalConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RegionalConfiguration) !void {
    try buf.appendSlice(alloc, "<ReplicationGroupId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.replication_group_id);
    try buf.appendSlice(alloc, "</ReplicationGroupId>");
    try buf.appendSlice(alloc, "<ReplicationGroupRegion>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.replication_group_region);
    try buf.appendSlice(alloc, "</ReplicationGroupRegion>");
    try buf.appendSlice(alloc, "<ReshardingConfiguration>");
    try serializeReshardingConfigurationList(alloc, buf, value.resharding_configuration, "ReshardingConfiguration");
    try buf.appendSlice(alloc, "</ReshardingConfiguration>");
}

pub fn serializeReshardingConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ReshardingConfiguration) !void {
    if (value.node_group_id) |v| {
        try buf.appendSlice(alloc, "<NodeGroupId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</NodeGroupId>");
    }
    if (value.preferred_availability_zones) |v| {
        try buf.appendSlice(alloc, "<PreferredAvailabilityZones>");
        try serializeAvailabilityZonesList(alloc, buf, v, "AvailabilityZone");
        try buf.appendSlice(alloc, "</PreferredAvailabilityZones>");
    }
}

pub fn serializeScaleConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScaleConfig) !void {
    if (value.scale_interval_minutes) |v| {
        try buf.appendSlice(alloc, "<ScaleIntervalMinutes>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ScaleIntervalMinutes>");
    }
    if (value.scale_percentage) |v| {
        try buf.appendSlice(alloc, "<ScalePercentage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ScalePercentage>");
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

pub fn serializeTimeRangeFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TimeRangeFilter) !void {
    if (value.end_time) |v| {
        try buf.appendSlice(alloc, "<EndTime>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</EndTime>");
    }
    if (value.start_time) |v| {
        try buf.appendSlice(alloc, "<StartTime>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</StartTime>");
    }
}

