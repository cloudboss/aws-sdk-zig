/// Configure image tests for your pipeline build. Tests run after building the
/// image, to
/// verify that the AMI or container image is valid before distributing it.
pub const ImageTestsConfiguration = struct {
    /// Determines if tests should run after building the image. Image Builder
    /// defaults to enable tests
    /// to run following the image build, before image distribution.
    image_tests_enabled: ?bool,

    /// The maximum time in minutes that tests are permitted to run.
    ///
    /// The timeout property is not currently active. This value is
    /// ignored.
    timeout_minutes: ?i32,

    pub const json_field_names = .{
        .image_tests_enabled = "imageTestsEnabled",
        .timeout_minutes = "timeoutMinutes",
    };
};
