/// Information about a resource in which DevOps Guru detected anomalous
/// behavior.
pub const RecommendationRelatedAnomalyResource = struct {
    /// The name of the resource.
    name: ?[]const u8,

    /// The type of the resource. Resource types take the same form that is used by
    /// Amazon Web Services CloudFormation
    /// resource type identifiers, `service-provider::service-name::data-type-name`.
    /// For example, `AWS::RDS::DBCluster`. For more information, see [Amazon Web
    /// Services
    /// resource and property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *Amazon Web Services CloudFormation User
    /// Guide*.
    type: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .type = "Type",
    };
};
