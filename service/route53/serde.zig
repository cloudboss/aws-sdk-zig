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

pub fn deserializeCheckerIpRanges(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeChildHealthCheckList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeCidrBlockSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CidrBlockSummary {
    var list: std.ArrayList(CidrBlockSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCidrBlockSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCollectionSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CollectionSummary {
    var list: std.ArrayList(CollectionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCollectionSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDelegationSetNameServers(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeDelegationSets(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DelegationSet {
    var list: std.ArrayList(DelegationSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDelegationSet(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDimensionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Dimension {
    var list: std.ArrayList(Dimension) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDimension(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeGeoLocationDetailsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const GeoLocationDetails {
    var list: std.ArrayList(GeoLocationDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeGeoLocationDetails(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeHealthCheckObservations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const HealthCheckObservation {
    var list: std.ArrayList(HealthCheckObservation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeHealthCheckObservation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeHealthCheckRegionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const HealthCheckRegion {
    var list: std.ArrayList(HealthCheckRegion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (HealthCheckRegion.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeHealthChecks(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const HealthCheck {
    var list: std.ArrayList(HealthCheck) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeHealthCheck(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeHostedZoneSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const HostedZoneSummary {
    var list: std.ArrayList(HostedZoneSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeHostedZoneSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeHostedZones(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const HostedZone {
    var list: std.ArrayList(HostedZone) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeHostedZone(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeKeySigningKeys(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const KeySigningKey {
    var list: std.ArrayList(KeySigningKey) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeKeySigningKey(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeLocationSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LocationSummary {
    var list: std.ArrayList(LocationSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLocationSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeQueryLoggingConfigs(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const QueryLoggingConfig {
    var list: std.ArrayList(QueryLoggingConfig) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeQueryLoggingConfig(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRecordData(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeResourceRecordSets(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceRecordSet {
    var list: std.ArrayList(ResourceRecordSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourceRecordSet(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceRecords(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceRecord {
    var list: std.ArrayList(ResourceRecord) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourceRecord(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceTagSetList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceTagSet {
    var list: std.ArrayList(ResourceTagSet) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourceTagSet(allocator, reader));
                } else {
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

pub fn deserializeTrafficPolicies(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrafficPolicy {
    var list: std.ArrayList(TrafficPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrafficPolicy(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTrafficPolicyInstances(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrafficPolicyInstance {
    var list: std.ArrayList(TrafficPolicyInstance) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrafficPolicyInstance(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTrafficPolicySummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrafficPolicySummary {
    var list: std.ArrayList(TrafficPolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrafficPolicySummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeVPCs(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const VPC {
    var list: std.ArrayList(VPC) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeVPC(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAccountLimit(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccountLimit {
    _ = allocator;
    var result: AccountLimit = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = AccountLimitType.fromWireName(try reader.readElementText());
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

pub fn deserializeAlarmIdentifier(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AlarmIdentifier {
    var result: AlarmIdentifier = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = CloudWatchRegion.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAliasTarget(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AliasTarget {
    var result: AliasTarget = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DNSName")) {
                    result.dns_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvaluateTargetHealth")) {
                    result.evaluate_target_health = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeChangeInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ChangeInfo {
    var result: ChangeInfo = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = ChangeStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeCidrBlockSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CidrBlockSummary {
    var result: CidrBlockSummary = undefined;
    result.cidr_block = null;
    result.location_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CidrBlock")) {
                    result.cidr_block = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LocationName")) {
                    result.location_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCidrCollection(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CidrCollection {
    var result: CidrCollection = undefined;
    result.arn = null;
    result.id = null;
    result.name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCidrRoutingConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CidrRoutingConfig {
    var result: CidrRoutingConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CollectionId")) {
                    result.collection_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LocationName")) {
                    result.location_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudWatchAlarmConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CloudWatchAlarmConfiguration {
    var result: CloudWatchAlarmConfiguration = undefined;
    result.dimensions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ComparisonOperator")) {
                    result.comparison_operator = ComparisonOperator.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensionList(allocator, reader, "Dimension");
                } else if (std.mem.eql(u8, e.local, "EvaluationPeriods")) {
                    result.evaluation_periods = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Statistic")) {
                    result.statistic = Statistic.fromWireName(try reader.readElementText());
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

pub fn deserializeCollectionSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CollectionSummary {
    var result: CollectionSummary = undefined;
    result.arn = null;
    result.id = null;
    result.name = null;
    result.version = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCoordinates(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Coordinates {
    var result: Coordinates = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Latitude")) {
                    result.latitude = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Longitude")) {
                    result.longitude = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDNSSECStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DNSSECStatus {
    var result: DNSSECStatus = undefined;
    result.serve_signature = null;
    result.status_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ServeSignature")) {
                    result.serve_signature = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDelegationSet(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DelegationSet {
    var result: DelegationSet = undefined;
    result.caller_reference = null;
    result.id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NameServers")) {
                    result.name_servers = try deserializeDelegationSetNameServers(allocator, reader, "NameServer");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDimension(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Dimension {
    var result: Dimension = undefined;
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

pub fn deserializeGeoLocation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GeoLocation {
    var result: GeoLocation = undefined;
    result.continent_code = null;
    result.country_code = null;
    result.subdivision_code = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContinentCode")) {
                    result.continent_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CountryCode")) {
                    result.country_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubdivisionCode")) {
                    result.subdivision_code = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGeoLocationDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GeoLocationDetails {
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
                    result.continent_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContinentName")) {
                    result.continent_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CountryCode")) {
                    result.country_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CountryName")) {
                    result.country_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubdivisionCode")) {
                    result.subdivision_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubdivisionName")) {
                    result.subdivision_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGeoProximityLocation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GeoProximityLocation {
    var result: GeoProximityLocation = undefined;
    result.aws_region = null;
    result.bias = null;
    result.coordinates = null;
    result.local_zone_group = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AWSRegion")) {
                    result.aws_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Bias")) {
                    result.bias = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Coordinates")) {
                    result.coordinates = try deserializeCoordinates(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LocalZoneGroup")) {
                    result.local_zone_group = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHealthCheck(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HealthCheck {
    var result: HealthCheck = undefined;
    result.cloud_watch_alarm_configuration = null;
    result.linked_service = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CloudWatchAlarmConfiguration")) {
                    result.cloud_watch_alarm_configuration = try deserializeCloudWatchAlarmConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "HealthCheckConfig")) {
                    result.health_check_config = try deserializeHealthCheckConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "HealthCheckVersion")) {
                    result.health_check_version = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LinkedService")) {
                    result.linked_service = try deserializeLinkedService(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHealthCheckConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HealthCheckConfig {
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
                    result.alarm_identifier = try deserializeAlarmIdentifier(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ChildHealthChecks")) {
                    result.child_health_checks = try deserializeChildHealthCheckList(allocator, reader, "ChildHealthCheck");
                } else if (std.mem.eql(u8, e.local, "Disabled")) {
                    result.disabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EnableSNI")) {
                    result.enable_sni = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "FailureThreshold")) {
                    result.failure_threshold = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FullyQualifiedDomainName")) {
                    result.fully_qualified_domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthThreshold")) {
                    result.health_threshold = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "InsufficientDataHealthStatus")) {
                    result.insufficient_data_health_status = InsufficientDataHealthStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Inverted")) {
                    result.inverted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IPAddress")) {
                    result.ip_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MeasureLatency")) {
                    result.measure_latency = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeHealthCheckRegionList(allocator, reader, "Region");
                } else if (std.mem.eql(u8, e.local, "RequestInterval")) {
                    result.request_interval = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourcePath")) {
                    result.resource_path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoutingControlArn")) {
                    result.routing_control_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SearchString")) {
                    result.search_string = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = HealthCheckType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHealthCheckObservation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HealthCheckObservation {
    var result: HealthCheckObservation = undefined;
    result.ip_address = null;
    result.region = null;
    result.status_report = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IPAddress")) {
                    result.ip_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = HealthCheckRegion.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReport")) {
                    result.status_report = try deserializeStatusReport(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZone(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HostedZone {
    var result: HostedZone = undefined;
    result.config = null;
    result.features = null;
    result.linked_service = null;
    result.resource_record_set_count = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Config")) {
                    result.config = try deserializeHostedZoneConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Features")) {
                    result.features = try deserializeHostedZoneFeatures(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LinkedService")) {
                    result.linked_service = try deserializeLinkedService(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeHostedZoneConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HostedZoneConfig {
    var result: HostedZoneConfig = undefined;
    result.comment = null;
    result.private_zone = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeHostedZoneFailureReasons(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HostedZoneFailureReasons {
    var result: HostedZoneFailureReasons = undefined;
    result.accelerated_recovery = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AcceleratedRecovery")) {
                    result.accelerated_recovery = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZoneFeatures(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HostedZoneFeatures {
    var result: HostedZoneFeatures = undefined;
    result.accelerated_recovery_status = null;
    result.failure_reasons = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AcceleratedRecoveryStatus")) {
                    result.accelerated_recovery_status = AcceleratedRecoveryStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureReasons")) {
                    result.failure_reasons = try deserializeHostedZoneFailureReasons(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZoneLimit(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HostedZoneLimit {
    _ = allocator;
    var result: HostedZoneLimit = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = HostedZoneLimitType.fromWireName(try reader.readElementText());
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

pub fn deserializeHostedZoneOwner(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HostedZoneOwner {
    var result: HostedZoneOwner = undefined;
    result.owning_account = null;
    result.owning_service = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OwningAccount")) {
                    result.owning_account = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OwningService")) {
                    result.owning_service = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostedZoneSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HostedZoneSummary {
    var result: HostedZoneSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try deserializeHostedZoneOwner(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeySigningKey(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeySigningKey {
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
                    result.digest_algorithm_mnemonic = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DigestAlgorithmType")) {
                    result.digest_algorithm_type = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DigestValue")) {
                    result.digest_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DNSKEYRecord")) {
                    result.dnskey_record = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DSRecord")) {
                    result.ds_record = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Flag")) {
                    result.flag = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KeyTag")) {
                    result.key_tag = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "KmsArn")) {
                    result.kms_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedDate")) {
                    result.last_modified_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicKey")) {
                    result.public_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SigningAlgorithmMnemonic")) {
                    result.signing_algorithm_mnemonic = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SigningAlgorithmType")) {
                    result.signing_algorithm_type = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLinkedService(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LinkedService {
    var result: LinkedService = undefined;
    result.description = null;
    result.service_principal = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServicePrincipal")) {
                    result.service_principal = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLocationSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LocationSummary {
    var result: LocationSummary = undefined;
    result.location_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LocationName")) {
                    result.location_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryLoggingConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !QueryLoggingConfig {
    var result: QueryLoggingConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudWatchLogsLogGroupArn")) {
                    result.cloud_watch_logs_log_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
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

pub fn deserializeResourceRecord(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceRecord {
    var result: ResourceRecord = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Value")) {
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

pub fn deserializeResourceRecordSet(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceRecordSet {
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
                    result.alias_target = try deserializeAliasTarget(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CidrRoutingConfig")) {
                    result.cidr_routing_config = try deserializeCidrRoutingConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Failover")) {
                    result.failover = ResourceRecordSetFailover.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GeoLocation")) {
                    result.geo_location = try deserializeGeoLocation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "GeoProximityLocation")) {
                    result.geo_proximity_location = try deserializeGeoProximityLocation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "HealthCheckId")) {
                    result.health_check_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MultiValueAnswer")) {
                    result.multi_value_answer = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = ResourceRecordSetRegion.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceRecords")) {
                    result.resource_records = try deserializeResourceRecords(allocator, reader, "ResourceRecord");
                } else if (std.mem.eql(u8, e.local, "SetIdentifier")) {
                    result.set_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyInstanceId")) {
                    result.traffic_policy_instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TTL")) {
                    result.ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = RRType.fromWireName(try reader.readElementText());
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

pub fn deserializeResourceTagSet(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceTagSet {
    var result: ResourceTagSet = undefined;
    result.resource_id = null;
    result.resource_type = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceId")) {
                    result.resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = TagResourceType.fromWireName(try reader.readElementText());
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

pub fn deserializeReusableDelegationSetLimit(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ReusableDelegationSetLimit {
    _ = allocator;
    var result: ReusableDelegationSetLimit = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = ReusableDelegationSetLimitType.fromWireName(try reader.readElementText());
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

pub fn deserializeStatusReport(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StatusReport {
    var result: StatusReport = undefined;
    result.checked_time = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CheckedTime")) {
                    result.checked_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

pub fn deserializeTrafficPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrafficPolicy {
    var result: TrafficPolicy = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Document")) {
                    result.document = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = RRType.fromWireName(try reader.readElementText());
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

pub fn deserializeTrafficPolicyInstance(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrafficPolicyInstance {
    var result: TrafficPolicyInstance = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyId")) {
                    result.traffic_policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyType")) {
                    result.traffic_policy_type = RRType.fromWireName(try reader.readElementText());
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

pub fn deserializeTrafficPolicySummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrafficPolicySummary {
    var result: TrafficPolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LatestVersion")) {
                    result.latest_version = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrafficPolicyCount")) {
                    result.traffic_policy_count = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = RRType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVPC(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VPC {
    var result: VPC = undefined;
    result.vpc_id = null;
    result.vpc_region = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "VPCId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VPCRegion")) {
                    result.vpc_region = VPCRegion.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeChanges(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Change, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeChange(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeChildHealthCheckList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCidrCollectionChanges(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CidrCollectionChange, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeCidrCollectionChange(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCidrList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeHealthCheckRegionList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const HealthCheckRegion, comptime item_tag: []const u8) !void {
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

pub fn serializeResettableElementNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResettableElementName, comptime item_tag: []const u8) !void {
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

pub fn serializeResourceRecords(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResourceRecord, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeResourceRecord(allocator, buf, item);
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

pub fn serializeTagResourceIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAlarmIdentifier(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AlarmIdentifier) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Region>");
    try buf.appendSlice(allocator, value.region.wireName());
    try buf.appendSlice(allocator, "</Region>");
}

pub fn serializeAliasTarget(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AliasTarget) !void {
    try buf.appendSlice(allocator, "<DNSName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.dns_name);
    try buf.appendSlice(allocator, "</DNSName>");
    try buf.appendSlice(allocator, "<EvaluateTargetHealth>");
    try buf.appendSlice(allocator, if (value.evaluate_target_health) "true" else "false");
    try buf.appendSlice(allocator, "</EvaluateTargetHealth>");
    try buf.appendSlice(allocator, "<HostedZoneId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.hosted_zone_id);
    try buf.appendSlice(allocator, "</HostedZoneId>");
}

pub fn serializeChange(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Change) !void {
    try buf.appendSlice(allocator, "<Action>");
    try buf.appendSlice(allocator, value.action.wireName());
    try buf.appendSlice(allocator, "</Action>");
    try buf.appendSlice(allocator, "<ResourceRecordSet>");
    try serializeResourceRecordSet(allocator, buf, value.resource_record_set);
    try buf.appendSlice(allocator, "</ResourceRecordSet>");
}

pub fn serializeChangeBatch(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ChangeBatch) !void {
    try buf.appendSlice(allocator, "<Changes>");
    try serializeChanges(allocator, buf, value.changes, "Change");
    try buf.appendSlice(allocator, "</Changes>");
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
}

pub fn serializeCidrCollectionChange(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CidrCollectionChange) !void {
    try buf.appendSlice(allocator, "<Action>");
    try buf.appendSlice(allocator, value.action.wireName());
    try buf.appendSlice(allocator, "</Action>");
    try buf.appendSlice(allocator, "<CidrList>");
    try serializeCidrList(allocator, buf, value.cidr_list, "Cidr");
    try buf.appendSlice(allocator, "</CidrList>");
    try buf.appendSlice(allocator, "<LocationName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.location_name);
    try buf.appendSlice(allocator, "</LocationName>");
}

pub fn serializeCidrRoutingConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CidrRoutingConfig) !void {
    try buf.appendSlice(allocator, "<CollectionId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.collection_id);
    try buf.appendSlice(allocator, "</CollectionId>");
    try buf.appendSlice(allocator, "<LocationName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.location_name);
    try buf.appendSlice(allocator, "</LocationName>");
}

pub fn serializeCoordinates(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Coordinates) !void {
    try buf.appendSlice(allocator, "<Latitude>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.latitude);
    try buf.appendSlice(allocator, "</Latitude>");
    try buf.appendSlice(allocator, "<Longitude>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.longitude);
    try buf.appendSlice(allocator, "</Longitude>");
}

pub fn serializeGeoLocation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: GeoLocation) !void {
    if (value.continent_code) |v| {
        try buf.appendSlice(allocator, "<ContinentCode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContinentCode>");
    }
    if (value.country_code) |v| {
        try buf.appendSlice(allocator, "<CountryCode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</CountryCode>");
    }
    if (value.subdivision_code) |v| {
        try buf.appendSlice(allocator, "<SubdivisionCode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SubdivisionCode>");
    }
}

pub fn serializeGeoProximityLocation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: GeoProximityLocation) !void {
    if (value.aws_region) |v| {
        try buf.appendSlice(allocator, "<AWSRegion>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AWSRegion>");
    }
    if (value.bias) |v| {
        try buf.appendSlice(allocator, "<Bias>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Bias>");
    }
    if (value.coordinates) |v| {
        try buf.appendSlice(allocator, "<Coordinates>");
        try serializeCoordinates(allocator, buf, v);
        try buf.appendSlice(allocator, "</Coordinates>");
    }
    if (value.local_zone_group) |v| {
        try buf.appendSlice(allocator, "<LocalZoneGroup>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</LocalZoneGroup>");
    }
}

pub fn serializeHealthCheckConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: HealthCheckConfig) !void {
    if (value.alarm_identifier) |v| {
        try buf.appendSlice(allocator, "<AlarmIdentifier>");
        try serializeAlarmIdentifier(allocator, buf, v);
        try buf.appendSlice(allocator, "</AlarmIdentifier>");
    }
    if (value.child_health_checks) |v| {
        try buf.appendSlice(allocator, "<ChildHealthChecks>");
        try serializeChildHealthCheckList(allocator, buf, v, "ChildHealthCheck");
        try buf.appendSlice(allocator, "</ChildHealthChecks>");
    }
    if (value.disabled) |v| {
        try buf.appendSlice(allocator, "<Disabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Disabled>");
    }
    if (value.enable_sni) |v| {
        try buf.appendSlice(allocator, "<EnableSNI>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</EnableSNI>");
    }
    if (value.failure_threshold) |v| {
        try buf.appendSlice(allocator, "<FailureThreshold>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</FailureThreshold>");
    }
    if (value.fully_qualified_domain_name) |v| {
        try buf.appendSlice(allocator, "<FullyQualifiedDomainName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</FullyQualifiedDomainName>");
    }
    if (value.health_threshold) |v| {
        try buf.appendSlice(allocator, "<HealthThreshold>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</HealthThreshold>");
    }
    if (value.insufficient_data_health_status) |v| {
        try buf.appendSlice(allocator, "<InsufficientDataHealthStatus>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</InsufficientDataHealthStatus>");
    }
    if (value.inverted) |v| {
        try buf.appendSlice(allocator, "<Inverted>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Inverted>");
    }
    if (value.ip_address) |v| {
        try buf.appendSlice(allocator, "<IPAddress>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</IPAddress>");
    }
    if (value.measure_latency) |v| {
        try buf.appendSlice(allocator, "<MeasureLatency>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</MeasureLatency>");
    }
    if (value.port) |v| {
        try buf.appendSlice(allocator, "<Port>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Port>");
    }
    if (value.regions) |v| {
        try buf.appendSlice(allocator, "<Regions>");
        try serializeHealthCheckRegionList(allocator, buf, v, "Region");
        try buf.appendSlice(allocator, "</Regions>");
    }
    if (value.request_interval) |v| {
        try buf.appendSlice(allocator, "<RequestInterval>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</RequestInterval>");
    }
    if (value.resource_path) |v| {
        try buf.appendSlice(allocator, "<ResourcePath>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResourcePath>");
    }
    if (value.routing_control_arn) |v| {
        try buf.appendSlice(allocator, "<RoutingControlArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RoutingControlArn>");
    }
    if (value.search_string) |v| {
        try buf.appendSlice(allocator, "<SearchString>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SearchString>");
    }
    try buf.appendSlice(allocator, "<Type>");
    try buf.appendSlice(allocator, value.@"type".wireName());
    try buf.appendSlice(allocator, "</Type>");
}

pub fn serializeHostedZoneConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: HostedZoneConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
    if (value.private_zone) |v| {
        try buf.appendSlice(allocator, "<PrivateZone>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</PrivateZone>");
    }
}

pub fn serializeResourceRecord(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceRecord) !void {
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeResourceRecordSet(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceRecordSet) !void {
    if (value.alias_target) |v| {
        try buf.appendSlice(allocator, "<AliasTarget>");
        try serializeAliasTarget(allocator, buf, v);
        try buf.appendSlice(allocator, "</AliasTarget>");
    }
    if (value.cidr_routing_config) |v| {
        try buf.appendSlice(allocator, "<CidrRoutingConfig>");
        try serializeCidrRoutingConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</CidrRoutingConfig>");
    }
    if (value.failover) |v| {
        try buf.appendSlice(allocator, "<Failover>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Failover>");
    }
    if (value.geo_location) |v| {
        try buf.appendSlice(allocator, "<GeoLocation>");
        try serializeGeoLocation(allocator, buf, v);
        try buf.appendSlice(allocator, "</GeoLocation>");
    }
    if (value.geo_proximity_location) |v| {
        try buf.appendSlice(allocator, "<GeoProximityLocation>");
        try serializeGeoProximityLocation(allocator, buf, v);
        try buf.appendSlice(allocator, "</GeoProximityLocation>");
    }
    if (value.health_check_id) |v| {
        try buf.appendSlice(allocator, "<HealthCheckId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</HealthCheckId>");
    }
    if (value.multi_value_answer) |v| {
        try buf.appendSlice(allocator, "<MultiValueAnswer>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</MultiValueAnswer>");
    }
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    if (value.region) |v| {
        try buf.appendSlice(allocator, "<Region>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Region>");
    }
    if (value.resource_records) |v| {
        try buf.appendSlice(allocator, "<ResourceRecords>");
        try serializeResourceRecords(allocator, buf, v, "ResourceRecord");
        try buf.appendSlice(allocator, "</ResourceRecords>");
    }
    if (value.set_identifier) |v| {
        try buf.appendSlice(allocator, "<SetIdentifier>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SetIdentifier>");
    }
    if (value.traffic_policy_instance_id) |v| {
        try buf.appendSlice(allocator, "<TrafficPolicyInstanceId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TrafficPolicyInstanceId>");
    }
    if (value.ttl) |v| {
        try buf.appendSlice(allocator, "<TTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</TTL>");
    }
    try buf.appendSlice(allocator, "<Type>");
    try buf.appendSlice(allocator, value.@"type".wireName());
    try buf.appendSlice(allocator, "</Type>");
    if (value.weight) |v| {
        try buf.appendSlice(allocator, "<Weight>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Weight>");
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

pub fn serializeVPC(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: VPC) !void {
    if (value.vpc_id) |v| {
        try buf.appendSlice(allocator, "<VPCId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</VPCId>");
    }
    if (value.vpc_region) |v| {
        try buf.appendSlice(allocator, "<VPCRegion>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</VPCRegion>");
    }
}

