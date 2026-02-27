const aws = @import("aws");

const ComponentDependencyRequirement = @import("component_dependency_requirement.zig").ComponentDependencyRequirement;
const LambdaExecutionParameters = @import("lambda_execution_parameters.zig").LambdaExecutionParameters;
const ComponentPlatform = @import("component_platform.zig").ComponentPlatform;

/// Contains information about an Lambda function to import to create a
/// component.
pub const LambdaFunctionRecipeSource = struct {
    /// The component versions on which this Lambda function component depends.
    component_dependencies: ?[]const aws.map.MapEntry(ComponentDependencyRequirement),

    /// The system and runtime parameters for the Lambda function as it runs on the
    /// Greengrass core
    /// device.
    component_lambda_parameters: ?LambdaExecutionParameters,

    /// The name of the component.
    ///
    /// Defaults to the name of the Lambda function.
    component_name: ?[]const u8,

    /// The platforms that the component version supports.
    component_platforms: ?[]const ComponentPlatform,

    /// The version of the component.
    ///
    /// Defaults to the version of the Lambda function as a semantic version. For
    /// example, if your
    /// function version is `3`, the component version becomes `3.0.0`.
    component_version: ?[]const u8,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the Lambda function. The ARN must include the version of the function to
    /// import. You can't use version aliases like `$LATEST`.
    lambda_arn: []const u8,

    pub const json_field_names = .{
        .component_dependencies = "componentDependencies",
        .component_lambda_parameters = "componentLambdaParameters",
        .component_name = "componentName",
        .component_platforms = "componentPlatforms",
        .component_version = "componentVersion",
        .lambda_arn = "lambdaArn",
    };
};
