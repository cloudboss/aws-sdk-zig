/// A reference to an AWS Organizations organizational unit (OU), with optional
/// display metadata.
pub const OrganizationalUnitReference = struct {
    /// The display name of the organizational unit.
    name: ?[]const u8 = null,

    /// The ID of the AWS Organizations organizational unit (OU).
    ou_id: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .ou_id = "ouId",
    };
};
