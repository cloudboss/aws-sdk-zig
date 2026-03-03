const BillingMethod = @import("billing_method.zig").BillingMethod;
const Counters = @import("counters.zig").Counters;
const CustomerArtifactPaths = @import("customer_artifact_paths.zig").CustomerArtifactPaths;
const DeviceMinutes = @import("device_minutes.zig").DeviceMinutes;
const DeviceProxy = @import("device_proxy.zig").DeviceProxy;
const DeviceSelectionResult = @import("device_selection_result.zig").DeviceSelectionResult;
const EnvironmentVariable = @import("environment_variable.zig").EnvironmentVariable;
const Location = @import("location.zig").Location;
const NetworkProfile = @import("network_profile.zig").NetworkProfile;
const DevicePlatform = @import("device_platform.zig").DevicePlatform;
const Radios = @import("radios.zig").Radios;
const ExecutionResult = @import("execution_result.zig").ExecutionResult;
const ExecutionResultCode = @import("execution_result_code.zig").ExecutionResultCode;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const TestType = @import("test_type.zig").TestType;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Represents a test run on a set of devices with a given app package, test
/// parameters, and so
/// on.
pub const Run = struct {
    /// An app to upload or that has been uploaded.
    app_upload: ?[]const u8 = null,

    /// The run's ARN.
    arn: ?[]const u8 = null,

    /// Specifies the billing method for a test run: `metered` or
    /// `unmetered`. If the parameter is not specified, the default value is
    /// `metered`.
    ///
    /// If you have unmetered device slots, you must set this to `unmetered` to use
    /// them.
    /// Otherwise, the run is counted toward metered device minutes.
    billing_method: ?BillingMethod = null,

    /// The total number of completed jobs.
    completed_jobs: ?i32 = null,

    /// The run's result counters.
    counters: ?Counters = null,

    /// When the run was created.
    created: ?i64 = null,

    /// Output `CustomerArtifactPaths` object for the test run.
    customer_artifact_paths: ?CustomerArtifactPaths = null,

    /// Represents the total (metered or unmetered) minutes used by the test run.
    device_minutes: ?DeviceMinutes = null,

    /// The ARN of the device pool for the run.
    device_pool_arn: ?[]const u8 = null,

    /// The device proxy configured for the devices in the run.
    device_proxy: ?DeviceProxy = null,

    /// The results of a device filter used to select the devices for a test run.
    device_selection_result: ?DeviceSelectionResult = null,

    /// Environment variables associated with the run.
    environment_variables: ?[]const EnvironmentVariable = null,

    /// For fuzz tests, this is the number of events, between 1 and 10000, that the
    /// UI fuzz
    /// test should perform.
    event_count: ?i32 = null,

    /// The IAM role associated with the run.
    execution_role_arn: ?[]const u8 = null,

    /// The number of minutes the job executes before it times out.
    job_timeout_minutes: ?i32 = null,

    /// Information about the locale that is used for the run.
    locale: ?[]const u8 = null,

    /// Information about the location that is used for the run.
    location: ?Location = null,

    /// A message about the run's result.
    message: ?[]const u8 = null,

    /// The run's name.
    name: ?[]const u8 = null,

    /// The network profile being used for a test run.
    network_profile: ?NetworkProfile = null,

    /// Read-only URL for an object in an S3 bucket where you can get the parsing
    /// results of the test package.
    /// If the test package doesn't parse, the reason why it doesn't parse appears
    /// in the file that this URL points
    /// to.
    parsing_result_url: ?[]const u8 = null,

    /// The run's platform.
    ///
    /// Allowed values include:
    ///
    /// * ANDROID
    ///
    /// * IOS
    platform: ?DevicePlatform = null,

    /// Information about the radio states for the run.
    radios: ?Radios = null,

    /// The run's result.
    ///
    /// Allowed values include:
    ///
    /// * PENDING
    ///
    /// * PASSED
    ///
    /// * WARNED
    ///
    /// * FAILED
    ///
    /// * SKIPPED
    ///
    /// * ERRORED
    ///
    /// * STOPPED
    result: ?ExecutionResult = null,

    /// Supporting field for the result field. Set only if `result` is `SKIPPED`.
    /// `PARSING_FAILED` if the result is skipped because of test package parsing
    /// failure.
    result_code: ?ExecutionResultCode = null,

    /// For fuzz tests, this is a seed to use for randomizing the UI fuzz test.
    /// Using the same
    /// seed value between tests ensures identical event sequences.
    seed: ?i32 = null,

    /// When set to `true`, for private devices, Device Farm does not sign your app
    /// again. For public
    /// devices, Device Farm always signs your apps again.
    ///
    /// For more information about how Device Farm re-signs your apps, see [Do you
    /// modify my app?](http://aws.amazon.com/device-farm/faqs/) in the *AWS Device
    /// Farm FAQs*.
    skip_app_resign: ?bool = null,

    /// The run's start time.
    started: ?i64 = null,

    /// The run's status.
    ///
    /// Allowed values include:
    ///
    /// * PENDING
    ///
    /// * PENDING_CONCURRENCY
    ///
    /// * PENDING_DEVICE
    ///
    /// * PROCESSING
    ///
    /// * SCHEDULING
    ///
    /// * PREPARING
    ///
    /// * RUNNING
    ///
    /// * COMPLETED
    ///
    /// * STOPPING
    status: ?ExecutionStatus = null,

    /// The run's stop time.
    stopped: ?i64 = null,

    /// The ARN of the YAML-formatted test specification for the run.
    test_spec_arn: ?[]const u8 = null,

    /// The total number of jobs for the run.
    total_jobs: ?i32 = null,

    /// The run's type.
    ///
    /// Must be one of the following values:
    ///
    /// * BUILTIN_FUZZ
    ///
    /// * APPIUM_JAVA_JUNIT
    ///
    /// * APPIUM_JAVA_TESTNG
    ///
    /// * APPIUM_PYTHON
    ///
    /// * APPIUM_NODE
    ///
    /// * APPIUM_RUBY
    ///
    /// * APPIUM_WEB_JAVA_JUNIT
    ///
    /// * APPIUM_WEB_JAVA_TESTNG
    ///
    /// * APPIUM_WEB_PYTHON
    ///
    /// * APPIUM_WEB_NODE
    ///
    /// * APPIUM_WEB_RUBY
    ///
    /// * INSTRUMENTATION
    ///
    /// * XCTEST
    ///
    /// * XCTEST_UI
    @"type": ?TestType = null,

    /// The VPC security groups and subnets that are attached to a project.
    vpc_config: ?VpcConfig = null,

    /// The Device Farm console URL for the recording of the run.
    web_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_upload = "appUpload",
        .arn = "arn",
        .billing_method = "billingMethod",
        .completed_jobs = "completedJobs",
        .counters = "counters",
        .created = "created",
        .customer_artifact_paths = "customerArtifactPaths",
        .device_minutes = "deviceMinutes",
        .device_pool_arn = "devicePoolArn",
        .device_proxy = "deviceProxy",
        .device_selection_result = "deviceSelectionResult",
        .environment_variables = "environmentVariables",
        .event_count = "eventCount",
        .execution_role_arn = "executionRoleArn",
        .job_timeout_minutes = "jobTimeoutMinutes",
        .locale = "locale",
        .location = "location",
        .message = "message",
        .name = "name",
        .network_profile = "networkProfile",
        .parsing_result_url = "parsingResultUrl",
        .platform = "platform",
        .radios = "radios",
        .result = "result",
        .result_code = "resultCode",
        .seed = "seed",
        .skip_app_resign = "skipAppResign",
        .started = "started",
        .status = "status",
        .stopped = "stopped",
        .test_spec_arn = "testSpecArn",
        .total_jobs = "totalJobs",
        .@"type" = "type",
        .vpc_config = "vpcConfig",
        .web_url = "webUrl",
    };
};
