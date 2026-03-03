/// A summary of information about a fleet provision template version.
pub const ProvisioningTemplateVersionSummary = struct {
    /// The date when the provisioning template version was created
    creation_date: ?i64 = null,

    /// True if the provisioning template version is the default version, otherwise
    /// false.
    is_default_version: bool = false,

    /// The ID of the fleet provisioning template version.
    version_id: ?i32 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .is_default_version = "isDefaultVersion",
        .version_id = "versionId",
    };
};
