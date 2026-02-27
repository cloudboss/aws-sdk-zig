const aws = @import("aws");

const CustomerPolicyStatus = @import("customer_policy_status.zig").CustomerPolicyStatus;
const ResourceTagLogicalOperator = @import("resource_tag_logical_operator.zig").ResourceTagLogicalOperator;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const SecurityServicePolicyData = @import("security_service_policy_data.zig").SecurityServicePolicyData;

/// An Firewall Manager policy.
pub const Policy = struct {
    /// Indicates whether Firewall Manager should automatically remove protections
    /// from resources that leave the policy scope and clean up resources
    /// that Firewall Manager is managing for accounts when those accounts leave
    /// policy scope. For example, Firewall Manager will disassociate a Firewall
    /// Manager managed web ACL
    /// from a protected customer resource when the customer resource leaves policy
    /// scope.
    ///
    /// By default, Firewall Manager doesn't remove protections or delete Firewall
    /// Manager managed resources.
    ///
    /// This option is not available for Shield Advanced or WAF Classic policies.
    delete_unused_fm_managed_resources: bool = false,

    /// Specifies the Amazon Web Services account IDs and Organizations
    /// organizational units (OUs) to exclude from the policy.
    /// Specifying an OU is the equivalent of specifying all accounts in the OU and
    /// in any of its child OUs, including any child OUs and accounts that are added
    /// at a later time.
    ///
    /// You can specify inclusions or exclusions, but not both. If you specify an
    /// `IncludeMap`, Firewall Manager
    /// applies the policy to all accounts specified by the `IncludeMap`, and
    /// does not evaluate any `ExcludeMap` specifications. If you do not specify an
    /// `IncludeMap`, then Firewall Manager
    /// applies the policy to all accounts except for those specified by the
    /// `ExcludeMap`.
    ///
    /// You can specify account IDs, OUs, or a combination:
    ///
    /// * Specify account IDs by setting the key to `ACCOUNT`. For example, the
    ///   following is a valid map:
    /// `{“ACCOUNT” : [“accountID1”, “accountID2”]}`.
    ///
    /// * Specify OUs by setting the key to `ORG_UNIT`. For example, the following
    ///   is a valid map:
    /// `{“ORG_UNIT” : [“ouid111”, “ouid112”]}`.
    ///
    /// * Specify accounts and OUs together in a single map, separated with a comma.
    ///   For example, the following is a valid map:
    /// `{“ACCOUNT” : [“accountID1”, “accountID2”], “ORG_UNIT” : [“ouid111”,
    /// “ouid112”]}`.
    exclude_map: ?[]const aws.map.MapEntry([]const []const u8),

    /// If set to `True`, resources with the tags that are specified in the
    /// `ResourceTag` array are not in scope of the policy. If set to `False`,
    /// and the `ResourceTag` array is not null, only resources with the specified
    /// tags are
    /// in scope of the policy.
    exclude_resource_tags: bool = false,

    /// Specifies the Amazon Web Services account IDs and Organizations
    /// organizational units (OUs) to include in the policy.
    /// Specifying an OU is the equivalent of specifying all accounts in the OU and
    /// in any of its child OUs, including any child OUs and accounts that are added
    /// at a later time.
    ///
    /// You can specify inclusions or exclusions, but not both. If you specify an
    /// `IncludeMap`, Firewall Manager
    /// applies the policy to all accounts specified by the `IncludeMap`, and
    /// does not evaluate any `ExcludeMap` specifications. If you do not specify an
    /// `IncludeMap`, then Firewall Manager
    /// applies the policy to all accounts except for those specified by the
    /// `ExcludeMap`.
    ///
    /// You can specify account IDs, OUs, or a combination:
    ///
    /// * Specify account IDs by setting the key to `ACCOUNT`. For example, the
    ///   following is a valid map:
    /// `{“ACCOUNT” : [“accountID1”, “accountID2”]}`.
    ///
    /// * Specify OUs by setting the key to `ORG_UNIT`. For example, the following
    ///   is a valid map:
    /// `{“ORG_UNIT” : [“ouid111”, “ouid112”]}`.
    ///
    /// * Specify accounts and OUs together in a single map, separated with a comma.
    ///   For example, the following is a valid map:
    /// `{“ACCOUNT” : [“accountID1”, “accountID2”], “ORG_UNIT” : [“ouid111”,
    /// “ouid112”]}`.
    include_map: ?[]const aws.map.MapEntry([]const []const u8),

    /// Your description of the Firewall Manager policy.
    policy_description: ?[]const u8,

    /// The ID of the Firewall Manager policy.
    policy_id: ?[]const u8,

    /// The name of the Firewall Manager policy.
    policy_name: []const u8,

    /// Indicates whether the policy is in or out of an admin's policy or Region
    /// scope.
    ///
    /// * `ACTIVE` - The administrator can manage and delete the policy.
    ///
    /// * `OUT_OF_ADMIN_SCOPE` - The administrator can view the policy, but they
    ///   can't edit or delete the policy. Existing policy protections stay in
    ///   place. Any new resources that come into scope of the policy won't be
    ///   protected.
    policy_status: ?CustomerPolicyStatus,

    /// A unique identifier for each update to the policy. When issuing a
    /// `PutPolicy`
    /// request, the `PolicyUpdateToken` in the request must match the
    /// `PolicyUpdateToken` of the current policy version. To get the
    /// `PolicyUpdateToken` of the current policy version, use a `GetPolicy`
    /// request.
    policy_update_token: ?[]const u8,

    /// Indicates if the policy should be automatically applied to new resources.
    remediation_enabled: bool = false,

    /// The unique identifiers of the resource sets used by the policy.
    resource_set_ids: ?[]const []const u8,

    /// Specifies whether to combine multiple resource tags with AND,
    /// so that a resource must have all tags to be included or excluded, or OR,
    /// so that a resource must have at least one tag.
    ///
    /// Default: `AND`
    resource_tag_logical_operator: ?ResourceTagLogicalOperator,

    /// An array of `ResourceTag` objects.
    resource_tags: ?[]const ResourceTag,

    /// The type of resource protected by or in scope of the policy. This is in the
    /// format shown
    /// in the [Amazon Web Services Resource Types
    /// Reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html).
    /// To apply this policy to multiple resource types, specify a resource type of
    /// `ResourceTypeList` and then specify the resource types in a
    /// `ResourceTypeList`.
    ///
    /// The following are valid resource types for each Firewall Manager policy
    /// type:
    ///
    /// * Amazon Web Services WAF Classic - `AWS::ApiGateway::Stage`,
    ///   `AWS::CloudFront::Distribution`, and
    ///   `AWS::ElasticLoadBalancingV2::LoadBalancer`.
    ///
    /// * WAF - `AWS::ApiGateway::Stage`,
    ///   `AWS::ElasticLoadBalancingV2::LoadBalancer`, and
    ///   `AWS::CloudFront::Distribution`.
    ///
    /// * Shield Advanced - `AWS::ElasticLoadBalancingV2::LoadBalancer`,
    ///   `AWS::ElasticLoadBalancing::LoadBalancer`, `AWS::EC2::EIP`, and
    ///   `AWS::CloudFront::Distribution`.
    ///
    /// * Network ACL - `AWS::EC2::Subnet`.
    ///
    /// * Security group usage audit - `AWS::EC2::SecurityGroup`.
    ///
    /// * Security group content audit - `AWS::EC2::SecurityGroup`,
    ///   `AWS::EC2::NetworkInterface`, and `AWS::EC2::Instance`.
    ///
    /// * DNS Firewall, Network Firewall, and third-party firewall -
    ///   `AWS::EC2::VPC`.
    resource_type: []const u8,

    /// An array of `ResourceType` objects. Use this only to specify multiple
    /// resource types. To specify a single resource type, use `ResourceType`.
    resource_type_list: ?[]const []const u8,

    /// Details about the security service that is being used to protect the
    /// resources.
    security_service_policy_data: SecurityServicePolicyData,

    pub const json_field_names = .{
        .delete_unused_fm_managed_resources = "DeleteUnusedFMManagedResources",
        .exclude_map = "ExcludeMap",
        .exclude_resource_tags = "ExcludeResourceTags",
        .include_map = "IncludeMap",
        .policy_description = "PolicyDescription",
        .policy_id = "PolicyId",
        .policy_name = "PolicyName",
        .policy_status = "PolicyStatus",
        .policy_update_token = "PolicyUpdateToken",
        .remediation_enabled = "RemediationEnabled",
        .resource_set_ids = "ResourceSetIds",
        .resource_tag_logical_operator = "ResourceTagLogicalOperator",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .resource_type_list = "ResourceTypeList",
        .security_service_policy_data = "SecurityServicePolicyData",
    };
};
