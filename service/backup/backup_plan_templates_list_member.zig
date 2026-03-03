/// An object specifying metadata associated with a backup plan template.
pub const BackupPlanTemplatesListMember = struct {
    /// Uniquely identifies a stored backup plan template.
    backup_plan_template_id: ?[]const u8 = null,

    /// The optional display name of a backup plan template.
    backup_plan_template_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_plan_template_id = "BackupPlanTemplateId",
        .backup_plan_template_name = "BackupPlanTemplateName",
    };
};
