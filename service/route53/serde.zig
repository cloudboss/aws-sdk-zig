const aws = @import("aws");
const std = @import("std");

const AcceleratedRecoveryStatus = @import("accelerated_recovery_status.zig").AcceleratedRecoveryStatus;
const AccountLimit = @import("account_limit.zig").AccountLimit;
const AccountLimitType = @import("account_limit_type.zig").AccountLimitType;
const AlarmIdentifier = @import("alarm_identifier.zig").AlarmIdentifier;
const AliasTarget = @import("alias_target.zig").AliasTarget;
const Change = @import("change.zig").Change;
const ChangeAction = @import("change_action.zig").ChangeAction;
const ChangeBatch = @import("change_batch.zig").ChangeBatch;
const ChangeInfo = @import("change_info.zig").ChangeInfo;
const ChangeStatus = @import("change_status.zig").ChangeStatus;
const CidrBlockSummary = @import("cidr_block_summary.zig").CidrBlockSummary;
const CidrCollection = @import("cidr_collection.zig").CidrCollection;
const CidrCollectionChange = @import("cidr_collection_change.zig").CidrCollectionChange;
const CidrCollectionChangeAction = @import("cidr_collection_change_action.zig").CidrCollectionChangeAction;
const CidrRoutingConfig = @import("cidr_routing_config.zig").CidrRoutingConfig;
const CloudWatchAlarmConfiguration = @import("cloud_watch_alarm_configuration.zig").CloudWatchAlarmConfiguration;
const CloudWatchRegion = @import("cloud_watch_region.zig").CloudWatchRegion;
const CollectionSummary = @import("collection_summary.zig").CollectionSummary;
const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const Coordinates = @import("coordinates.zig").Coordinates;
const DNSSECStatus = @import("dnssec_status.zig").DNSSECStatus;
const DelegationSet = @import("delegation_set.zig").DelegationSet;
const Dimension = @import("dimension.zig").Dimension;
const GeoLocation = @import("geo_location.zig").GeoLocation;
const GeoLocationDetails = @import("geo_location_details.zig").GeoLocationDetails;
const GeoProximityLocation = @import("geo_proximity_location.zig").GeoProximityLocation;
const HealthCheck = @import("health_check.zig").HealthCheck;
const HealthCheckConfig = @import("health_check_config.zig").HealthCheckConfig;
const HealthCheckObservation = @import("health_check_observation.zig").HealthCheckObservation;
const HealthCheckRegion = @import("health_check_region.zig").HealthCheckRegion;
const HealthCheckType = @import("health_check_type.zig").HealthCheckType;
const HostedZone = @import("hosted_zone.zig").HostedZone;
const HostedZoneConfig = @import("hosted_zone_config.zig").HostedZoneConfig;
const HostedZoneFailureReasons = @import("hosted_zone_failure_reasons.zig").HostedZoneFailureReasons;
const HostedZoneFeatures = @import("hosted_zone_features.zig").HostedZoneFeatures;
const HostedZoneLimit = @import("hosted_zone_limit.zig").HostedZoneLimit;
const HostedZoneLimitType = @import("hosted_zone_limit_type.zig").HostedZoneLimitType;
const HostedZoneOwner = @import("hosted_zone_owner.zig").HostedZoneOwner;
const HostedZoneSummary = @import("hosted_zone_summary.zig").HostedZoneSummary;
const InsufficientDataHealthStatus = @import("insufficient_data_health_status.zig").InsufficientDataHealthStatus;
const KeySigningKey = @import("key_signing_key.zig").KeySigningKey;
const LinkedService = @import("linked_service.zig").LinkedService;
const LocationSummary = @import("location_summary.zig").LocationSummary;
const QueryLoggingConfig = @import("query_logging_config.zig").QueryLoggingConfig;
const RRType = @import("rr_type.zig").RRType;
const ResettableElementName = @import("resettable_element_name.zig").ResettableElementName;
const ResourceRecord = @import("resource_record.zig").ResourceRecord;
const ResourceRecordSet = @import("resource_record_set.zig").ResourceRecordSet;
const ResourceRecordSetFailover = @import("resource_record_set_failover.zig").ResourceRecordSetFailover;
const ResourceRecordSetRegion = @import("resource_record_set_region.zig").ResourceRecordSetRegion;
const ResourceTagSet = @import("resource_tag_set.zig").ResourceTagSet;
const ReusableDelegationSetLimit = @import("reusable_delegation_set_limit.zig").ReusableDelegationSetLimit;
const ReusableDelegationSetLimitType = @import("reusable_delegation_set_limit_type.zig").ReusableDelegationSetLimitType;
const Statistic = @import("statistic.zig").Statistic;
const StatusReport = @import("status_report.zig").StatusReport;
const Tag = @import("tag.zig").Tag;
const TagResourceType = @import("tag_resource_type.zig").TagResourceType;
const TrafficPolicy = @import("traffic_policy.zig").TrafficPolicy;
const TrafficPolicyInstance = @import("traffic_policy_instance.zig").TrafficPolicyInstance;
const TrafficPolicySummary = @import("traffic_policy_summary.zig").TrafficPolicySummary;
const VPC = @import("vpc.zig").VPC;
const VPCRegion = @import("vpc_region.zig").VPCRegion;

pub fn deserializeCheckerIpRanges(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeChildHealthCheckList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCidrBlockSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CidrBlockSummary {
    var list: std.ArrayList(CidrBlockSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCidrBlockSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCollectionSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CollectionSummary {
    var list: std.ArrayList(CollectionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCollectionSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDelegationSetNameServers(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeDelegationSets(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DelegationSet {
    var list: std.ArrayList(DelegationSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDelegationSet(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDimensionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Dimension {
    var list: std.ArrayList(Dimension) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDimension(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeGeoLocationDetailsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const GeoLocationDetails {
    var list: std.ArrayList(GeoLocationDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeGeoLocationDetails(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeHealthCheckObservations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const HealthCheckObservation {
    var list: std.ArrayList(HealthCheckObservation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeHealthCheckObservation(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeHealthCheckRegionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const HealthCheckRegion {
    var list: std.ArrayList(HealthCheckRegion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(HealthCheckRegion, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeHealthChecks(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const HealthCheck {
    var list: std.ArrayList(HealthCheck) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeHealthCheck(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeHostedZoneSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const HostedZoneSummary {
    var list: std.ArrayList(HostedZoneSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeHostedZoneSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeHostedZones(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const HostedZone {
    var list: std.ArrayList(HostedZone) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeHostedZone(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeKeySigningKeys(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const KeySigningKey {
    var list: std.ArrayList(KeySigningKey) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeKeySigningKey(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeLocationSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LocationSummary {
    var list: std.ArrayList(LocationSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLocationSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeQueryLoggingConfigs(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const QueryLoggingConfig {
    var list: std.ArrayList(QueryLoggingConfig) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeQueryLoggingConfig(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeRecordData(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeResourceRecordSets(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceRecordSet {
    var list: std.ArrayList(ResourceRecordSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourceRecordSet(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeResourceRecords(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceRecord {
    var list: std.ArrayList(ResourceRecord) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourceRecord(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeResourceTagSetList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceTagSet {
    var list: std.ArrayList(ResourceTagSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourceTagSet(reader, alloc));
                } else {
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

pub fn deserializeTrafficPolicies(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrafficPolicy {
    var list: std.ArrayList(TrafficPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrafficPolicy(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTrafficPolicyInstances(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrafficPolicyInstance {
    var list: std.ArrayList(TrafficPolicyInstance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrafficPolicyInstance(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTrafficPolicySummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrafficPolicySummary {
    var list: std.ArrayList(TrafficPolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrafficPolicySummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeVPCs(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const VPC {
    var list: std.ArrayList(VPC) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeVPC(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAccountLimit(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccountLimit {
    _ = alloc;
    var result: AccountLimit = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(AccountLimitType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAlarmIdentifier(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AlarmIdentifier {
    var result: AlarmIdentifier = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = std.meta.stringToEnum(CloudWatchRegion, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAliasTarget(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AliasTarget {
    var result: AliasTarget = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DNSName")) {
                    result.dns_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvaluateTargetHealth")) {
                    result.evaluate_target_health = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeChangeInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ChangeInfo {
    var result: ChangeInfo = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ChangeStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubmittedAt")) {
                    result.submitted_at = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCidrBlockSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CidrBlockSummary {
    var result: CidrBlockSummary = undefined;
    result.cidr_block = null;
    result.location_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CidrBlock")) {
                    result.cidr_block = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LocationName")) {
                    result.location_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCidrCollection(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CidrCollection {
    var result: CidrCollection = undefined;
    result.arn = null;
    result.id = null;
    result.name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Version")) {
                    result.version = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCidrRoutingConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CidrRoutingConfig {
    var result: CidrRoutingConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CollectionId")) {
                    result.collection_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LocationName")) {
                    result.location_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudWatchAlarmConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CloudWatchAlarmConfiguration {
    var result: CloudWatchAlarmConfiguration = undefined;
    result.dimensions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ComparisonOperator")) {
                    result.comparison_operator = std.meta.stringToEnum(ComparisonOperator, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensionList(reader, alloc, "Dimension");
                } else if (std.mem.eql(u8, e.local, "EvaluationPeriods")) {
                    result.evaluation_periods = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Statistic")) {
                    result.statistic = std.meta.stringToEnum(Statistic, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Threshold")) {
                    result.threshold = try std.fmt.parseFloat(f64, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCollectionSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CollectionSummary {
    var result: CollectionSummary = undefined;
    result.arn = null;
    result.id = null;
    result.name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Version")) {
                    result.version = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCoordinates(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Coordinates {
    var result: Coordinates = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Latitude")) {
                    result.latitude = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Longitude")) {
                    result.longitude = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDNSSECStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DNSSECStatus {
    var result: DNSSECStatus = undefined;
    result.serve_signature = null;
    result.status_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ServeSignature")) {
                    result.serve_signature = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDelegationSet(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DelegationSet {
    var result: DelegationSet = undefined;
    result.caller_reference = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NameServers")) {
                    result.name_servers = try deserializeDelegationSetNameServers(reader, alloc, "NameServer");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDimension(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Dimension {
    var result: Dimension = undefined;
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

pub fn deserializeGeoLocation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GeoLocation {
    var result: GeoLocation = undefined;
    result.continent_code = null;
    result.country_code = null;
    result.subdivision_code = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContinentCode")) {
                    result.continent_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CountryCode")) {
                    result.country_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubdivisionCode")) {
                    result.subdivision_code = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGeoLocationDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GeoLocationDetails {
    var result: GeoLocationDetails = undefined;
    result.continent_code = null;
    result.continent_name = null;
    result.country_code = null;
    result.country_name = null;
    result.subdivision_code = null;
    result.subdivision_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContinentCode")) {
                    result.continent_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContinentName")) {
                    result.continent_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CountryCode")) {
                    result.country_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CountryName")) {
                    result.country_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubdivisionCode")) {
                    result.subdivision_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubdivisionName")) {
                    result.subdivision_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGeoProximityLocation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GeoProximityLocation {
    var result: GeoProximityLocation = undefined;
    result.aws_region = null;
    result.bias = null;
    result.coordinates = null;
    result.local_zone_group = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AWSRegion")) {
                    result.aws_region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Bias")) {
                    result.bias = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Coordinates")) {
                    result.coordinates = try deserializeCoordinates(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LocalZoneGroup")) {
                    result.local_zone_group = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHealthCheck(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HealthCheck {
    var result: HealthCheck = undefined;
    result.cloud_watch_alarm_configuration = null;
    result.linked_service = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CloudWatchAlarmConfiguration")) {
                    result.cloud_watch_alarm_configuration = try deserializeCloudWatchAlarmConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "HealthCheckConfig")) {
                    result.health_check_config = try deserializeHealthCheckConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "HealthCheckVersion")) {
                    result.health_check_version = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LinkedService")) {
                    result.linked_service = try deserializeLinkedService(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHealthCheckConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HealthCheckConfig {
    var result: HealthCheckConfig = undefined;
    result.alarm_identifier = null;
    result.child_health_checks = null;
    result.disabled = null;
    result.enable_sni = null;
    result.failure_threshold = null;
    result.fully_qualified_domain_name = null;
    result.health_threshold = null;
    result.insufficient_data_health_status = null;
    result.inverted = null;
    result.ip_address = null;
    result.measure_latency = null;
    result.port = null;
    result.regions = null;
    result.request_interval = null;
    result.resource_path = null;
    result.routing_control_arn = null;
    result.search_string = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmIdentifier")) {
                    result.alarm_identifier = try deserializeAlarmIdentifier(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ChildHealthChecks")) {
                    result.child_health_checks = try deserializeChildHealthCheckList(reader, alloc, "ChildHealthCheck");
                } else if (std.mem.eql(u8, e.local, "Disabled")) {
                    result.disabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EnableSNI")) {
                    result.enable_sni = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "FailureThreshold")) {
                    result.failure_threshold = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FullyQualifiedDomainName")) {
                    result.fully_qualified_domain_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthThreshold")) {
                    result.health_threshold = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "InsufficientDataHealthStatus")) {
                    result.insufficient_data_health_status = std.meta.stringToEnum(InsufficientDataHealthStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Inverted")) {
                    result.inverted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IPAddress")) {
                    result.ip_address = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MeasureLatency")) {
                    result.measure_latency = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeHealthCheckRegionList(reader, alloc, "Region");
                } else if (std.mem.eql(u8, e.local, "RequestInterval")) {
                    result.request_interval = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourcePath")) {
                    result.resource_path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoutingControlArn")) {
                    result.routing_control_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SearchString")) {
                    result.search_string = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(HealthCheckType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHealthCheckObservation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HealthCheckObservation {
    var result: HealthCheckObservation = undefined;
    result.ip_address = null;
    result.region = null;
    result.status_report = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IPAddress")) {
                    result.ip_address = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = std.meta.stringToEnum(HealthCheckRegion, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReport")) {
                    result.status_report = try deserializeStatusReport(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZone(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HostedZone {
    var result: HostedZone = undefined;
    result.config = null;
    result.features = null;
    result.linked_service = null;
    result.resource_record_set_count = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Config")) {
                    result.config = try deserializeHostedZoneConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Features")) {
                    result.features = try deserializeHostedZoneFeatures(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LinkedService")) {
                    result.linked_service = try deserializeLinkedService(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceRecordSetCount")) {
                    result.resource_record_set_count = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZoneConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HostedZoneConfig {
    var result: HostedZoneConfig = undefined;
    result.comment = null;
    result.private_zone = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PrivateZone")) {
                    result.private_zone = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZoneFailureReasons(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HostedZoneFailureReasons {
    var result: HostedZoneFailureReasons = undefined;
    result.accelerated_recovery = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AcceleratedRecovery")) {
                    result.accelerated_recovery = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZoneFeatures(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HostedZoneFeatures {
    var result: HostedZoneFeatures = undefined;
    result.accelerated_recovery_status = null;
    result.failure_reasons = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AcceleratedRecoveryStatus")) {
                    result.accelerated_recovery_status = std.meta.stringToEnum(AcceleratedRecoveryStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureReasons")) {
                    result.failure_reasons = try deserializeHostedZoneFailureReasons(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZoneLimit(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HostedZoneLimit {
    _ = alloc;
    var result: HostedZoneLimit = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(HostedZoneLimitType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZoneOwner(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HostedZoneOwner {
    var result: HostedZoneOwner = undefined;
    result.owning_account = null;
    result.owning_service = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OwningAccount")) {
                    result.owning_account = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OwningService")) {
                    result.owning_service = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZoneSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HostedZoneSummary {
    var result: HostedZoneSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeHostedZoneOwner(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeySigningKey(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeySigningKey {
    var result: KeySigningKey = undefined;
    result.created_date = null;
    result.digest_algorithm_mnemonic = null;
    result.digest_algorithm_type = 0;
    result.digest_value = null;
    result.dnskey_record = null;
    result.ds_record = null;
    result.flag = 0;
    result.key_tag = 0;
    result.kms_arn = null;
    result.last_modified_date = null;
    result.name = null;
    result.public_key = null;
    result.signing_algorithm_mnemonic = null;
    result.signing_algorithm_type = 0;
    result.status = null;
    result.status_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedDate")) {
                    result.created_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DigestAlgorithmMnemonic")) {
                    result.digest_algorithm_mnemonic = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DigestAlgorithmType")) {
                    result.digest_algorithm_type = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DigestValue")) {
                    result.digest_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DNSKEYRecord")) {
                    result.dnskey_record = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DSRecord")) {
                    result.ds_record = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Flag")) {
                    result.flag = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KeyTag")) {
                    result.key_tag = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsArn")) {
                    result.kms_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedDate")) {
                    result.last_modified_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicKey")) {
                    result.public_key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SigningAlgorithmMnemonic")) {
                    result.signing_algorithm_mnemonic = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SigningAlgorithmType")) {
                    result.signing_algorithm_type = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLinkedService(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LinkedService {
    var result: LinkedService = undefined;
    result.description = null;
    result.service_principal = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServicePrincipal")) {
                    result.service_principal = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLocationSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LocationSummary {
    var result: LocationSummary = undefined;
    result.location_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LocationName")) {
                    result.location_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryLoggingConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !QueryLoggingConfig {
    var result: QueryLoggingConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudWatchLogsLogGroupArn")) {
                    result.cloud_watch_logs_log_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
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

pub fn deserializeResourceRecord(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceRecord {
    var result: ResourceRecord = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Value")) {
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

pub fn deserializeResourceRecordSet(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceRecordSet {
    var result: ResourceRecordSet = undefined;
    result.alias_target = null;
    result.cidr_routing_config = null;
    result.failover = null;
    result.geo_location = null;
    result.geo_proximity_location = null;
    result.health_check_id = null;
    result.multi_value_answer = null;
    result.region = null;
    result.resource_records = null;
    result.set_identifier = null;
    result.traffic_policy_instance_id = null;
    result.ttl = null;
    result.weight = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AliasTarget")) {
                    result.alias_target = try deserializeAliasTarget(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CidrRoutingConfig")) {
                    result.cidr_routing_config = try deserializeCidrRoutingConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Failover")) {
                    result.failover = std.meta.stringToEnum(ResourceRecordSetFailover, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GeoLocation")) {
                    result.geo_location = try deserializeGeoLocation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "GeoProximityLocation")) {
                    result.geo_proximity_location = try deserializeGeoProximityLocation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "HealthCheckId")) {
                    result.health_check_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiValueAnswer")) {
                    result.multi_value_answer = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = std.meta.stringToEnum(ResourceRecordSetRegion, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceRecords")) {
                    result.resource_records = try deserializeResourceRecords(reader, alloc, "ResourceRecord");
                } else if (std.mem.eql(u8, e.local, "SetIdentifier")) {
                    result.set_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyInstanceId")) {
                    result.traffic_policy_instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TTL")) {
                    result.ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(RRType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Weight")) {
                    result.weight = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResourceTagSet(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceTagSet {
    var result: ResourceTagSet = undefined;
    result.resource_id = null;
    result.resource_type = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceId")) {
                    result.resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = std.meta.stringToEnum(TagResourceType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(reader, alloc, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeReusableDelegationSetLimit(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ReusableDelegationSetLimit {
    _ = alloc;
    var result: ReusableDelegationSetLimit = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(ReusableDelegationSetLimitType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStatusReport(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StatusReport {
    var result: StatusReport = undefined;
    result.checked_time = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CheckedTime")) {
                    result.checked_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeTrafficPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrafficPolicy {
    var result: TrafficPolicy = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Document")) {
                    result.document = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(RRType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Version")) {
                    result.version = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrafficPolicyInstance(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrafficPolicyInstance {
    var result: TrafficPolicyInstance = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyId")) {
                    result.traffic_policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyType")) {
                    result.traffic_policy_type = std.meta.stringToEnum(RRType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyVersion")) {
                    result.traffic_policy_version = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "TTL")) {
                    result.ttl = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrafficPolicySummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrafficPolicySummary {
    var result: TrafficPolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestVersion")) {
                    result.latest_version = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyCount")) {
                    result.traffic_policy_count = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(RRType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVPC(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VPC {
    var result: VPC = undefined;
    result.vpc_id = null;
    result.vpc_region = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "VPCId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VPCRegion")) {
                    result.vpc_region = std.meta.stringToEnum(VPCRegion, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeChanges(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Change, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeChange(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeChildHealthCheckList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCidrCollectionChanges(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CidrCollectionChange, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeCidrCollectionChange(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeCidrList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeHealthCheckRegionList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const HealthCheckRegion, comptime item_tag: []const u8) !void {
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

pub fn serializeResettableElementNameList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResettableElementName, comptime item_tag: []const u8) !void {
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

pub fn serializeResourceRecords(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResourceRecord, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeResourceRecord(alloc, buf, item);
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

pub fn serializeTagResourceIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAlarmIdentifier(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AlarmIdentifier) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Region>");
    try buf.appendSlice(alloc, @tagName(value.region));
    try buf.appendSlice(alloc, "</Region>");
}

pub fn serializeAliasTarget(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AliasTarget) !void {
    try buf.appendSlice(alloc, "<DNSName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.dns_name);
    try buf.appendSlice(alloc, "</DNSName>");
    try buf.appendSlice(alloc, "<EvaluateTargetHealth>");
    try buf.appendSlice(alloc, if (value.evaluate_target_health) "true" else "false");
    try buf.appendSlice(alloc, "</EvaluateTargetHealth>");
    try buf.appendSlice(alloc, "<HostedZoneId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.hosted_zone_id);
    try buf.appendSlice(alloc, "</HostedZoneId>");
}

pub fn serializeChange(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Change) !void {
    try buf.appendSlice(alloc, "<Action>");
    try buf.appendSlice(alloc, @tagName(value.action));
    try buf.appendSlice(alloc, "</Action>");
    try buf.appendSlice(alloc, "<ResourceRecordSet>");
    try serializeResourceRecordSet(alloc, buf, value.resource_record_set);
    try buf.appendSlice(alloc, "</ResourceRecordSet>");
}

pub fn serializeChangeBatch(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ChangeBatch) !void {
    try buf.appendSlice(alloc, "<Changes>");
    try serializeChanges(alloc, buf, value.changes, "Change");
    try buf.appendSlice(alloc, "</Changes>");
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
}

pub fn serializeCidrCollectionChange(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CidrCollectionChange) !void {
    try buf.appendSlice(alloc, "<Action>");
    try buf.appendSlice(alloc, @tagName(value.action));
    try buf.appendSlice(alloc, "</Action>");
    try buf.appendSlice(alloc, "<CidrList>");
    try serializeCidrList(alloc, buf, value.cidr_list, "Cidr");
    try buf.appendSlice(alloc, "</CidrList>");
    try buf.appendSlice(alloc, "<LocationName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.location_name);
    try buf.appendSlice(alloc, "</LocationName>");
}

pub fn serializeCidrRoutingConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CidrRoutingConfig) !void {
    try buf.appendSlice(alloc, "<CollectionId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.collection_id);
    try buf.appendSlice(alloc, "</CollectionId>");
    try buf.appendSlice(alloc, "<LocationName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.location_name);
    try buf.appendSlice(alloc, "</LocationName>");
}

pub fn serializeCoordinates(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Coordinates) !void {
    try buf.appendSlice(alloc, "<Latitude>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.latitude);
    try buf.appendSlice(alloc, "</Latitude>");
    try buf.appendSlice(alloc, "<Longitude>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.longitude);
    try buf.appendSlice(alloc, "</Longitude>");
}

pub fn serializeGeoLocation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: GeoLocation) !void {
    if (value.continent_code) |v| {
        try buf.appendSlice(alloc, "<ContinentCode>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContinentCode>");
    }
    if (value.country_code) |v| {
        try buf.appendSlice(alloc, "<CountryCode>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</CountryCode>");
    }
    if (value.subdivision_code) |v| {
        try buf.appendSlice(alloc, "<SubdivisionCode>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SubdivisionCode>");
    }
}

pub fn serializeGeoProximityLocation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: GeoProximityLocation) !void {
    if (value.aws_region) |v| {
        try buf.appendSlice(alloc, "<AWSRegion>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AWSRegion>");
    }
    if (value.bias) |v| {
        try buf.appendSlice(alloc, "<Bias>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Bias>");
    }
    if (value.coordinates) |v| {
        try buf.appendSlice(alloc, "<Coordinates>");
        try serializeCoordinates(alloc, buf, v);
        try buf.appendSlice(alloc, "</Coordinates>");
    }
    if (value.local_zone_group) |v| {
        try buf.appendSlice(alloc, "<LocalZoneGroup>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</LocalZoneGroup>");
    }
}

pub fn serializeHealthCheckConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: HealthCheckConfig) !void {
    if (value.alarm_identifier) |v| {
        try buf.appendSlice(alloc, "<AlarmIdentifier>");
        try serializeAlarmIdentifier(alloc, buf, v);
        try buf.appendSlice(alloc, "</AlarmIdentifier>");
    }
    if (value.child_health_checks) |v| {
        try buf.appendSlice(alloc, "<ChildHealthChecks>");
        try serializeChildHealthCheckList(alloc, buf, v, "ChildHealthCheck");
        try buf.appendSlice(alloc, "</ChildHealthChecks>");
    }
    if (value.disabled) |v| {
        try buf.appendSlice(alloc, "<Disabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Disabled>");
    }
    if (value.enable_sni) |v| {
        try buf.appendSlice(alloc, "<EnableSNI>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</EnableSNI>");
    }
    if (value.failure_threshold) |v| {
        try buf.appendSlice(alloc, "<FailureThreshold>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</FailureThreshold>");
    }
    if (value.fully_qualified_domain_name) |v| {
        try buf.appendSlice(alloc, "<FullyQualifiedDomainName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</FullyQualifiedDomainName>");
    }
    if (value.health_threshold) |v| {
        try buf.appendSlice(alloc, "<HealthThreshold>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</HealthThreshold>");
    }
    if (value.insufficient_data_health_status) |v| {
        try buf.appendSlice(alloc, "<InsufficientDataHealthStatus>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</InsufficientDataHealthStatus>");
    }
    if (value.inverted) |v| {
        try buf.appendSlice(alloc, "<Inverted>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Inverted>");
    }
    if (value.ip_address) |v| {
        try buf.appendSlice(alloc, "<IPAddress>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</IPAddress>");
    }
    if (value.measure_latency) |v| {
        try buf.appendSlice(alloc, "<MeasureLatency>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</MeasureLatency>");
    }
    if (value.port) |v| {
        try buf.appendSlice(alloc, "<Port>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Port>");
    }
    if (value.regions) |v| {
        try buf.appendSlice(alloc, "<Regions>");
        try serializeHealthCheckRegionList(alloc, buf, v, "Region");
        try buf.appendSlice(alloc, "</Regions>");
    }
    if (value.request_interval) |v| {
        try buf.appendSlice(alloc, "<RequestInterval>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</RequestInterval>");
    }
    if (value.resource_path) |v| {
        try buf.appendSlice(alloc, "<ResourcePath>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResourcePath>");
    }
    if (value.routing_control_arn) |v| {
        try buf.appendSlice(alloc, "<RoutingControlArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</RoutingControlArn>");
    }
    if (value.search_string) |v| {
        try buf.appendSlice(alloc, "<SearchString>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SearchString>");
    }
    try buf.appendSlice(alloc, "<Type>");
    try buf.appendSlice(alloc, @tagName(value.@"type"));
    try buf.appendSlice(alloc, "</Type>");
}

pub fn serializeHostedZoneConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: HostedZoneConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
    if (value.private_zone) |v| {
        try buf.appendSlice(alloc, "<PrivateZone>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</PrivateZone>");
    }
}

pub fn serializeResourceRecord(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceRecord) !void {
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeResourceRecordSet(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceRecordSet) !void {
    if (value.alias_target) |v| {
        try buf.appendSlice(alloc, "<AliasTarget>");
        try serializeAliasTarget(alloc, buf, v);
        try buf.appendSlice(alloc, "</AliasTarget>");
    }
    if (value.cidr_routing_config) |v| {
        try buf.appendSlice(alloc, "<CidrRoutingConfig>");
        try serializeCidrRoutingConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</CidrRoutingConfig>");
    }
    if (value.failover) |v| {
        try buf.appendSlice(alloc, "<Failover>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Failover>");
    }
    if (value.geo_location) |v| {
        try buf.appendSlice(alloc, "<GeoLocation>");
        try serializeGeoLocation(alloc, buf, v);
        try buf.appendSlice(alloc, "</GeoLocation>");
    }
    if (value.geo_proximity_location) |v| {
        try buf.appendSlice(alloc, "<GeoProximityLocation>");
        try serializeGeoProximityLocation(alloc, buf, v);
        try buf.appendSlice(alloc, "</GeoProximityLocation>");
    }
    if (value.health_check_id) |v| {
        try buf.appendSlice(alloc, "<HealthCheckId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</HealthCheckId>");
    }
    if (value.multi_value_answer) |v| {
        try buf.appendSlice(alloc, "<MultiValueAnswer>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</MultiValueAnswer>");
    }
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    if (value.region) |v| {
        try buf.appendSlice(alloc, "<Region>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Region>");
    }
    if (value.resource_records) |v| {
        try buf.appendSlice(alloc, "<ResourceRecords>");
        try serializeResourceRecords(alloc, buf, v, "ResourceRecord");
        try buf.appendSlice(alloc, "</ResourceRecords>");
    }
    if (value.set_identifier) |v| {
        try buf.appendSlice(alloc, "<SetIdentifier>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SetIdentifier>");
    }
    if (value.traffic_policy_instance_id) |v| {
        try buf.appendSlice(alloc, "<TrafficPolicyInstanceId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TrafficPolicyInstanceId>");
    }
    if (value.ttl) |v| {
        try buf.appendSlice(alloc, "<TTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</TTL>");
    }
    try buf.appendSlice(alloc, "<Type>");
    try buf.appendSlice(alloc, @tagName(value.@"type"));
    try buf.appendSlice(alloc, "</Type>");
    if (value.weight) |v| {
        try buf.appendSlice(alloc, "<Weight>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Weight>");
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

pub fn serializeVPC(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: VPC) !void {
    if (value.vpc_id) |v| {
        try buf.appendSlice(alloc, "<VPCId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</VPCId>");
    }
    if (value.vpc_region) |v| {
        try buf.appendSlice(alloc, "<VPCRegion>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</VPCRegion>");
    }
}

