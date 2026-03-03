/// Represents configuration information about a test run, such as the execution
/// timeout (in minutes).
pub const ExecutionConfiguration = struct {
    /// True if account cleanup is enabled at the beginning of the test. Otherwise,
    /// false.
    accounts_cleanup: ?bool = null,

    /// True if app package cleanup is enabled at the beginning of the test.
    /// Otherwise, false.
    app_packages_cleanup: ?bool = null,

    /// The number of minutes a test run executes before it times out.
    job_timeout_minutes: ?i32 = null,

    /// When set to `true`, for private devices, Device Farm does not sign your app
    /// again. For public
    /// devices, Device Farm always signs your apps again.
    ///
    /// For more information about how Device Farm re-signs your apps, see [Do you
    /// modify my app?](http://aws.amazon.com/device-farm/faqs/) in the *AWS Device
    /// Farm FAQs*.
    skip_app_resign: ?bool = null,

    /// Set to true to enable video capture. Otherwise, set to false. The default is
    /// true.
    video_capture: ?bool = null,

    pub const json_field_names = .{
        .accounts_cleanup = "accountsCleanup",
        .app_packages_cleanup = "appPackagesCleanup",
        .job_timeout_minutes = "jobTimeoutMinutes",
        .skip_app_resign = "skipAppResign",
        .video_capture = "videoCapture",
    };
};
