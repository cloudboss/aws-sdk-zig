const PolicyOption = @import("policy_option.zig").PolicyOption;
const SecurityServiceType = @import("security_service_type.zig").SecurityServiceType;

/// Details about the security service that is being used to protect the
/// resources.
pub const SecurityServicePolicyData = struct {
    /// Details about the service that are specific to the service type, in JSON
    /// format.
    ///
    /// * Example: `DNS_FIREWALL`
    ///
    /// `"{\"type\":\"DNS_FIREWALL\",\"preProcessRuleGroups\":[{\"ruleGroupId\":\"rslvr-frg-1\",\"priority\":10}],\"postProcessRuleGroups\":[{\"ruleGroupId\":\"rslvr-frg-2\",\"priority\":9911}]}"`
    ///
    /// Valid values for `preProcessRuleGroups` are between 1 and 99. Valid
    /// values for `postProcessRuleGroups` are between 9901 and 10000.
    ///
    /// * Example: `IMPORT_NETWORK_FIREWALL`
    ///
    /// `"{\"type\":\"IMPORT_NETWORK_FIREWALL\",\"awsNetworkFirewallConfig\":{\"networkFirewallStatelessRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-west-2:000000000000:stateless-rulegroup\/rg1\",\"priority\":1}],\"networkFirewallStatelessDefaultActions\":[\"aws:drop\"],\"networkFirewallStatelessFragmentDefaultActions\":[\"aws:pass\"],\"networkFirewallStatelessCustomActions\":[],\"networkFirewallStatefulRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-west-2:aws-managed:stateful-rulegroup\/ThreatSignaturesEmergingEventsStrictOrder\",\"priority\":8}],\"networkFirewallStatefulEngineOptions\":{\"ruleOrder\":\"STRICT_ORDER\"},\"networkFirewallStatefulDefaultActions\":[\"aws:drop_strict\"]}}"`
    ///
    /// `"{\"type\":\"DNS_FIREWALL\",\"preProcessRuleGroups\":[{\"ruleGroupId\":\"rslvr-frg-1\",\"priority\":10}],\"postProcessRuleGroups\":[{\"ruleGroupId\":\"rslvr-frg-2\",\"priority\":9911}]}"`
    ///
    /// Valid values for `preProcessRuleGroups` are between 1 and 99. Valid
    /// values for `postProcessRuleGroups` are between 9901 and 10000.
    ///
    /// * Example: `NETWORK_FIREWALL` - Centralized deployment
    /// model
    ///
    /// `"{\"type\":\"NETWORK_FIREWALL\",\"awsNetworkFirewallConfig\":{\"networkFirewallStatelessRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateless-rulegroup/test\",\"priority\":1}],\"networkFirewallStatelessDefaultActions\":[\"aws:forward_to_sfe\",\"customActionName\"],\"networkFirewallStatelessFragmentDefaultActions\":[\"aws:forward_to_sfe\",\"customActionName\"],\"networkFirewallStatelessCustomActions\":[{\"actionName\":\"customActionName\",\"actionDefinition\":{\"publishMetricAction\":{\"dimensions\":[{\"value\":\"metricdimensionvalue\"}]}}}],\"networkFirewallStatefulRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateful-rulegroup/test\"}],\"networkFirewallLoggingConfiguration\":{\"logDestinationConfigs\":[{\"logDestinationType\":\"S3\",\"logType\":\"ALERT\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}},{\"logDestinationType\":\"S3\",\"logType\":\"FLOW\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}}],\"overrideExistingConfig\":true}},\"firewallDeploymentModel\":{\"centralizedFirewallDeploymentModel\":{\"centralizedFirewallOrchestrationConfig\":{\"inspectionVpcIds\":[{\"resourceId\":\"vpc-1234\",\"accountId\":\"123456789011\"}],\"firewallCreationConfig\":{\"endpointLocation\":{\"availabilityZoneConfigList\":[{\"availabilityZoneId\":null,\"availabilityZoneName\":\"us-east-1a\",\"allowedIPV4CidrList\":[\"10.0.0.0/28\"]}]}},\"allowedIPV4CidrList\":[]}}}}"`
    ///
    /// To use the centralized deployment model, you must set
    /// [PolicyOption](https://docs.aws.amazon.com/fms/2018-01-01/APIReference/API_PolicyOption.html) to
    /// `CENTRALIZED`.
    ///
    /// * Example: `NETWORK_FIREWALL` - Distributed deployment model with
    /// automatic Availability Zone configuration
    ///
    /// `
    /// "{\"type\":\"NETWORK_FIREWALL\",\"networkFirewallStatelessRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateless-rulegroup/test\",\"priority\":1}],\"networkFirewallStatelessDefaultActions\":[\"aws:forward_to_sfe\",\"customActionName\"],\"networkFirewallStatelessFragmentDefaultActions\":[\"aws:forward_to_sfe\",\"customActionName\"],\"networkFirewallStatelessCustomActions\":[{\"actionName\":\"customActionName\",\"actionDefinition\":{\"publishMetricAction\":{\"dimensions\":[{\"value\":\"metricdimensionvalue\"}]}}}],\"networkFirewallStatefulRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateful-rulegroup/test\"}],\"networkFirewallOrchestrationConfig\":{\"singleFirewallEndpointPerVPC\":false,\"allowedIPV4CidrList\":[\"10.0.0.0/28\",\"192.168.0.0/28\"],\"routeManagementAction\":\"OFF\"},\"networkFirewallLoggingConfiguration\":{\"logDestinationConfigs\":[{\"logDestinationType\":\"S3\",\"logType\":\"ALERT\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}},{\"logDestinationType\":\"S3\",\"logType\":\"FLOW\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}}],\"overrideExistingConfig\":true}}"
    /// `
    ///
    /// With automatic Availbility Zone configuration, Firewall Manager chooses
    /// which Availability Zones to create the endpoints in. To use the distributed
    /// deployment model, you must set
    /// [PolicyOption](https://docs.aws.amazon.com/fms/2018-01-01/APIReference/API_PolicyOption.html) to
    /// `NULL`.
    ///
    /// * Example: `NETWORK_FIREWALL` - Distributed deployment model with
    /// automatic Availability Zone configuration and route management
    ///
    /// `
    /// "{\"type\":\"NETWORK_FIREWALL\",\"networkFirewallStatelessRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateless-rulegroup/test\",\"priority\":1}],\"networkFirewallStatelessDefaultActions\":[\"aws:forward_to_sfe\",\"customActionName\"],\"networkFirewallStatelessFragmentDefaultActions\":[\"aws:forward_to_sfe\",\"customActionName\"],\"networkFirewallStatelessCustomActions\":[{\"actionName\":\"customActionName\",\"actionDefinition\":{\"publishMetricAction\":{\"dimensions\":[{\"value\":\"metricdimensionvalue\"}]}}}],\"networkFirewallStatefulRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateful-rulegroup/test\"}],\"networkFirewallOrchestrationConfig\":{\"singleFirewallEndpointPerVPC\":false,\"allowedIPV4CidrList\":[\"10.0.0.0/28\",\"192.168.0.0/28\"],\"routeManagementAction\":\"MONITOR\",\"routeManagementTargetTypes\":[\"InternetGateway\"]},\"networkFirewallLoggingConfiguration\":{\"logDestinationConfigs\":[{\"logDestinationType\":\"S3\",\"logType\":\"ALERT\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}},{\"logDestinationType\":\"S3\",\"logType\": \"FLOW\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}}],\"overrideExistingConfig\":true}}"
    /// `
    ///
    /// To use the distributed deployment model, you must set
    /// [PolicyOption](https://docs.aws.amazon.com/fms/2018-01-01/APIReference/API_PolicyOption.html) to
    /// `NULL`.
    ///
    /// * Example: `NETWORK_FIREWALL` - Distributed deployment model with
    /// custom Availability Zone configuration
    ///
    /// `"{\"type\":\"NETWORK_FIREWALL\",\"networkFirewallStatelessRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateless-rulegroup/test\",\"priority\":1}],\"networkFirewallStatelessDefaultActions\":[\"aws:forward_to_sfe\",\"customActionName\"],\"networkFirewallStatelessFragmentDefaultActions\":[\"aws:forward_to_sfe\",\"fragmentcustomactionname\"],\"networkFirewallStatelessCustomActions\":[{\"actionName\":\"customActionName\", \"actionDefinition\":{\"publishMetricAction\":{\"dimensions\":[{\"value\":\"metricdimensionvalue\"}]}}},{\"actionName\":\"fragmentcustomactionname\",\"actionDefinition\":{\"publishMetricAction\":{\"dimensions\":[{\"value\":\"fragmentmetricdimensionvalue\"}]}}}],\"networkFirewallStatefulRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateful-rulegroup/test\"}],\"networkFirewallOrchestrationConfig\":{\"firewallCreationConfig\":{ \"endpointLocation\":{\"availabilityZoneConfigList\":[{\"availabilityZoneName\":\"us-east-1a\",\"allowedIPV4CidrList\":[\"10.0.0.0/28\"]},{\"availabilityZoneName\":\"us-east-1b\",\"allowedIPV4CidrList\":[ \"10.0.0.0/28\"]}]} },\"singleFirewallEndpointPerVPC\":false,\"allowedIPV4CidrList\":null,\"routeManagementAction\":\"OFF\",\"networkFirewallLoggingConfiguration\":{\"logDestinationConfigs\":[{\"logDestinationType\":\"S3\",\"logType\":\"ALERT\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}},{\"logDestinationType\":\"S3\",\"logType\":\"FLOW\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}}],\"overrideExistingConfig\":boolean}}"
    /// `
    ///
    /// With custom Availability Zone configuration,
    /// you define which specific Availability Zones to create endpoints in by
    /// configuring
    /// `firewallCreationConfig`. To configure the Availability Zones in
    /// `firewallCreationConfig`, specify either the `availabilityZoneName` or
    /// `availabilityZoneId` parameter, not both parameters.
    ///
    /// To use the distributed deployment model, you must set
    /// [PolicyOption](https://docs.aws.amazon.com/fms/2018-01-01/APIReference/API_PolicyOption.html) to
    /// `NULL`.
    ///
    /// * Example: `NETWORK_FIREWALL` - Distributed deployment model with
    /// custom Availability Zone configuration and route management
    ///
    /// `"{\"type\":\"NETWORK_FIREWALL\",\"networkFirewallStatelessRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateless-rulegroup/test\",\"priority\":1}],\"networkFirewallStatelessDefaultActions\":[\"aws:forward_to_sfe\",\"customActionName\"],\"networkFirewallStatelessFragmentDefaultActions\":[\"aws:forward_to_sfe\",\"fragmentcustomactionname\"],\"networkFirewallStatelessCustomActions\":[{\"actionName\":\"customActionName\",\"actionDefinition\":{\"publishMetricAction\":{\"dimensions\":[{\"value\":\"metricdimensionvalue\"}]}}},{\"actionName\":\"fragmentcustomactionname\",\"actionDefinition\":{\"publishMetricAction\":{\"dimensions\":[{\"value\":\"fragmentmetricdimensionvalue\"}]}}}],\"networkFirewallStatefulRuleGroupReferences\":[{\"resourceARN\":\"arn:aws:network-firewall:us-east-1:123456789011:stateful-rulegroup/test\"}],\"networkFirewallOrchestrationConfig\":{\"firewallCreationConfig\":{\"endpointLocation\":{\"availabilityZoneConfigList\":[{\"availabilityZoneName\":\"us-east-1a\",\"allowedIPV4CidrList\":[\"10.0.0.0/28\"]},{\"availabilityZoneName\":\"us-east-1b\",\"allowedIPV4CidrList\":[\"10.0.0.0/28\"]}]}},\"singleFirewallEndpointPerVPC\":false,\"allowedIPV4CidrList\":null,\"routeManagementAction\":\"MONITOR\",\"routeManagementTargetTypes\":[\"InternetGateway\"],\"routeManagementConfig\":{\"allowCrossAZTrafficIfNoEndpoint\":true}},\"networkFirewallLoggingConfiguration\":{\"logDestinationConfigs\":[{\"logDestinationType\":\"S3\",\"logType\":\"ALERT\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}},{\"logDestinationType\":\"S3\",\"logType\":\"FLOW\",\"logDestination\":{\"bucketName\":\"s3-bucket-name\"}}],\"overrideExistingConfig\":boolean}}"
    /// `
    ///
    /// To use the distributed deployment model, you must set
    /// [PolicyOption](https://docs.aws.amazon.com/fms/2018-01-01/APIReference/API_PolicyOption.html) to
    /// `NULL`.
    ///
    /// * Example: `SECURITY_GROUPS_COMMON`
    ///
    /// `"{\"type\":\"SECURITY_GROUPS_COMMON\",\"securityGroups\":[{\"id\":\"sg-03b1f67d69ed00197\"}],\"revertManualSecurityGroupChanges\":true,\"exclusiveResourceSecurityGroupManagement\":true,\"applyToAllEC2InstanceENIs\":false,\"includeSharedVPC\":true,\"enableSecurityGroupReferencesDistribution\":true}"`
    ///
    /// * Example: `SECURITY_GROUPS_COMMON` - Security group tag distribution
    ///
    /// `""{\"type\":\"SECURITY_GROUPS_COMMON\",\"securityGroups\":[{\"id\":\"sg-000e55995d61a06bd\"}],\"revertManualSecurityGroupChanges\":true,\"exclusiveResourceSecurityGroupManagement\":false,\"applyToAllEC2InstanceENIs\":false,\"includeSharedVPC\":false,\"enableTagDistribution\":true}""`
    ///
    /// Firewall Manager automatically distributes tags from the primary group to
    /// the security groups created by this policy. To use security group tag
    /// distribution, you must also set `revertManualSecurityGroupChanges` to
    /// `true`, otherwise Firewall Manager won't be able to create the policy. When
    /// you enable `revertManualSecurityGroupChanges`, Firewall Manager identifies
    /// and reports when the security groups created by this policy become
    /// non-compliant.
    ///
    /// Firewall Manager won't distribute system tags added by Amazon Web Services
    /// services into the replica security groups. System tags begin with the `aws:`
    /// prefix.
    ///
    /// * Example: Shared VPCs. Apply the preceding policy to resources in shared
    ///   VPCs as
    /// well as to those in VPCs that the account owns
    ///
    /// `"{\"type\":\"SECURITY_GROUPS_COMMON\",\"revertManualSecurityGroupChanges\":false,\"exclusiveResourceSecurityGroupManagement\":false,
    /// \"applyToAllEC2InstanceENIs\":false,\"includeSharedVPC\":true,\"securityGroups\":[{\"id\":\"
    /// sg-000e55995d61a06bd\"}]}"`
    ///
    /// * Example: `SECURITY_GROUPS_CONTENT_AUDIT`
    ///
    /// `"{\"type\":\"SECURITY_GROUPS_CONTENT_AUDIT\",\"preManagedOptions\":[{\"denyProtocolAllValue\":true},{\"auditSgDirection\":{\"type\":\"ALL\"}}],\"securityGroups\":[{\"id\":\"sg-049b2393a25468971\"}],\"securityGroupAction\":{\"type\":\"ALLOW\"}}"`
    ///
    /// The security group action for content audit can be `ALLOW` or
    /// `DENY`. For `ALLOW`, all in-scope security group rules must
    /// be within the allowed range of the policy's security group rules. For
    /// `DENY`, all in-scope security group rules must not contain a value or a
    /// range that matches a rule value or range in the policy security group.
    ///
    /// * Example: `SECURITY_GROUPS_USAGE_AUDIT`
    ///
    /// `"{\"type\":\"SECURITY_GROUPS_USAGE_AUDIT\",\"deleteUnusedSecurityGroups\":true,\"coalesceRedundantSecurityGroups\":true,\"optionalDelayForUnusedInMinutes\":60}"`
    ///
    /// * Example: `SHIELD_ADVANCED` with web ACL management
    ///
    /// `"{\"type\":\"SHIELD_ADVANCED\",\"optimizeUnassociatedWebACL\":true}"`
    ///
    /// If you set `optimizeUnassociatedWebACL` to `true`, Firewall Manager creates
    /// web ACLs in accounts within the policy scope if the web ACLs will be used by
    /// at least one resource. Firewall Manager creates web ACLs in the accounts
    /// within policy scope only if the web ACLs will be used by at least one
    /// resource. If at any time an account comes into policy scope, Firewall
    /// Manager automatically creates a web ACL in the account if at least one
    /// resource will use the web ACL.
    ///
    /// Upon enablement, Firewall Manager performs a one-time cleanup of unused web
    /// ACLs in your account. The cleanup process can take several hours. If a
    /// resource leaves policy scope after Firewall Manager creates a web ACL,
    /// Firewall Manager doesn't disassociate the resource from the web ACL. If you
    /// want Firewall Manager to clean up the web ACL, you must first manually
    /// disassociate the resources from the web ACL, and then enable the manage
    /// unused web ACLs option in your policy.
    ///
    /// If you set `optimizeUnassociatedWebACL` to `false`, and Firewall Manager
    /// automatically creates an empty web ACL in each account that's within policy
    /// scope.
    ///
    /// * Specification for `SHIELD_ADVANCED` for Amazon CloudFront distributions
    ///
    /// `"{\"type\":\"SHIELD_ADVANCED\",\"automaticResponseConfiguration\":
    /// {\"automaticResponseStatus\":\"ENABLED|IGNORED|DISABLED\",
    /// \"automaticResponseAction\":\"BLOCK|COUNT\"},
    /// \"overrideCustomerWebaclClassic\":true|false,
    /// \"optimizeUnassociatedWebACL\":true|false}"`
    ///
    /// For example:
    /// `"{\"type\":\"SHIELD_ADVANCED\",\"automaticResponseConfiguration\":
    /// {\"automaticResponseStatus\":\"ENABLED\",
    /// \"automaticResponseAction\":\"COUNT\"}}"`
    ///
    /// The default value for `automaticResponseStatus` is
    /// `IGNORED`. The value for `automaticResponseAction` is only
    /// required when `automaticResponseStatus` is set to `ENABLED`.
    /// The default value for `overrideCustomerWebaclClassic` is
    /// `false`.
    ///
    /// For other resource types that you can protect with a Shield Advanced policy,
    /// this
    /// `ManagedServiceData` configuration is an empty string.
    ///
    /// * Example: `THIRD_PARTY_FIREWALL`
    ///
    /// Replace `THIRD_PARTY_FIREWALL_NAME` with the name of the third-party
    /// firewall.
    ///
    /// `"{
    /// "type":"THIRD_PARTY_FIREWALL",
    /// "thirdPartyFirewall":"THIRD_PARTY_FIREWALL_NAME",
    /// "thirdPartyFirewallConfig":{
    /// "thirdPartyFirewallPolicyList":["global-1"]
    /// },
    /// "firewallDeploymentModel":{
    /// "distributedFirewallDeploymentModel":{
    /// "distributedFirewallOrchestrationConfig":{
    /// "firewallCreationConfig":{
    /// "endpointLocation":{
    /// "availabilityZoneConfigList":[
    /// {
    /// "availabilityZoneName":"${AvailabilityZone}"
    /// }
    /// ]
    /// }
    /// },
    /// "allowedIPV4CidrList":[
    /// ]
    /// }
    /// }
    /// }
    /// }"`
    ///
    /// * Example: `WAFV2` - Account takeover prevention, Bot Control managed rule
    ///   groups, optimize unassociated web ACL, and rule action override
    ///
    /// `"{\"type\":\"WAFV2\",\"preProcessRuleGroups\":[{\"ruleGroupArn\":null,\"overrideAction\":{\"type\":\"NONE\"},\"managedRuleGroupIdentifier\":{\"versionEnabled\":null,\"version\":null,\"vendorName\":\"AWS\",\"managedRuleGroupName\":\"AWSManagedRulesATPRuleSet\",\"managedRuleGroupConfigs\":[{\"awsmanagedRulesATPRuleSet\":{\"loginPath\":\"/loginpath\",\"requestInspection\":{\"payloadType\":\"FORM_ENCODED|JSON\",\"usernameField\":{\"identifier\":\"/form/username\"},\"passwordField\":{\"identifier\":\"/form/password\"}}}}]},\"ruleGroupType\":\"ManagedRuleGroup\",\"excludeRules\":[],\"sampledRequestsEnabled\":true},{\"ruleGroupArn\":null,\"overrideAction\":{\"type\":\"NONE\"},\"managedRuleGroupIdentifier\":{\"versionEnabled\":null,\"version\":null,\"vendorName\":\"AWS\",\"managedRuleGroupName\":\"AWSManagedRulesBotControlRuleSet\",\"managedRuleGroupConfigs\":[{\"awsmanagedRulesBotControlRuleSet\":{\"inspectionLevel\":\"TARGETED|COMMON\"}}]},\"ruleGroupType\":\"ManagedRuleGroup\",\"excludeRules\":[],\"sampledRequestsEnabled\":true,\"ruleActionOverrides\":[{\"name\":\"Rule1\",\"actionToUse\":{\"allow|block|count|captcha|challenge\":{}}},{\"name\":\"Rule2\",\"actionToUse\":{\"allow|block|count|captcha|challenge\":{}}}]}],\"postProcessRuleGroups\":[],\"defaultAction\":{\"type\":\"ALLOW\"},\"customRequestHandling\":null,\"customResponse\":null,\"overrideCustomerWebACLAssociation\":false,\"loggingConfiguration\":null,\"sampledRequestsEnabledForDefaultActions\":true,\"optimizeUnassociatedWebACL\":true}"`
    ///
    /// * Bot Control - For information about `AWSManagedRulesBotControlRuleSet`
    ///   managed rule groups, see
    ///   [AWSManagedRulesBotControlRuleSet](https://docs.aws.amazon.com/waf/latest/APIReference/API_AWSManagedRulesBotControlRuleSet.html) in the *WAF API Reference*.
    ///
    /// * Fraud Control account takeover prevention (ATP) - For information about
    ///   the properties available for `AWSManagedRulesATPRuleSet` managed rule
    ///   groups, see
    ///   [AWSManagedRulesATPRuleSet](https://docs.aws.amazon.com/waf/latest/APIReference/API_AWSManagedRulesATPRuleSet.html) in the *WAF API Reference*.
    ///
    /// * Optimize unassociated web ACL - If you set `optimizeUnassociatedWebACL` to
    ///   `true`, Firewall Manager creates web ACLs in accounts within the policy
    ///   scope if the web ACLs will be used by at least one resource. Firewall
    ///   Manager creates web ACLs in the accounts within policy scope only if the
    ///   web ACLs will be used by at least one resource. If at any time an account
    ///   comes into policy scope, Firewall Manager automatically creates a web ACL
    ///   in the account if at least one resource will use the web ACL.
    ///
    /// Upon enablement, Firewall Manager performs a one-time cleanup of unused web
    /// ACLs in your account. The cleanup process can take several hours. If a
    /// resource leaves policy scope after Firewall Manager creates a web ACL,
    /// Firewall Manager disassociates the resource from the web ACL, but won't
    /// clean up the unused web ACL. Firewall Manager only cleans up unused web ACLs
    /// when you first enable management of unused web ACLs in a policy.
    ///
    /// If you set `optimizeUnassociatedWebACL` to `false` Firewall Manager doesn't
    /// manage unused web ACLs, and Firewall Manager automatically creates an empty
    /// web ACL in each account that's within policy scope.
    ///
    /// * Rule action overrides - Firewall Manager supports rule action overrides
    ///   only for managed rule groups. To configure a `RuleActionOverrides` add the
    ///   `Name` of the rule to override, and `ActionToUse`, which is the new action
    ///   to use for the rule. For information about using rule action override, see
    ///   [RuleActionOverride](https://docs.aws.amazon.com/waf/latest/APIReference/API_RuleActionOverride.html) in the *WAF API Reference*.
    ///
    /// * Example: `WAFV2` - `CAPTCHA` and `Challenge` configs
    ///
    /// `"{\"type\":\"WAFV2\",\"preProcessRuleGroups\":[{\"ruleGroupArn\":null,\"overrideAction\":{\"type\":\"NONE\"},\"managedRuleGroupIdentifier\":{\"versionEnabled\":null,\"version\":null,\"vendorName\":\"AWS\",\"managedRuleGroupName\":\"AWSManagedRulesAdminProtectionRuleSet\"},\"ruleGroupType\":\"ManagedRuleGroup\",\"excludeRules\":[],\"sampledRequestsEnabled\":true}],\"postProcessRuleGroups\":[],\"defaultAction\":{\"type\":\"ALLOW\"},\"customRequestHandling\":null,\"customResponse\":null,\"overrideCustomerWebACLAssociation\":false,\"loggingConfiguration\":null,\"sampledRequestsEnabledForDefaultActions\":true,\"captchaConfig\":{\"immunityTimeProperty\":{\"immunityTime\":500}},\"challengeConfig\":{\"immunityTimeProperty\":{\"immunityTime\":800}},\"tokenDomains\":[\"google.com\",\"amazon.com\"],\"associationConfig\":{\"requestBody\":{\"CLOUDFRONT\":{\"defaultSizeInspectionLimit\":\"KB_16\"}}}}"`
    ///
    /// * `CAPTCHA` and `Challenge` configs - If you update the policy's values for
    ///   `associationConfig`, `captchaConfig`, `challengeConfig`, or
    ///   `tokenDomains`, Firewall Manager will overwrite your local web ACLs to
    ///   contain the new value(s). However, if you don't update the policy's
    ///   `associationConfig`, `captchaConfig`, `challengeConfig`, or `tokenDomains`
    ///   values, the values in your local web ACLs will remain unchanged. For
    ///   information about association configs, see
    ///   [AssociationConfig](https://docs.aws.amazon.com/waf/latest/APIReference/API_AssociationConfig.html). For information about CAPTCHA and Challenge configs, see [CaptchaConfig](https://docs.aws.amazon.com/waf/latest/APIReference/API_CaptchaConfig.html) and [ChallengeConfig](https://docs.aws.amazon.com/waf/latest/APIReference/API_ChallengeConfig.html) in the *WAF API Reference*.
    ///
    /// * `defaultSizeInspectionLimit` - Specifies the maximum size of the web
    ///   request body component that an associated Amazon CloudFront distribution
    ///   should send to WAF for inspection. For more information, see
    ///   [DefaultSizeInspectionLimit](https://docs.aws.amazon.com/waf/latest/APIReference/API_RequestBodyAssociatedResourceTypeConfig.html#WAF-Type-RequestBodyAssociatedResourceTypeConfig-DefaultSizeInspectionLimit) in the *WAF API Reference*.
    ///
    /// * Example: `WAFV2` - Firewall Manager support for WAF managed rule group
    ///   versioning
    ///
    /// `"{\"preProcessRuleGroups\":[{\"ruleGroupType\":\"ManagedRuleGroup\",\"overrideAction\":{\"type\":\"NONE\"},\"sampledRequestsEnabled\":true,\"managedRuleGroupIdentifier\":{\"managedRuleGroupName\":\"AWSManagedRulesAdminProtectionRuleSet\",\"vendorName\":\"AWS\",\"managedRuleGroupConfigs\":null}}],\"postProcessRuleGroups\":[],\"defaultAction\":{\"type\":\"ALLOW\"},\"customRequestHandling\":null,\"tokenDomains\":null,\"customResponse\":null,\"type\":\"WAFV2\",\"overrideCustomerWebACLAssociation\":false,\"sampledRequestsEnabledForDefaultActions\":true,\"optimizeUnassociatedWebACL\":true,\"webACLSource\":\"RETROFIT_EXISTING\"}"`
    ///
    /// To use a specific version of a WAF managed rule group in your Firewall
    /// Manager policy, you must set `versionEnabled` to `true`, and set `version`
    /// to the version you'd like to use. If you don't set `versionEnabled` to
    /// `true`, or if you omit `versionEnabled`, then Firewall Manager uses the
    /// default version of the WAF managed rule group.
    ///
    /// * Example: `WAFV2` - Logging configurations
    ///
    /// `"{\"type\":\"WAFV2\",\"preProcessRuleGroups\":[{\"ruleGroupArn\":null,
    /// \"overrideAction\":{\"type\":\"NONE\"},\"managedRuleGroupIdentifier\":
    /// {\"versionEnabled\":null,\"version\":null,\"vendorName\":\"AWS\",
    /// \"managedRuleGroupName\":\"AWSManagedRulesAdminProtectionRuleSet\"}
    /// ,\"ruleGroupType\":\"ManagedRuleGroup\",\"excludeRules\":[],
    /// \"sampledRequestsEnabled\":true}],\"postProcessRuleGroups\":[],
    /// \"defaultAction\":{\"type\":\"ALLOW\"},\"customRequestHandling\"
    /// :null,\"customResponse\":null,\"overrideCustomerWebACLAssociation\"
    /// :false,\"loggingConfiguration\":{\"logDestinationConfigs\":
    /// [\"arn:aws:s3:::aws-waf-logs-example-bucket\"]
    /// ,\"redactedFields\":[],\"loggingFilterConfigs\":{\"defaultBehavior\":\"KEEP\", \"filters\":[{\"behavior\":\"KEEP\",\"requirement\":\"MEETS_ALL\", \"conditions\":[{\"actionCondition\":\"CAPTCHA\"},{\"actionCondition\": \"CHALLENGE\"}, {\"actionCondition\":\"EXCLUDED_AS_COUNT\"}]}]}},\"sampledRequestsEnabledForDefaultActions\":true}"`
    ///
    /// Firewall Manager supports Amazon Kinesis Data Firehose and Amazon S3 as the
    /// `logDestinationConfigs` in your `loggingConfiguration`. For information
    /// about WAF logging configurations, see
    /// [LoggingConfiguration](https://docs.aws.amazon.com/waf/latest/APIReference/API_LoggingConfiguration.html) in the *WAF API Reference*
    ///
    /// In the `loggingConfiguration`, you can specify one
    /// `logDestinationConfigs`. Optionally provide as many as 20
    /// `redactedFields`. The `RedactedFieldType` must be one of
    /// `URI`, `QUERY_STRING`, `HEADER`, or
    /// `METHOD`.
    ///
    /// * Example: `WAF Classic`
    ///
    /// `"{\"ruleGroups\":[{\"id\":\"78cb36c0-1b5e-4d7d-82b2-cf48d3ad9659\",\"overrideAction\":{\"type\":\"NONE\"}}],\"overrideCustomerWebACLAssociation\":true,\"defaultAction\":{\"type\":\"ALLOW\"},\"type\":\"WAF\"}"`
    managed_service_data: ?[]const u8,

    /// Contains the settings to configure a network ACL policy, a Network Firewall
    /// firewall policy deployment model, or a third-party firewall policy.
    policy_option: ?PolicyOption,

    /// The service that the policy is using to protect the resources. This
    /// specifies the type of
    /// policy that is created, either an WAF policy, a Shield Advanced policy, or a
    /// security
    /// group policy. For security group policies, Firewall Manager supports one
    /// security group for
    /// each common policy and for each content audit policy. This is an adjustable
    /// limit that you can
    /// increase by contacting Amazon Web Services Support.
    @"type": SecurityServiceType,

    pub const json_field_names = .{
        .managed_service_data = "ManagedServiceData",
        .policy_option = "PolicyOption",
        .@"type" = "Type",
    };
};
