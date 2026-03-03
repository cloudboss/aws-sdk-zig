const aws = @import("aws");
const std = @import("std");

const AccountAttribute = @import("account_attribute.zig").AccountAttribute;
const AccountWithRestoreAccess = @import("account_with_restore_access.zig").AccountWithRestoreAccess;
const ApplicationType = @import("application_type.zig").ApplicationType;
const AquaConfiguration = @import("aqua_configuration.zig").AquaConfiguration;
const AquaConfigurationStatus = @import("aqua_configuration_status.zig").AquaConfigurationStatus;
const AquaStatus = @import("aqua_status.zig").AquaStatus;
const Association = @import("association.zig").Association;
const AttributeValueTarget = @import("attribute_value_target.zig").AttributeValueTarget;
const AuthenticationProfile = @import("authentication_profile.zig").AuthenticationProfile;
const AuthorizationStatus = @import("authorization_status.zig").AuthorizationStatus;
const AuthorizedTokenIssuer = @import("authorized_token_issuer.zig").AuthorizedTokenIssuer;
const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const CertificateAssociation = @import("certificate_association.zig").CertificateAssociation;
const Cluster = @import("cluster.zig").Cluster;
const ClusterAssociatedToSchedule = @import("cluster_associated_to_schedule.zig").ClusterAssociatedToSchedule;
const ClusterDbRevision = @import("cluster_db_revision.zig").ClusterDbRevision;
const ClusterIamRole = @import("cluster_iam_role.zig").ClusterIamRole;
const ClusterNode = @import("cluster_node.zig").ClusterNode;
const ClusterParameterGroup = @import("cluster_parameter_group.zig").ClusterParameterGroup;
const ClusterParameterGroupStatus = @import("cluster_parameter_group_status.zig").ClusterParameterGroupStatus;
const ClusterParameterStatus = @import("cluster_parameter_status.zig").ClusterParameterStatus;
const ClusterSecurityGroup = @import("cluster_security_group.zig").ClusterSecurityGroup;
const ClusterSecurityGroupMembership = @import("cluster_security_group_membership.zig").ClusterSecurityGroupMembership;
const ClusterSnapshotCopyStatus = @import("cluster_snapshot_copy_status.zig").ClusterSnapshotCopyStatus;
const ClusterSubnetGroup = @import("cluster_subnet_group.zig").ClusterSubnetGroup;
const ClusterVersion = @import("cluster_version.zig").ClusterVersion;
const DataShare = @import("data_share.zig").DataShare;
const DataShareAssociation = @import("data_share_association.zig").DataShareAssociation;
const DataShareStatus = @import("data_share_status.zig").DataShareStatus;
const DataShareType = @import("data_share_type.zig").DataShareType;
const DataTransferProgress = @import("data_transfer_progress.zig").DataTransferProgress;
const DefaultClusterParameters = @import("default_cluster_parameters.zig").DefaultClusterParameters;
const DeferredMaintenanceWindow = @import("deferred_maintenance_window.zig").DeferredMaintenanceWindow;
const DeleteClusterSnapshotMessage = @import("delete_cluster_snapshot_message.zig").DeleteClusterSnapshotMessage;
const DescribeIntegrationsFilter = @import("describe_integrations_filter.zig").DescribeIntegrationsFilter;
const DescribeIntegrationsFilterName = @import("describe_integrations_filter_name.zig").DescribeIntegrationsFilterName;
const EC2SecurityGroup = @import("ec2_security_group.zig").EC2SecurityGroup;
const ElasticIpStatus = @import("elastic_ip_status.zig").ElasticIpStatus;
const Endpoint = @import("endpoint.zig").Endpoint;
const EndpointAccess = @import("endpoint_access.zig").EndpointAccess;
const EndpointAuthorization = @import("endpoint_authorization.zig").EndpointAuthorization;
const Event = @import("event.zig").Event;
const EventCategoriesMap = @import("event_categories_map.zig").EventCategoriesMap;
const EventInfoMap = @import("event_info_map.zig").EventInfoMap;
const EventSubscription = @import("event_subscription.zig").EventSubscription;
const HsmClientCertificate = @import("hsm_client_certificate.zig").HsmClientCertificate;
const HsmConfiguration = @import("hsm_configuration.zig").HsmConfiguration;
const HsmStatus = @import("hsm_status.zig").HsmStatus;
const IPRange = @import("ip_range.zig").IPRange;
const ImpactRankingType = @import("impact_ranking_type.zig").ImpactRankingType;
const InboundIntegration = @import("inbound_integration.zig").InboundIntegration;
const Integration = @import("integration.zig").Integration;
const IntegrationError = @import("integration_error.zig").IntegrationError;
const MaintenanceTrack = @import("maintenance_track.zig").MaintenanceTrack;
const Mode = @import("mode.zig").Mode;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const NodeConfigurationOption = @import("node_configuration_option.zig").NodeConfigurationOption;
const NodeConfigurationOptionsFilter = @import("node_configuration_options_filter.zig").NodeConfigurationOptionsFilter;
const NodeConfigurationOptionsFilterName = @import("node_configuration_options_filter_name.zig").NodeConfigurationOptionsFilterName;
const OperatorType = @import("operator_type.zig").OperatorType;
const OrderableClusterOption = @import("orderable_cluster_option.zig").OrderableClusterOption;
const Parameter = @import("parameter.zig").Parameter;
const ParameterApplyType = @import("parameter_apply_type.zig").ParameterApplyType;
const PartnerIntegrationInfo = @import("partner_integration_info.zig").PartnerIntegrationInfo;
const PartnerIntegrationStatus = @import("partner_integration_status.zig").PartnerIntegrationStatus;
const PauseClusterMessage = @import("pause_cluster_message.zig").PauseClusterMessage;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const Recommendation = @import("recommendation.zig").Recommendation;
const RecommendedAction = @import("recommended_action.zig").RecommendedAction;
const RecommendedActionType = @import("recommended_action_type.zig").RecommendedActionType;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;
const RedshiftIdcApplication = @import("redshift_idc_application.zig").RedshiftIdcApplication;
const ReferenceLink = @import("reference_link.zig").ReferenceLink;
const ReservedNode = @import("reserved_node.zig").ReservedNode;
const ReservedNodeConfigurationOption = @import("reserved_node_configuration_option.zig").ReservedNodeConfigurationOption;
const ReservedNodeExchangeStatus = @import("reserved_node_exchange_status.zig").ReservedNodeExchangeStatus;
const ReservedNodeExchangeStatusType = @import("reserved_node_exchange_status_type.zig").ReservedNodeExchangeStatusType;
const ReservedNodeOffering = @import("reserved_node_offering.zig").ReservedNodeOffering;
const ReservedNodeOfferingType = @import("reserved_node_offering_type.zig").ReservedNodeOfferingType;
const ResizeClusterMessage = @import("resize_cluster_message.zig").ResizeClusterMessage;
const ResizeInfo = @import("resize_info.zig").ResizeInfo;
const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;
const RestoreStatus = @import("restore_status.zig").RestoreStatus;
const ResumeClusterMessage = @import("resume_cluster_message.zig").ResumeClusterMessage;
const RevisionTarget = @import("revision_target.zig").RevisionTarget;
const ScheduleState = @import("schedule_state.zig").ScheduleState;
const ScheduledAction = @import("scheduled_action.zig").ScheduledAction;
const ScheduledActionFilter = @import("scheduled_action_filter.zig").ScheduledActionFilter;
const ScheduledActionFilterName = @import("scheduled_action_filter_name.zig").ScheduledActionFilterName;
const ScheduledActionState = @import("scheduled_action_state.zig").ScheduledActionState;
const ScheduledActionType = @import("scheduled_action_type.zig").ScheduledActionType;
const SecondaryClusterInfo = @import("secondary_cluster_info.zig").SecondaryClusterInfo;
const ServiceIntegrationsUnion = @import("service_integrations_union.zig").ServiceIntegrationsUnion;
const Snapshot = @import("snapshot.zig").Snapshot;
const SnapshotAttributeToSortBy = @import("snapshot_attribute_to_sort_by.zig").SnapshotAttributeToSortBy;
const SnapshotCopyGrant = @import("snapshot_copy_grant.zig").SnapshotCopyGrant;
const SnapshotErrorMessage = @import("snapshot_error_message.zig").SnapshotErrorMessage;
const SnapshotSchedule = @import("snapshot_schedule.zig").SnapshotSchedule;
const SnapshotSortingEntity = @import("snapshot_sorting_entity.zig").SnapshotSortingEntity;
const SortByOrder = @import("sort_by_order.zig").SortByOrder;
const SourceType = @import("source_type.zig").SourceType;
const Subnet = @import("subnet.zig").Subnet;
const SupportedOperation = @import("supported_operation.zig").SupportedOperation;
const SupportedPlatform = @import("supported_platform.zig").SupportedPlatform;
const TableRestoreStatus = @import("table_restore_status.zig").TableRestoreStatus;
const TableRestoreStatusType = @import("table_restore_status_type.zig").TableRestoreStatusType;
const Tag = @import("tag.zig").Tag;
const TaggedResource = @import("tagged_resource.zig").TaggedResource;
const UpdateTarget = @import("update_target.zig").UpdateTarget;
const UsageLimit = @import("usage_limit.zig").UsageLimit;
const UsageLimitBreachAction = @import("usage_limit_breach_action.zig").UsageLimitBreachAction;
const UsageLimitFeatureType = @import("usage_limit_feature_type.zig").UsageLimitFeatureType;
const UsageLimitLimitType = @import("usage_limit_limit_type.zig").UsageLimitLimitType;
const UsageLimitPeriod = @import("usage_limit_period.zig").UsageLimitPeriod;
const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;
const ZeroETLIntegrationStatus = @import("zero_etl_integration_status.zig").ZeroETLIntegrationStatus;

pub fn deserializeAccountsWithRestoreAccessList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AccountWithRestoreAccess {
    var list: std.ArrayList(AccountWithRestoreAccess) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAccountWithRestoreAccess(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAssociatedClusterList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterAssociatedToSchedule {
    var list: std.ArrayList(ClusterAssociatedToSchedule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterAssociatedToSchedule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAssociationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Association {
    var list: std.ArrayList(Association) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAssociation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAttributeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AccountAttribute {
    var list: std.ArrayList(AccountAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAccountAttribute(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAttributeValueList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AttributeValueTarget {
    var list: std.ArrayList(AttributeValueTarget) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAttributeValueTarget(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAuthenticationProfileList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AuthenticationProfile {
    var list: std.ArrayList(AuthenticationProfile) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAuthenticationProfile(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAuthorizedAudienceList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAuthorizedTokenIssuerList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AuthorizedTokenIssuer {
    var list: std.ArrayList(AuthorizedTokenIssuer) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAuthorizedTokenIssuer(allocator, reader));
                } else {
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

pub fn deserializeBatchSnapshotOperationErrorList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SnapshotErrorMessage {
    var list: std.ArrayList(SnapshotErrorMessage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSnapshotErrorMessage(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeBatchSnapshotOperationErrors(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SnapshotErrorMessage {
    var list: std.ArrayList(SnapshotErrorMessage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSnapshotErrorMessage(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCertificateAssociationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CertificateAssociation {
    var list: std.ArrayList(CertificateAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCertificateAssociation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterDbRevisionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterDbRevision {
    var list: std.ArrayList(ClusterDbRevision) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterDbRevision(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterIamRoleList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterIamRole {
    var list: std.ArrayList(ClusterIamRole) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterIamRole(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Cluster {
    var list: std.ArrayList(Cluster) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCluster(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterNodesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterNode {
    var list: std.ArrayList(ClusterNode) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterNode(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterParameterGroupStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterParameterGroupStatus {
    var list: std.ArrayList(ClusterParameterGroupStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterParameterGroupStatus(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterParameterStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterParameterStatus {
    var list: std.ArrayList(ClusterParameterStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterParameterStatus(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterSecurityGroupMembershipList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterSecurityGroupMembership {
    var list: std.ArrayList(ClusterSecurityGroupMembership) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterSecurityGroupMembership(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterSecurityGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterSecurityGroup {
    var list: std.ArrayList(ClusterSecurityGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterSecurityGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterSubnetGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterSubnetGroup {
    var list: std.ArrayList(ClusterSubnetGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterSubnetGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeClusterVersionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterVersion {
    var list: std.ArrayList(ClusterVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterVersion(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDataShareAssociationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DataShareAssociation {
    var list: std.ArrayList(DataShareAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDataShareAssociation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDataShareList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DataShare {
    var list: std.ArrayList(DataShare) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDataShare(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDeferredMaintenanceWindowsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DeferredMaintenanceWindow {
    var list: std.ArrayList(DeferredMaintenanceWindow) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDeferredMaintenanceWindow(allocator, reader));
                } else {
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

pub fn deserializeEligibleTracksToUpdateList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const UpdateTarget {
    var list: std.ArrayList(UpdateTarget) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUpdateTarget(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEndpointAccesses(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EndpointAccess {
    var list: std.ArrayList(EndpointAccess) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEndpointAccess(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEndpointAuthorizations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EndpointAuthorization {
    var list: std.ArrayList(EndpointAuthorization) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEndpointAuthorization(allocator, reader));
                } else {
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

pub fn deserializeEventInfoMapList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EventInfoMap {
    var list: std.ArrayList(EventInfoMap) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEventInfoMap(allocator, reader));
                } else {
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

pub fn deserializeHsmClientCertificateList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const HsmClientCertificate {
    var list: std.ArrayList(HsmClientCertificate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeHsmClientCertificate(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeHsmConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const HsmConfiguration {
    var list: std.ArrayList(HsmConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeHsmConfiguration(allocator, reader));
                } else {
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

pub fn deserializeImportTablesCompleted(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeImportTablesInProgress(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeImportTablesNotStarted(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeInboundIntegrationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InboundIntegration {
    var list: std.ArrayList(InboundIntegration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInboundIntegration(allocator, reader));
                } else {
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

pub fn deserializeNetworkInterfaceList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NetworkInterface {
    var list: std.ArrayList(NetworkInterface) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeNetworkInterface(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeNodeConfigurationOptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const NodeConfigurationOption {
    var list: std.ArrayList(NodeConfigurationOption) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeNodeConfigurationOption(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOrderableClusterOptionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OrderableClusterOption {
    var list: std.ArrayList(OrderableClusterOption) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOrderableClusterOption(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeParameterGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ClusterParameterGroup {
    var list: std.ArrayList(ClusterParameterGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeClusterParameterGroup(allocator, reader));
                } else {
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

pub fn deserializePartnerIntegrationInfoList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PartnerIntegrationInfo {
    var list: std.ArrayList(PartnerIntegrationInfo) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePartnerIntegrationInfo(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePendingActionsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeRecommendationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Recommendation {
    var list: std.ArrayList(Recommendation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRecommendation(allocator, reader));
                } else {
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

pub fn deserializeRedshiftIdcApplicationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RedshiftIdcApplication {
    var list: std.ArrayList(RedshiftIdcApplication) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRedshiftIdcApplication(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReferenceLinkList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReferenceLink {
    var list: std.ArrayList(ReferenceLink) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReferenceLink(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReservedNodeConfigurationOptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReservedNodeConfigurationOption {
    var list: std.ArrayList(ReservedNodeConfigurationOption) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReservedNodeConfigurationOption(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReservedNodeExchangeStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReservedNodeExchangeStatus {
    var list: std.ArrayList(ReservedNodeExchangeStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReservedNodeExchangeStatus(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReservedNodeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReservedNode {
    var list: std.ArrayList(ReservedNode) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReservedNode(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeReservedNodeOfferingList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ReservedNodeOffering {
    var list: std.ArrayList(ReservedNodeOffering) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeReservedNodeOffering(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRestorableNodeTypeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeRevisionTargetsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RevisionTarget {
    var list: std.ArrayList(RevisionTarget) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRevisionTarget(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeScheduleDefinitionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeScheduledActionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ScheduledAction {
    var list: std.ArrayList(ScheduledAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeScheduledAction(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeScheduledActionTimeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const i64 {
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

pub fn deserializeScheduledSnapshotTimeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const i64 {
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

pub fn deserializeServiceIntegrationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ServiceIntegrationsUnion {
    var list: std.ArrayList(ServiceIntegrationsUnion) = .{};
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

pub fn deserializeSnapshotCopyGrantList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SnapshotCopyGrant {
    var list: std.ArrayList(SnapshotCopyGrant) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSnapshotCopyGrant(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSnapshotIdentifierList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSnapshotScheduleList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SnapshotSchedule {
    var list: std.ArrayList(SnapshotSchedule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSnapshotSchedule(allocator, reader));
                } else {
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

pub fn deserializeSupportedOperationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SupportedOperation {
    var list: std.ArrayList(SupportedOperation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSupportedOperation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSupportedPlatformsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SupportedPlatform {
    var list: std.ArrayList(SupportedPlatform) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSupportedPlatform(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTableRestoreStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TableRestoreStatus {
    var list: std.ArrayList(TableRestoreStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTableRestoreStatus(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTagKeyList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTaggedResourceList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TaggedResource {
    var list: std.ArrayList(TaggedResource) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTaggedResource(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTrackList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MaintenanceTrack {
    var list: std.ArrayList(MaintenanceTrack) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMaintenanceTrack(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeUsageLimits(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const UsageLimit {
    var list: std.ArrayList(UsageLimit) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUsageLimit(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeValueStringList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeVpcEndpointsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const VpcEndpoint {
    var list: std.ArrayList(VpcEndpoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeVpcEndpoint(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeVpcIdentifierList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAccountAttribute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccountAttribute {
    var result: AccountAttribute = undefined;
    result.attribute_name = null;
    result.attribute_values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AttributeName")) {
                    result.attribute_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeValues")) {
                    result.attribute_values = try deserializeAttributeValueList(allocator, reader, "AttributeValueTarget");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAccountWithRestoreAccess(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccountWithRestoreAccess {
    var result: AccountWithRestoreAccess = undefined;
    result.account_alias = null;
    result.account_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountAlias")) {
                    result.account_alias = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAquaConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AquaConfiguration {
    _ = allocator;
    var result: AquaConfiguration = undefined;
    result.aqua_configuration_status = null;
    result.aqua_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AquaConfigurationStatus")) {
                    result.aqua_configuration_status = std.meta.stringToEnum(AquaConfigurationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AquaStatus")) {
                    result.aqua_status = std.meta.stringToEnum(AquaStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAssociation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Association {
    var result: Association = undefined;
    result.certificate_associations = null;
    result.custom_domain_certificate_arn = null;
    result.custom_domain_certificate_expiry_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateAssociations")) {
                    result.certificate_associations = try deserializeCertificateAssociationList(allocator, reader, "CertificateAssociation");
                } else if (std.mem.eql(u8, e.local, "CustomDomainCertificateArn")) {
                    result.custom_domain_certificate_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomDomainCertificateExpiryDate")) {
                    result.custom_domain_certificate_expiry_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAttributeValueTarget(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AttributeValueTarget {
    var result: AttributeValueTarget = undefined;
    result.attribute_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AttributeValue")) {
                    result.attribute_value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAuthenticationProfile(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AuthenticationProfile {
    var result: AuthenticationProfile = undefined;
    result.authentication_profile_content = null;
    result.authentication_profile_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthenticationProfileContent")) {
                    result.authentication_profile_content = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AuthenticationProfileName")) {
                    result.authentication_profile_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAuthorizedTokenIssuer(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AuthorizedTokenIssuer {
    var result: AuthorizedTokenIssuer = undefined;
    result.authorized_audiences_list = null;
    result.trusted_token_issuer_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthorizedAudiencesList")) {
                    result.authorized_audiences_list = try deserializeAuthorizedAudienceList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TrustedTokenIssuerArn")) {
                    result.trusted_token_issuer_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
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
    result.supported_platforms = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedPlatforms")) {
                    result.supported_platforms = try deserializeSupportedPlatformsList(allocator, reader, "SupportedPlatform");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCertificateAssociation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CertificateAssociation {
    var result: CertificateAssociation = undefined;
    result.cluster_identifier = null;
    result.custom_domain_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomDomainName")) {
                    result.custom_domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCluster(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Cluster {
    var result: Cluster = undefined;
    result.allow_version_upgrade = null;
    result.aqua_configuration = null;
    result.automated_snapshot_retention_period = null;
    result.availability_zone = null;
    result.availability_zone_relocation_status = null;
    result.catalog_arn = null;
    result.cluster_availability_status = null;
    result.cluster_create_time = null;
    result.cluster_identifier = null;
    result.cluster_namespace_arn = null;
    result.cluster_nodes = null;
    result.cluster_parameter_groups = null;
    result.cluster_public_key = null;
    result.cluster_revision_number = null;
    result.cluster_security_groups = null;
    result.cluster_snapshot_copy_status = null;
    result.cluster_status = null;
    result.cluster_subnet_group_name = null;
    result.cluster_version = null;
    result.custom_domain_certificate_arn = null;
    result.custom_domain_certificate_expiry_date = null;
    result.custom_domain_name = null;
    result.data_transfer_progress = null;
    result.db_name = null;
    result.default_iam_role_arn = null;
    result.deferred_maintenance_windows = null;
    result.elastic_ip_status = null;
    result.elastic_resize_number_of_node_options = null;
    result.encrypted = null;
    result.endpoint = null;
    result.enhanced_vpc_routing = null;
    result.expected_next_snapshot_schedule_time = null;
    result.expected_next_snapshot_schedule_time_status = null;
    result.extra_compute_for_automatic_optimization = null;
    result.hsm_status = null;
    result.iam_roles = null;
    result.ip_address_type = null;
    result.kms_key_id = null;
    result.lakehouse_registration_status = null;
    result.maintenance_track_name = null;
    result.manual_snapshot_retention_period = null;
    result.master_password_secret_arn = null;
    result.master_password_secret_kms_key_id = null;
    result.master_username = null;
    result.modify_status = null;
    result.multi_az = null;
    result.multi_az_secondary = null;
    result.next_maintenance_window_start_time = null;
    result.node_type = null;
    result.number_of_nodes = null;
    result.pending_actions = null;
    result.pending_modified_values = null;
    result.preferred_maintenance_window = null;
    result.publicly_accessible = null;
    result.reserved_node_exchange_status = null;
    result.resize_info = null;
    result.restore_status = null;
    result.snapshot_schedule_identifier = null;
    result.snapshot_schedule_state = null;
    result.tags = null;
    result.total_storage_capacity_in_mega_bytes = null;
    result.vpc_id = null;
    result.vpc_security_groups = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowVersionUpgrade")) {
                    result.allow_version_upgrade = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AquaConfiguration")) {
                    result.aqua_configuration = try deserializeAquaConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AutomatedSnapshotRetentionPeriod")) {
                    result.automated_snapshot_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AvailabilityZoneRelocationStatus")) {
                    result.availability_zone_relocation_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CatalogArn")) {
                    result.catalog_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterAvailabilityStatus")) {
                    result.cluster_availability_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterNamespaceArn")) {
                    result.cluster_namespace_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterNodes")) {
                    result.cluster_nodes = try deserializeClusterNodesList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ClusterParameterGroups")) {
                    result.cluster_parameter_groups = try deserializeClusterParameterGroupStatusList(allocator, reader, "ClusterParameterGroup");
                } else if (std.mem.eql(u8, e.local, "ClusterPublicKey")) {
                    result.cluster_public_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterRevisionNumber")) {
                    result.cluster_revision_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterSecurityGroups")) {
                    result.cluster_security_groups = try deserializeClusterSecurityGroupMembershipList(allocator, reader, "ClusterSecurityGroup");
                } else if (std.mem.eql(u8, e.local, "ClusterSnapshotCopyStatus")) {
                    result.cluster_snapshot_copy_status = try deserializeClusterSnapshotCopyStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ClusterStatus")) {
                    result.cluster_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterSubnetGroupName")) {
                    result.cluster_subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterVersion")) {
                    result.cluster_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomDomainCertificateArn")) {
                    result.custom_domain_certificate_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomDomainCertificateExpiryDate")) {
                    result.custom_domain_certificate_expiry_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CustomDomainName")) {
                    result.custom_domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataTransferProgress")) {
                    result.data_transfer_progress = try deserializeDataTransferProgress(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DBName")) {
                    result.db_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultIamRoleArn")) {
                    result.default_iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeferredMaintenanceWindows")) {
                    result.deferred_maintenance_windows = try deserializeDeferredMaintenanceWindowsList(allocator, reader, "DeferredMaintenanceWindow");
                } else if (std.mem.eql(u8, e.local, "ElasticIpStatus")) {
                    result.elastic_ip_status = try deserializeElasticIpStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ElasticResizeNumberOfNodeOptions")) {
                    result.elastic_resize_number_of_node_options = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try deserializeEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "EnhancedVpcRouting")) {
                    result.enhanced_vpc_routing = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ExpectedNextSnapshotScheduleTime")) {
                    result.expected_next_snapshot_schedule_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExpectedNextSnapshotScheduleTimeStatus")) {
                    result.expected_next_snapshot_schedule_time_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExtraComputeForAutomaticOptimization")) {
                    result.extra_compute_for_automatic_optimization = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HsmStatus")) {
                    result.hsm_status = try deserializeHsmStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "IamRoles")) {
                    result.iam_roles = try deserializeClusterIamRoleList(allocator, reader, "ClusterIamRole");
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LakehouseRegistrationStatus")) {
                    result.lakehouse_registration_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaintenanceTrackName")) {
                    result.maintenance_track_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ManualSnapshotRetentionPeriod")) {
                    result.manual_snapshot_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MasterPasswordSecretArn")) {
                    result.master_password_secret_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterPasswordSecretKmsKeyId")) {
                    result.master_password_secret_kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModifyStatus")) {
                    result.modify_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZ")) {
                    result.multi_az = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiAZSecondary")) {
                    result.multi_az_secondary = try deserializeSecondaryClusterInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "NextMaintenanceWindowStartTime")) {
                    result.next_maintenance_window_start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeType")) {
                    result.node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfNodes")) {
                    result.number_of_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PendingActions")) {
                    result.pending_actions = try deserializePendingActionsList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PendingModifiedValues")) {
                    result.pending_modified_values = try deserializePendingModifiedValues(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PreferredMaintenanceWindow")) {
                    result.preferred_maintenance_window = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReservedNodeExchangeStatus")) {
                    result.reserved_node_exchange_status = try deserializeReservedNodeExchangeStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ResizeInfo")) {
                    result.resize_info = try deserializeResizeInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RestoreStatus")) {
                    result.restore_status = try deserializeRestoreStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SnapshotScheduleIdentifier")) {
                    result.snapshot_schedule_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotScheduleState")) {
                    result.snapshot_schedule_state = std.meta.stringToEnum(ScheduleState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "TotalStorageCapacityInMegaBytes")) {
                    result.total_storage_capacity_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "VpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroups")) {
                    result.vpc_security_groups = try deserializeVpcSecurityGroupMembershipList(allocator, reader, "VpcSecurityGroup");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterAssociatedToSchedule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterAssociatedToSchedule {
    var result: ClusterAssociatedToSchedule = undefined;
    result.cluster_identifier = null;
    result.schedule_association_state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduleAssociationState")) {
                    result.schedule_association_state = std.meta.stringToEnum(ScheduleState, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterDbRevision(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterDbRevision {
    var result: ClusterDbRevision = undefined;
    result.cluster_identifier = null;
    result.current_database_revision = null;
    result.database_revision_release_date = null;
    result.revision_targets = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CurrentDatabaseRevision")) {
                    result.current_database_revision = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseRevisionReleaseDate")) {
                    result.database_revision_release_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "RevisionTargets")) {
                    result.revision_targets = try deserializeRevisionTargetsList(allocator, reader, "RevisionTarget");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterIamRole(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterIamRole {
    var result: ClusterIamRole = undefined;
    result.apply_status = null;
    result.iam_role_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplyStatus")) {
                    result.apply_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IamRoleArn")) {
                    result.iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterNode(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterNode {
    var result: ClusterNode = undefined;
    result.node_role = null;
    result.private_ip_address = null;
    result.public_ip_address = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NodeRole")) {
                    result.node_role = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PrivateIPAddress")) {
                    result.private_ip_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicIPAddress")) {
                    result.public_ip_address = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterParameterGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterParameterGroup {
    var result: ClusterParameterGroup = undefined;
    result.description = null;
    result.parameter_group_family = null;
    result.parameter_group_name = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterGroupFamily")) {
                    result.parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterGroupName")) {
                    result.parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterParameterGroupStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterParameterGroupStatus {
    var result: ClusterParameterGroupStatus = undefined;
    result.cluster_parameter_status_list = null;
    result.parameter_apply_status = null;
    result.parameter_group_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterParameterStatusList")) {
                    result.cluster_parameter_status_list = try deserializeClusterParameterStatusList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ParameterApplyStatus")) {
                    result.parameter_apply_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterGroupName")) {
                    result.parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterParameterStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterParameterStatus {
    var result: ClusterParameterStatus = undefined;
    result.parameter_apply_error_description = null;
    result.parameter_apply_status = null;
    result.parameter_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ParameterApplyErrorDescription")) {
                    result.parameter_apply_error_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterApplyStatus")) {
                    result.parameter_apply_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterName")) {
                    result.parameter_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterSecurityGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterSecurityGroup {
    var result: ClusterSecurityGroup = undefined;
    result.cluster_security_group_name = null;
    result.description = null;
    result.ec2_security_groups = null;
    result.ip_ranges = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterSecurityGroupName")) {
                    result.cluster_security_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroups")) {
                    result.ec2_security_groups = try deserializeEC2SecurityGroupList(allocator, reader, "EC2SecurityGroup");
                } else if (std.mem.eql(u8, e.local, "IPRanges")) {
                    result.ip_ranges = try deserializeIPRangeList(allocator, reader, "IPRange");
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterSecurityGroupMembership(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterSecurityGroupMembership {
    var result: ClusterSecurityGroupMembership = undefined;
    result.cluster_security_group_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterSecurityGroupName")) {
                    result.cluster_security_group_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeClusterSnapshotCopyStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterSnapshotCopyStatus {
    var result: ClusterSnapshotCopyStatus = undefined;
    result.destination_region = null;
    result.manual_snapshot_retention_period = null;
    result.retention_period = null;
    result.snapshot_copy_grant_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DestinationRegion")) {
                    result.destination_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ManualSnapshotRetentionPeriod")) {
                    result.manual_snapshot_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RetentionPeriod")) {
                    result.retention_period = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotCopyGrantName")) {
                    result.snapshot_copy_grant_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeClusterSubnetGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterSubnetGroup {
    var result: ClusterSubnetGroup = undefined;
    result.cluster_subnet_group_name = null;
    result.description = null;
    result.subnet_group_status = null;
    result.subnets = null;
    result.supported_cluster_ip_address_types = null;
    result.tags = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterSubnetGroupName")) {
                    result.cluster_subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetGroupStatus")) {
                    result.subnet_group_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Subnets")) {
                    result.subnets = try deserializeSubnetList(allocator, reader, "Subnet");
                } else if (std.mem.eql(u8, e.local, "SupportedClusterIpAddressTypes")) {
                    result.supported_cluster_ip_address_types = try deserializeValueStringList(allocator, reader, "item");
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
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

pub fn deserializeClusterVersion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ClusterVersion {
    var result: ClusterVersion = undefined;
    result.cluster_parameter_group_family = null;
    result.cluster_version = null;
    result.description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterParameterGroupFamily")) {
                    result.cluster_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterVersion")) {
                    result.cluster_version = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDataShare(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DataShare {
    var result: DataShare = undefined;
    result.allow_publicly_accessible_consumers = null;
    result.data_share_arn = null;
    result.data_share_associations = null;
    result.data_share_type = null;
    result.managed_by = null;
    result.producer_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowPubliclyAccessibleConsumers")) {
                    result.allow_publicly_accessible_consumers = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DataShareArn")) {
                    result.data_share_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DataShareAssociations")) {
                    result.data_share_associations = try deserializeDataShareAssociationList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "DataShareType")) {
                    result.data_share_type = std.meta.stringToEnum(DataShareType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ManagedBy")) {
                    result.managed_by = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProducerArn")) {
                    result.producer_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDataShareAssociation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DataShareAssociation {
    var result: DataShareAssociation = undefined;
    result.consumer_accepted_writes = null;
    result.consumer_identifier = null;
    result.consumer_region = null;
    result.created_date = null;
    result.producer_allowed_writes = null;
    result.status = null;
    result.status_change_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConsumerAcceptedWrites")) {
                    result.consumer_accepted_writes = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ConsumerIdentifier")) {
                    result.consumer_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConsumerRegion")) {
                    result.consumer_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedDate")) {
                    result.created_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ProducerAllowedWrites")) {
                    result.producer_allowed_writes = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(DataShareStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusChangeDate")) {
                    result.status_change_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDataTransferProgress(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DataTransferProgress {
    var result: DataTransferProgress = undefined;
    result.current_rate_in_mega_bytes_per_second = null;
    result.data_transferred_in_mega_bytes = null;
    result.elapsed_time_in_seconds = null;
    result.estimated_time_to_completion_in_seconds = null;
    result.status = null;
    result.total_data_in_mega_bytes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CurrentRateInMegaBytesPerSecond")) {
                    result.current_rate_in_mega_bytes_per_second = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DataTransferredInMegaBytes")) {
                    result.data_transferred_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ElapsedTimeInSeconds")) {
                    result.elapsed_time_in_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "EstimatedTimeToCompletionInSeconds")) {
                    result.estimated_time_to_completion_in_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TotalDataInMegaBytes")) {
                    result.total_data_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDefaultClusterParameters(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DefaultClusterParameters {
    var result: DefaultClusterParameters = undefined;
    result.marker = null;
    result.parameter_group_family = null;
    result.parameters = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterGroupFamily")) {
                    result.parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDeferredMaintenanceWindow(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DeferredMaintenanceWindow {
    var result: DeferredMaintenanceWindow = undefined;
    result.defer_maintenance_end_time = null;
    result.defer_maintenance_identifier = null;
    result.defer_maintenance_start_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeferMaintenanceEndTime")) {
                    result.defer_maintenance_end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DeferMaintenanceIdentifier")) {
                    result.defer_maintenance_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeferMaintenanceStartTime")) {
                    result.defer_maintenance_start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
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
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EC2SecurityGroupName")) {
                    result.ec2_security_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EC2SecurityGroupOwnerId")) {
                    result.ec2_security_group_owner_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeElasticIpStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ElasticIpStatus {
    var result: ElasticIpStatus = undefined;
    result.elastic_ip = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ElasticIp")) {
                    result.elastic_ip = try allocator.dupe(u8, try reader.readElementText());
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
    result.port = null;
    result.vpc_endpoints = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Address")) {
                    result.address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "VpcEndpoints")) {
                    result.vpc_endpoints = try deserializeVpcEndpointsList(allocator, reader, "VpcEndpoint");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEndpointAccess(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EndpointAccess {
    var result: EndpointAccess = undefined;
    result.address = null;
    result.cluster_identifier = null;
    result.endpoint_create_time = null;
    result.endpoint_name = null;
    result.endpoint_status = null;
    result.port = null;
    result.resource_owner = null;
    result.subnet_group_name = null;
    result.vpc_endpoint = null;
    result.vpc_security_groups = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Address")) {
                    result.address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointCreateTime")) {
                    result.endpoint_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EndpointName")) {
                    result.endpoint_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointStatus")) {
                    result.endpoint_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourceOwner")) {
                    result.resource_owner = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetGroupName")) {
                    result.subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcEndpoint")) {
                    result.vpc_endpoint = try deserializeVpcEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroups")) {
                    result.vpc_security_groups = try deserializeVpcSecurityGroupMembershipList(allocator, reader, "VpcSecurityGroup");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEndpointAuthorization(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EndpointAuthorization {
    var result: EndpointAuthorization = undefined;
    result.allowed_all_vp_cs = null;
    result.allowed_vp_cs = null;
    result.authorize_time = null;
    result.cluster_identifier = null;
    result.cluster_status = null;
    result.endpoint_count = null;
    result.grantee = null;
    result.grantor = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedAllVPCs")) {
                    result.allowed_all_vp_cs = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AllowedVPCs")) {
                    result.allowed_vp_cs = try deserializeVpcIdentifierList(allocator, reader, "VpcIdentifier");
                } else if (std.mem.eql(u8, e.local, "AuthorizeTime")) {
                    result.authorize_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterStatus")) {
                    result.cluster_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointCount")) {
                    result.endpoint_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Grantor")) {
                    result.grantor = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(AuthorizationStatus, try reader.readElementText());
                } else {
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
    result.event_id = null;
    result.message = null;
    result.severity = null;
    result.source_identifier = null;
    result.source_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Date")) {
                    result.date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EventCategories")) {
                    result.event_categories = try deserializeEventCategoriesList(allocator, reader, "EventCategory");
                } else if (std.mem.eql(u8, e.local, "EventId")) {
                    result.event_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Severity")) {
                    result.severity = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceIdentifier")) {
                    result.source_identifier = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeEventCategoriesMap(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EventCategoriesMap {
    var result: EventCategoriesMap = undefined;
    result.events = null;
    result.source_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Events")) {
                    result.events = try deserializeEventInfoMapList(allocator, reader, "EventInfoMap");
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

pub fn deserializeEventInfoMap(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EventInfoMap {
    var result: EventInfoMap = undefined;
    result.event_categories = null;
    result.event_description = null;
    result.event_id = null;
    result.severity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventCategories")) {
                    result.event_categories = try deserializeEventCategoriesList(allocator, reader, "EventCategory");
                } else if (std.mem.eql(u8, e.local, "EventDescription")) {
                    result.event_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EventId")) {
                    result.event_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Severity")) {
                    result.severity = try allocator.dupe(u8, try reader.readElementText());
                } else {
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
    result.severity = null;
    result.sns_topic_arn = null;
    result.source_ids_list = null;
    result.source_type = null;
    result.status = null;
    result.subscription_creation_time = null;
    result.tags = null;
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
                } else if (std.mem.eql(u8, e.local, "Severity")) {
                    result.severity = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnsTopicArn")) {
                    result.sns_topic_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceIdsList")) {
                    result.source_ids_list = try deserializeSourceIdsList(allocator, reader, "SourceId");
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubscriptionCreationTime")) {
                    result.subscription_creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHsmClientCertificate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HsmClientCertificate {
    var result: HsmClientCertificate = undefined;
    result.hsm_client_certificate_identifier = null;
    result.hsm_client_certificate_public_key = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HsmClientCertificateIdentifier")) {
                    result.hsm_client_certificate_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HsmClientCertificatePublicKey")) {
                    result.hsm_client_certificate_public_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHsmConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HsmConfiguration {
    var result: HsmConfiguration = undefined;
    result.description = null;
    result.hsm_configuration_identifier = null;
    result.hsm_ip_address = null;
    result.hsm_partition_name = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HsmConfigurationIdentifier")) {
                    result.hsm_configuration_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HsmIpAddress")) {
                    result.hsm_ip_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HsmPartitionName")) {
                    result.hsm_partition_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHsmStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HsmStatus {
    var result: HsmStatus = undefined;
    result.hsm_client_certificate_identifier = null;
    result.hsm_configuration_identifier = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HsmClientCertificateIdentifier")) {
                    result.hsm_client_certificate_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HsmConfigurationIdentifier")) {
                    result.hsm_configuration_identifier = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeIPRange(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IPRange {
    var result: IPRange = undefined;
    result.cidrip = null;
    result.status = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CIDRIP")) {
                    result.cidrip = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInboundIntegration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InboundIntegration {
    var result: InboundIntegration = undefined;
    result.create_time = null;
    result.errors = null;
    result.integration_arn = null;
    result.source_arn = null;
    result.status = null;
    result.target_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Errors")) {
                    result.errors = try deserializeIntegrationErrorList(allocator, reader, "IntegrationError");
                } else if (std.mem.eql(u8, e.local, "IntegrationArn")) {
                    result.integration_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceArn")) {
                    result.source_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ZeroETLIntegrationStatus, try reader.readElementText());
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

pub fn deserializeIntegration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Integration {
    var result: Integration = undefined;
    result.additional_encryption_context = null;
    result.create_time = null;
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
                    result.status = std.meta.stringToEnum(ZeroETLIntegrationStatus, try reader.readElementText());
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

pub fn deserializeMaintenanceTrack(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MaintenanceTrack {
    var result: MaintenanceTrack = undefined;
    result.database_version = null;
    result.maintenance_track_name = null;
    result.update_targets = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DatabaseVersion")) {
                    result.database_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaintenanceTrackName")) {
                    result.maintenance_track_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdateTargets")) {
                    result.update_targets = try deserializeEligibleTracksToUpdateList(allocator, reader, "UpdateTarget");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeNetworkInterface(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NetworkInterface {
    var result: NetworkInterface = undefined;
    result.availability_zone = null;
    result.ipv_6_address = null;
    result.network_interface_id = null;
    result.private_ip_address = null;
    result.subnet_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Ipv6Address")) {
                    result.ipv_6_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NetworkInterfaceId")) {
                    result.network_interface_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PrivateIpAddress")) {
                    result.private_ip_address = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeNodeConfigurationOption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !NodeConfigurationOption {
    var result: NodeConfigurationOption = undefined;
    result.estimated_disk_utilization_percent = null;
    result.mode = null;
    result.node_type = null;
    result.number_of_nodes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EstimatedDiskUtilizationPercent")) {
                    result.estimated_disk_utilization_percent = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = std.meta.stringToEnum(Mode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeType")) {
                    result.node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfNodes")) {
                    result.number_of_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOrderableClusterOption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OrderableClusterOption {
    var result: OrderableClusterOption = undefined;
    result.availability_zones = null;
    result.cluster_type = null;
    result.cluster_version = null;
    result.node_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZoneList(allocator, reader, "AvailabilityZone");
                } else if (std.mem.eql(u8, e.local, "ClusterType")) {
                    result.cluster_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterVersion")) {
                    result.cluster_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeType")) {
                    result.node_type = try allocator.dupe(u8, try reader.readElementText());
                } else {
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
                } else if (std.mem.eql(u8, e.local, "ApplyType")) {
                    result.apply_type = std.meta.stringToEnum(ParameterApplyType, try reader.readElementText());
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

pub fn deserializePartnerIntegrationInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PartnerIntegrationInfo {
    var result: PartnerIntegrationInfo = undefined;
    result.created_at = null;
    result.database_name = null;
    result.partner_name = null;
    result.status = null;
    result.status_message = null;
    result.updated_at = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DatabaseName")) {
                    result.database_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PartnerName")) {
                    result.partner_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(PartnerIntegrationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusMessage")) {
                    result.status_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdatedAt")) {
                    result.updated_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePauseClusterMessage(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PauseClusterMessage {
    var result: PauseClusterMessage = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else {
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
    result.automated_snapshot_retention_period = null;
    result.cluster_identifier = null;
    result.cluster_type = null;
    result.cluster_version = null;
    result.encryption_type = null;
    result.enhanced_vpc_routing = null;
    result.maintenance_track_name = null;
    result.master_user_password = null;
    result.node_type = null;
    result.number_of_nodes = null;
    result.publicly_accessible = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutomatedSnapshotRetentionPeriod")) {
                    result.automated_snapshot_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterType")) {
                    result.cluster_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterVersion")) {
                    result.cluster_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncryptionType")) {
                    result.encryption_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnhancedVpcRouting")) {
                    result.enhanced_vpc_routing = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaintenanceTrackName")) {
                    result.maintenance_track_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUserPassword")) {
                    result.master_user_password = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeType")) {
                    result.node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfNodes")) {
                    result.number_of_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PubliclyAccessible")) {
                    result.publicly_accessible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRecommendation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Recommendation {
    var result: Recommendation = undefined;
    result.cluster_identifier = null;
    result.created_at = null;
    result.description = null;
    result.id = null;
    result.impact_ranking = null;
    result.namespace_arn = null;
    result.observation = null;
    result.recommendation_text = null;
    result.recommendation_type = null;
    result.recommended_actions = null;
    result.reference_links = null;
    result.title = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImpactRanking")) {
                    result.impact_ranking = std.meta.stringToEnum(ImpactRankingType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NamespaceArn")) {
                    result.namespace_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Observation")) {
                    result.observation = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecommendationText")) {
                    result.recommendation_text = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecommendationType")) {
                    result.recommendation_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecommendedActions")) {
                    result.recommended_actions = try deserializeRecommendedActionList(allocator, reader, "RecommendedAction");
                } else if (std.mem.eql(u8, e.local, "ReferenceLinks")) {
                    result.reference_links = try deserializeReferenceLinkList(allocator, reader, "ReferenceLink");
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

pub fn deserializeRecommendedAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RecommendedAction {
    var result: RecommendedAction = undefined;
    result.command = null;
    result.database = null;
    result.text = null;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Command")) {
                    result.command = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Database")) {
                    result.database = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Text")) {
                    result.text = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(RecommendedActionType, try reader.readElementText());
                } else {
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

pub fn deserializeRedshiftIdcApplication(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RedshiftIdcApplication {
    var result: RedshiftIdcApplication = undefined;
    result.application_type = null;
    result.authorized_token_issuer_list = null;
    result.iam_role_arn = null;
    result.idc_display_name = null;
    result.idc_instance_arn = null;
    result.idc_managed_application_arn = null;
    result.idc_onboard_status = null;
    result.identity_namespace = null;
    result.redshift_idc_application_arn = null;
    result.redshift_idc_application_name = null;
    result.service_integrations = null;
    result.sso_tag_keys = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationType")) {
                    result.application_type = std.meta.stringToEnum(ApplicationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AuthorizedTokenIssuerList")) {
                    result.authorized_token_issuer_list = try deserializeAuthorizedTokenIssuerList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "IamRoleArn")) {
                    result.iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdcDisplayName")) {
                    result.idc_display_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdcInstanceArn")) {
                    result.idc_instance_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdcManagedApplicationArn")) {
                    result.idc_managed_application_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdcOnboardStatus")) {
                    result.idc_onboard_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdentityNamespace")) {
                    result.identity_namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RedshiftIdcApplicationArn")) {
                    result.redshift_idc_application_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RedshiftIdcApplicationName")) {
                    result.redshift_idc_application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceIntegrations")) {
                    result.service_integrations = try deserializeServiceIntegrationList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SsoTagKeys")) {
                    result.sso_tag_keys = try deserializeTagKeyList(allocator, reader, "TagKey");
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReferenceLink(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReferenceLink {
    var result: ReferenceLink = undefined;
    result.link = null;
    result.text = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Link")) {
                    result.link = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Text")) {
                    result.text = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReservedNode(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReservedNode {
    var result: ReservedNode = undefined;
    result.currency_code = null;
    result.duration = null;
    result.fixed_price = null;
    result.node_count = null;
    result.node_type = null;
    result.offering_type = null;
    result.recurring_charges = null;
    result.reserved_node_id = null;
    result.reserved_node_offering_id = null;
    result.reserved_node_offering_type = null;
    result.start_time = null;
    result.state = null;
    result.usage_price = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CurrencyCode")) {
                    result.currency_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeCount")) {
                    result.node_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeType")) {
                    result.node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(allocator, reader, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservedNodeId")) {
                    result.reserved_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedNodeOfferingId")) {
                    result.reserved_node_offering_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedNodeOfferingType")) {
                    result.reserved_node_offering_type = std.meta.stringToEnum(ReservedNodeOfferingType, try reader.readElementText());
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

pub fn deserializeReservedNodeConfigurationOption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReservedNodeConfigurationOption {
    var result: ReservedNodeConfigurationOption = undefined;
    result.source_reserved_node = null;
    result.target_reserved_node_count = null;
    result.target_reserved_node_offering = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SourceReservedNode")) {
                    result.source_reserved_node = try deserializeReservedNode(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TargetReservedNodeCount")) {
                    result.target_reserved_node_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TargetReservedNodeOffering")) {
                    result.target_reserved_node_offering = try deserializeReservedNodeOffering(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReservedNodeExchangeStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReservedNodeExchangeStatus {
    var result: ReservedNodeExchangeStatus = undefined;
    result.request_time = null;
    result.reserved_node_exchange_request_id = null;
    result.source_reserved_node_count = null;
    result.source_reserved_node_id = null;
    result.source_reserved_node_type = null;
    result.status = null;
    result.target_reserved_node_count = null;
    result.target_reserved_node_offering_id = null;
    result.target_reserved_node_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RequestTime")) {
                    result.request_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ReservedNodeExchangeRequestId")) {
                    result.reserved_node_exchange_request_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceReservedNodeCount")) {
                    result.source_reserved_node_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SourceReservedNodeId")) {
                    result.source_reserved_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceReservedNodeType")) {
                    result.source_reserved_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ReservedNodeExchangeStatusType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetReservedNodeCount")) {
                    result.target_reserved_node_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TargetReservedNodeOfferingId")) {
                    result.target_reserved_node_offering_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetReservedNodeType")) {
                    result.target_reserved_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReservedNodeOffering(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReservedNodeOffering {
    var result: ReservedNodeOffering = undefined;
    result.currency_code = null;
    result.duration = null;
    result.fixed_price = null;
    result.node_type = null;
    result.offering_type = null;
    result.recurring_charges = null;
    result.reserved_node_offering_id = null;
    result.reserved_node_offering_type = null;
    result.usage_price = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CurrencyCode")) {
                    result.currency_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FixedPrice")) {
                    result.fixed_price = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NodeType")) {
                    result.node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OfferingType")) {
                    result.offering_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RecurringCharges")) {
                    result.recurring_charges = try deserializeRecurringChargeList(allocator, reader, "RecurringCharge");
                } else if (std.mem.eql(u8, e.local, "ReservedNodeOfferingId")) {
                    result.reserved_node_offering_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedNodeOfferingType")) {
                    result.reserved_node_offering_type = std.meta.stringToEnum(ReservedNodeOfferingType, try reader.readElementText());
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

pub fn deserializeResizeClusterMessage(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResizeClusterMessage {
    var result: ResizeClusterMessage = undefined;
    result.classic = null;
    result.cluster_type = null;
    result.node_type = null;
    result.number_of_nodes = null;
    result.reserved_node_id = null;
    result.target_reserved_node_offering_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Classic")) {
                    result.classic = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterType")) {
                    result.cluster_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeType")) {
                    result.node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfNodes")) {
                    result.number_of_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ReservedNodeId")) {
                    result.reserved_node_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetReservedNodeOfferingId")) {
                    result.target_reserved_node_offering_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResizeInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResizeInfo {
    var result: ResizeInfo = undefined;
    result.allow_cancel_resize = null;
    result.resize_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowCancelResize")) {
                    result.allow_cancel_resize = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ResizeType")) {
                    result.resize_type = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResourcePolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourcePolicy {
    var result: ResourcePolicy = undefined;
    result.policy = null;
    result.resource_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceArn")) {
                    result.resource_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRestoreStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RestoreStatus {
    var result: RestoreStatus = undefined;
    result.current_restore_rate_in_mega_bytes_per_second = null;
    result.elapsed_time_in_seconds = null;
    result.estimated_time_to_completion_in_seconds = null;
    result.progress_in_mega_bytes = null;
    result.snapshot_size_in_mega_bytes = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CurrentRestoreRateInMegaBytesPerSecond")) {
                    result.current_restore_rate_in_mega_bytes_per_second = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ElapsedTimeInSeconds")) {
                    result.elapsed_time_in_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "EstimatedTimeToCompletionInSeconds")) {
                    result.estimated_time_to_completion_in_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ProgressInMegaBytes")) {
                    result.progress_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotSizeInMegaBytes")) {
                    result.snapshot_size_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeResumeClusterMessage(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResumeClusterMessage {
    var result: ResumeClusterMessage = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRevisionTarget(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RevisionTarget {
    var result: RevisionTarget = undefined;
    result.database_revision = null;
    result.database_revision_release_date = null;
    result.description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DatabaseRevision")) {
                    result.database_revision = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseRevisionReleaseDate")) {
                    result.database_revision_release_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeScheduledAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScheduledAction {
    var result: ScheduledAction = undefined;
    result.end_time = null;
    result.iam_role = null;
    result.next_invocations = null;
    result.schedule = null;
    result.scheduled_action_description = null;
    result.scheduled_action_name = null;
    result.start_time = null;
    result.state = null;
    result.target_action = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IamRole")) {
                    result.iam_role = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextInvocations")) {
                    result.next_invocations = try deserializeScheduledActionTimeList(allocator, reader, "ScheduledActionTime");
                } else if (std.mem.eql(u8, e.local, "Schedule")) {
                    result.schedule = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionDescription")) {
                    result.scheduled_action_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActionName")) {
                    result.scheduled_action_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = std.meta.stringToEnum(ScheduledActionState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetAction")) {
                    result.target_action = try deserializeScheduledActionType(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeScheduledActionType(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScheduledActionType {
    var result: ScheduledActionType = undefined;
    result.pause_cluster = null;
    result.resize_cluster = null;
    result.resume_cluster = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PauseCluster")) {
                    result.pause_cluster = try deserializePauseClusterMessage(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ResizeCluster")) {
                    result.resize_cluster = try deserializeResizeClusterMessage(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ResumeCluster")) {
                    result.resume_cluster = try deserializeResumeClusterMessage(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSecondaryClusterInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SecondaryClusterInfo {
    var result: SecondaryClusterInfo = undefined;
    result.availability_zone = null;
    result.cluster_nodes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterNodes")) {
                    result.cluster_nodes = try deserializeClusterNodesList(allocator, reader, "member");
                } else {
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
    result.accounts_with_restore_access = null;
    result.actual_incremental_backup_size_in_mega_bytes = null;
    result.availability_zone = null;
    result.backup_progress_in_mega_bytes = null;
    result.cluster_create_time = null;
    result.cluster_identifier = null;
    result.cluster_version = null;
    result.current_backup_rate_in_mega_bytes_per_second = null;
    result.db_name = null;
    result.elapsed_time_in_seconds = null;
    result.encrypted = null;
    result.encrypted_with_hsm = null;
    result.engine_full_version = null;
    result.enhanced_vpc_routing = null;
    result.estimated_seconds_to_completion = null;
    result.kms_key_id = null;
    result.maintenance_track_name = null;
    result.manual_snapshot_remaining_days = null;
    result.manual_snapshot_retention_period = null;
    result.master_password_secret_arn = null;
    result.master_password_secret_kms_key_id = null;
    result.master_username = null;
    result.node_type = null;
    result.number_of_nodes = null;
    result.owner_account = null;
    result.port = null;
    result.restorable_node_types = null;
    result.snapshot_arn = null;
    result.snapshot_create_time = null;
    result.snapshot_identifier = null;
    result.snapshot_retention_start_time = null;
    result.snapshot_type = null;
    result.source_region = null;
    result.status = null;
    result.tags = null;
    result.total_backup_size_in_mega_bytes = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountsWithRestoreAccess")) {
                    result.accounts_with_restore_access = try deserializeAccountsWithRestoreAccessList(allocator, reader, "AccountWithRestoreAccess");
                } else if (std.mem.eql(u8, e.local, "ActualIncrementalBackupSizeInMegaBytes")) {
                    result.actual_incremental_backup_size_in_mega_bytes = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BackupProgressInMegaBytes")) {
                    result.backup_progress_in_mega_bytes = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterCreateTime")) {
                    result.cluster_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterVersion")) {
                    result.cluster_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CurrentBackupRateInMegaBytesPerSecond")) {
                    result.current_backup_rate_in_mega_bytes_per_second = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DBName")) {
                    result.db_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ElapsedTimeInSeconds")) {
                    result.elapsed_time_in_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EncryptedWithHSM")) {
                    result.encrypted_with_hsm = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EngineFullVersion")) {
                    result.engine_full_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnhancedVpcRouting")) {
                    result.enhanced_vpc_routing = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EstimatedSecondsToCompletion")) {
                    result.estimated_seconds_to_completion = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaintenanceTrackName")) {
                    result.maintenance_track_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ManualSnapshotRemainingDays")) {
                    result.manual_snapshot_remaining_days = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ManualSnapshotRetentionPeriod")) {
                    result.manual_snapshot_retention_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MasterPasswordSecretArn")) {
                    result.master_password_secret_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterPasswordSecretKmsKeyId")) {
                    result.master_password_secret_kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MasterUsername")) {
                    result.master_username = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NodeType")) {
                    result.node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfNodes")) {
                    result.number_of_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OwnerAccount")) {
                    result.owner_account = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RestorableNodeTypes")) {
                    result.restorable_node_types = try deserializeRestorableNodeTypeList(allocator, reader, "NodeType");
                } else if (std.mem.eql(u8, e.local, "SnapshotArn")) {
                    result.snapshot_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotCreateTime")) {
                    result.snapshot_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotIdentifier")) {
                    result.snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotRetentionStartTime")) {
                    result.snapshot_retention_start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotType")) {
                    result.snapshot_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceRegion")) {
                    result.source_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "TotalBackupSizeInMegaBytes")) {
                    result.total_backup_size_in_mega_bytes = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
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

pub fn deserializeSnapshotCopyGrant(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SnapshotCopyGrant {
    var result: SnapshotCopyGrant = undefined;
    result.kms_key_id = null;
    result.snapshot_copy_grant_name = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotCopyGrantName")) {
                    result.snapshot_copy_grant_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSnapshotErrorMessage(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SnapshotErrorMessage {
    var result: SnapshotErrorMessage = undefined;
    result.failure_code = null;
    result.failure_reason = null;
    result.snapshot_cluster_identifier = null;
    result.snapshot_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailureCode")) {
                    result.failure_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureReason")) {
                    result.failure_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotClusterIdentifier")) {
                    result.snapshot_cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotIdentifier")) {
                    result.snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSnapshotSchedule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SnapshotSchedule {
    var result: SnapshotSchedule = undefined;
    result.associated_cluster_count = null;
    result.associated_clusters = null;
    result.next_invocations = null;
    result.schedule_definitions = null;
    result.schedule_description = null;
    result.schedule_identifier = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssociatedClusterCount")) {
                    result.associated_cluster_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AssociatedClusters")) {
                    result.associated_clusters = try deserializeAssociatedClusterList(allocator, reader, "ClusterAssociatedToSchedule");
                } else if (std.mem.eql(u8, e.local, "NextInvocations")) {
                    result.next_invocations = try deserializeScheduledSnapshotTimeList(allocator, reader, "SnapshotTime");
                } else if (std.mem.eql(u8, e.local, "ScheduleDefinitions")) {
                    result.schedule_definitions = try deserializeScheduleDefinitionList(allocator, reader, "ScheduleDefinition");
                } else if (std.mem.eql(u8, e.local, "ScheduleDescription")) {
                    result.schedule_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduleIdentifier")) {
                    result.schedule_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else {
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

pub fn deserializeSupportedOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SupportedOperation {
    var result: SupportedOperation = undefined;
    result.operation_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OperationName")) {
                    result.operation_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSupportedPlatform(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SupportedPlatform {
    var result: SupportedPlatform = undefined;
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

pub fn deserializeTableRestoreStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TableRestoreStatus {
    var result: TableRestoreStatus = undefined;
    result.cluster_identifier = null;
    result.message = null;
    result.new_table_name = null;
    result.progress_in_mega_bytes = null;
    result.request_time = null;
    result.snapshot_identifier = null;
    result.source_database_name = null;
    result.source_schema_name = null;
    result.source_table_name = null;
    result.status = null;
    result.table_restore_request_id = null;
    result.target_database_name = null;
    result.target_schema_name = null;
    result.total_data_in_mega_bytes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NewTableName")) {
                    result.new_table_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProgressInMegaBytes")) {
                    result.progress_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RequestTime")) {
                    result.request_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SnapshotIdentifier")) {
                    result.snapshot_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceDatabaseName")) {
                    result.source_database_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceSchemaName")) {
                    result.source_schema_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceTableName")) {
                    result.source_table_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(TableRestoreStatusType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TableRestoreRequestId")) {
                    result.table_restore_request_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetDatabaseName")) {
                    result.target_database_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetSchemaName")) {
                    result.target_schema_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TotalDataInMegaBytes")) {
                    result.total_data_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
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

pub fn deserializeTaggedResource(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TaggedResource {
    var result: TaggedResource = undefined;
    result.resource_name = null;
    result.resource_type = null;
    result.tag = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceName")) {
                    result.resource_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tag")) {
                    result.tag = try deserializeTag(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUpdateTarget(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UpdateTarget {
    var result: UpdateTarget = undefined;
    result.database_version = null;
    result.maintenance_track_name = null;
    result.supported_operations = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DatabaseVersion")) {
                    result.database_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaintenanceTrackName")) {
                    result.maintenance_track_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedOperations")) {
                    result.supported_operations = try deserializeSupportedOperationList(allocator, reader, "SupportedOperation");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUsageLimit(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UsageLimit {
    var result: UsageLimit = undefined;
    result.amount = null;
    result.breach_action = null;
    result.cluster_identifier = null;
    result.feature_type = null;
    result.limit_type = null;
    result.period = null;
    result.tags = null;
    result.usage_limit_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Amount")) {
                    result.amount = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "BreachAction")) {
                    result.breach_action = std.meta.stringToEnum(UsageLimitBreachAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FeatureType")) {
                    result.feature_type = std.meta.stringToEnum(UsageLimitFeatureType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LimitType")) {
                    result.limit_type = std.meta.stringToEnum(UsageLimitLimitType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.meta.stringToEnum(UsageLimitPeriod, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "UsageLimitId")) {
                    result.usage_limit_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVpcEndpoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VpcEndpoint {
    var result: VpcEndpoint = undefined;
    result.network_interfaces = null;
    result.vpc_endpoint_id = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NetworkInterfaces")) {
                    result.network_interfaces = try deserializeNetworkInterfaceList(allocator, reader, "NetworkInterface");
                } else if (std.mem.eql(u8, e.local, "VpcEndpointId")) {
                    result.vpc_endpoint_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn serializeAttributeNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAuthorizedAudienceList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAuthorizedTokenIssuerList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AuthorizedTokenIssuer, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeAuthorizedTokenIssuer(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeClusterIdentifierList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeClusterSecurityGroupNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeConsumerIdentifierList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeDbGroupList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeDeleteClusterSnapshotMessageList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const DeleteClusterSnapshotMessage, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeDeleteClusterSnapshotMessage(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeDescribeIntegrationsFilterList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const DescribeIntegrationsFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeDescribeIntegrationsFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeDescribeIntegrationsFilterValueList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeIamRoleArnList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeNodeConfigurationOptionsFilterList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const NodeConfigurationOptionsFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeNodeConfigurationOptionsFilter(allocator, buf, item);
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

pub fn serializeScheduleDefinitionList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeScheduledActionFilterList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ScheduledActionFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeScheduledActionFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeServiceIntegrationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ServiceIntegrationsUnion, comptime item_tag: []const u8) !void {
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

pub fn serializeSnapshotIdentifierList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSnapshotSortingEntityList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const SnapshotSortingEntity, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeSnapshotSortingEntity(allocator, buf, item);
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

pub fn serializeTagValueList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeValueStringList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeVpcIdentifierList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAuthorizedTokenIssuer(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AuthorizedTokenIssuer) !void {
    if (value.authorized_audiences_list) |v| {
        try buf.appendSlice(allocator, "<AuthorizedAudiencesList>");
        try serializeAuthorizedAudienceList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</AuthorizedAudiencesList>");
    }
    if (value.trusted_token_issuer_arn) |v| {
        try buf.appendSlice(allocator, "<TrustedTokenIssuerArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TrustedTokenIssuerArn>");
    }
}

pub fn serializeDeleteClusterSnapshotMessage(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeleteClusterSnapshotMessage) !void {
    if (value.snapshot_cluster_identifier) |v| {
        try buf.appendSlice(allocator, "<SnapshotClusterIdentifier>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SnapshotClusterIdentifier>");
    }
    try buf.appendSlice(allocator, "<SnapshotIdentifier>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.snapshot_identifier);
    try buf.appendSlice(allocator, "</SnapshotIdentifier>");
}

pub fn serializeDescribeIntegrationsFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DescribeIntegrationsFilter) !void {
    try buf.appendSlice(allocator, "<Name>");
    try buf.appendSlice(allocator, @tagName(value.name));
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Values>");
    try serializeDescribeIntegrationsFilterValueList(allocator, buf, value.values, "Value");
    try buf.appendSlice(allocator, "</Values>");
}

pub fn serializeNodeConfigurationOptionsFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: NodeConfigurationOptionsFilter) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.operator) |v| {
        try buf.appendSlice(allocator, "<Operator>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</Operator>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try serializeValueStringList(allocator, buf, v, "item");
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeParameter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Parameter) !void {
    if (value.allowed_values) |v| {
        try buf.appendSlice(allocator, "<AllowedValues>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AllowedValues>");
    }
    if (value.apply_type) |v| {
        try buf.appendSlice(allocator, "<ApplyType>");
        try buf.appendSlice(allocator, @tagName(v));
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

pub fn serializePauseClusterMessage(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PauseClusterMessage) !void {
    try buf.appendSlice(allocator, "<ClusterIdentifier>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.cluster_identifier);
    try buf.appendSlice(allocator, "</ClusterIdentifier>");
}

pub fn serializeResizeClusterMessage(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResizeClusterMessage) !void {
    if (value.classic) |v| {
        try buf.appendSlice(allocator, "<Classic>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Classic>");
    }
    try buf.appendSlice(allocator, "<ClusterIdentifier>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.cluster_identifier);
    try buf.appendSlice(allocator, "</ClusterIdentifier>");
    if (value.cluster_type) |v| {
        try buf.appendSlice(allocator, "<ClusterType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ClusterType>");
    }
    if (value.node_type) |v| {
        try buf.appendSlice(allocator, "<NodeType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</NodeType>");
    }
    if (value.number_of_nodes) |v| {
        try buf.appendSlice(allocator, "<NumberOfNodes>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</NumberOfNodes>");
    }
    if (value.reserved_node_id) |v| {
        try buf.appendSlice(allocator, "<ReservedNodeId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReservedNodeId>");
    }
    if (value.target_reserved_node_offering_id) |v| {
        try buf.appendSlice(allocator, "<TargetReservedNodeOfferingId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TargetReservedNodeOfferingId>");
    }
}

pub fn serializeResumeClusterMessage(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResumeClusterMessage) !void {
    try buf.appendSlice(allocator, "<ClusterIdentifier>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.cluster_identifier);
    try buf.appendSlice(allocator, "</ClusterIdentifier>");
}

pub fn serializeScheduledActionFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScheduledActionFilter) !void {
    try buf.appendSlice(allocator, "<Name>");
    try buf.appendSlice(allocator, @tagName(value.name));
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Values>");
    try serializeValueStringList(allocator, buf, value.values, "item");
    try buf.appendSlice(allocator, "</Values>");
}

pub fn serializeScheduledActionType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScheduledActionType) !void {
    if (value.pause_cluster) |v| {
        try buf.appendSlice(allocator, "<PauseCluster>");
        try serializePauseClusterMessage(allocator, buf, v);
        try buf.appendSlice(allocator, "</PauseCluster>");
    }
    if (value.resize_cluster) |v| {
        try buf.appendSlice(allocator, "<ResizeCluster>");
        try serializeResizeClusterMessage(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResizeCluster>");
    }
    if (value.resume_cluster) |v| {
        try buf.appendSlice(allocator, "<ResumeCluster>");
        try serializeResumeClusterMessage(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResumeCluster>");
    }
}

pub fn serializeSnapshotSortingEntity(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SnapshotSortingEntity) !void {
    try buf.appendSlice(allocator, "<Attribute>");
    try buf.appendSlice(allocator, @tagName(value.attribute));
    try buf.appendSlice(allocator, "</Attribute>");
    if (value.sort_order) |v| {
        try buf.appendSlice(allocator, "<SortOrder>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</SortOrder>");
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

