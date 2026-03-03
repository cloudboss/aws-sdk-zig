const AdministrativeAction = @import("administrative_action.zig").AdministrativeAction;
const FileSystemFailureDetails = @import("file_system_failure_details.zig").FileSystemFailureDetails;
const FileSystemType = @import("file_system_type.zig").FileSystemType;
const FileSystemLifecycle = @import("file_system_lifecycle.zig").FileSystemLifecycle;
const LustreFileSystemConfiguration = @import("lustre_file_system_configuration.zig").LustreFileSystemConfiguration;
const NetworkType = @import("network_type.zig").NetworkType;
const OntapFileSystemConfiguration = @import("ontap_file_system_configuration.zig").OntapFileSystemConfiguration;
const OpenZFSFileSystemConfiguration = @import("open_zfs_file_system_configuration.zig").OpenZFSFileSystemConfiguration;
const StorageType = @import("storage_type.zig").StorageType;
const Tag = @import("tag.zig").Tag;
const WindowsFileSystemConfiguration = @import("windows_file_system_configuration.zig").WindowsFileSystemConfiguration;

/// A description of a specific Amazon FSx file system.
pub const FileSystem = struct {
    /// A list of administrative actions for the file system that are in process or
    /// waiting to
    /// be processed. Administrative actions describe changes to the Amazon FSx
    /// system
    /// that you have initiated using the `UpdateFileSystem` operation.
    administrative_actions: ?[]const AdministrativeAction = null,

    /// The time that the file system was created, in seconds (since
    /// 1970-01-01T00:00:00Z),
    /// also known as Unix time.
    creation_time: ?i64 = null,

    /// The Domain Name System (DNS) name for the file system.
    dns_name: ?[]const u8 = null,

    failure_details: ?FileSystemFailureDetails = null,

    /// The system-generated, unique 17-digit ID of the file system.
    file_system_id: ?[]const u8 = null,

    /// The type of Amazon FSx file system, which can be `LUSTRE`,
    /// `WINDOWS`, `ONTAP`, or `OPENZFS`.
    file_system_type: ?FileSystemType = null,

    /// The Lustre version of the Amazon FSx for Lustre file system, which
    /// can be `2.10`, `2.12`, or `2.15`.
    file_system_type_version: ?[]const u8 = null,

    /// The ID of the Key Management Service (KMS) key used to encrypt Amazon FSx
    /// file
    /// system data. Used as follows with Amazon FSx file system types:
    ///
    /// * Amazon FSx for Lustre `PERSISTENT_1`
    /// and `PERSISTENT_2` deployment types only.
    ///
    /// `SCRATCH_1` and `SCRATCH_2` types are encrypted using
    /// the Amazon FSx service KMS key for your account.
    ///
    /// * Amazon FSx for NetApp ONTAP
    ///
    /// * Amazon FSx for OpenZFS
    ///
    /// * Amazon FSx for Windows File Server
    kms_key_id: ?[]const u8 = null,

    /// The lifecycle status of the file system. The following are the possible
    /// values and
    /// what they mean:
    ///
    /// * `AVAILABLE` - The file system is in a healthy state, and is reachable and
    ///   available for use.
    ///
    /// * `CREATING` - Amazon FSx is creating the new file system.
    ///
    /// * `DELETING` - Amazon FSx is deleting an existing file system.
    ///
    /// * `FAILED` - An existing file system has experienced an unrecoverable
    ///   failure.
    /// When creating a new file system, Amazon FSx was unable to create the file
    /// system.
    ///
    /// * `MISCONFIGURED` - The file system is in a failed but recoverable state.
    ///
    /// * `MISCONFIGURED_UNAVAILABLE` - (Amazon FSx for Windows File Server only)
    ///   The file system is
    /// currently unavailable due to a change in your Active Directory
    /// configuration.
    ///
    /// * `UPDATING` - The file system is undergoing a customer-initiated update.
    lifecycle: ?FileSystemLifecycle = null,

    lustre_configuration: ?LustreFileSystemConfiguration = null,

    /// The IDs of the elastic network interfaces from which a specific file system
    /// is
    /// accessible. The elastic network interface is automatically created in the
    /// same virtual
    /// private cloud (VPC) that the Amazon FSx file system was created in. For more
    /// information, see [Elastic Network
    /// Interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html) in
    /// the *Amazon EC2 User Guide.*
    ///
    /// For an Amazon FSx for Windows File Server file system, you can have one
    /// network interface ID. For an Amazon FSx for Lustre file system, you can have
    /// more than one.
    network_interface_ids: ?[]const []const u8 = null,

    /// The network type of the file system.
    network_type: ?NetworkType = null,

    /// The configuration for this Amazon FSx for NetApp ONTAP file system.
    ontap_configuration: ?OntapFileSystemConfiguration = null,

    /// The configuration for this Amazon FSx for OpenZFS file system.
    open_zfs_configuration: ?OpenZFSFileSystemConfiguration = null,

    /// The Amazon Web Services account that created the file system. If the file
    /// system was created by a
    /// user in IAM Identity Center, the Amazon Web Services account to which the
    /// IAM user belongs is the owner.
    owner_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the file system resource.
    resource_arn: ?[]const u8 = null,

    /// The storage capacity of the file system in gibibytes (GiB).
    ///
    /// Amazon FSx responds with an HTTP status code 400 (Bad Request) if the value
    /// of `StorageCapacity` is outside of the minimum or maximum values.
    storage_capacity: ?i32 = null,

    /// The type of storage the file system is using.
    ///
    /// * If set to `SSD`, the file system uses solid state drive storage.
    ///
    /// * If set to `HDD`, the file system uses hard disk drive storage.
    ///
    /// * If set to `INTELLIGENT_TIERING`, the file system uses fully elastic,
    /// intelligently-tiered storage.
    storage_type: ?StorageType = null,

    /// Specifies the IDs of the subnets that the file system is accessible from.
    /// For the Amazon FSx Windows and
    /// ONTAP `MULTI_AZ_1` file system deployment type, there are two subnet IDs,
    /// one for
    /// the preferred file server and one for the standby file server. The preferred
    /// file server subnet
    /// identified in the `PreferredSubnetID` property. All other file systems have
    /// only one subnet ID.
    ///
    /// For FSx for Lustre file systems, and Single-AZ Windows file systems, this is
    /// the ID of
    /// the subnet that contains the file system's endpoint. For `MULTI_AZ_1`
    /// Windows and
    /// ONTAP file systems, the file system endpoint is available in the
    /// `PreferredSubnetID`.
    subnet_ids: ?[]const []const u8 = null,

    /// The tags to associate with the file system. For more information, see
    /// [Tagging your
    /// Amazon FSx
    /// resources](https://docs.aws.amazon.com/fsx/latest/LustreGuide/tag-resources.html) in the *Amazon FSx for Lustre User
    /// Guide*.
    tags: ?[]const Tag = null,

    /// The ID of the primary virtual private cloud (VPC) for the file system.
    vpc_id: ?[]const u8 = null,

    /// The configuration for this Amazon FSx for Windows File Server file system.
    windows_configuration: ?WindowsFileSystemConfiguration = null,

    pub const json_field_names = .{
        .administrative_actions = "AdministrativeActions",
        .creation_time = "CreationTime",
        .dns_name = "DNSName",
        .failure_details = "FailureDetails",
        .file_system_id = "FileSystemId",
        .file_system_type = "FileSystemType",
        .file_system_type_version = "FileSystemTypeVersion",
        .kms_key_id = "KmsKeyId",
        .lifecycle = "Lifecycle",
        .lustre_configuration = "LustreConfiguration",
        .network_interface_ids = "NetworkInterfaceIds",
        .network_type = "NetworkType",
        .ontap_configuration = "OntapConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .owner_id = "OwnerId",
        .resource_arn = "ResourceARN",
        .storage_capacity = "StorageCapacity",
        .storage_type = "StorageType",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .vpc_id = "VpcId",
        .windows_configuration = "WindowsConfiguration",
    };
};
