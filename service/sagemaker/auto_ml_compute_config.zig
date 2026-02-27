const EmrServerlessComputeConfig = @import("emr_serverless_compute_config.zig").EmrServerlessComputeConfig;

/// This data type is intended for use exclusively by SageMaker Canvas and
/// cannot be used in other contexts at the moment.
///
/// Specifies the compute configuration for an AutoML job V2.
pub const AutoMLComputeConfig = struct {
    /// The configuration for using [ EMR
    /// Serverless](https://docs.aws.amazon.com/emr/latest/EMR-Serverless-UserGuide/emr-serverless.html) to run the AutoML job V2.
    ///
    /// To allow your AutoML job V2 to automatically initiate a remote job on EMR
    /// Serverless when additional compute resources are needed to process large
    /// datasets, you need to provide an `EmrServerlessComputeConfig` object, which
    /// includes an `ExecutionRoleARN` attribute, to the `AutoMLComputeConfig` of
    /// the AutoML job V2 input request.
    ///
    /// By seamlessly transitioning to EMR Serverless when required, the AutoML job
    /// can handle datasets that would otherwise exceed the initially provisioned
    /// resources, without any manual intervention from you.
    ///
    /// EMR Serverless is available for the tabular and time series problem types.
    /// We recommend setting up this option for tabular datasets larger than 5 GB
    /// and time series datasets larger than 30 GB.
    emr_serverless_compute_config: ?EmrServerlessComputeConfig,

    pub const json_field_names = .{
        .emr_serverless_compute_config = "EmrServerlessComputeConfig",
    };
};
