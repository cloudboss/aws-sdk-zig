/// Describes an inventory database instance for a Fleet Advisor collector.
pub const DatabaseInstanceSoftwareDetailsResponse = struct {
    /// The database engine of a database in a Fleet Advisor collector inventory,
    /// for example `Microsoft
    /// SQL Server`.
    engine: ?[]const u8 = null,

    /// The database engine edition of a database in a Fleet Advisor collector
    /// inventory, for example
    /// `Express`.
    engine_edition: ?[]const u8 = null,

    /// The database engine version of a database in a Fleet Advisor collector
    /// inventory, for example
    /// `2019`.
    engine_version: ?[]const u8 = null,

    /// The operating system architecture of the database.
    os_architecture: ?i32 = null,

    /// The service pack level of the database.
    service_pack: ?[]const u8 = null,

    /// The support level of the database, for example `Mainstream support`.
    support_level: ?[]const u8 = null,

    /// Information about the database engine software, for example `Mainstream
    /// support
    /// ends on November 14th, 2024`.
    tooltip: ?[]const u8 = null,

    pub const json_field_names = .{
        .engine = "Engine",
        .engine_edition = "EngineEdition",
        .engine_version = "EngineVersion",
        .os_architecture = "OsArchitecture",
        .service_pack = "ServicePack",
        .support_level = "SupportLevel",
        .tooltip = "Tooltip",
    };
};
