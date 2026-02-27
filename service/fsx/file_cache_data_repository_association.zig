const FileCacheNFSConfiguration = @import("file_cache_nfs_configuration.zig").FileCacheNFSConfiguration;

/// The configuration for a data repository association (DRA) to
/// be created during the Amazon File Cache resource creation. The DRA
/// links the cache to either an Amazon S3 bucket or prefix, or a Network File
/// System (NFS) data repository that supports the NFSv3 protocol.
///
/// The DRA does not support automatic import or automatic
/// export.
pub const FileCacheDataRepositoryAssociation = struct {
    /// The path to the S3 or NFS data repository that links to the
    /// cache. You must provide one of the following paths:
    ///
    /// * The path can be an NFS data repository that links to
    /// the cache. The path can be in one of two formats:
    ///
    /// * If you are not using the `DataRepositorySubdirectories`
    /// parameter, the path is to an NFS Export directory (or one of its
    /// subdirectories)
    /// in the format `nfs://nfs-domain-name/exportpath`. You can therefore
    /// link a single NFS Export to a single data repository association.
    ///
    /// * If you are using the `DataRepositorySubdirectories`
    /// parameter, the path is the domain name of the NFS file system in the format
    /// `nfs://filer-domain-name`, which indicates the root of the
    /// subdirectories specified with the `DataRepositorySubdirectories`
    /// parameter.
    ///
    /// * The path can be an S3 bucket or prefix
    /// in the format `s3://bucket-name/prefix/` (where `prefix`
    /// is optional).
    data_repository_path: []const u8,

    /// A list of NFS Exports that will be linked with this data repository
    /// association. The Export paths are in the format `/exportpath1`.
    /// To use this parameter, you must configure `DataRepositoryPath`
    /// as the domain name of the NFS file system. The NFS file system domain name
    /// in effect is the
    /// root of the subdirectories. Note that `DataRepositorySubdirectories`
    /// is not supported for S3 data repositories.
    data_repository_subdirectories: ?[]const []const u8,

    /// A path on the cache that points to a high-level directory (such
    /// as `/ns1/`) or subdirectory (such as `/ns1/subdir/`)
    /// that will be mapped 1-1 with `DataRepositoryPath`.
    /// The leading forward slash in the name is required. Two data repository
    /// associations cannot have overlapping cache paths. For example, if
    /// a data repository is associated with cache path `/ns1/`,
    /// then you cannot link another data repository with cache
    /// path `/ns1/ns2`.
    ///
    /// This path specifies where in your cache files will be exported
    /// from. This cache directory can be linked to only one data repository,
    /// and no data repository other can be linked to the directory.
    ///
    /// The cache path can only be set to root (/) on an NFS DRA when
    /// `DataRepositorySubdirectories` is specified. If you
    /// specify root (/) as the cache path, you can create only one DRA
    /// on the cache.
    ///
    /// The cache path cannot be set to root (/) for an S3 DRA.
    file_cache_path: []const u8,

    /// The configuration for a data repository association that
    /// links an Amazon File Cache resource to an NFS data repository.
    nfs: ?FileCacheNFSConfiguration,

    pub const json_field_names = .{
        .data_repository_path = "DataRepositoryPath",
        .data_repository_subdirectories = "DataRepositorySubdirectories",
        .file_cache_path = "FileCachePath",
        .nfs = "NFS",
    };
};
