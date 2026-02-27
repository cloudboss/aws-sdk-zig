/// The image scanning configuration for a repository.
pub const ImageScanningConfiguration = struct {
    /// The setting that determines whether images are scanned after being pushed to
    /// a
    /// repository. If set to `true`, images will be scanned after being pushed. If
    /// this parameter is not specified, it will default to `false` and images will
    /// not be scanned unless a scan is manually started with the
    /// [API_StartImageScan](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_StartImageScan.html) API.
    scan_on_push: bool = false,

    pub const json_field_names = .{
        .scan_on_push = "scanOnPush",
    };
};
