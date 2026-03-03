const RecordingGroup = @import("recording_group.zig").RecordingGroup;
const RecordingMode = @import("recording_mode.zig").RecordingMode;
const RecordingScope = @import("recording_scope.zig").RecordingScope;

/// Records configuration changes to the resource types in scope.
///
/// For more information about the configuration recorder,
/// see [
/// **Working with the Configuration Recorder**
/// ](https://docs.aws.amazon.com/config/latest/developerguide/stop-start-recorder.html) in the *Config Developer Guide*.
pub const ConfigurationRecorder = struct {
    /// The Amazon Resource Name (ARN) of the specified configuration recorder.
    arn: ?[]const u8 = null,

    /// The name of the configuration recorder.
    ///
    /// For customer managed configuration recorders, Config automatically assigns
    /// the name of "default" when creating a configuration recorder if you do not
    /// specify a name at creation time.
    ///
    /// For service-linked configuration recorders, Config automatically assigns a
    /// name that has the prefix "`AWSConfigurationRecorderFor`" to a new
    /// service-linked configuration recorder.
    ///
    /// **Changing the name of a configuration recorder**
    ///
    /// To change the name of the customer managed configuration recorder, you must
    /// delete it and create a new customer managed configuration recorder with a
    /// new name.
    ///
    /// You cannot change the name of a service-linked configuration recorder.
    name: ?[]const u8 = null,

    /// Specifies which resource types are in scope for the configuration recorder
    /// to record.
    ///
    /// ** High Number of Config Evaluations**
    ///
    /// You might notice increased activity in your account during your initial
    /// month recording with Config when compared to subsequent months. During the
    /// initial bootstrapping process, Config runs evaluations on all the resources
    /// in your account that you have selected
    /// for Config to record.
    ///
    /// If you are running ephemeral workloads, you may see increased activity from
    /// Config as it records configuration changes associated with creating and
    /// deleting these
    /// temporary resources. An *ephemeral workload* is a temporary use of computing
    /// resources that are loaded
    /// and run when needed. Examples include Amazon Elastic Compute Cloud (Amazon
    /// EC2)
    /// Spot Instances, Amazon EMR jobs, and Auto Scaling.
    ///
    /// If you want to avoid the increased activity from running ephemeral
    /// workloads, you can set up the configuration recorder to exclude these
    /// resource types from being recorded, or run these types of workloads in a
    /// separate account with Config turned off to avoid
    /// increased configuration recording and rule evaluations.
    recording_group: ?RecordingGroup = null,

    /// Specifies the default recording frequency for the configuration recorder.
    ///
    /// Config supports *Continuous recording* and *Daily recording*.
    ///
    /// * Continuous recording allows you to record configuration changes
    ///   continuously whenever a change occurs.
    ///
    /// * Daily recording allows you to receive a configuration item (CI)
    ///   representing the most recent state of your resources over the last 24-hour
    ///   period, only if it’s different from the previous CI recorded.
    ///
    /// **Some resource types require continuous recording**
    ///
    /// Firewall Manager depends on continuous recording to monitor your resources.
    /// If you are using Firewall Manager,
    /// it is recommended that you set the recording frequency to Continuous.
    ///
    /// You can also override the recording frequency for specific resource types.
    recording_mode: ?RecordingMode = null,

    /// Specifies whether the
    /// [ConfigurationItems](https://docs.aws.amazon.com/config/latest/APIReference/API_ConfigurationItem.html) in scope for the specified configuration recorder are recorded for free (`INTERNAL`) or if it impacts the costs to your bill (`PAID`).
    recording_scope: ?RecordingScope = null,

    /// The Amazon Resource Name (ARN) of the IAM role assumed by Config and used by
    /// the specified configuration recorder.
    ///
    /// **The server will reject a request without a defined `roleARN` for the
    /// configuration recorder**
    ///
    /// While the API model does not require this field, the server will reject a
    /// request without a defined `roleARN` for the configuration recorder.
    ///
    /// **Policies and compliance results**
    ///
    /// [IAM
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
    /// and [other policies managed in
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies.html)
    /// can impact whether Config
    /// has permissions to record configuration changes for your resources.
    /// Additionally, rules directly evaluate the configuration of a resource and
    /// rules don't take into account these policies when running evaluations.
    /// Make sure that the policies in effect align with how you intend to use
    /// Config.
    ///
    /// **Keep Minimum Permisions When Reusing an IAM role**
    ///
    /// If you use an Amazon Web Services service that uses Config, such as Security
    /// Hub CSPM or
    /// Control Tower, and an IAM role has already been created, make sure that the
    /// IAM role that you use when setting up Config keeps the same minimum
    /// permissions as the pre-existing IAM role. You must do this to ensure that
    /// the
    /// other Amazon Web Services service continues to run as expected.
    ///
    /// For example, if Control Tower has an IAM role that allows Config to read
    /// S3 objects, make sure that the same permissions are granted
    /// to the IAM role you use when setting up Config. Otherwise, it may
    /// interfere with how Control Tower operates.
    ///
    /// **The service-linked IAM role for Config must be used for service-linked
    /// configuration recorders**
    ///
    /// For service-linked configuration recorders, you must use the service-linked
    /// IAM role for Config:
    /// [AWSServiceRoleForConfig](https://docs.aws.amazon.com/config/latest/developerguide/using-service-linked-roles.html).
    role_arn: ?[]const u8 = null,

    /// For service-linked configuration recorders, specifies the linked Amazon Web
    /// Services service for the configuration recorder.
    service_principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .recording_group = "recordingGroup",
        .recording_mode = "recordingMode",
        .recording_scope = "recordingScope",
        .role_arn = "roleARN",
        .service_principal = "servicePrincipal",
    };
};
