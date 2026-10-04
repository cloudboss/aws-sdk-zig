/// Describes the software metadata for an image, such as the installed NVIDIA
/// GRID driver version.
pub const ImageSoftwareMetadata = struct {
    /// The version of the NVIDIA GRID driver installed on the image. This field is
    /// empty if no NVIDIA GRID driver is installed.
    nvidia_grid_driver_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .nvidia_grid_driver_version = "nvidiaGridDriverVersion",
    };
};
