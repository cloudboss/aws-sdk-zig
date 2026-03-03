const LicenseEdition = @import("license_edition.zig").LicenseEdition;
const LicenseModel = @import("license_model.zig").LicenseModel;
const LicenseName = @import("license_name.zig").LicenseName;
const MetricSource = @import("metric_source.zig").MetricSource;

/// Describes the configuration of a license for an Amazon EC2 instance.
pub const LicenseConfiguration = struct {
    /// The instance type used in the license.
    instance_type: ?[]const u8 = null,

    /// The edition of the license for the application that runs on the instance.
    license_edition: ?LicenseEdition = null,

    /// The license type associated with the instance.
    license_model: ?LicenseModel = null,

    /// The name of the license for the application that runs on the instance.
    license_name: ?LicenseName = null,

    /// The version of the license for the application that runs on the instance.
    license_version: ?[]const u8 = null,

    /// The list of metric sources required to generate recommendations for
    /// commercial software licenses.
    metrics_source: ?[]const MetricSource = null,

    /// The current number of cores associated with the instance.
    number_of_cores: i32 = 0,

    /// The operating system of the instance.
    operating_system: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_type = "instanceType",
        .license_edition = "licenseEdition",
        .license_model = "licenseModel",
        .license_name = "licenseName",
        .license_version = "licenseVersion",
        .metrics_source = "metricsSource",
        .number_of_cores = "numberOfCores",
        .operating_system = "operatingSystem",
    };
};
