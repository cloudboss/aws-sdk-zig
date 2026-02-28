const DependencyType = @import("dependency_type.zig").DependencyType;

/// A structure that contains information about a dependency for a canary.
pub const Dependency = struct {
    /// The dependency reference. For Lambda layers, this is the ARN of the Lambda
    /// layer. For more information
    /// about Lambda ARN format, see
    /// [Lambda](https://docs.aws.amazon.com/lambda/latest/api/API_Layer.html).
    reference: []const u8,

    /// The type of dependency. Valid value is `LambdaLayer`.
    @"type": ?DependencyType,

    pub const json_field_names = .{
        .reference = "Reference",
        .@"type" = "Type",
    };
};
