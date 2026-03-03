const ControlRelationType = @import("control_relation_type.zig").ControlRelationType;

/// A structure that describes a control's relationship status with other
/// controls.
pub const RelatedControlMappingDetails = struct {
    /// The unique identifier of a control.
    control_arn: ?[]const u8 = null,

    /// Returns an enumerated value that represents the relationship between two or
    /// more controls.
    relation_type: ControlRelationType,

    pub const json_field_names = .{
        .control_arn = "ControlArn",
        .relation_type = "RelationType",
    };
};
