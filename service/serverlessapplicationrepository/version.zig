const ParameterDefinition = @import("parameter_definition.zig").ParameterDefinition;
const Capability = @import("capability.zig").Capability;

/// Application version details.
pub const Version = struct {
    /// The application Amazon Resource Name (ARN).
    application_id: []const u8,

    /// The date and time this resource was created.
    creation_time: []const u8,

    /// An array of parameter types supported by the application.
    parameter_definitions: []const ParameterDefinition,

    /// A list of values that you must specify before you can deploy certain
    /// applications.
    /// Some applications might include resources that can affect permissions in
    /// your AWS
    /// account, for example, by creating new AWS Identity and Access Management
    /// (IAM) users.
    /// For those applications, you must explicitly acknowledge their capabilities
    /// by
    /// specifying this parameter.
    ///
    /// The only valid values are CAPABILITY_IAM, CAPABILITY_NAMED_IAM,
    /// CAPABILITY_RESOURCE_POLICY, and CAPABILITY_AUTO_EXPAND.
    ///
    /// The following resources require you to specify CAPABILITY_IAM or
    /// CAPABILITY_NAMED_IAM:
    /// [AWS::IAM::Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-group.html),
    /// [AWS::IAM::InstanceProfile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html),
    /// [AWS::IAM::Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-policy.html), and
    /// [AWS::IAM::Role](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html).
    /// If the application contains IAM resources, you can specify either
    /// CAPABILITY_IAM
    /// or CAPABILITY_NAMED_IAM. If the application contains IAM resources
    /// with custom names, you must specify CAPABILITY_NAMED_IAM.
    ///
    /// The following resources require you to specify CAPABILITY_RESOURCE_POLICY:
    /// [AWS::Lambda::Permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html),
    /// [AWS::IAM:Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-policy.html),
    /// [AWS::ApplicationAutoScaling::ScalingPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalingpolicy.html),
    /// [AWS::S3::BucketPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-policy.html),
    /// [AWS::SQS::QueuePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sqs-policy.html), and
    /// [AWS::SNS::TopicPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sns-policy.html).
    ///
    /// Applications that contain one or more nested applications require you to
    /// specify
    /// CAPABILITY_AUTO_EXPAND.
    ///
    /// If your application template contains any of the above resources, we
    /// recommend that you review
    /// all permissions associated with the application before deploying. If you
    /// don't specify
    /// this parameter for an application that requires capabilities, the call will
    /// fail.
    required_capabilities: []const Capability,

    /// Whether all of the AWS resources contained in this application are supported
    /// in the region
    /// in which it is being retrieved.
    resources_supported: bool,

    /// The semantic version of the application:
    ///
    /// [https://semver.org/](https://semver.org/)
    semantic_version: []const u8,

    /// A link to the S3 object that contains the ZIP archive of the source code for
    /// this version of your application.
    ///
    /// Maximum size 50 MB
    source_code_archive_url: ?[]const u8,

    /// A link to a public repository for the source code of your application, for
    /// example the URL of a specific GitHub commit.
    source_code_url: ?[]const u8,

    /// A link to the packaged AWS SAM template of your application.
    template_url: []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .creation_time = "CreationTime",
        .parameter_definitions = "ParameterDefinitions",
        .required_capabilities = "RequiredCapabilities",
        .resources_supported = "ResourcesSupported",
        .semantic_version = "SemanticVersion",
        .source_code_archive_url = "SourceCodeArchiveUrl",
        .source_code_url = "SourceCodeUrl",
        .template_url = "TemplateUrl",
    };
};
