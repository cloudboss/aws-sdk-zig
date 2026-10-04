/// The connection URLs for accessing tools and services for an Autonomous
/// Database.
pub const AutonomousDatabaseConnectionUrls = struct {
    /// The URL for accessing Oracle Application Express (APEX) for the Autonomous
    /// Database.
    apex_url: ?[]const u8 = null,

    /// The URL for accessing Oracle Database Transforms for the Autonomous
    /// Database.
    database_transforms_url: ?[]const u8 = null,

    /// The URL for accessing Oracle Graph Studio for the Autonomous Database.
    graph_studio_url: ?[]const u8 = null,

    /// The URL for accessing the Oracle Machine Learning notebook for the
    /// Autonomous Database.
    machine_learning_notebook_url: ?[]const u8 = null,

    /// The URL for accessing Oracle Machine Learning user management for the
    /// Autonomous Database.
    machine_learning_user_management_url: ?[]const u8 = null,

    /// The URL for accessing the MongoDB API for the Autonomous Database.
    mongo_db_url: ?[]const u8 = null,

    /// The URL for accessing Oracle REST Data Services (ORDS) for the Autonomous
    /// Database.
    ords_url: ?[]const u8 = null,

    /// The URL for accessing Oracle Spatial Studio for the Autonomous Database.
    spatial_studio_url: ?[]const u8 = null,

    /// The URL for accessing Oracle SQL Developer Web for the Autonomous Database.
    sql_dev_web_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .apex_url = "apexUrl",
        .database_transforms_url = "databaseTransformsUrl",
        .graph_studio_url = "graphStudioUrl",
        .machine_learning_notebook_url = "machineLearningNotebookUrl",
        .machine_learning_user_management_url = "machineLearningUserManagementUrl",
        .mongo_db_url = "mongoDbUrl",
        .ords_url = "ordsUrl",
        .spatial_studio_url = "spatialStudioUrl",
        .sql_dev_web_url = "sqlDevWebUrl",
    };
};
