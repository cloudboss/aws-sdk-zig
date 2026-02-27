const DataProviderSettings = @import("data_provider_settings.zig").DataProviderSettings;

/// Provides information that defines a data provider.
pub const DataProvider = struct {
    /// The Amazon Resource Name (ARN) string that uniquely identifies the data
    /// provider.
    data_provider_arn: ?[]const u8,

    /// The time the data provider was created.
    data_provider_creation_time: ?i64,

    /// The name of the data provider.
    data_provider_name: ?[]const u8,

    /// A description of the data provider. Descriptions can have up to 31
    /// characters.
    /// A description can contain only ASCII letters, digits, and hyphens ('-').
    /// Also, it can't
    /// end with a hyphen or contain two consecutive hyphens, and can only begin
    /// with a letter.
    description: ?[]const u8,

    /// The type of database engine for the data provider. Valid values include
    /// `"aurora"`,
    /// `"aurora-postgresql"`, `"mysql"`, `"oracle"`, `"postgres"`,
    /// `"sqlserver"`, `redshift`, `mariadb`, `mongodb`, `db2`, `db2-zos`, `docdb`,
    /// and `sybase`. A value of `"aurora"` represents Amazon Aurora
    /// MySQL-Compatible Edition.
    engine: ?[]const u8,

    /// The settings in JSON format for a data provider.
    settings: ?DataProviderSettings,

    /// Indicates whether the data provider is virtual.
    virtual: ?bool,

    pub const json_field_names = .{
        .data_provider_arn = "DataProviderArn",
        .data_provider_creation_time = "DataProviderCreationTime",
        .data_provider_name = "DataProviderName",
        .description = "Description",
        .engine = "Engine",
        .settings = "Settings",
        .virtual = "Virtual",
    };
};
