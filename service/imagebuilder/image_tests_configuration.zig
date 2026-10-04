/// Configure image tests for your pipeline build. Tests run after building the
/// image, to
/// verify that the AMI or container image is valid before distributing it.
pub const ImageTestsConfiguration = struct {
    /// Specifies whether tests run after building the image.
    /// When enabled, tests run after the image build and before image distribution.
    /// Defaults to `true`.
    image_tests_enabled: ?bool = null,

    /// The maximum time in minutes that tests are permitted to run. If you don't
    /// specify a value, Image Builder stores and returns 720.
    ///
    /// The timeout property is not currently active. This value is
    /// ignored.
    timeout_minutes: ?i32 = null,

    pub const json_field_names = .{
        .image_tests_enabled = "imageTestsEnabled",
        .timeout_minutes = "timeoutMinutes",
    };
};
