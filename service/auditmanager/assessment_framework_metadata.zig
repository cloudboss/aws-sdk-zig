const FrameworkType = @import("framework_type.zig").FrameworkType;

/// The metadata that's associated with a standard framework or a custom
/// framework.
pub const AssessmentFrameworkMetadata = struct {
    /// The Amazon Resource Name (ARN) of the framework.
    arn: ?[]const u8,

    /// The compliance type that the new custom framework supports, such as CIS or
    /// HIPAA.
    compliance_type: ?[]const u8,

    /// The number of controls that are associated with the framework.
    controls_count: i32 = 0,

    /// The number of control sets that are associated with the framework.
    control_sets_count: i32 = 0,

    /// The time when the framework was created.
    created_at: ?i64,

    /// The description of the framework.
    description: ?[]const u8,

    /// The unique identifier for the framework.
    id: ?[]const u8,

    /// The time when the framework was most recently updated.
    last_updated_at: ?i64,

    /// The logo that's associated with the framework.
    logo: ?[]const u8,

    /// The name of the framework.
    name: ?[]const u8,

    /// The framework type, such as a standard framework or a custom framework.
    @"type": ?FrameworkType,

    pub const json_field_names = .{
        .arn = "arn",
        .compliance_type = "complianceType",
        .controls_count = "controlsCount",
        .control_sets_count = "controlSetsCount",
        .created_at = "createdAt",
        .description = "description",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .logo = "logo",
        .name = "name",
        .@"type" = "type",
    };
};
