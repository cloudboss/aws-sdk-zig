const ExpressionType = @import("expression_type.zig").ExpressionType;

/// Describes a destination.
pub const Destinations = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// The description of the resource.
    description: ?[]const u8 = null,

    /// The rule name or topic rule to send messages to.
    expression: ?[]const u8 = null,

    /// The type of value in `Expression`.
    expression_type: ?ExpressionType = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// The ARN of the IAM Role that authorizes the destination.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .expression = "Expression",
        .expression_type = "ExpressionType",
        .name = "Name",
        .role_arn = "RoleArn",
    };
};
