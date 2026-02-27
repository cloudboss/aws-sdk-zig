const CodeConfigurationValues = @import("code_configuration_values.zig").CodeConfigurationValues;
const ConfigurationSource = @import("configuration_source.zig").ConfigurationSource;

/// Describes the configuration that App Runner uses to build and run an App
/// Runner service from a source code repository.
pub const CodeConfiguration = struct {
    /// The basic configuration for building and running the App Runner service. Use
    /// it to quickly launch an App Runner service without providing a
    /// `apprunner.yaml` file in the source code repository (or ignoring the file if
    /// it exists).
    code_configuration_values: ?CodeConfigurationValues,

    /// The source of the App Runner configuration. Values are interpreted as
    /// follows:
    ///
    /// * `REPOSITORY` – App Runner reads configuration values from the
    ///   `apprunner.yaml` file in the source code repository and
    /// ignores `CodeConfigurationValues`.
    ///
    /// * `API` – App Runner uses configuration values provided in
    ///   `CodeConfigurationValues` and ignores the
    /// `apprunner.yaml` file in the source code repository.
    configuration_source: ConfigurationSource,

    pub const json_field_names = .{
        .code_configuration_values = "CodeConfigurationValues",
        .configuration_source = "ConfigurationSource",
    };
};
