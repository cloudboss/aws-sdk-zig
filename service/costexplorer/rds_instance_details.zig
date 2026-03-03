/// Details about the Amazon RDS reservations that Amazon Web Services
/// recommends that you
/// purchase.
pub const RDSInstanceDetails = struct {
    /// Determines whether the recommendation is for a current-generation instance.
    current_generation: bool = false,

    /// The database edition that the recommended reservation supports.
    database_edition: ?[]const u8 = null,

    /// The database engine that the recommended reservation supports.
    database_engine: ?[]const u8 = null,

    /// Determines whether the recommendation is for a reservation for RDS Custom.
    deployment_model: ?[]const u8 = null,

    /// Determines whether the recommendation is for a reservation in a single
    /// Availability
    /// Zone or a reservation with a backup in a second Availability Zone.
    deployment_option: ?[]const u8 = null,

    /// The instance family of the recommended reservation.
    family: ?[]const u8 = null,

    /// The type of instance that Amazon Web Services recommends.
    instance_type: ?[]const u8 = null,

    /// The license model that the recommended reservation supports.
    license_model: ?[]const u8 = null,

    /// The Amazon Web Services Region of the recommended reservation.
    region: ?[]const u8 = null,

    /// Determines whether the recommended reservation is size flexible.
    size_flex_eligible: bool = false,

    pub const json_field_names = .{
        .current_generation = "CurrentGeneration",
        .database_edition = "DatabaseEdition",
        .database_engine = "DatabaseEngine",
        .deployment_model = "DeploymentModel",
        .deployment_option = "DeploymentOption",
        .family = "Family",
        .instance_type = "InstanceType",
        .license_model = "LicenseModel",
        .region = "Region",
        .size_flex_eligible = "SizeFlexEligible",
    };
};
