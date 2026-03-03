const PhysicalIdentifierType = @import("physical_identifier_type.zig").PhysicalIdentifierType;

/// Defines a physical resource identifier.
pub const PhysicalResourceId = struct {
    /// The Amazon Web Services account that owns the physical resource.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services Region that the physical resource is located in.
    aws_region: ?[]const u8 = null,

    /// Identifier of the physical resource.
    identifier: []const u8,

    /// Specifies the type of physical resource identifier.
    ///
    /// **Arn**
    ///
    /// The resource identifier is an Amazon Resource Name (ARN) and it can identify
    /// the
    /// following list of resources:
    ///
    /// * `AWS::ECS::Service`
    ///
    /// * `AWS::EFS::FileSystem`
    ///
    /// * `AWS::ElasticLoadBalancingV2::LoadBalancer`
    ///
    /// * `AWS::Lambda::Function`
    ///
    /// * `AWS::SNS::Topic`
    ///
    /// **Native**
    ///
    /// The resource identifier is an Resilience Hub-native identifier and it can
    /// identify the following list of resources:
    ///
    /// * `AWS::ApiGateway::RestApi`
    ///
    /// * `AWS::ApiGatewayV2::Api`
    ///
    /// * `AWS::AutoScaling::AutoScalingGroup`
    ///
    /// * `AWS::DocDB::DBCluster`
    ///
    /// * `AWS::DocDB::DBGlobalCluster`
    ///
    /// * `AWS::DocDB::DBInstance`
    ///
    /// * `AWS::DynamoDB::GlobalTable`
    ///
    /// * `AWS::DynamoDB::Table`
    ///
    /// * `AWS::EC2::EC2Fleet`
    ///
    /// * `AWS::EC2::Instance`
    ///
    /// * `AWS::EC2::NatGateway`
    ///
    /// * `AWS::EC2::Volume`
    ///
    /// * `AWS::ElasticLoadBalancing::LoadBalancer`
    ///
    /// * `AWS::RDS::DBCluster`
    ///
    /// * `AWS::RDS::DBInstance`
    ///
    /// * `AWS::RDS::GlobalCluster`
    ///
    /// * `AWS::Route53::RecordSet`
    ///
    /// * `AWS::S3::Bucket`
    ///
    /// * `AWS::SQS::Queue`
    @"type": PhysicalIdentifierType,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_region = "awsRegion",
        .identifier = "identifier",
        .@"type" = "type",
    };
};
