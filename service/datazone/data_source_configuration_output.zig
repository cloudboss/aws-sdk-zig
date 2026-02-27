const GlueRunConfigurationOutput = @import("glue_run_configuration_output.zig").GlueRunConfigurationOutput;
const RedshiftRunConfigurationOutput = @import("redshift_run_configuration_output.zig").RedshiftRunConfigurationOutput;
const SageMakerRunConfigurationOutput = @import("sage_maker_run_configuration_output.zig").SageMakerRunConfigurationOutput;

/// The configuration of the data source.
pub const DataSourceConfigurationOutput = union(enum) {
    /// The configuration of the Amazon Web Services Glue data source.
    glue_run_configuration: ?GlueRunConfigurationOutput,
    /// The configuration of the Amazon Redshift data source.
    redshift_run_configuration: ?RedshiftRunConfigurationOutput,
    /// The Amazon SageMaker run configuration.
    sage_maker_run_configuration: ?SageMakerRunConfigurationOutput,

    pub const json_field_names = .{
        .glue_run_configuration = "glueRunConfiguration",
        .redshift_run_configuration = "redshiftRunConfiguration",
        .sage_maker_run_configuration = "sageMakerRunConfiguration",
    };
};
