const DataRepositoryFailureDetails = @import("data_repository_failure_details.zig").DataRepositoryFailureDetails;
const DataRepositoryLifecycle = @import("data_repository_lifecycle.zig").DataRepositoryLifecycle;
const NFSDataRepositoryConfiguration = @import("nfs_data_repository_configuration.zig").NFSDataRepositoryConfiguration;
const S3DataRepositoryConfiguration = @import("s3_data_repository_configuration.zig").S3DataRepositoryConfiguration;
const Tag = @import("tag.zig").Tag;

/// The configuration of a data repository association that links
/// an Amazon FSx for Lustre file system to an Amazon S3 bucket
/// or an Amazon File Cache resource to an Amazon S3 bucket or an NFS file
/// system.
/// The data repository association configuration object is returned
/// in the response of the following operations:
///
/// * `CreateDataRepositoryAssociation`
///
/// * `UpdateDataRepositoryAssociation`
///
/// * `DescribeDataRepositoryAssociations`
///
/// Data repository associations are supported on Amazon File Cache resources
/// and
/// all FSx for Lustre 2.12 and 2.15 file systems, excluding
/// Intelligent-Tiering and `scratch_1` file systems.
pub const DataRepositoryAssociation = struct {
    /// The system-generated, unique ID of the data repository association.
    association_id: ?[]const u8,

    /// A boolean flag indicating whether an import data repository task to import
    /// metadata should run after the data repository association is created. The
    /// task runs if this flag is set to `true`.
    ///
    /// `BatchImportMetaDataOnCreate` is not supported for data repositories
    /// linked to an Amazon File Cache resource.
    batch_import_meta_data_on_create: ?bool,

    creation_time: ?i64,

    /// The path to the data repository that will be linked to the cache
    /// or file system.
    ///
    /// * For Amazon File Cache, the path can be an NFS data repository
    /// that will be linked to the cache. The path can be in one of two formats:
    ///
    /// * If you are not using the `DataRepositorySubdirectories`
    /// parameter, the path is to an NFS Export directory (or one of its
    /// subdirectories)
    /// in the format `nsf://nfs-domain-name/exportpath`. You can therefore
    /// link a single NFS Export to a single data repository association.
    ///
    /// * If you are using the `DataRepositorySubdirectories`
    /// parameter, the path is the domain name of the NFS file system in the format
    /// `nfs://filer-domain-name`, which indicates the root of the
    /// subdirectories specified with the `DataRepositorySubdirectories`
    /// parameter.
    ///
    /// * For Amazon File Cache, the path can be an S3 bucket or prefix
    /// in the format `s3://bucket-name/prefix/` (where `prefix`
    /// is optional).
    ///
    /// * For Amazon FSx for Lustre, the path can be an S3 bucket or prefix
    /// in the format `s3://bucket-name/prefix/` (where `prefix`
    /// is optional).
    data_repository_path: ?[]const u8,

    /// For Amazon File Cache, a list of NFS Exports that will be linked with an
    /// NFS data repository association. All the subdirectories must be on a single
    /// NFS file system.
    /// The Export paths are in the format `/exportpath1`.
    /// To use this parameter, you must configure `DataRepositoryPath`
    /// as the domain name of the NFS file system. The NFS file system domain name
    /// in effect is the
    /// root of the subdirectories. Note that `DataRepositorySubdirectories` is not
    /// supported for S3 data repositories.
    data_repository_subdirectories: ?[]const []const u8,

    failure_details: ?DataRepositoryFailureDetails,

    /// The globally unique ID of the Amazon File Cache resource.
    file_cache_id: ?[]const u8,

    /// A path on the Amazon File Cache that points to a high-level directory (such
    /// as `/ns1/`) or subdirectory (such as `/ns1/subdir/`)
    /// that will be mapped 1-1 with `DataRepositoryPath`.
    /// The leading forward slash in the path is required. Two data repository
    /// associations cannot have overlapping cache paths. For example, if
    /// a data repository is associated with cache path `/ns1/`,
    /// then you cannot link another data repository with cache
    /// path `/ns1/ns2`.
    ///
    /// This path specifies the directory in your cache where files will be exported
    /// from. This cache directory can be linked to only one data repository
    /// (S3 or NFS) and no other data repository can be linked to the directory.
    ///
    /// The cache path can only be set to root (/) on an NFS DRA when
    /// `DataRepositorySubdirectories` is specified. If you
    /// specify root (/) as the cache path, you can create only one DRA
    /// on the cache.
    ///
    /// The cache path cannot be set to root (/) for an S3 DRA.
    file_cache_path: ?[]const u8,

    file_system_id: ?[]const u8,

    /// A path on the Amazon FSx for Lustre file system that points to a high-level
    /// directory (such
    /// as `/ns1/`) or subdirectory (such as `/ns1/subdir/`)
    /// that will be mapped 1-1 with `DataRepositoryPath`.
    /// The leading forward slash in the name is required. Two data repository
    /// associations cannot have overlapping file system paths. For example, if
    /// a data repository is associated with file system path `/ns1/`,
    /// then you cannot link another data repository with file system
    /// path `/ns1/ns2`.
    ///
    /// This path specifies where in your file system files will be exported
    /// from or imported to. This file system directory can be linked to only one
    /// Amazon S3 bucket, and no other S3 bucket can be linked to the directory.
    ///
    /// If you specify only a forward slash (`/`) as the file system
    /// path, you can link only one data repository to the file system. You can only
    /// specify
    /// "/" as the file system path for the first data repository associated with a
    /// file system.
    file_system_path: ?[]const u8,

    /// For files imported from a data repository, this value determines the stripe
    /// count and
    /// maximum amount of data per file (in MiB) stored on a single physical disk.
    /// The maximum
    /// number of disks that a single file can be striped across is limited by the
    /// total number
    /// of disks that make up the file system or cache.
    ///
    /// The default chunk size is 1,024 MiB (1 GiB) and can go as high as 512,000
    /// MiB (500
    /// GiB). Amazon S3 objects have a maximum size of 5 TB.
    imported_file_chunk_size: ?i32,

    /// Describes the state of a data repository association. The lifecycle can have
    /// the following values:
    ///
    /// * `CREATING` - The data repository association between
    /// the file system or cache and the data repository is being created.
    /// The data repository is unavailable.
    ///
    /// * `AVAILABLE` - The data repository association is
    /// available for use.
    ///
    /// * `MISCONFIGURED` - The data repository association is
    /// misconfigured. Until the configuration is corrected, automatic import and
    /// automatic export will not work (only for Amazon FSx for Lustre).
    ///
    /// * `UPDATING` - The data repository association is undergoing
    /// a customer initiated update that might affect its availability.
    ///
    /// * `DELETING` - The data repository association is undergoing
    /// a customer initiated deletion.
    ///
    /// * `FAILED` - The data repository association is in a terminal
    /// state that cannot be recovered.
    lifecycle: ?DataRepositoryLifecycle,

    /// The configuration for an NFS data repository linked to an
    /// Amazon File Cache resource with a data repository association.
    nfs: ?NFSDataRepositoryConfiguration,

    resource_arn: ?[]const u8,

    /// The configuration for an Amazon S3 data repository linked to an
    /// Amazon FSx for Lustre file system with a data repository association.
    s3: ?S3DataRepositoryConfiguration,

    tags: ?[]const Tag,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .batch_import_meta_data_on_create = "BatchImportMetaDataOnCreate",
        .creation_time = "CreationTime",
        .data_repository_path = "DataRepositoryPath",
        .data_repository_subdirectories = "DataRepositorySubdirectories",
        .failure_details = "FailureDetails",
        .file_cache_id = "FileCacheId",
        .file_cache_path = "FileCachePath",
        .file_system_id = "FileSystemId",
        .file_system_path = "FileSystemPath",
        .imported_file_chunk_size = "ImportedFileChunkSize",
        .lifecycle = "Lifecycle",
        .nfs = "NFS",
        .resource_arn = "ResourceARN",
        .s3 = "S3",
        .tags = "Tags",
    };
};
