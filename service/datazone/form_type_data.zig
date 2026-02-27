const Import = @import("import.zig").Import;
const Model = @import("model.zig").Model;
const FormTypeStatus = @import("form_type_status.zig").FormTypeStatus;

/// The details of the metadata form type.
pub const FormTypeData = struct {
    /// The timestamp of when the metadata form type was created.
    created_at: ?i64,

    /// The Amazon DataZone user who created teh metadata form type.
    created_by: ?[]const u8,

    /// The description of the metadata form type.
    description: ?[]const u8,

    /// The identifier of the Amazon DataZone domain in which the form type exists.
    domain_id: []const u8,

    /// The imports specified in the form type.
    imports: ?[]const Import,

    /// The model of the form type.
    model: ?Model,

    /// The name of the form type.
    name: []const u8,

    /// The identifier of the Amazon DataZone domain in which the form type was
    /// originally created.
    origin_domain_id: ?[]const u8,

    /// The identifier of the project in which the form type was originally created.
    origin_project_id: ?[]const u8,

    /// The identifier of the project that owns the form type.
    owning_project_id: ?[]const u8,

    /// The revision of the form type.
    revision: []const u8,

    /// The status of the form type.
    status: ?FormTypeStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .imports = "imports",
        .model = "model",
        .name = "name",
        .origin_domain_id = "originDomainId",
        .origin_project_id = "originProjectId",
        .owning_project_id = "owningProjectId",
        .revision = "revision",
        .status = "status",
    };
};
