const Condition = @import("condition.zig").Condition;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;
const Resource = @import("resource.zig").Resource;

/// A single principal-resource pair that has Lake Formation permissins
/// enforced.
pub const LakeFormationOptInsInfo = struct {
    /// A Lake Formation condition, which applies to permissions and opt-ins that
    /// contain an expression.
    condition: ?Condition,

    /// The last modified date and time of the record.
    last_modified: ?i64,

    /// The user who updated the record.
    last_updated_by: ?[]const u8,

    principal: ?DataLakePrincipal,

    resource: ?Resource,

    pub const json_field_names = .{
        .condition = "Condition",
        .last_modified = "LastModified",
        .last_updated_by = "LastUpdatedBy",
        .principal = "Principal",
        .resource = "Resource",
    };
};
