/// Provides information about the limitations of target Amazon Web Services
/// engines.
///
/// Your source database might include features that the target Amazon Web
/// Services engine doesn't
/// support. Fleet Advisor lists these features as limitations. You should
/// consider these
/// limitations during database migration. For each limitation, Fleet Advisor
/// recommends an
/// action that you can take to address or avoid this limitation.
pub const Limitation = struct {
    /// The identifier of the source database.
    database_id: ?[]const u8,

    /// A description of the limitation. Provides additional information about the
    /// limitation,
    /// and includes recommended actions that you can take to address or avoid this
    /// limitation.
    description: ?[]const u8,

    /// The name of the target engine that Fleet Advisor should use in the target
    /// engine
    /// recommendation. Valid values include `"rds-aurora-mysql"`,
    /// `"rds-aurora-postgresql"`, `"rds-mysql"`,
    /// `"rds-oracle"`, `"rds-sql-server"`, and
    /// `"rds-postgresql"`.
    engine_name: ?[]const u8,

    /// The impact of the limitation. You can use this parameter to prioritize
    /// limitations
    /// that you want to address. Valid values include `"Blocker"`,
    /// `"High"`, `"Medium"`, and `"Low"`.
    impact: ?[]const u8,

    /// The name of the limitation. Describes unsupported database features,
    /// migration action
    /// items, and other limitations.
    name: ?[]const u8,

    /// The type of the limitation, such as action required, upgrade required, and
    /// limited
    /// feature.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .database_id = "DatabaseId",
        .description = "Description",
        .engine_name = "EngineName",
        .impact = "Impact",
        .name = "Name",
        .@"type" = "Type",
    };
};
