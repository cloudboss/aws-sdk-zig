const aws = @import("aws");
const std = @import("std");

const Action = @import("action.zig").Action;
const ActionTypeEnum = @import("action_type_enum.zig").ActionTypeEnum;
const AdministrativeOverride = @import("administrative_override.zig").AdministrativeOverride;
const AdvertiseTrustStoreCaNamesEnum = @import("advertise_trust_store_ca_names_enum.zig").AdvertiseTrustStoreCaNamesEnum;
const AnomalyDetection = @import("anomaly_detection.zig").AnomalyDetection;
const AnomalyResultEnum = @import("anomaly_result_enum.zig").AnomalyResultEnum;
const AuthenticateCognitoActionConditionalBehaviorEnum = @import("authenticate_cognito_action_conditional_behavior_enum.zig").AuthenticateCognitoActionConditionalBehaviorEnum;
const AuthenticateCognitoActionConfig = @import("authenticate_cognito_action_config.zig").AuthenticateCognitoActionConfig;
const AuthenticateOidcActionConditionalBehaviorEnum = @import("authenticate_oidc_action_conditional_behavior_enum.zig").AuthenticateOidcActionConditionalBehaviorEnum;
const AuthenticateOidcActionConfig = @import("authenticate_oidc_action_config.zig").AuthenticateOidcActionConfig;
const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const CapacityReservationStateEnum = @import("capacity_reservation_state_enum.zig").CapacityReservationStateEnum;
const CapacityReservationStatus = @import("capacity_reservation_status.zig").CapacityReservationStatus;
const Certificate = @import("certificate.zig").Certificate;
const Cipher = @import("cipher.zig").Cipher;
const DescribeTargetHealthInputIncludeEnum = @import("describe_target_health_input_include_enum.zig").DescribeTargetHealthInputIncludeEnum;
const DescribeTrustStoreRevocation = @import("describe_trust_store_revocation.zig").DescribeTrustStoreRevocation;
const EnablePrefixForIpv6SourceNatEnum = @import("enable_prefix_for_ipv_6_source_nat_enum.zig").EnablePrefixForIpv6SourceNatEnum;
const FixedResponseActionConfig = @import("fixed_response_action_config.zig").FixedResponseActionConfig;
const ForwardActionConfig = @import("forward_action_config.zig").ForwardActionConfig;
const HostHeaderConditionConfig = @import("host_header_condition_config.zig").HostHeaderConditionConfig;
const HostHeaderRewriteConfig = @import("host_header_rewrite_config.zig").HostHeaderRewriteConfig;
const HttpHeaderConditionConfig = @import("http_header_condition_config.zig").HttpHeaderConditionConfig;
const HttpRequestMethodConditionConfig = @import("http_request_method_condition_config.zig").HttpRequestMethodConditionConfig;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const IpamPools = @import("ipam_pools.zig").IpamPools;
const JwtValidationActionAdditionalClaim = @import("jwt_validation_action_additional_claim.zig").JwtValidationActionAdditionalClaim;
const JwtValidationActionAdditionalClaimFormatEnum = @import("jwt_validation_action_additional_claim_format_enum.zig").JwtValidationActionAdditionalClaimFormatEnum;
const JwtValidationActionConfig = @import("jwt_validation_action_config.zig").JwtValidationActionConfig;
const Limit = @import("limit.zig").Limit;
const Listener = @import("listener.zig").Listener;
const ListenerAttribute = @import("listener_attribute.zig").ListenerAttribute;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const LoadBalancerAddress = @import("load_balancer_address.zig").LoadBalancerAddress;
const LoadBalancerAttribute = @import("load_balancer_attribute.zig").LoadBalancerAttribute;
const LoadBalancerSchemeEnum = @import("load_balancer_scheme_enum.zig").LoadBalancerSchemeEnum;
const LoadBalancerState = @import("load_balancer_state.zig").LoadBalancerState;
const LoadBalancerStateEnum = @import("load_balancer_state_enum.zig").LoadBalancerStateEnum;
const LoadBalancerTypeEnum = @import("load_balancer_type_enum.zig").LoadBalancerTypeEnum;
const Matcher = @import("matcher.zig").Matcher;
const MinimumLoadBalancerCapacity = @import("minimum_load_balancer_capacity.zig").MinimumLoadBalancerCapacity;
const MitigationInEffectEnum = @import("mitigation_in_effect_enum.zig").MitigationInEffectEnum;
const MutualAuthenticationAttributes = @import("mutual_authentication_attributes.zig").MutualAuthenticationAttributes;
const PathPatternConditionConfig = @import("path_pattern_condition_config.zig").PathPatternConditionConfig;
const ProtocolEnum = @import("protocol_enum.zig").ProtocolEnum;
const QueryStringConditionConfig = @import("query_string_condition_config.zig").QueryStringConditionConfig;
const QueryStringKeyValuePair = @import("query_string_key_value_pair.zig").QueryStringKeyValuePair;
const RedirectActionConfig = @import("redirect_action_config.zig").RedirectActionConfig;
const RedirectActionStatusCodeEnum = @import("redirect_action_status_code_enum.zig").RedirectActionStatusCodeEnum;
const RemoveIpamPoolEnum = @import("remove_ipam_pool_enum.zig").RemoveIpamPoolEnum;
const RevocationContent = @import("revocation_content.zig").RevocationContent;
const RevocationType = @import("revocation_type.zig").RevocationType;
const RewriteConfig = @import("rewrite_config.zig").RewriteConfig;
const Rule = @import("rule.zig").Rule;
const RuleCondition = @import("rule_condition.zig").RuleCondition;
const RulePriorityPair = @import("rule_priority_pair.zig").RulePriorityPair;
const RuleTransform = @import("rule_transform.zig").RuleTransform;
const SourceIpConditionConfig = @import("source_ip_condition_config.zig").SourceIpConditionConfig;
const SslPolicy = @import("ssl_policy.zig").SslPolicy;
const SubnetMapping = @import("subnet_mapping.zig").SubnetMapping;
const Tag = @import("tag.zig").Tag;
const TagDescription = @import("tag_description.zig").TagDescription;
const TargetAdministrativeOverrideReasonEnum = @import("target_administrative_override_reason_enum.zig").TargetAdministrativeOverrideReasonEnum;
const TargetAdministrativeOverrideStateEnum = @import("target_administrative_override_state_enum.zig").TargetAdministrativeOverrideStateEnum;
const TargetDescription = @import("target_description.zig").TargetDescription;
const TargetGroup = @import("target_group.zig").TargetGroup;
const TargetGroupAttribute = @import("target_group_attribute.zig").TargetGroupAttribute;
const TargetGroupIpAddressTypeEnum = @import("target_group_ip_address_type_enum.zig").TargetGroupIpAddressTypeEnum;
const TargetGroupStickinessConfig = @import("target_group_stickiness_config.zig").TargetGroupStickinessConfig;
const TargetGroupTuple = @import("target_group_tuple.zig").TargetGroupTuple;
const TargetHealth = @import("target_health.zig").TargetHealth;
const TargetHealthDescription = @import("target_health_description.zig").TargetHealthDescription;
const TargetHealthReasonEnum = @import("target_health_reason_enum.zig").TargetHealthReasonEnum;
const TargetHealthStateEnum = @import("target_health_state_enum.zig").TargetHealthStateEnum;
const TargetTypeEnum = @import("target_type_enum.zig").TargetTypeEnum;
const TransformTypeEnum = @import("transform_type_enum.zig").TransformTypeEnum;
const TrustStore = @import("trust_store.zig").TrustStore;
const TrustStoreAssociation = @import("trust_store_association.zig").TrustStoreAssociation;
const TrustStoreAssociationStatusEnum = @import("trust_store_association_status_enum.zig").TrustStoreAssociationStatusEnum;
const TrustStoreRevocation = @import("trust_store_revocation.zig").TrustStoreRevocation;
const TrustStoreStatus = @import("trust_store_status.zig").TrustStoreStatus;
const UrlRewriteConfig = @import("url_rewrite_config.zig").UrlRewriteConfig;
const ZonalCapacityReservationState = @import("zonal_capacity_reservation_state.zig").ZonalCapacityReservationState;

pub fn deserializeActions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Action {
    var list: std.ArrayList(Action) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAction(reader, alloc));
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

pub fn deserializeAlpnPolicyName(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAvailabilityZones(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AvailabilityZone {
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

pub fn deserializeCertificateList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Certificate {
    var list: std.ArrayList(Certificate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCertificate(reader, alloc));
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

pub fn deserializeCiphers(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Cipher {
    var list: std.ArrayList(Cipher) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCipher(reader, alloc));
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

pub fn deserializeDescribeTrustStoreRevocationResponse(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DescribeTrustStoreRevocation {
    var list: std.ArrayList(DescribeTrustStoreRevocation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDescribeTrustStoreRevocation(reader, alloc));
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

pub fn deserializeJwtValidationActionAdditionalClaimValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeJwtValidationActionAdditionalClaims(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const JwtValidationActionAdditionalClaim {
    var list: std.ArrayList(JwtValidationActionAdditionalClaim) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeJwtValidationActionAdditionalClaim(reader, alloc));
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

pub fn deserializeLimits(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Limit {
    var list: std.ArrayList(Limit) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLimit(reader, alloc));
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

pub fn deserializeListOfString(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeListenerAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ListenerAttribute {
    var list: std.ArrayList(ListenerAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListenerAttribute(reader, alloc));
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

pub fn deserializeListeners(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Listener {
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

pub fn deserializeLoadBalancerAddresses(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LoadBalancerAddress {
    var list: std.ArrayList(LoadBalancerAddress) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLoadBalancerAddress(reader, alloc));
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

pub fn deserializeLoadBalancerArns(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeLoadBalancerAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LoadBalancerAttribute {
    var list: std.ArrayList(LoadBalancerAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLoadBalancerAttribute(reader, alloc));
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

pub fn deserializeLoadBalancers(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LoadBalancer {
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

pub fn deserializeQueryStringKeyValuePairList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const QueryStringKeyValuePair {
    var list: std.ArrayList(QueryStringKeyValuePair) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeQueryStringKeyValuePair(reader, alloc));
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

pub fn deserializeRewriteConfigList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RewriteConfig {
    var list: std.ArrayList(RewriteConfig) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRewriteConfig(reader, alloc));
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

pub fn deserializeRuleConditionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RuleCondition {
    var list: std.ArrayList(RuleCondition) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRuleCondition(reader, alloc));
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

pub fn deserializeRuleTransformList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RuleTransform {
    var list: std.ArrayList(RuleTransform) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRuleTransform(reader, alloc));
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

pub fn deserializeRules(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Rule {
    var list: std.ArrayList(Rule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRule(reader, alloc));
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

pub fn deserializeSourceNatIpv6Prefixes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSslPolicies(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SslPolicy {
    var list: std.ArrayList(SslPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSslPolicy(reader, alloc));
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

pub fn deserializeSslProtocols(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTagDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TagDescription {
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

pub fn deserializeTargetGroupAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TargetGroupAttribute {
    var list: std.ArrayList(TargetGroupAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTargetGroupAttribute(reader, alloc));
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

pub fn deserializeTargetGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TargetGroupTuple {
    var list: std.ArrayList(TargetGroupTuple) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTargetGroupTuple(reader, alloc));
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

pub fn deserializeTargetGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TargetGroup {
    var list: std.ArrayList(TargetGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTargetGroup(reader, alloc));
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

pub fn deserializeTargetHealthDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TargetHealthDescription {
    var list: std.ArrayList(TargetHealthDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTargetHealthDescription(reader, alloc));
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

pub fn deserializeTrustStoreAssociations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrustStoreAssociation {
    var list: std.ArrayList(TrustStoreAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrustStoreAssociation(reader, alloc));
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

pub fn deserializeTrustStoreRevocations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrustStoreRevocation {
    var list: std.ArrayList(TrustStoreRevocation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrustStoreRevocation(reader, alloc));
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

pub fn deserializeTrustStores(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrustStore {
    var list: std.ArrayList(TrustStore) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrustStore(reader, alloc));
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

pub fn deserializeZonalCapacityReservationStates(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ZonalCapacityReservationState {
    var list: std.ArrayList(ZonalCapacityReservationState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeZonalCapacityReservationState(reader, alloc));
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

pub fn deserializeAuthenticateCognitoActionAuthenticationRequestExtraParams(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try alloc.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
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

pub fn deserializeAuthenticateOidcActionAuthenticationRequestExtraParams(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try alloc.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
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

pub fn deserializeAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Action {
    var result: Action = undefined;
    result.authenticate_cognito_config = null;
    result.authenticate_oidc_config = null;
    result.fixed_response_config = null;
    result.forward_config = null;
    result.jwt_validation_config = null;
    result.order = null;
    result.redirect_config = null;
    result.target_group_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthenticateCognitoConfig")) {
                    result.authenticate_cognito_config = try deserializeAuthenticateCognitoActionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AuthenticateOidcConfig")) {
                    result.authenticate_oidc_config = try deserializeAuthenticateOidcActionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "FixedResponseConfig")) {
                    result.fixed_response_config = try deserializeFixedResponseActionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ForwardConfig")) {
                    result.forward_config = try deserializeForwardActionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "JwtValidationConfig")) {
                    result.jwt_validation_config = try deserializeJwtValidationActionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Order")) {
                    result.order = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RedirectConfig")) {
                    result.redirect_config = try deserializeRedirectActionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TargetGroupArn")) {
                    result.target_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(ActionTypeEnum, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAdministrativeOverride(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AdministrativeOverride {
    var result: AdministrativeOverride = undefined;
    result.description = null;
    result.reason = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = std.meta.stringToEnum(TargetAdministrativeOverrideReasonEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = std.meta.stringToEnum(TargetAdministrativeOverrideStateEnum, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnomalyDetection(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnomalyDetection {
    _ = alloc;
    var result: AnomalyDetection = undefined;
    result.mitigation_in_effect = null;
    result.result = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MitigationInEffect")) {
                    result.mitigation_in_effect = std.meta.stringToEnum(MitigationInEffectEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Result")) {
                    result.result = std.meta.stringToEnum(AnomalyResultEnum, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAuthenticateCognitoActionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AuthenticateCognitoActionConfig {
    var result: AuthenticateCognitoActionConfig = undefined;
    result.authentication_request_extra_params = null;
    result.on_unauthenticated_request = null;
    result.scope = null;
    result.session_cookie_name = null;
    result.session_timeout = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthenticationRequestExtraParams")) {
                    result.authentication_request_extra_params = try deserializeAuthenticateCognitoActionAuthenticationRequestExtraParams(reader, alloc, "entry");
                } else if (std.mem.eql(u8, e.local, "OnUnauthenticatedRequest")) {
                    result.on_unauthenticated_request = std.meta.stringToEnum(AuthenticateCognitoActionConditionalBehaviorEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Scope")) {
                    result.scope = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionCookieName")) {
                    result.session_cookie_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionTimeout")) {
                    result.session_timeout = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "UserPoolArn")) {
                    result.user_pool_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserPoolClientId")) {
                    result.user_pool_client_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserPoolDomain")) {
                    result.user_pool_domain = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAuthenticateOidcActionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AuthenticateOidcActionConfig {
    var result: AuthenticateOidcActionConfig = undefined;
    result.authentication_request_extra_params = null;
    result.client_secret = null;
    result.on_unauthenticated_request = null;
    result.scope = null;
    result.session_cookie_name = null;
    result.session_timeout = null;
    result.use_existing_client_secret = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthenticationRequestExtraParams")) {
                    result.authentication_request_extra_params = try deserializeAuthenticateOidcActionAuthenticationRequestExtraParams(reader, alloc, "entry");
                } else if (std.mem.eql(u8, e.local, "AuthorizationEndpoint")) {
                    result.authorization_endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClientId")) {
                    result.client_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClientSecret")) {
                    result.client_secret = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Issuer")) {
                    result.issuer = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OnUnauthenticatedRequest")) {
                    result.on_unauthenticated_request = std.meta.stringToEnum(AuthenticateOidcActionConditionalBehaviorEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Scope")) {
                    result.scope = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionCookieName")) {
                    result.session_cookie_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionTimeout")) {
                    result.session_timeout = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TokenEndpoint")) {
                    result.token_endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UseExistingClientSecret")) {
                    result.use_existing_client_secret = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "UserInfoEndpoint")) {
                    result.user_info_endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else {
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
    result.load_balancer_addresses = null;
    result.outpost_id = null;
    result.source_nat_ipv_6_prefixes = null;
    result.subnet_id = null;
    result.zone_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancerAddresses")) {
                    result.load_balancer_addresses = try deserializeLoadBalancerAddresses(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "OutpostId")) {
                    result.outpost_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceNatIpv6Prefixes")) {
                    result.source_nat_ipv_6_prefixes = try deserializeSourceNatIpv6Prefixes(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SubnetId")) {
                    result.subnet_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ZoneName")) {
                    result.zone_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCapacityReservationStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CapacityReservationStatus {
    var result: CapacityReservationStatus = undefined;
    result.code = null;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = std.meta.stringToEnum(CapacityReservationStateEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCertificate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Certificate {
    var result: Certificate = undefined;
    result.certificate_arn = null;
    result.is_default = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateArn")) {
                    result.certificate_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCipher(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Cipher {
    var result: Cipher = undefined;
    result.name = null;
    result.priority = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Priority")) {
                    result.priority = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDescribeTrustStoreRevocation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DescribeTrustStoreRevocation {
    var result: DescribeTrustStoreRevocation = undefined;
    result.number_of_revoked_entries = null;
    result.revocation_id = null;
    result.revocation_type = null;
    result.trust_store_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NumberOfRevokedEntries")) {
                    result.number_of_revoked_entries = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RevocationId")) {
                    result.revocation_id = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RevocationType")) {
                    result.revocation_type = std.meta.stringToEnum(RevocationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreArn")) {
                    result.trust_store_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFixedResponseActionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FixedResponseActionConfig {
    var result: FixedResponseActionConfig = undefined;
    result.content_type = null;
    result.message_body = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContentType")) {
                    result.content_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MessageBody")) {
                    result.message_body = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeForwardActionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ForwardActionConfig {
    var result: ForwardActionConfig = undefined;
    result.target_groups = null;
    result.target_group_stickiness_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TargetGroups")) {
                    result.target_groups = try deserializeTargetGroupList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "TargetGroupStickinessConfig")) {
                    result.target_group_stickiness_config = try deserializeTargetGroupStickinessConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostHeaderConditionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HostHeaderConditionConfig {
    var result: HostHeaderConditionConfig = undefined;
    result.regex_values = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RegexValues")) {
                    result.regex_values = try deserializeListOfString(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostHeaderRewriteConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HostHeaderRewriteConfig {
    var result: HostHeaderRewriteConfig = undefined;
    result.rewrites = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rewrites")) {
                    result.rewrites = try deserializeRewriteConfigList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHttpHeaderConditionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HttpHeaderConditionConfig {
    var result: HttpHeaderConditionConfig = undefined;
    result.http_header_name = null;
    result.regex_values = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HttpHeaderName")) {
                    result.http_header_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RegexValues")) {
                    result.regex_values = try deserializeListOfString(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHttpRequestMethodConditionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HttpRequestMethodConditionConfig {
    var result: HttpRequestMethodConditionConfig = undefined;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIpamPools(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IpamPools {
    var result: IpamPools = undefined;
    result.ipv_4_ipam_pool_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Ipv4IpamPoolId")) {
                    result.ipv_4_ipam_pool_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJwtValidationActionAdditionalClaim(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JwtValidationActionAdditionalClaim {
    var result: JwtValidationActionAdditionalClaim = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = std.meta.stringToEnum(JwtValidationActionAdditionalClaimFormatEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeJwtValidationActionAdditionalClaimValues(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJwtValidationActionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !JwtValidationActionConfig {
    var result: JwtValidationActionConfig = undefined;
    result.additional_claims = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalClaims")) {
                    result.additional_claims = try deserializeJwtValidationActionAdditionalClaims(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Issuer")) {
                    result.issuer = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "JwksEndpoint")) {
                    result.jwks_endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLimit(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Limit {
    var result: Limit = undefined;
    result.max = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
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

pub fn deserializeListener(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Listener {
    var result: Listener = undefined;
    result.alpn_policy = null;
    result.certificates = null;
    result.default_actions = null;
    result.listener_arn = null;
    result.load_balancer_arn = null;
    result.mutual_authentication = null;
    result.port = null;
    result.protocol = null;
    result.ssl_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlpnPolicy")) {
                    result.alpn_policy = try deserializeAlpnPolicyName(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Certificates")) {
                    result.certificates = try deserializeCertificateList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "DefaultActions")) {
                    result.default_actions = try deserializeActions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ListenerArn")) {
                    result.listener_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LoadBalancerArn")) {
                    result.load_balancer_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MutualAuthentication")) {
                    result.mutual_authentication = try deserializeMutualAuthenticationAttributes(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = std.meta.stringToEnum(ProtocolEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SslPolicy")) {
                    result.ssl_policy = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeListenerAttribute(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ListenerAttribute {
    var result: ListenerAttribute = undefined;
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

pub fn deserializeLoadBalancer(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancer {
    var result: LoadBalancer = undefined;
    result.availability_zones = null;
    result.canonical_hosted_zone_id = null;
    result.created_time = null;
    result.customer_owned_ipv_4_pool = null;
    result.dns_name = null;
    result.enable_prefix_for_ipv_6_source_nat = null;
    result.enforce_security_group_inbound_rules_on_private_link_traffic = null;
    result.ip_address_type = null;
    result.ipam_pools = null;
    result.load_balancer_arn = null;
    result.load_balancer_name = null;
    result.scheme = null;
    result.security_groups = null;
    result.state = null;
    result.@"type" = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try deserializeAvailabilityZones(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "CanonicalHostedZoneId")) {
                    result.canonical_hosted_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CustomerOwnedIpv4Pool")) {
                    result.customer_owned_ipv_4_pool = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DNSName")) {
                    result.dns_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnablePrefixForIpv6SourceNat")) {
                    result.enable_prefix_for_ipv_6_source_nat = std.meta.stringToEnum(EnablePrefixForIpv6SourceNatEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnforceSecurityGroupInboundRulesOnPrivateLinkTraffic")) {
                    result.enforce_security_group_inbound_rules_on_private_link_traffic = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = std.meta.stringToEnum(IpAddressType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpamPools")) {
                    result.ipam_pools = try deserializeIpamPools(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LoadBalancerArn")) {
                    result.load_balancer_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Scheme")) {
                    result.scheme = std.meta.stringToEnum(LoadBalancerSchemeEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecurityGroups")) {
                    result.security_groups = try deserializeSecurityGroups(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try deserializeLoadBalancerState(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(LoadBalancerTypeEnum, try reader.readElementText());
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

pub fn deserializeLoadBalancerAddress(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancerAddress {
    var result: LoadBalancerAddress = undefined;
    result.allocation_id = null;
    result.ip_address = null;
    result.i_pv_6_address = null;
    result.private_i_pv_4_address = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocationId")) {
                    result.allocation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpAddress")) {
                    result.ip_address = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IPv6Address")) {
                    result.i_pv_6_address = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PrivateIPv4Address")) {
                    result.private_i_pv_4_address = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoadBalancerAttribute(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancerAttribute {
    var result: LoadBalancerAttribute = undefined;
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

pub fn deserializeLoadBalancerState(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoadBalancerState {
    var result: LoadBalancerState = undefined;
    result.code = null;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = std.meta.stringToEnum(LoadBalancerStateEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMatcher(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Matcher {
    var result: Matcher = undefined;
    result.grpc_code = null;
    result.http_code = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GrpcCode")) {
                    result.grpc_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpCode")) {
                    result.http_code = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMinimumLoadBalancerCapacity(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MinimumLoadBalancerCapacity {
    _ = alloc;
    var result: MinimumLoadBalancerCapacity = undefined;
    result.capacity_units = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CapacityUnits")) {
                    result.capacity_units = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMutualAuthenticationAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MutualAuthenticationAttributes {
    var result: MutualAuthenticationAttributes = undefined;
    result.advertise_trust_store_ca_names = null;
    result.ignore_client_certificate_expiry = null;
    result.mode = null;
    result.trust_store_arn = null;
    result.trust_store_association_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdvertiseTrustStoreCaNames")) {
                    result.advertise_trust_store_ca_names = std.meta.stringToEnum(AdvertiseTrustStoreCaNamesEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IgnoreClientCertificateExpiry")) {
                    result.ignore_client_certificate_expiry = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreArn")) {
                    result.trust_store_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreAssociationStatus")) {
                    result.trust_store_association_status = std.meta.stringToEnum(TrustStoreAssociationStatusEnum, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePathPatternConditionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PathPatternConditionConfig {
    var result: PathPatternConditionConfig = undefined;
    result.regex_values = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RegexValues")) {
                    result.regex_values = try deserializeListOfString(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryStringConditionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !QueryStringConditionConfig {
    var result: QueryStringConditionConfig = undefined;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeQueryStringKeyValuePairList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryStringKeyValuePair(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !QueryStringKeyValuePair {
    var result: QueryStringKeyValuePair = undefined;
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

pub fn deserializeRedirectActionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RedirectActionConfig {
    var result: RedirectActionConfig = undefined;
    result.host = null;
    result.path = null;
    result.port = null;
    result.protocol = null;
    result.query = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Host")) {
                    result.host = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Query")) {
                    result.query = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = std.meta.stringToEnum(RedirectActionStatusCodeEnum, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRewriteConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RewriteConfig {
    var result: RewriteConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Regex")) {
                    result.regex = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Replace")) {
                    result.replace = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Rule {
    var result: Rule = undefined;
    result.actions = null;
    result.conditions = null;
    result.is_default = null;
    result.priority = null;
    result.rule_arn = null;
    result.transforms = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Actions")) {
                    result.actions = try deserializeActions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Conditions")) {
                    result.conditions = try deserializeRuleConditionList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Priority")) {
                    result.priority = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RuleArn")) {
                    result.rule_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Transforms")) {
                    result.transforms = try deserializeRuleTransformList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRuleCondition(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RuleCondition {
    var result: RuleCondition = undefined;
    result.field = null;
    result.host_header_config = null;
    result.http_header_config = null;
    result.http_request_method_config = null;
    result.path_pattern_config = null;
    result.query_string_config = null;
    result.regex_values = null;
    result.source_ip_config = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Field")) {
                    result.field = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostHeaderConfig")) {
                    result.host_header_config = try deserializeHostHeaderConditionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "HttpHeaderConfig")) {
                    result.http_header_config = try deserializeHttpHeaderConditionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "HttpRequestMethodConfig")) {
                    result.http_request_method_config = try deserializeHttpRequestMethodConditionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PathPatternConfig")) {
                    result.path_pattern_config = try deserializePathPatternConditionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "QueryStringConfig")) {
                    result.query_string_config = try deserializeQueryStringConditionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RegexValues")) {
                    result.regex_values = try deserializeListOfString(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SourceIpConfig")) {
                    result.source_ip_config = try deserializeSourceIpConditionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRuleTransform(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RuleTransform {
    var result: RuleTransform = undefined;
    result.host_header_rewrite_config = null;
    result.url_rewrite_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostHeaderRewriteConfig")) {
                    result.host_header_rewrite_config = try deserializeHostHeaderRewriteConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(TransformTypeEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UrlRewriteConfig")) {
                    result.url_rewrite_config = try deserializeUrlRewriteConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSourceIpConditionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SourceIpConditionConfig {
    var result: SourceIpConditionConfig = undefined;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSslPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SslPolicy {
    var result: SslPolicy = undefined;
    result.ciphers = null;
    result.name = null;
    result.ssl_protocols = null;
    result.supported_load_balancer_types = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Ciphers")) {
                    result.ciphers = try deserializeCiphers(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SslProtocols")) {
                    result.ssl_protocols = try deserializeSslProtocols(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedLoadBalancerTypes")) {
                    result.supported_load_balancer_types = try deserializeListOfString(reader, alloc, "member");
                } else {
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

pub fn deserializeTagDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TagDescription {
    var result: TagDescription = undefined;
    result.resource_arn = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceArn")) {
                    result.resource_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetDescription {
    var result: TargetDescription = undefined;
    result.availability_zone = null;
    result.port = null;
    result.quic_server_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "QuicServerId")) {
                    result.quic_server_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetGroup {
    var result: TargetGroup = undefined;
    result.health_check_enabled = null;
    result.health_check_interval_seconds = null;
    result.health_check_path = null;
    result.health_check_port = null;
    result.health_check_protocol = null;
    result.health_check_timeout_seconds = null;
    result.healthy_threshold_count = null;
    result.ip_address_type = null;
    result.load_balancer_arns = null;
    result.matcher = null;
    result.port = null;
    result.protocol = null;
    result.protocol_version = null;
    result.target_control_port = null;
    result.target_group_arn = null;
    result.target_group_name = null;
    result.target_type = null;
    result.unhealthy_threshold_count = null;
    result.vpc_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HealthCheckEnabled")) {
                    result.health_check_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HealthCheckIntervalSeconds")) {
                    result.health_check_interval_seconds = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "HealthCheckPath")) {
                    result.health_check_path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthCheckPort")) {
                    result.health_check_port = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthCheckProtocol")) {
                    result.health_check_protocol = std.meta.stringToEnum(ProtocolEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthCheckTimeoutSeconds")) {
                    result.health_check_timeout_seconds = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "HealthyThresholdCount")) {
                    result.healthy_threshold_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = std.meta.stringToEnum(TargetGroupIpAddressTypeEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LoadBalancerArns")) {
                    result.load_balancer_arns = try deserializeLoadBalancerArns(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Matcher")) {
                    result.matcher = try deserializeMatcher(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = std.meta.stringToEnum(ProtocolEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProtocolVersion")) {
                    result.protocol_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetControlPort")) {
                    result.target_control_port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TargetGroupArn")) {
                    result.target_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetGroupName")) {
                    result.target_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetType")) {
                    result.target_type = std.meta.stringToEnum(TargetTypeEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UnhealthyThresholdCount")) {
                    result.unhealthy_threshold_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeTargetGroupAttribute(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetGroupAttribute {
    var result: TargetGroupAttribute = undefined;
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

pub fn deserializeTargetGroupStickinessConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetGroupStickinessConfig {
    _ = alloc;
    var result: TargetGroupStickinessConfig = undefined;
    result.duration_seconds = null;
    result.enabled = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DurationSeconds")) {
                    result.duration_seconds = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
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

pub fn deserializeTargetGroupTuple(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetGroupTuple {
    var result: TargetGroupTuple = undefined;
    result.target_group_arn = null;
    result.weight = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TargetGroupArn")) {
                    result.target_group_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Weight")) {
                    result.weight = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetHealth(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetHealth {
    var result: TargetHealth = undefined;
    result.description = null;
    result.reason = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = std.meta.stringToEnum(TargetHealthReasonEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = std.meta.stringToEnum(TargetHealthStateEnum, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetHealthDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TargetHealthDescription {
    var result: TargetHealthDescription = undefined;
    result.administrative_override = null;
    result.anomaly_detection = null;
    result.health_check_port = null;
    result.target = null;
    result.target_health = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdministrativeOverride")) {
                    result.administrative_override = try deserializeAdministrativeOverride(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AnomalyDetection")) {
                    result.anomaly_detection = try deserializeAnomalyDetection(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "HealthCheckPort")) {
                    result.health_check_port = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Target")) {
                    result.target = try deserializeTargetDescription(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TargetHealth")) {
                    result.target_health = try deserializeTargetHealth(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustStore(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrustStore {
    var result: TrustStore = undefined;
    result.name = null;
    result.number_of_ca_certificates = null;
    result.status = null;
    result.total_revoked_entries = null;
    result.trust_store_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfCaCertificates")) {
                    result.number_of_ca_certificates = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(TrustStoreStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TotalRevokedEntries")) {
                    result.total_revoked_entries = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TrustStoreArn")) {
                    result.trust_store_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustStoreAssociation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrustStoreAssociation {
    var result: TrustStoreAssociation = undefined;
    result.resource_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceArn")) {
                    result.resource_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustStoreRevocation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrustStoreRevocation {
    var result: TrustStoreRevocation = undefined;
    result.number_of_revoked_entries = null;
    result.revocation_id = null;
    result.revocation_type = null;
    result.trust_store_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NumberOfRevokedEntries")) {
                    result.number_of_revoked_entries = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RevocationId")) {
                    result.revocation_id = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RevocationType")) {
                    result.revocation_type = std.meta.stringToEnum(RevocationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreArn")) {
                    result.trust_store_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUrlRewriteConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !UrlRewriteConfig {
    var result: UrlRewriteConfig = undefined;
    result.rewrites = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rewrites")) {
                    result.rewrites = try deserializeRewriteConfigList(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeZonalCapacityReservationState(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ZonalCapacityReservationState {
    var result: ZonalCapacityReservationState = undefined;
    result.availability_zone = null;
    result.effective_capacity_units = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EffectiveCapacityUnits")) {
                    result.effective_capacity_units = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try deserializeCapacityReservationStatus(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeActions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Action, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeAction(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAlpnPolicyName(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCertificateList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Certificate, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeCertificate(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeJwtValidationActionAdditionalClaimValues(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeJwtValidationActionAdditionalClaims(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const JwtValidationActionAdditionalClaim, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeJwtValidationActionAdditionalClaim(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeListOfDescribeTargetHealthIncludeOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const DescribeTargetHealthInputIncludeEnum, comptime item_tag: []const u8) !void {
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

pub fn serializeListOfString(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeListenerArns(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeListenerAttributes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ListenerAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeListenerAttribute(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeLoadBalancerArns(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLoadBalancerAttributes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LoadBalancerAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeLoadBalancerAttribute(alloc, buf, item);
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

pub fn serializeQueryStringKeyValuePairList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const QueryStringKeyValuePair, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeQueryStringKeyValuePair(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRemoveIpamPools(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RemoveIpamPoolEnum, comptime item_tag: []const u8) !void {
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

pub fn serializeResourceArns(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRevocationContents(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RevocationContent, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRevocationContent(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRevocationIds(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const i64, comptime item_tag: []const u8) !void {
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

pub fn serializeRewriteConfigList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RewriteConfig, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRewriteConfig(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRuleArns(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRuleConditionList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RuleCondition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRuleCondition(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRulePriorityList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RulePriorityPair, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRulePriorityPair(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRuleTransformList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RuleTransform, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRuleTransform(alloc, buf, item);
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

pub fn serializeSslPolicyNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSubnetMappings(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const SubnetMapping, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeSubnetMapping(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeSubnets(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTagKeys(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTargetDescriptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TargetDescription, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTargetDescription(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTargetGroupArns(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTargetGroupAttributes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TargetGroupAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTargetGroupAttribute(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTargetGroupList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TargetGroupTuple, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTargetGroupTuple(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTargetGroupNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTrustStoreArns(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTrustStoreNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAuthenticateCognitoActionAuthenticationRequestExtraParams(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, "<key>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.key);
        try buf.appendSlice(alloc, "</key>");
        try buf.appendSlice(alloc, "<value>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.value);
        try buf.appendSlice(alloc, "</value>");
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAuthenticateOidcActionAuthenticationRequestExtraParams(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, "<key>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.key);
        try buf.appendSlice(alloc, "</key>");
        try buf.appendSlice(alloc, "<value>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.value);
        try buf.appendSlice(alloc, "</value>");
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Action) !void {
    if (value.authenticate_cognito_config) |v| {
        try buf.appendSlice(alloc, "<AuthenticateCognitoConfig>");
        try serializeAuthenticateCognitoActionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</AuthenticateCognitoConfig>");
    }
    if (value.authenticate_oidc_config) |v| {
        try buf.appendSlice(alloc, "<AuthenticateOidcConfig>");
        try serializeAuthenticateOidcActionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</AuthenticateOidcConfig>");
    }
    if (value.fixed_response_config) |v| {
        try buf.appendSlice(alloc, "<FixedResponseConfig>");
        try serializeFixedResponseActionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</FixedResponseConfig>");
    }
    if (value.forward_config) |v| {
        try buf.appendSlice(alloc, "<ForwardConfig>");
        try serializeForwardActionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</ForwardConfig>");
    }
    if (value.jwt_validation_config) |v| {
        try buf.appendSlice(alloc, "<JwtValidationConfig>");
        try serializeJwtValidationActionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</JwtValidationConfig>");
    }
    if (value.order) |v| {
        try buf.appendSlice(alloc, "<Order>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Order>");
    }
    if (value.redirect_config) |v| {
        try buf.appendSlice(alloc, "<RedirectConfig>");
        try serializeRedirectActionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</RedirectConfig>");
    }
    if (value.target_group_arn) |v| {
        try buf.appendSlice(alloc, "<TargetGroupArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TargetGroupArn>");
    }
    try buf.appendSlice(alloc, "<Type>");
    try buf.appendSlice(alloc, @tagName(value.@"type"));
    try buf.appendSlice(alloc, "</Type>");
}

pub fn serializeAuthenticateCognitoActionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AuthenticateCognitoActionConfig) !void {
    if (value.authentication_request_extra_params) |v| {
        try buf.appendSlice(alloc, "<AuthenticationRequestExtraParams>");
        try serializeAuthenticateCognitoActionAuthenticationRequestExtraParams(alloc, buf, v, "entry");
        try buf.appendSlice(alloc, "</AuthenticationRequestExtraParams>");
    }
    if (value.on_unauthenticated_request) |v| {
        try buf.appendSlice(alloc, "<OnUnauthenticatedRequest>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</OnUnauthenticatedRequest>");
    }
    if (value.scope) |v| {
        try buf.appendSlice(alloc, "<Scope>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Scope>");
    }
    if (value.session_cookie_name) |v| {
        try buf.appendSlice(alloc, "<SessionCookieName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SessionCookieName>");
    }
    if (value.session_timeout) |v| {
        try buf.appendSlice(alloc, "<SessionTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</SessionTimeout>");
    }
    try buf.appendSlice(alloc, "<UserPoolArn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.user_pool_arn);
    try buf.appendSlice(alloc, "</UserPoolArn>");
    try buf.appendSlice(alloc, "<UserPoolClientId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.user_pool_client_id);
    try buf.appendSlice(alloc, "</UserPoolClientId>");
    try buf.appendSlice(alloc, "<UserPoolDomain>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.user_pool_domain);
    try buf.appendSlice(alloc, "</UserPoolDomain>");
}

pub fn serializeAuthenticateOidcActionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AuthenticateOidcActionConfig) !void {
    if (value.authentication_request_extra_params) |v| {
        try buf.appendSlice(alloc, "<AuthenticationRequestExtraParams>");
        try serializeAuthenticateOidcActionAuthenticationRequestExtraParams(alloc, buf, v, "entry");
        try buf.appendSlice(alloc, "</AuthenticationRequestExtraParams>");
    }
    try buf.appendSlice(alloc, "<AuthorizationEndpoint>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.authorization_endpoint);
    try buf.appendSlice(alloc, "</AuthorizationEndpoint>");
    try buf.appendSlice(alloc, "<ClientId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.client_id);
    try buf.appendSlice(alloc, "</ClientId>");
    if (value.client_secret) |v| {
        try buf.appendSlice(alloc, "<ClientSecret>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ClientSecret>");
    }
    try buf.appendSlice(alloc, "<Issuer>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.issuer);
    try buf.appendSlice(alloc, "</Issuer>");
    if (value.on_unauthenticated_request) |v| {
        try buf.appendSlice(alloc, "<OnUnauthenticatedRequest>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</OnUnauthenticatedRequest>");
    }
    if (value.scope) |v| {
        try buf.appendSlice(alloc, "<Scope>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Scope>");
    }
    if (value.session_cookie_name) |v| {
        try buf.appendSlice(alloc, "<SessionCookieName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SessionCookieName>");
    }
    if (value.session_timeout) |v| {
        try buf.appendSlice(alloc, "<SessionTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</SessionTimeout>");
    }
    try buf.appendSlice(alloc, "<TokenEndpoint>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.token_endpoint);
    try buf.appendSlice(alloc, "</TokenEndpoint>");
    if (value.use_existing_client_secret) |v| {
        try buf.appendSlice(alloc, "<UseExistingClientSecret>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</UseExistingClientSecret>");
    }
    try buf.appendSlice(alloc, "<UserInfoEndpoint>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.user_info_endpoint);
    try buf.appendSlice(alloc, "</UserInfoEndpoint>");
}

pub fn serializeCertificate(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Certificate) !void {
    if (value.certificate_arn) |v| {
        try buf.appendSlice(alloc, "<CertificateArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</CertificateArn>");
    }
    if (value.is_default) |v| {
        try buf.appendSlice(alloc, "<IsDefault>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsDefault>");
    }
}

pub fn serializeFixedResponseActionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: FixedResponseActionConfig) !void {
    if (value.content_type) |v| {
        try buf.appendSlice(alloc, "<ContentType>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentType>");
    }
    if (value.message_body) |v| {
        try buf.appendSlice(alloc, "<MessageBody>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</MessageBody>");
    }
    try buf.appendSlice(alloc, "<StatusCode>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.status_code);
    try buf.appendSlice(alloc, "</StatusCode>");
}

pub fn serializeForwardActionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ForwardActionConfig) !void {
    if (value.target_groups) |v| {
        try buf.appendSlice(alloc, "<TargetGroups>");
        try serializeTargetGroupList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</TargetGroups>");
    }
    if (value.target_group_stickiness_config) |v| {
        try buf.appendSlice(alloc, "<TargetGroupStickinessConfig>");
        try serializeTargetGroupStickinessConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</TargetGroupStickinessConfig>");
    }
}

pub fn serializeHostHeaderConditionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: HostHeaderConditionConfig) !void {
    if (value.regex_values) |v| {
        try buf.appendSlice(alloc, "<RegexValues>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</RegexValues>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeHostHeaderRewriteConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: HostHeaderRewriteConfig) !void {
    if (value.rewrites) |v| {
        try buf.appendSlice(alloc, "<Rewrites>");
        try serializeRewriteConfigList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Rewrites>");
    }
}

pub fn serializeHttpHeaderConditionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: HttpHeaderConditionConfig) !void {
    if (value.http_header_name) |v| {
        try buf.appendSlice(alloc, "<HttpHeaderName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</HttpHeaderName>");
    }
    if (value.regex_values) |v| {
        try buf.appendSlice(alloc, "<RegexValues>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</RegexValues>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeHttpRequestMethodConditionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: HttpRequestMethodConditionConfig) !void {
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeIpamPools(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: IpamPools) !void {
    if (value.ipv_4_ipam_pool_id) |v| {
        try buf.appendSlice(alloc, "<Ipv4IpamPoolId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Ipv4IpamPoolId>");
    }
}

pub fn serializeJwtValidationActionAdditionalClaim(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: JwtValidationActionAdditionalClaim) !void {
    try buf.appendSlice(alloc, "<Format>");
    try buf.appendSlice(alloc, @tagName(value.format));
    try buf.appendSlice(alloc, "</Format>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Values>");
    try serializeJwtValidationActionAdditionalClaimValues(alloc, buf, value.values, "member");
    try buf.appendSlice(alloc, "</Values>");
}

pub fn serializeJwtValidationActionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: JwtValidationActionConfig) !void {
    if (value.additional_claims) |v| {
        try buf.appendSlice(alloc, "<AdditionalClaims>");
        try serializeJwtValidationActionAdditionalClaims(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</AdditionalClaims>");
    }
    try buf.appendSlice(alloc, "<Issuer>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.issuer);
    try buf.appendSlice(alloc, "</Issuer>");
    try buf.appendSlice(alloc, "<JwksEndpoint>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.jwks_endpoint);
    try buf.appendSlice(alloc, "</JwksEndpoint>");
}

pub fn serializeListenerAttribute(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ListenerAttribute) !void {
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

pub fn serializeLoadBalancerAttribute(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LoadBalancerAttribute) !void {
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

pub fn serializeMatcher(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Matcher) !void {
    if (value.grpc_code) |v| {
        try buf.appendSlice(alloc, "<GrpcCode>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</GrpcCode>");
    }
    if (value.http_code) |v| {
        try buf.appendSlice(alloc, "<HttpCode>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</HttpCode>");
    }
}

pub fn serializeMinimumLoadBalancerCapacity(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MinimumLoadBalancerCapacity) !void {
    if (value.capacity_units) |v| {
        try buf.appendSlice(alloc, "<CapacityUnits>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</CapacityUnits>");
    }
}

pub fn serializeMutualAuthenticationAttributes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MutualAuthenticationAttributes) !void {
    if (value.advertise_trust_store_ca_names) |v| {
        try buf.appendSlice(alloc, "<AdvertiseTrustStoreCaNames>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</AdvertiseTrustStoreCaNames>");
    }
    if (value.ignore_client_certificate_expiry) |v| {
        try buf.appendSlice(alloc, "<IgnoreClientCertificateExpiry>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IgnoreClientCertificateExpiry>");
    }
    if (value.mode) |v| {
        try buf.appendSlice(alloc, "<Mode>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Mode>");
    }
    if (value.trust_store_arn) |v| {
        try buf.appendSlice(alloc, "<TrustStoreArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TrustStoreArn>");
    }
    if (value.trust_store_association_status) |v| {
        try buf.appendSlice(alloc, "<TrustStoreAssociationStatus>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</TrustStoreAssociationStatus>");
    }
}

pub fn serializePathPatternConditionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PathPatternConditionConfig) !void {
    if (value.regex_values) |v| {
        try buf.appendSlice(alloc, "<RegexValues>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</RegexValues>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeQueryStringConditionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryStringConditionConfig) !void {
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeQueryStringKeyValuePairList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeQueryStringKeyValuePair(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryStringKeyValuePair) !void {
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

pub fn serializeRedirectActionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RedirectActionConfig) !void {
    if (value.host) |v| {
        try buf.appendSlice(alloc, "<Host>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Host>");
    }
    if (value.path) |v| {
        try buf.appendSlice(alloc, "<Path>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Path>");
    }
    if (value.port) |v| {
        try buf.appendSlice(alloc, "<Port>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Port>");
    }
    if (value.protocol) |v| {
        try buf.appendSlice(alloc, "<Protocol>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Protocol>");
    }
    if (value.query) |v| {
        try buf.appendSlice(alloc, "<Query>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Query>");
    }
    try buf.appendSlice(alloc, "<StatusCode>");
    try buf.appendSlice(alloc, @tagName(value.status_code));
    try buf.appendSlice(alloc, "</StatusCode>");
}

pub fn serializeRevocationContent(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RevocationContent) !void {
    if (value.revocation_type) |v| {
        try buf.appendSlice(alloc, "<RevocationType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</RevocationType>");
    }
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
    if (value.s3_object_version) |v| {
        try buf.appendSlice(alloc, "<S3ObjectVersion>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3ObjectVersion>");
    }
}

pub fn serializeRewriteConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RewriteConfig) !void {
    try buf.appendSlice(alloc, "<Regex>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.regex);
    try buf.appendSlice(alloc, "</Regex>");
    try buf.appendSlice(alloc, "<Replace>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.replace);
    try buf.appendSlice(alloc, "</Replace>");
}

pub fn serializeRuleCondition(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RuleCondition) !void {
    if (value.field) |v| {
        try buf.appendSlice(alloc, "<Field>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Field>");
    }
    if (value.host_header_config) |v| {
        try buf.appendSlice(alloc, "<HostHeaderConfig>");
        try serializeHostHeaderConditionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</HostHeaderConfig>");
    }
    if (value.http_header_config) |v| {
        try buf.appendSlice(alloc, "<HttpHeaderConfig>");
        try serializeHttpHeaderConditionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</HttpHeaderConfig>");
    }
    if (value.http_request_method_config) |v| {
        try buf.appendSlice(alloc, "<HttpRequestMethodConfig>");
        try serializeHttpRequestMethodConditionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</HttpRequestMethodConfig>");
    }
    if (value.path_pattern_config) |v| {
        try buf.appendSlice(alloc, "<PathPatternConfig>");
        try serializePathPatternConditionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</PathPatternConfig>");
    }
    if (value.query_string_config) |v| {
        try buf.appendSlice(alloc, "<QueryStringConfig>");
        try serializeQueryStringConditionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</QueryStringConfig>");
    }
    if (value.regex_values) |v| {
        try buf.appendSlice(alloc, "<RegexValues>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</RegexValues>");
    }
    if (value.source_ip_config) |v| {
        try buf.appendSlice(alloc, "<SourceIpConfig>");
        try serializeSourceIpConditionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceIpConfig>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeRulePriorityPair(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RulePriorityPair) !void {
    if (value.priority) |v| {
        try buf.appendSlice(alloc, "<Priority>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Priority>");
    }
    if (value.rule_arn) |v| {
        try buf.appendSlice(alloc, "<RuleArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</RuleArn>");
    }
}

pub fn serializeRuleTransform(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RuleTransform) !void {
    if (value.host_header_rewrite_config) |v| {
        try buf.appendSlice(alloc, "<HostHeaderRewriteConfig>");
        try serializeHostHeaderRewriteConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</HostHeaderRewriteConfig>");
    }
    try buf.appendSlice(alloc, "<Type>");
    try buf.appendSlice(alloc, @tagName(value.@"type"));
    try buf.appendSlice(alloc, "</Type>");
    if (value.url_rewrite_config) |v| {
        try buf.appendSlice(alloc, "<UrlRewriteConfig>");
        try serializeUrlRewriteConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</UrlRewriteConfig>");
    }
}

pub fn serializeSourceIpConditionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SourceIpConditionConfig) !void {
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeListOfString(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeSubnetMapping(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SubnetMapping) !void {
    if (value.allocation_id) |v| {
        try buf.appendSlice(alloc, "<AllocationId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AllocationId>");
    }
    if (value.i_pv_6_address) |v| {
        try buf.appendSlice(alloc, "<IPv6Address>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</IPv6Address>");
    }
    if (value.private_i_pv_4_address) |v| {
        try buf.appendSlice(alloc, "<PrivateIPv4Address>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</PrivateIPv4Address>");
    }
    if (value.source_nat_ipv_6_prefix) |v| {
        try buf.appendSlice(alloc, "<SourceNatIpv6Prefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceNatIpv6Prefix>");
    }
    if (value.subnet_id) |v| {
        try buf.appendSlice(alloc, "<SubnetId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SubnetId>");
    }
}

pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeTargetDescription(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetDescription) !void {
    if (value.availability_zone) |v| {
        try buf.appendSlice(alloc, "<AvailabilityZone>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AvailabilityZone>");
    }
    try buf.appendSlice(alloc, "<Id>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.id);
    try buf.appendSlice(alloc, "</Id>");
    if (value.port) |v| {
        try buf.appendSlice(alloc, "<Port>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Port>");
    }
    if (value.quic_server_id) |v| {
        try buf.appendSlice(alloc, "<QuicServerId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</QuicServerId>");
    }
}

pub fn serializeTargetGroupAttribute(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetGroupAttribute) !void {
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

pub fn serializeTargetGroupStickinessConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetGroupStickinessConfig) !void {
    if (value.duration_seconds) |v| {
        try buf.appendSlice(alloc, "<DurationSeconds>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DurationSeconds>");
    }
    if (value.enabled) |v| {
        try buf.appendSlice(alloc, "<Enabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Enabled>");
    }
}

pub fn serializeTargetGroupTuple(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetGroupTuple) !void {
    if (value.target_group_arn) |v| {
        try buf.appendSlice(alloc, "<TargetGroupArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TargetGroupArn>");
    }
    if (value.weight) |v| {
        try buf.appendSlice(alloc, "<Weight>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Weight>");
    }
}

pub fn serializeUrlRewriteConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: UrlRewriteConfig) !void {
    if (value.rewrites) |v| {
        try buf.appendSlice(alloc, "<Rewrites>");
        try serializeRewriteConfigList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Rewrites>");
    }
}

