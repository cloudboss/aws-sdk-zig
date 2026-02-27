/// The device-remembering configuration for a user pool.
///
/// When you provide a value for any property of `DeviceConfiguration`, you
/// activate the device remembering for the user pool.
pub const DeviceConfigurationType = struct {
    /// When true, a remembered device can sign in with device authentication
    /// instead of SMS
    /// and time-based one-time password (TOTP) factors for multi-factor
    /// authentication
    /// (MFA).
    ///
    /// Whether or not `ChallengeRequiredOnNewDevice` is true, users who sign
    /// in with devices that have not been confirmed or remembered must still
    /// provide a
    /// second factor in a user pool that requires MFA.
    challenge_required_on_new_device: bool = false,

    /// When true, Amazon Cognito doesn't automatically remember a user's device
    /// when your app sends a
    /// `ConfirmDevice` API request. In your app, create a prompt for your user
    /// to choose whether they want to remember their device. Return the user's
    /// choice in an
    /// `UpdateDeviceStatus` API request.
    ///
    /// When `DeviceOnlyRememberedOnUserPrompt` is `false`, Amazon
    /// Cognito immediately remembers devices that you register in a `ConfirmDevice`
    /// API request.
    device_only_remembered_on_user_prompt: bool = false,

    pub const json_field_names = .{
        .challenge_required_on_new_device = "ChallengeRequiredOnNewDevice",
        .device_only_remembered_on_user_prompt = "DeviceOnlyRememberedOnUserPrompt",
    };
};
