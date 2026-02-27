/// License asset group status. Allowed values are
///
/// * `ACTIVE`
///
/// * `DISABLED`
///
/// * `DELETED`
pub const LicenseAssetGroupStatus = enum {
    active,
    disabled,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .disabled = "DISABLED",
        .deleted = "DELETED",
    };
};
