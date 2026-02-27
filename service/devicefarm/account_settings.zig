const aws = @import("aws");

const TrialMinutes = @import("trial_minutes.zig").TrialMinutes;

/// A container for account-level settings in AWS Device Farm.
pub const AccountSettings = struct {
    /// The AWS account number specified in the `AccountSettings`
    /// container.
    aws_account_number: ?[]const u8,

    /// The default number of minutes (at the account level) a test run executes
    /// before it times out. The
    /// default value is 150 minutes.
    default_job_timeout_minutes: ?i32,

    /// The maximum number of minutes a test run executes before it times out.
    max_job_timeout_minutes: ?i32,

    /// The maximum number of device slots that the AWS account can purchase. Each
    /// maximum
    /// is expressed as an `offering-id:number` pair, where the
    /// `offering-id` represents one of the IDs returned by the
    /// `ListOfferings` command.
    max_slots: ?[]const aws.map.MapEntry(i32),

    /// When set to `true`, for private devices, Device Farm does not sign your app
    /// again. For public
    /// devices, Device Farm always signs your apps again.
    ///
    /// For more information about how Device Farm re-signs your apps, see [Do you
    /// modify my app?](http://aws.amazon.com/device-farm/faqs/) in the *AWS Device
    /// Farm FAQs*.
    skip_app_resign: ?bool,

    /// Information about an AWS account's usage of free trial device minutes.
    trial_minutes: ?TrialMinutes,

    /// Returns the unmetered devices you have purchased or want to purchase.
    unmetered_devices: ?[]const aws.map.MapEntry(i32),

    /// Returns the unmetered remote access devices you have purchased or want to
    /// purchase.
    unmetered_remote_access_devices: ?[]const aws.map.MapEntry(i32),

    pub const json_field_names = .{
        .aws_account_number = "awsAccountNumber",
        .default_job_timeout_minutes = "defaultJobTimeoutMinutes",
        .max_job_timeout_minutes = "maxJobTimeoutMinutes",
        .max_slots = "maxSlots",
        .skip_app_resign = "skipAppResign",
        .trial_minutes = "trialMinutes",
        .unmetered_devices = "unmeteredDevices",
        .unmetered_remote_access_devices = "unmeteredRemoteAccessDevices",
    };
};
