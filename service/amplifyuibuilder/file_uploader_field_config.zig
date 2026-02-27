const StorageAccessLevel = @import("storage_access_level.zig").StorageAccessLevel;

/// Describes the configuration for the file uploader field.
pub const FileUploaderFieldConfig = struct {
    /// The file types that are allowed to be uploaded by the file uploader. Provide
    /// this
    /// information in an array of strings specifying the valid file extensions.
    accepted_file_types: []const []const u8,

    /// The access level to assign to the uploaded files in the Amazon S3 bucket
    /// where
    /// they are stored. The valid values for this property are `private`,
    /// `protected`, or `public`. For detailed information about the
    /// permissions associated with each access level, see [File access
    /// levels](https://docs.amplify.aws/lib/storage/configureaccess/q/platform/js/)
    /// in the *Amplify documentation*.
    access_level: StorageAccessLevel,

    /// Allows the file upload operation to be paused and resumed. The default value
    /// is
    /// `false`.
    ///
    /// When `isResumable` is set to `true`, the file uploader uses a
    /// multipart upload to break the files into chunks before upload. The progress
    /// of the upload
    /// isn't continuous, because the file uploader uploads a chunk at a time.
    is_resumable: ?bool,

    /// Specifies the maximum number of files that can be selected to upload. The
    /// default value is
    /// an unlimited number of files.
    max_file_count: ?i32,

    /// The maximum file size in bytes that the file uploader will accept. The
    /// default value is an
    /// unlimited file size.
    max_size: ?i32,

    /// Specifies whether to display or hide the image preview after selecting a
    /// file for upload.
    /// The default value is `true` to display the image preview.
    show_thumbnails: ?bool,

    pub const json_field_names = .{
        .accepted_file_types = "acceptedFileTypes",
        .access_level = "accessLevel",
        .is_resumable = "isResumable",
        .max_file_count = "maxFileCount",
        .max_size = "maxSize",
        .show_thumbnails = "showThumbnails",
    };
};
