const AutoExportPolicy = @import("auto_export_policy.zig").AutoExportPolicy;
const AutoImportPolicy = @import("auto_import_policy.zig").AutoImportPolicy;

/// The configuration for an Amazon S3 data repository linked to an
/// Amazon FSx for Lustre file system with a data repository association.
/// The configuration consists of an `AutoImportPolicy` that
/// defines which file events on the data repository are automatically
/// imported to the file system and an `AutoExportPolicy` that
/// defines which file events on the file system are automatically exported
/// to the data repository. File events are when files or directories are
/// added, changed, or deleted on the file system or the data repository.
///
/// Data repository associations on Amazon File Cache don't
/// use `S3DataRepositoryConfiguration` because they don't
/// support automatic import or automatic export.
pub const S3DataRepositoryConfiguration = struct {
    /// Specifies the type of updated objects (new, changed, deleted)
    /// that will be automatically exported from your file system to
    /// the linked S3 bucket.
    auto_export_policy: ?AutoExportPolicy = null,

    /// Specifies the type of updated objects (new, changed, deleted)
    /// that will be automatically imported from the linked S3 bucket
    /// to your file system.
    auto_import_policy: ?AutoImportPolicy = null,

    pub const json_field_names = .{
        .auto_export_policy = "AutoExportPolicy",
        .auto_import_policy = "AutoImportPolicy",
    };
};
