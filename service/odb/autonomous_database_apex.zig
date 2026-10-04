/// The Oracle Application Express (APEX) details for an Autonomous Database.
pub const AutonomousDatabaseApex = struct {
    /// The Oracle Application Express (APEX) version of the Autonomous Database.
    apex_version: ?[]const u8 = null,

    /// The Oracle REST Data Services (ORDS) version of the Autonomous Database.
    ords_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .apex_version = "apexVersion",
        .ords_version = "ordsVersion",
    };
};
