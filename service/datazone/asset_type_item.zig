const aws = @import("aws");

const FormEntryOutput = @import("form_entry_output.zig").FormEntryOutput;

/// The details of the asset type.
pub const AssetTypeItem = struct {
    /// The timestamp of when the asset type was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the asset type.
    created_by: ?[]const u8 = null,

    /// The description of the asset type.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain where the asset type exists.
    domain_id: []const u8,

    /// The forms included in the details of the asset type.
    forms_output: []const aws.map.MapEntry(FormEntryOutput),

    /// The name of the asset type.
    name: []const u8,

    /// The identifier of the Amazon DataZone domain where the asset type was
    /// originally created.
    origin_domain_id: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone project where the asset type exists.
    origin_project_id: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone project that owns the asset type.
    owning_project_id: []const u8,

    /// The revision of the asset type.
    revision: []const u8,

    /// The timestamp of when the asset type was updated.
    updated_at: ?i64 = null,

    /// The Amazon DataZone user who updated the asset type.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .forms_output = "formsOutput",
        .name = "name",
        .origin_domain_id = "originDomainId",
        .origin_project_id = "originProjectId",
        .owning_project_id = "owningProjectId",
        .revision = "revision",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
