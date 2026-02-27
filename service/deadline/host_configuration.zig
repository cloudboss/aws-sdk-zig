/// Provides a script that runs as a worker is starting up that you can use to
/// provide additional configuration for workers in your fleet.
///
/// To remove a script from a fleet, use the
/// [UpdateFleet](https://docs.aws.amazon.com/deadline-cloud/latest/APIReference/API_UpdateFleet.html) operation with the `hostConfiguration` `scriptBody` parameter set to an empty string ("").
pub const HostConfiguration = struct {
    /// The text of the script that runs as a worker is starting up that you can use
    /// to provide additional configuration for workers in your fleet. The script
    /// runs after a worker enters the `STARTING` state and before the worker
    /// processes tasks.
    ///
    /// For more information about using the script, see [Run scripts as an
    /// administrator to configure
    /// workers](https://docs.aws.amazon.com/deadline-cloud/latest/developerguide/smf-admin.html) in the *Deadline Cloud Developer Guide*.
    ///
    /// The script runs as an administrative user (`sudo root` on Linux, as an
    /// Administrator on Windows).
    script_body: []const u8,

    /// The maximum time that the host configuration can run. If the timeout
    /// expires, the worker enters the `NOT RESPONDING` state and shuts down. You
    /// are charged for the time that the worker is running the host configuration
    /// script.
    ///
    /// You should configure your fleet for a maximum of one worker while testing
    /// your host configuration script to avoid starting additional workers.
    ///
    /// The default is 300 seconds (5 minutes).
    script_timeout_seconds: i32 = 300,

    pub const json_field_names = .{
        .script_body = "scriptBody",
        .script_timeout_seconds = "scriptTimeoutSeconds",
    };
};
