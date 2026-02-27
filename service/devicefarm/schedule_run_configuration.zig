const BillingMethod = @import("billing_method.zig").BillingMethod;
const CustomerArtifactPaths = @import("customer_artifact_paths.zig").CustomerArtifactPaths;
const DeviceProxy = @import("device_proxy.zig").DeviceProxy;
const EnvironmentVariable = @import("environment_variable.zig").EnvironmentVariable;
const Location = @import("location.zig").Location;
const Radios = @import("radios.zig").Radios;

/// Represents the settings for a run. Includes things like location, radio
/// states,
/// auxiliary apps, and network profiles.
pub const ScheduleRunConfiguration = struct {
    /// A list of upload ARNs for app packages to be installed with your app.
    auxiliary_apps: ?[]const []const u8,

    /// Specifies the billing method for a test run: `metered` or
    /// `unmetered`. If the parameter is not specified, the default value is
    /// `metered`.
    ///
    /// If you have purchased unmetered device slots, you must set this parameter to
    /// `unmetered` to
    /// make use of them. Otherwise, your run counts against your metered time.
    billing_method: ?BillingMethod,

    /// Input `CustomerArtifactPaths` object for the scheduled run
    /// configuration.
    customer_artifact_paths: ?CustomerArtifactPaths,

    /// The device proxy to be configured on the device for the run.
    device_proxy: ?DeviceProxy,

    /// Environment variables associated with the run.
    environment_variables: ?[]const EnvironmentVariable,

    /// An IAM role to be assumed by the test host for the run.
    execution_role_arn: ?[]const u8,

    /// The ARN of the extra data for the run. The extra data is a .zip file that
    /// AWS Device Farm extracts to
    /// external data for Android or the app's sandbox for iOS.
    extra_data_package_arn: ?[]const u8,

    /// Information about the locale that is used for the run.
    locale: ?[]const u8,

    /// Information about the location that is used for the run.
    location: ?Location,

    /// Reserved for internal use.
    network_profile_arn: ?[]const u8,

    /// Information about the radio states for the run.
    radios: ?Radios,

    /// An array of ARNs for your VPC endpoint configurations.
    vpce_configuration_arns: ?[]const []const u8,

    pub const json_field_names = .{
        .auxiliary_apps = "auxiliaryApps",
        .billing_method = "billingMethod",
        .customer_artifact_paths = "customerArtifactPaths",
        .device_proxy = "deviceProxy",
        .environment_variables = "environmentVariables",
        .execution_role_arn = "executionRoleArn",
        .extra_data_package_arn = "extraDataPackageArn",
        .locale = "locale",
        .location = "location",
        .network_profile_arn = "networkProfileArn",
        .radios = "radios",
        .vpce_configuration_arns = "vpceConfigurationArns",
    };
};
