/// Allows you to opt in or opt out to share data with Rekognition to improve
/// model performance. You can choose this option at the account level or on a
/// per-stream basis.
/// Note that if you opt out at the account level this setting is ignored on
/// individual streams.
pub const StreamProcessorDataSharingPreference = struct {
    /// If this option is set to true, you choose to share data with Rekognition to
    /// improve model performance.
    opt_in: bool = false,

    pub const json_field_names = .{
        .opt_in = "OptIn",
    };
};
