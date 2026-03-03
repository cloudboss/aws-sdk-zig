const DiskImageFormat = @import("disk_image_format.zig").DiskImageFormat;

/// Properties that configure export from your build instance to a compatible
/// file format
/// for your VM.
pub const S3ExportConfiguration = struct {
    /// Export the updated image to one of the following supported disk image
    /// formats:
    ///
    /// * **Virtual Hard Disk (VHD)** – Compatible
    /// with Citrix Xen and Microsoft Hyper-V virtualization products.
    ///
    /// * **Stream-optimized ESX Virtual Machine Disk
    /// (VMDK)** – Compatible with VMware ESX and VMware vSphere
    /// versions 4, 5, and 6.
    ///
    /// * **Raw** – Raw format.
    disk_image_format: DiskImageFormat,

    /// The name of the role that grants VM Import/Export permission to export
    /// images to your
    /// S3 bucket.
    role_name: []const u8,

    /// The S3 bucket in which to store the output disk images for your VM.
    s_3_bucket: []const u8,

    /// The Amazon S3 path for the bucket where the output disk images for your VM
    /// are
    /// stored.
    s_3_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .disk_image_format = "diskImageFormat",
        .role_name = "roleName",
        .s_3_bucket = "s3Bucket",
        .s_3_prefix = "s3Prefix",
    };
};
