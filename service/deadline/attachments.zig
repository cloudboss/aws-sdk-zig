const JobAttachmentsFileSystem = @import("job_attachments_file_system.zig").JobAttachmentsFileSystem;
const ManifestProperties = @import("manifest_properties.zig").ManifestProperties;

/// The job attachments.
pub const Attachments = struct {
    /// The file system location for the attachments.
    file_system: JobAttachmentsFileSystem = .copied,

    /// The manifest properties for the attachments.
    manifests: []const ManifestProperties,

    pub const json_field_names = .{
        .file_system = "fileSystem",
        .manifests = "manifests",
    };
};
