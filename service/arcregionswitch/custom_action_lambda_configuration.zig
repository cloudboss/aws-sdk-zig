const Lambdas = @import("lambdas.zig").Lambdas;
const RegionToRunIn = @import("region_to_run_in.zig").RegionToRunIn;
const LambdaUngraceful = @import("lambda_ungraceful.zig").LambdaUngraceful;

/// Configuration for Amazon Web Services Lambda functions that perform custom
/// actions during a Region switch.
pub const CustomActionLambdaConfiguration = struct {
    /// The Amazon Web Services Lambda functions for the execution block.
    lambdas: []const Lambdas,

    /// The Amazon Web Services Region for the function to run in.
    region_to_run: RegionToRunIn,

    /// The retry interval specified.
    retry_interval_minutes: f32,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// The settings for ungraceful execution.
    ungraceful: ?LambdaUngraceful,

    pub const json_field_names = .{
        .lambdas = "lambdas",
        .region_to_run = "regionToRun",
        .retry_interval_minutes = "retryIntervalMinutes",
        .timeout_minutes = "timeoutMinutes",
        .ungraceful = "ungraceful",
    };
};
