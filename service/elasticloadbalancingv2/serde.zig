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

pub fn deserializeActions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Action {
    var list: std.ArrayList(Action) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAction(allocator, reader));
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

pub fn deserializeAlpnPolicyName(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAvailabilityZones(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AvailabilityZone {
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

pub fn deserializeCiphers(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Cipher {
    var list: std.ArrayList(Cipher) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCipher(allocator, reader));
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

pub fn deserializeDescribeTrustStoreRevocationResponse(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DescribeTrustStoreRevocation {
    var list: std.ArrayList(DescribeTrustStoreRevocation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDescribeTrustStoreRevocation(allocator, reader));
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

pub fn deserializeJwtValidationActionAdditionalClaimValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeJwtValidationActionAdditionalClaims(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const JwtValidationActionAdditionalClaim {
    var list: std.ArrayList(JwtValidationActionAdditionalClaim) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeJwtValidationActionAdditionalClaim(allocator, reader));
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

pub fn deserializeLimits(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Limit {
    var list: std.ArrayList(Limit) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLimit(allocator, reader));
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

pub fn deserializeListOfString(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeListenerAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ListenerAttribute {
    var list: std.ArrayList(ListenerAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListenerAttribute(allocator, reader));
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

pub fn deserializeListeners(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Listener {
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

pub fn deserializeLoadBalancerAddresses(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LoadBalancerAddress {
    var list: std.ArrayList(LoadBalancerAddress) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLoadBalancerAddress(allocator, reader));
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

pub fn deserializeLoadBalancerArns(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeLoadBalancerAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LoadBalancerAttribute {
    var list: std.ArrayList(LoadBalancerAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLoadBalancerAttribute(allocator, reader));
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

pub fn deserializeLoadBalancers(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LoadBalancer {
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

pub fn deserializeQueryStringKeyValuePairList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const QueryStringKeyValuePair {
    var list: std.ArrayList(QueryStringKeyValuePair) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeQueryStringKeyValuePair(allocator, reader));
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

pub fn deserializeRewriteConfigList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RewriteConfig {
    var list: std.ArrayList(RewriteConfig) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRewriteConfig(allocator, reader));
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

pub fn deserializeRuleConditionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RuleCondition {
    var list: std.ArrayList(RuleCondition) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRuleCondition(allocator, reader));
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

pub fn deserializeRuleTransformList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RuleTransform {
    var list: std.ArrayList(RuleTransform) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRuleTransform(allocator, reader));
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

pub fn deserializeRules(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Rule {
    var list: std.ArrayList(Rule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRule(allocator, reader));
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

pub fn deserializeSecurityGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSourceNatIpv6Prefixes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeSslPolicies(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SslPolicy {
    var list: std.ArrayList(SslPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSslPolicy(allocator, reader));
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

pub fn deserializeSslProtocols(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTagDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TagDescription {
    var list: std.ArrayList(TagDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTagDescription(allocator, reader));
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

pub fn deserializeTargetGroupAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TargetGroupAttribute {
    var list: std.ArrayList(TargetGroupAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTargetGroupAttribute(allocator, reader));
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

pub fn deserializeTargetGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TargetGroupTuple {
    var list: std.ArrayList(TargetGroupTuple) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTargetGroupTuple(allocator, reader));
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

pub fn deserializeTargetGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TargetGroup {
    var list: std.ArrayList(TargetGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTargetGroup(allocator, reader));
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

pub fn deserializeTargetHealthDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TargetHealthDescription {
    var list: std.ArrayList(TargetHealthDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTargetHealthDescription(allocator, reader));
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

pub fn deserializeTrustStoreAssociations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrustStoreAssociation {
    var list: std.ArrayList(TrustStoreAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrustStoreAssociation(allocator, reader));
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

pub fn deserializeTrustStoreRevocations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrustStoreRevocation {
    var list: std.ArrayList(TrustStoreRevocation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrustStoreRevocation(allocator, reader));
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

pub fn deserializeTrustStores(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrustStore {
    var list: std.ArrayList(TrustStore) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrustStore(allocator, reader));
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

pub fn deserializeZonalCapacityReservationStates(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ZonalCapacityReservationState {
    var list: std.ArrayList(ZonalCapacityReservationState) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeZonalCapacityReservationState(allocator, reader));
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

pub fn deserializeAuthenticateCognitoActionAuthenticationRequestExtraParams(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeAuthenticateOidcActionAuthenticationRequestExtraParams(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Action {
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
                    result.authenticate_cognito_config = try deserializeAuthenticateCognitoActionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AuthenticateOidcConfig")) {
                    result.authenticate_oidc_config = try deserializeAuthenticateOidcActionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "FixedResponseConfig")) {
                    result.fixed_response_config = try deserializeFixedResponseActionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ForwardConfig")) {
                    result.forward_config = try deserializeForwardActionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "JwtValidationConfig")) {
                    result.jwt_validation_config = try deserializeJwtValidationActionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Order")) {
                    result.order = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RedirectConfig")) {
                    result.redirect_config = try deserializeRedirectActionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TargetGroupArn")) {
                    result.target_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = ActionTypeEnum.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAdministrativeOverride(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AdministrativeOverride {
    var result: AdministrativeOverride = undefined;
    result.description = null;
    result.reason = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = TargetAdministrativeOverrideReasonEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = TargetAdministrativeOverrideStateEnum.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnomalyDetection(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnomalyDetection {
    _ = allocator;
    var result: AnomalyDetection = undefined;
    result.mitigation_in_effect = null;
    result.result = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MitigationInEffect")) {
                    result.mitigation_in_effect = MitigationInEffectEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Result")) {
                    result.result = AnomalyResultEnum.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAuthenticateCognitoActionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AuthenticateCognitoActionConfig {
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
                    result.authentication_request_extra_params = try deserializeAuthenticateCognitoActionAuthenticationRequestExtraParams(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "OnUnauthenticatedRequest")) {
                    result.on_unauthenticated_request = AuthenticateCognitoActionConditionalBehaviorEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Scope")) {
                    result.scope = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionCookieName")) {
                    result.session_cookie_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionTimeout")) {
                    result.session_timeout = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "UserPoolArn")) {
                    result.user_pool_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserPoolClientId")) {
                    result.user_pool_client_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserPoolDomain")) {
                    result.user_pool_domain = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAuthenticateOidcActionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AuthenticateOidcActionConfig {
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
                    result.authentication_request_extra_params = try deserializeAuthenticateOidcActionAuthenticationRequestExtraParams(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "AuthorizationEndpoint")) {
                    result.authorization_endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClientId")) {
                    result.client_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClientSecret")) {
                    result.client_secret = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Issuer")) {
                    result.issuer = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OnUnauthenticatedRequest")) {
                    result.on_unauthenticated_request = AuthenticateOidcActionConditionalBehaviorEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Scope")) {
                    result.scope = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionCookieName")) {
                    result.session_cookie_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SessionTimeout")) {
                    result.session_timeout = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TokenEndpoint")) {
                    result.token_endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UseExistingClientSecret")) {
                    result.use_existing_client_secret = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "UserInfoEndpoint")) {
                    result.user_info_endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else {
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
    result.load_balancer_addresses = null;
    result.outpost_id = null;
    result.source_nat_ipv_6_prefixes = null;
    result.subnet_id = null;
    result.zone_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancerAddresses")) {
                    result.load_balancer_addresses = try deserializeLoadBalancerAddresses(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "OutpostId")) {
                    result.outpost_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceNatIpv6Prefixes")) {
                    result.source_nat_ipv_6_prefixes = try deserializeSourceNatIpv6Prefixes(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SubnetId")) {
                    result.subnet_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ZoneName")) {
                    result.zone_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCapacityReservationStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CapacityReservationStatus {
    var result: CapacityReservationStatus = undefined;
    result.code = null;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = CapacityReservationStateEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try allocator.dupe(u8, try reader.readElementText());
                } else {
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
    result.is_default = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateArn")) {
                    result.certificate_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCipher(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Cipher {
    var result: Cipher = undefined;
    result.name = null;
    result.priority = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDescribeTrustStoreRevocation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DescribeTrustStoreRevocation {
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
                    result.revocation_type = RevocationType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreArn")) {
                    result.trust_store_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFixedResponseActionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FixedResponseActionConfig {
    var result: FixedResponseActionConfig = undefined;
    result.content_type = null;
    result.message_body = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContentType")) {
                    result.content_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MessageBody")) {
                    result.message_body = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeForwardActionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ForwardActionConfig {
    var result: ForwardActionConfig = undefined;
    result.target_groups = null;
    result.target_group_stickiness_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TargetGroups")) {
                    result.target_groups = try deserializeTargetGroupList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TargetGroupStickinessConfig")) {
                    result.target_group_stickiness_config = try deserializeTargetGroupStickinessConfig(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostHeaderConditionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HostHeaderConditionConfig {
    var result: HostHeaderConditionConfig = undefined;
    result.regex_values = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RegexValues")) {
                    result.regex_values = try deserializeListOfString(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHostHeaderRewriteConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HostHeaderRewriteConfig {
    var result: HostHeaderRewriteConfig = undefined;
    result.rewrites = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rewrites")) {
                    result.rewrites = try deserializeRewriteConfigList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHttpHeaderConditionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HttpHeaderConditionConfig {
    var result: HttpHeaderConditionConfig = undefined;
    result.http_header_name = null;
    result.regex_values = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HttpHeaderName")) {
                    result.http_header_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RegexValues")) {
                    result.regex_values = try deserializeListOfString(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHttpRequestMethodConditionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HttpRequestMethodConditionConfig {
    var result: HttpRequestMethodConditionConfig = undefined;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIpamPools(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IpamPools {
    var result: IpamPools = undefined;
    result.ipv_4_ipam_pool_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Ipv4IpamPoolId")) {
                    result.ipv_4_ipam_pool_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJwtValidationActionAdditionalClaim(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JwtValidationActionAdditionalClaim {
    var result: JwtValidationActionAdditionalClaim = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = JwtValidationActionAdditionalClaimFormatEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeJwtValidationActionAdditionalClaimValues(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeJwtValidationActionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !JwtValidationActionConfig {
    var result: JwtValidationActionConfig = undefined;
    result.additional_claims = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalClaims")) {
                    result.additional_claims = try deserializeJwtValidationActionAdditionalClaims(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Issuer")) {
                    result.issuer = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "JwksEndpoint")) {
                    result.jwks_endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLimit(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Limit {
    var result: Limit = undefined;
    result.max = null;
    result.name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max")) {
                    result.max = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
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

pub fn deserializeListener(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Listener {
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
                    result.alpn_policy = try deserializeAlpnPolicyName(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Certificates")) {
                    result.certificates = try deserializeCertificateList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "DefaultActions")) {
                    result.default_actions = try deserializeActions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ListenerArn")) {
                    result.listener_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LoadBalancerArn")) {
                    result.load_balancer_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MutualAuthentication")) {
                    result.mutual_authentication = try deserializeMutualAuthenticationAttributes(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = ProtocolEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SslPolicy")) {
                    result.ssl_policy = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeListenerAttribute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ListenerAttribute {
    var result: ListenerAttribute = undefined;
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

pub fn deserializeLoadBalancer(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancer {
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
                    result.availability_zones = try deserializeAvailabilityZones(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "CanonicalHostedZoneId")) {
                    result.canonical_hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CustomerOwnedIpv4Pool")) {
                    result.customer_owned_ipv_4_pool = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DNSName")) {
                    result.dns_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnablePrefixForIpv6SourceNat")) {
                    result.enable_prefix_for_ipv_6_source_nat = EnablePrefixForIpv6SourceNatEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnforceSecurityGroupInboundRulesOnPrivateLinkTraffic")) {
                    result.enforce_security_group_inbound_rules_on_private_link_traffic = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = IpAddressType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpamPools")) {
                    result.ipam_pools = try deserializeIpamPools(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LoadBalancerArn")) {
                    result.load_balancer_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Scheme")) {
                    result.scheme = LoadBalancerSchemeEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecurityGroups")) {
                    result.security_groups = try deserializeSecurityGroups(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try deserializeLoadBalancerState(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = LoadBalancerTypeEnum.fromWireName(try reader.readElementText());
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

pub fn deserializeLoadBalancerAddress(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancerAddress {
    var result: LoadBalancerAddress = undefined;
    result.allocation_id = null;
    result.ip_address = null;
    result.i_pv_6_address = null;
    result.private_i_pv_4_address = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllocationId")) {
                    result.allocation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpAddress")) {
                    result.ip_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IPv6Address")) {
                    result.i_pv_6_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PrivateIPv4Address")) {
                    result.private_i_pv_4_address = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoadBalancerAttribute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancerAttribute {
    var result: LoadBalancerAttribute = undefined;
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

pub fn deserializeLoadBalancerState(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoadBalancerState {
    var result: LoadBalancerState = undefined;
    result.code = null;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = LoadBalancerStateEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMatcher(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Matcher {
    var result: Matcher = undefined;
    result.grpc_code = null;
    result.http_code = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GrpcCode")) {
                    result.grpc_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpCode")) {
                    result.http_code = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMinimumLoadBalancerCapacity(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MinimumLoadBalancerCapacity {
    _ = allocator;
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

pub fn deserializeMutualAuthenticationAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MutualAuthenticationAttributes {
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
                    result.advertise_trust_store_ca_names = AdvertiseTrustStoreCaNamesEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IgnoreClientCertificateExpiry")) {
                    result.ignore_client_certificate_expiry = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreArn")) {
                    result.trust_store_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreAssociationStatus")) {
                    result.trust_store_association_status = TrustStoreAssociationStatusEnum.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePathPatternConditionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PathPatternConditionConfig {
    var result: PathPatternConditionConfig = undefined;
    result.regex_values = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RegexValues")) {
                    result.regex_values = try deserializeListOfString(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryStringConditionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !QueryStringConditionConfig {
    var result: QueryStringConditionConfig = undefined;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeQueryStringKeyValuePairList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryStringKeyValuePair(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !QueryStringKeyValuePair {
    var result: QueryStringKeyValuePair = undefined;
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

pub fn deserializeRedirectActionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RedirectActionConfig {
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
                    result.host = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Query")) {
                    result.query = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = RedirectActionStatusCodeEnum.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRewriteConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RewriteConfig {
    var result: RewriteConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Regex")) {
                    result.regex = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Replace")) {
                    result.replace = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Rule {
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
                    result.actions = try deserializeActions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Conditions")) {
                    result.conditions = try deserializeRuleConditionList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Priority")) {
                    result.priority = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RuleArn")) {
                    result.rule_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Transforms")) {
                    result.transforms = try deserializeRuleTransformList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRuleCondition(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RuleCondition {
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
                    result.field = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostHeaderConfig")) {
                    result.host_header_config = try deserializeHostHeaderConditionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "HttpHeaderConfig")) {
                    result.http_header_config = try deserializeHttpHeaderConditionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "HttpRequestMethodConfig")) {
                    result.http_request_method_config = try deserializeHttpRequestMethodConditionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PathPatternConfig")) {
                    result.path_pattern_config = try deserializePathPatternConditionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "QueryStringConfig")) {
                    result.query_string_config = try deserializeQueryStringConditionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RegexValues")) {
                    result.regex_values = try deserializeListOfString(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SourceIpConfig")) {
                    result.source_ip_config = try deserializeSourceIpConditionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRuleTransform(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RuleTransform {
    var result: RuleTransform = undefined;
    result.host_header_rewrite_config = null;
    result.url_rewrite_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostHeaderRewriteConfig")) {
                    result.host_header_rewrite_config = try deserializeHostHeaderRewriteConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = TransformTypeEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UrlRewriteConfig")) {
                    result.url_rewrite_config = try deserializeUrlRewriteConfig(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSourceIpConditionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SourceIpConditionConfig {
    var result: SourceIpConditionConfig = undefined;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeListOfString(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSslPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SslPolicy {
    var result: SslPolicy = undefined;
    result.ciphers = null;
    result.name = null;
    result.ssl_protocols = null;
    result.supported_load_balancer_types = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Ciphers")) {
                    result.ciphers = try deserializeCiphers(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SslProtocols")) {
                    result.ssl_protocols = try deserializeSslProtocols(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedLoadBalancerTypes")) {
                    result.supported_load_balancer_types = try deserializeListOfString(allocator, reader, "member");
                } else {
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

pub fn deserializeTagDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TagDescription {
    var result: TagDescription = undefined;
    result.resource_arn = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceArn")) {
                    result.resource_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTagList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetDescription {
    var result: TargetDescription = undefined;
    result.availability_zone = null;
    result.port = null;
    result.quic_server_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "QuicServerId")) {
                    result.quic_server_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetGroup {
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
                    result.health_check_path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthCheckPort")) {
                    result.health_check_port = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthCheckProtocol")) {
                    result.health_check_protocol = ProtocolEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthCheckTimeoutSeconds")) {
                    result.health_check_timeout_seconds = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "HealthyThresholdCount")) {
                    result.healthy_threshold_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = TargetGroupIpAddressTypeEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LoadBalancerArns")) {
                    result.load_balancer_arns = try deserializeLoadBalancerArns(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Matcher")) {
                    result.matcher = try deserializeMatcher(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Protocol")) {
                    result.protocol = ProtocolEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProtocolVersion")) {
                    result.protocol_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetControlPort")) {
                    result.target_control_port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TargetGroupArn")) {
                    result.target_group_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetGroupName")) {
                    result.target_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetType")) {
                    result.target_type = TargetTypeEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UnhealthyThresholdCount")) {
                    result.unhealthy_threshold_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeTargetGroupAttribute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetGroupAttribute {
    var result: TargetGroupAttribute = undefined;
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

pub fn deserializeTargetGroupStickinessConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetGroupStickinessConfig {
    _ = allocator;
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

pub fn deserializeTargetGroupTuple(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetGroupTuple {
    var result: TargetGroupTuple = undefined;
    result.target_group_arn = null;
    result.weight = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TargetGroupArn")) {
                    result.target_group_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTargetHealth(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetHealth {
    var result: TargetHealth = undefined;
    result.description = null;
    result.reason = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = TargetHealthReasonEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = TargetHealthStateEnum.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTargetHealthDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TargetHealthDescription {
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
                    result.administrative_override = try deserializeAdministrativeOverride(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AnomalyDetection")) {
                    result.anomaly_detection = try deserializeAnomalyDetection(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "HealthCheckPort")) {
                    result.health_check_port = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Target")) {
                    result.target = try deserializeTargetDescription(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TargetHealth")) {
                    result.target_health = try deserializeTargetHealth(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustStore(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrustStore {
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
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfCaCertificates")) {
                    result.number_of_ca_certificates = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = TrustStoreStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TotalRevokedEntries")) {
                    result.total_revoked_entries = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TrustStoreArn")) {
                    result.trust_store_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustStoreAssociation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrustStoreAssociation {
    var result: TrustStoreAssociation = undefined;
    result.resource_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceArn")) {
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

pub fn deserializeTrustStoreRevocation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrustStoreRevocation {
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
                    result.revocation_type = RevocationType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreArn")) {
                    result.trust_store_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUrlRewriteConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UrlRewriteConfig {
    var result: UrlRewriteConfig = undefined;
    result.rewrites = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rewrites")) {
                    result.rewrites = try deserializeRewriteConfigList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeZonalCapacityReservationState(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ZonalCapacityReservationState {
    var result: ZonalCapacityReservationState = undefined;
    result.availability_zone = null;
    result.effective_capacity_units = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EffectiveCapacityUnits")) {
                    result.effective_capacity_units = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try deserializeCapacityReservationStatus(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeActions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Action, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeAction(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAlpnPolicyName(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCertificateList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Certificate, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeCertificate(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeJwtValidationActionAdditionalClaimValues(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeJwtValidationActionAdditionalClaims(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const JwtValidationActionAdditionalClaim, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeJwtValidationActionAdditionalClaim(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeListOfDescribeTargetHealthIncludeOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const DescribeTargetHealthInputIncludeEnum, comptime item_tag: []const u8) !void {
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

pub fn serializeListOfString(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeListenerArns(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeListenerAttributes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ListenerAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeListenerAttribute(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLoadBalancerArns(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLoadBalancerAttributes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LoadBalancerAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeLoadBalancerAttribute(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLoadBalancerNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeQueryStringKeyValuePairList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const QueryStringKeyValuePair, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeQueryStringKeyValuePair(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRemoveIpamPools(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RemoveIpamPoolEnum, comptime item_tag: []const u8) !void {
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

pub fn serializeResourceArns(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRevocationContents(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RevocationContent, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRevocationContent(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRevocationIds(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const i64, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{item}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRewriteConfigList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RewriteConfig, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRewriteConfig(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRuleArns(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRuleConditionList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RuleCondition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRuleCondition(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRulePriorityList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RulePriorityPair, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRulePriorityPair(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRuleTransformList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RuleTransform, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRuleTransform(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSecurityGroups(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSslPolicyNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeSubnetMappings(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const SubnetMapping, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeSubnetMapping(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSubnets(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTagKeys(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTargetDescriptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TargetDescription, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTargetDescription(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTargetGroupArns(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTargetGroupAttributes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TargetGroupAttribute, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTargetGroupAttribute(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTargetGroupList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TargetGroupTuple, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTargetGroupTuple(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTargetGroupNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTrustStoreArns(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeTrustStoreNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAuthenticateCognitoActionAuthenticationRequestExtraParams(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
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

pub fn serializeAuthenticateOidcActionAuthenticationRequestExtraParams(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
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

pub fn serializeAction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Action) !void {
    if (value.authenticate_cognito_config) |v| {
        try buf.appendSlice(allocator, "<AuthenticateCognitoConfig>");
        try serializeAuthenticateCognitoActionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</AuthenticateCognitoConfig>");
    }
    if (value.authenticate_oidc_config) |v| {
        try buf.appendSlice(allocator, "<AuthenticateOidcConfig>");
        try serializeAuthenticateOidcActionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</AuthenticateOidcConfig>");
    }
    if (value.fixed_response_config) |v| {
        try buf.appendSlice(allocator, "<FixedResponseConfig>");
        try serializeFixedResponseActionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</FixedResponseConfig>");
    }
    if (value.forward_config) |v| {
        try buf.appendSlice(allocator, "<ForwardConfig>");
        try serializeForwardActionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</ForwardConfig>");
    }
    if (value.jwt_validation_config) |v| {
        try buf.appendSlice(allocator, "<JwtValidationConfig>");
        try serializeJwtValidationActionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</JwtValidationConfig>");
    }
    if (value.order) |v| {
        try buf.appendSlice(allocator, "<Order>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Order>");
    }
    if (value.redirect_config) |v| {
        try buf.appendSlice(allocator, "<RedirectConfig>");
        try serializeRedirectActionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</RedirectConfig>");
    }
    if (value.target_group_arn) |v| {
        try buf.appendSlice(allocator, "<TargetGroupArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TargetGroupArn>");
    }
    try buf.appendSlice(allocator, "<Type>");
    try buf.appendSlice(allocator, value.@"type".wireName());
    try buf.appendSlice(allocator, "</Type>");
}

pub fn serializeAuthenticateCognitoActionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AuthenticateCognitoActionConfig) !void {
    if (value.authentication_request_extra_params) |v| {
        try buf.appendSlice(allocator, "<AuthenticationRequestExtraParams>");
        try serializeAuthenticateCognitoActionAuthenticationRequestExtraParams(allocator, buf, v, "entry");
        try buf.appendSlice(allocator, "</AuthenticationRequestExtraParams>");
    }
    if (value.on_unauthenticated_request) |v| {
        try buf.appendSlice(allocator, "<OnUnauthenticatedRequest>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</OnUnauthenticatedRequest>");
    }
    if (value.scope) |v| {
        try buf.appendSlice(allocator, "<Scope>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Scope>");
    }
    if (value.session_cookie_name) |v| {
        try buf.appendSlice(allocator, "<SessionCookieName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SessionCookieName>");
    }
    if (value.session_timeout) |v| {
        try buf.appendSlice(allocator, "<SessionTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</SessionTimeout>");
    }
    try buf.appendSlice(allocator, "<UserPoolArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.user_pool_arn);
    try buf.appendSlice(allocator, "</UserPoolArn>");
    try buf.appendSlice(allocator, "<UserPoolClientId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.user_pool_client_id);
    try buf.appendSlice(allocator, "</UserPoolClientId>");
    try buf.appendSlice(allocator, "<UserPoolDomain>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.user_pool_domain);
    try buf.appendSlice(allocator, "</UserPoolDomain>");
}

pub fn serializeAuthenticateOidcActionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AuthenticateOidcActionConfig) !void {
    if (value.authentication_request_extra_params) |v| {
        try buf.appendSlice(allocator, "<AuthenticationRequestExtraParams>");
        try serializeAuthenticateOidcActionAuthenticationRequestExtraParams(allocator, buf, v, "entry");
        try buf.appendSlice(allocator, "</AuthenticationRequestExtraParams>");
    }
    try buf.appendSlice(allocator, "<AuthorizationEndpoint>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.authorization_endpoint);
    try buf.appendSlice(allocator, "</AuthorizationEndpoint>");
    try buf.appendSlice(allocator, "<ClientId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.client_id);
    try buf.appendSlice(allocator, "</ClientId>");
    if (value.client_secret) |v| {
        try buf.appendSlice(allocator, "<ClientSecret>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ClientSecret>");
    }
    try buf.appendSlice(allocator, "<Issuer>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.issuer);
    try buf.appendSlice(allocator, "</Issuer>");
    if (value.on_unauthenticated_request) |v| {
        try buf.appendSlice(allocator, "<OnUnauthenticatedRequest>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</OnUnauthenticatedRequest>");
    }
    if (value.scope) |v| {
        try buf.appendSlice(allocator, "<Scope>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Scope>");
    }
    if (value.session_cookie_name) |v| {
        try buf.appendSlice(allocator, "<SessionCookieName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SessionCookieName>");
    }
    if (value.session_timeout) |v| {
        try buf.appendSlice(allocator, "<SessionTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</SessionTimeout>");
    }
    try buf.appendSlice(allocator, "<TokenEndpoint>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.token_endpoint);
    try buf.appendSlice(allocator, "</TokenEndpoint>");
    if (value.use_existing_client_secret) |v| {
        try buf.appendSlice(allocator, "<UseExistingClientSecret>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</UseExistingClientSecret>");
    }
    try buf.appendSlice(allocator, "<UserInfoEndpoint>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.user_info_endpoint);
    try buf.appendSlice(allocator, "</UserInfoEndpoint>");
}

pub fn serializeCertificate(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Certificate) !void {
    if (value.certificate_arn) |v| {
        try buf.appendSlice(allocator, "<CertificateArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</CertificateArn>");
    }
    if (value.is_default) |v| {
        try buf.appendSlice(allocator, "<IsDefault>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsDefault>");
    }
}

pub fn serializeFixedResponseActionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: FixedResponseActionConfig) !void {
    if (value.content_type) |v| {
        try buf.appendSlice(allocator, "<ContentType>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentType>");
    }
    if (value.message_body) |v| {
        try buf.appendSlice(allocator, "<MessageBody>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</MessageBody>");
    }
    try buf.appendSlice(allocator, "<StatusCode>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.status_code);
    try buf.appendSlice(allocator, "</StatusCode>");
}

pub fn serializeForwardActionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ForwardActionConfig) !void {
    if (value.target_groups) |v| {
        try buf.appendSlice(allocator, "<TargetGroups>");
        try serializeTargetGroupList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</TargetGroups>");
    }
    if (value.target_group_stickiness_config) |v| {
        try buf.appendSlice(allocator, "<TargetGroupStickinessConfig>");
        try serializeTargetGroupStickinessConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</TargetGroupStickinessConfig>");
    }
}

pub fn serializeHostHeaderConditionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: HostHeaderConditionConfig) !void {
    if (value.regex_values) |v| {
        try buf.appendSlice(allocator, "<RegexValues>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</RegexValues>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeHostHeaderRewriteConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: HostHeaderRewriteConfig) !void {
    if (value.rewrites) |v| {
        try buf.appendSlice(allocator, "<Rewrites>");
        try serializeRewriteConfigList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Rewrites>");
    }
}

pub fn serializeHttpHeaderConditionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: HttpHeaderConditionConfig) !void {
    if (value.http_header_name) |v| {
        try buf.appendSlice(allocator, "<HttpHeaderName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</HttpHeaderName>");
    }
    if (value.regex_values) |v| {
        try buf.appendSlice(allocator, "<RegexValues>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</RegexValues>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeHttpRequestMethodConditionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: HttpRequestMethodConditionConfig) !void {
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeIpamPools(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: IpamPools) !void {
    if (value.ipv_4_ipam_pool_id) |v| {
        try buf.appendSlice(allocator, "<Ipv4IpamPoolId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Ipv4IpamPoolId>");
    }
}

pub fn serializeJwtValidationActionAdditionalClaim(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JwtValidationActionAdditionalClaim) !void {
    try buf.appendSlice(allocator, "<Format>");
    try buf.appendSlice(allocator, value.format.wireName());
    try buf.appendSlice(allocator, "</Format>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Values>");
    try serializeJwtValidationActionAdditionalClaimValues(allocator, buf, value.values, "member");
    try buf.appendSlice(allocator, "</Values>");
}

pub fn serializeJwtValidationActionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: JwtValidationActionConfig) !void {
    if (value.additional_claims) |v| {
        try buf.appendSlice(allocator, "<AdditionalClaims>");
        try serializeJwtValidationActionAdditionalClaims(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</AdditionalClaims>");
    }
    try buf.appendSlice(allocator, "<Issuer>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.issuer);
    try buf.appendSlice(allocator, "</Issuer>");
    try buf.appendSlice(allocator, "<JwksEndpoint>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.jwks_endpoint);
    try buf.appendSlice(allocator, "</JwksEndpoint>");
}

pub fn serializeListenerAttribute(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ListenerAttribute) !void {
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

pub fn serializeLoadBalancerAttribute(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LoadBalancerAttribute) !void {
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

pub fn serializeMatcher(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Matcher) !void {
    if (value.grpc_code) |v| {
        try buf.appendSlice(allocator, "<GrpcCode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</GrpcCode>");
    }
    if (value.http_code) |v| {
        try buf.appendSlice(allocator, "<HttpCode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</HttpCode>");
    }
}

pub fn serializeMinimumLoadBalancerCapacity(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MinimumLoadBalancerCapacity) !void {
    if (value.capacity_units) |v| {
        try buf.appendSlice(allocator, "<CapacityUnits>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</CapacityUnits>");
    }
}

pub fn serializeMutualAuthenticationAttributes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MutualAuthenticationAttributes) !void {
    if (value.advertise_trust_store_ca_names) |v| {
        try buf.appendSlice(allocator, "<AdvertiseTrustStoreCaNames>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</AdvertiseTrustStoreCaNames>");
    }
    if (value.ignore_client_certificate_expiry) |v| {
        try buf.appendSlice(allocator, "<IgnoreClientCertificateExpiry>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IgnoreClientCertificateExpiry>");
    }
    if (value.mode) |v| {
        try buf.appendSlice(allocator, "<Mode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Mode>");
    }
    if (value.trust_store_arn) |v| {
        try buf.appendSlice(allocator, "<TrustStoreArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TrustStoreArn>");
    }
    if (value.trust_store_association_status) |v| {
        try buf.appendSlice(allocator, "<TrustStoreAssociationStatus>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</TrustStoreAssociationStatus>");
    }
}

pub fn serializePathPatternConditionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PathPatternConditionConfig) !void {
    if (value.regex_values) |v| {
        try buf.appendSlice(allocator, "<RegexValues>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</RegexValues>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeQueryStringConditionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryStringConditionConfig) !void {
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeQueryStringKeyValuePairList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeQueryStringKeyValuePair(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryStringKeyValuePair) !void {
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

pub fn serializeRedirectActionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RedirectActionConfig) !void {
    if (value.host) |v| {
        try buf.appendSlice(allocator, "<Host>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Host>");
    }
    if (value.path) |v| {
        try buf.appendSlice(allocator, "<Path>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Path>");
    }
    if (value.port) |v| {
        try buf.appendSlice(allocator, "<Port>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Port>");
    }
    if (value.protocol) |v| {
        try buf.appendSlice(allocator, "<Protocol>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Protocol>");
    }
    if (value.query) |v| {
        try buf.appendSlice(allocator, "<Query>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Query>");
    }
    try buf.appendSlice(allocator, "<StatusCode>");
    try buf.appendSlice(allocator, value.status_code.wireName());
    try buf.appendSlice(allocator, "</StatusCode>");
}

pub fn serializeRevocationContent(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RevocationContent) !void {
    if (value.revocation_type) |v| {
        try buf.appendSlice(allocator, "<RevocationType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</RevocationType>");
    }
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
    if (value.s3_object_version) |v| {
        try buf.appendSlice(allocator, "<S3ObjectVersion>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3ObjectVersion>");
    }
}

pub fn serializeRewriteConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RewriteConfig) !void {
    try buf.appendSlice(allocator, "<Regex>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.regex);
    try buf.appendSlice(allocator, "</Regex>");
    try buf.appendSlice(allocator, "<Replace>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.replace);
    try buf.appendSlice(allocator, "</Replace>");
}

pub fn serializeRuleCondition(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RuleCondition) !void {
    if (value.field) |v| {
        try buf.appendSlice(allocator, "<Field>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Field>");
    }
    if (value.host_header_config) |v| {
        try buf.appendSlice(allocator, "<HostHeaderConfig>");
        try serializeHostHeaderConditionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</HostHeaderConfig>");
    }
    if (value.http_header_config) |v| {
        try buf.appendSlice(allocator, "<HttpHeaderConfig>");
        try serializeHttpHeaderConditionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</HttpHeaderConfig>");
    }
    if (value.http_request_method_config) |v| {
        try buf.appendSlice(allocator, "<HttpRequestMethodConfig>");
        try serializeHttpRequestMethodConditionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</HttpRequestMethodConfig>");
    }
    if (value.path_pattern_config) |v| {
        try buf.appendSlice(allocator, "<PathPatternConfig>");
        try serializePathPatternConditionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</PathPatternConfig>");
    }
    if (value.query_string_config) |v| {
        try buf.appendSlice(allocator, "<QueryStringConfig>");
        try serializeQueryStringConditionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</QueryStringConfig>");
    }
    if (value.regex_values) |v| {
        try buf.appendSlice(allocator, "<RegexValues>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</RegexValues>");
    }
    if (value.source_ip_config) |v| {
        try buf.appendSlice(allocator, "<SourceIpConfig>");
        try serializeSourceIpConditionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceIpConfig>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeRulePriorityPair(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RulePriorityPair) !void {
    if (value.priority) |v| {
        try buf.appendSlice(allocator, "<Priority>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Priority>");
    }
    if (value.rule_arn) |v| {
        try buf.appendSlice(allocator, "<RuleArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RuleArn>");
    }
}

pub fn serializeRuleTransform(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RuleTransform) !void {
    if (value.host_header_rewrite_config) |v| {
        try buf.appendSlice(allocator, "<HostHeaderRewriteConfig>");
        try serializeHostHeaderRewriteConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</HostHeaderRewriteConfig>");
    }
    try buf.appendSlice(allocator, "<Type>");
    try buf.appendSlice(allocator, value.@"type".wireName());
    try buf.appendSlice(allocator, "</Type>");
    if (value.url_rewrite_config) |v| {
        try buf.appendSlice(allocator, "<UrlRewriteConfig>");
        try serializeUrlRewriteConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</UrlRewriteConfig>");
    }
}

pub fn serializeSourceIpConditionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SourceIpConditionConfig) !void {
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeListOfString(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeSubnetMapping(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SubnetMapping) !void {
    if (value.allocation_id) |v| {
        try buf.appendSlice(allocator, "<AllocationId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AllocationId>");
    }
    if (value.i_pv_6_address) |v| {
        try buf.appendSlice(allocator, "<IPv6Address>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</IPv6Address>");
    }
    if (value.private_i_pv_4_address) |v| {
        try buf.appendSlice(allocator, "<PrivateIPv4Address>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</PrivateIPv4Address>");
    }
    if (value.source_nat_ipv_6_prefix) |v| {
        try buf.appendSlice(allocator, "<SourceNatIpv6Prefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceNatIpv6Prefix>");
    }
    if (value.subnet_id) |v| {
        try buf.appendSlice(allocator, "<SubnetId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SubnetId>");
    }
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeTargetDescription(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetDescription) !void {
    if (value.availability_zone) |v| {
        try buf.appendSlice(allocator, "<AvailabilityZone>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AvailabilityZone>");
    }
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    if (value.port) |v| {
        try buf.appendSlice(allocator, "<Port>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Port>");
    }
    if (value.quic_server_id) |v| {
        try buf.appendSlice(allocator, "<QuicServerId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</QuicServerId>");
    }
}

pub fn serializeTargetGroupAttribute(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetGroupAttribute) !void {
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

pub fn serializeTargetGroupStickinessConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetGroupStickinessConfig) !void {
    if (value.duration_seconds) |v| {
        try buf.appendSlice(allocator, "<DurationSeconds>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DurationSeconds>");
    }
    if (value.enabled) |v| {
        try buf.appendSlice(allocator, "<Enabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Enabled>");
    }
}

pub fn serializeTargetGroupTuple(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TargetGroupTuple) !void {
    if (value.target_group_arn) |v| {
        try buf.appendSlice(allocator, "<TargetGroupArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TargetGroupArn>");
    }
    if (value.weight) |v| {
        try buf.appendSlice(allocator, "<Weight>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Weight>");
    }
}

pub fn serializeUrlRewriteConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: UrlRewriteConfig) !void {
    if (value.rewrites) |v| {
        try buf.appendSlice(allocator, "<Rewrites>");
        try serializeRewriteConfigList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Rewrites>");
    }
}

