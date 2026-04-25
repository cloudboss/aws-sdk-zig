/// Controls Secure Boot and UEFI data settings for the resulting image
/// during ISO imports. For more information, see [UEFI Secure Boot for Amazon
/// EC2
/// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/uefi-secure-boot.html) in
/// the *
/// Amazon EC2 User Guide*
/// .
pub const RegisterImageOptions = struct {
    /// Specifies whether Secure Boot is enabled for the output AMI.
    /// The default value is `true`. To disable Secure Boot
    /// for custom unsigned drivers, set this value to `false`.
    secure_boot_enabled: ?bool = null,

    /// A Base64-encoded representation of the non-volatile UEFI variable store.
    /// You can specify this parameter only when
    /// `secureBootEnabled` is `true` or
    /// unspecified. You can inspect and modify the UEFI data by using
    /// the [python-uefivars tool on
    /// GitHub](https://github.com/awslabs/python-uefivars).
    ///
    /// For more information, see [UEFI
    /// variables for Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/uefi-variables.html).
    uefi_data: ?[]const u8 = null,

    pub const json_field_names = .{
        .secure_boot_enabled = "secureBootEnabled",
        .uefi_data = "uefiData",
    };
};
