const GlueRunConfigurationInput = @import("glue_run_configuration_input.zig").GlueRunConfigurationInput;
const RedshiftRunConfigurationInput = @import("redshift_run_configuration_input.zig").RedshiftRunConfigurationInput;
const SageMakerRunConfigurationInput = @import("sage_maker_run_configuration_input.zig").SageMakerRunConfigurationInput;

/// The configuration of the data source.
pub const DataSourceConfigurationInput = union(enum) {
    /// The configuration of the Amazon Web Services Glue data source.
    glue_run_configuration: ?GlueRunConfigurationInput,
    /// The configuration of the Amazon Redshift data source.
    redshift_run_configuration: ?RedshiftRunConfigurationInput,
    /// The Amazon SageMaker run configuration.
    sage_maker_run_configuration: ?SageMakerRunConfigurationInput,

    pub const json_field_names = .{
        .glue_run_configuration = "glueRunConfiguration",
        .redshift_run_configuration = "redshiftRunConfiguration",
        .sage_maker_run_configuration = "sageMakerRunConfiguration",
    };
};
