const aws = @import("aws");

const ControlSet = @import("control_set.zig").ControlSet;
const FrameworkType = @import("framework_type.zig").FrameworkType;

/// The file that's used to structure and automate Audit Manager assessments for
/// a
/// given compliance standard.
pub const Framework = struct {
    /// The Amazon Resource Name (ARN) of the framework.
    arn: ?[]const u8,

    /// The compliance type that the framework supports, such as CIS or HIPAA.
    compliance_type: ?[]const u8,

    /// The control sets that are associated with the framework.
    ///
    /// The `Controls` object returns a partial response when called through
    /// Framework APIs. For a complete `Controls` object, use
    /// `GetControl`.
    control_sets: ?[]const ControlSet,

    /// The control data sources where Audit Manager collects evidence from.
    ///
    /// This API parameter is no longer supported.
    control_sources: ?[]const u8,

    /// The time when the framework was created.
    created_at: ?i64,

    /// The user or role that created the framework.
    created_by: ?[]const u8,

    /// The description of the framework.
    description: ?[]const u8,

    /// The unique identifier for the framework.
    id: ?[]const u8,

    /// The time when the framework was most recently updated.
    last_updated_at: ?i64,

    /// The user or role that most recently updated the framework.
    last_updated_by: ?[]const u8,

    /// The logo that's associated with the framework.
    logo: ?[]const u8,

    /// The name of the framework.
    name: ?[]const u8,

    /// The tags that are associated with the framework.
    tags: ?[]const aws.map.StringMapEntry,

    /// Specifies whether the framework is a standard framework or a custom
    /// framework.
    type: ?FrameworkType,

    pub const json_field_names = .{
        .arn = "arn",
        .compliance_type = "complianceType",
        .control_sets = "controlSets",
        .control_sources = "controlSources",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .last_updated_by = "lastUpdatedBy",
        .logo = "logo",
        .name = "name",
        .tags = "tags",
        .type = "type",
    };
};
