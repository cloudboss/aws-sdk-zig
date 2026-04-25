const TargetType = @import("target_type.zig").TargetType;

/// An attribute is a name-value pair that's associated with an Amazon ECS
/// object. Use attributes to extend the Amazon ECS data model by adding custom
/// metadata to your resources. For more information, see
/// [Attributes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement-constraints.html#attributes) in the *Amazon Elastic Container Service Developer Guide*.
pub const Attribute = struct {
    /// The name of the attribute. The `name` must contain between 1 and 128
    /// characters. The name may contain letters (uppercase and lowercase), numbers,
    /// hyphens (-), underscores (_), forward slashes (/), back slashes (\), or
    /// periods (.).
    name: []const u8,

    /// The ID of the target. You can specify the short form ID for a resource or
    /// the full Amazon Resource Name (ARN).
    target_id: ?[]const u8 = null,

    /// The type of the target to attach the attribute with. This parameter is
    /// required if you use the short form ID for a resource instead of the full
    /// ARN.
    target_type: ?TargetType = null,

    /// The value of the attribute. The `value` must contain between 1 and 128
    /// characters. It can contain letters (uppercase and lowercase), numbers,
    /// hyphens (-), underscores (_), periods (.), at signs (@), forward slashes
    /// (/), back slashes (\), colons (:), or spaces. The value can't start or end
    /// with a space.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .target_id = "targetId",
        .target_type = "targetType",
        .value = "value",
    };
};
